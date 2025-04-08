//
//  PortfolioDataService.swift
//  RoboCrypto
//
//  Created by Robin O'Brien on 2025-04-08.
//

import CoreData
import Foundation

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: - PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            // Update existing entity
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            // Add new entity
            add(coin: coin, amount: amount)
        }
    }
    
    
    // MARK: - PRIVATE
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio data \(error)")
        }
    }
    
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving portfolio data \(error)")
        }
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
