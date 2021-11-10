import CoreData
import Combine

final class ViaplayDataBase: NSObject, ViaplayDataBaseProtocol {
  
  private(set) var sectionsPublisher = CurrentValueSubject<[ViaplaySection], Never>([])
  private let coreDataManager: CoreDataManager
  private var fetchedResultsController: NSFetchedResultsController<ViaplaySection>!
  
  init(coreDataManager: CoreDataManager) {
    self.coreDataManager = coreDataManager
    super.init()
    setupFetchedResultsController()
  }
  
  func updateSection(
    id: String,
    _ configurationsHandler: @escaping (ViaplaySection) -> Void
  ) {
    let fetchRequest: NSFetchRequest<ViaplaySection> = ViaplaySection.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
    
    coreDataManager
      .viewContext
      .perform { [unowned self] in
        do {
          let note = try coreDataManager
            .viewContext
            .fetch(fetchRequest).first ?? ViaplaySection(context: coreDataManager.viewContext)
          configurationsHandler(note)
        } catch {
          print("Error occured while updating notes: \(error.localizedDescription)")
        }
      }
  }
}

// MARK: - NSFetchedResultsController
extension ViaplayDataBase: NSFetchedResultsControllerDelegate {
  
  private func setupFetchedResultsController() {
    let fetchRequest = ViaplaySection.fetchRequest() as NSFetchRequest
    fetchRequest.sortDescriptors = []
    
    fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: coreDataManager.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    fetchedResultsController.delegate = self
    
    do {
      try fetchedResultsController.performFetch()
      syncList()
    } catch { print(error.localizedDescription) }
  }
  
  func controllerDidChangeContent(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>
  ) { syncList() }
  
  private func syncList() {
    fetchedResultsController
      .fetchedObjects
      .map { sections in sectionsPublisher.send(sections) }
  }
}
