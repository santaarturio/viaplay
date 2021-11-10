
enum DataBaseManager {
  static let viaplay = CoreDataManager(containerName: "ViaplayData")
}

enum DataBase {
  static let viaplay: ViaplayDataBaseProtocol = ViaplayDataBase(coreDataManager: DataBaseManager.viaplay)
}
