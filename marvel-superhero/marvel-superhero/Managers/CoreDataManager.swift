//
//  CoreDataManager.swift
//  marvel-superhero
//
//  Created by Antonio de Carvalho Jr on 12/06/18.
//  Copyright © 2018 Antonio R de Carvalho Jr. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataManager {
    public static let shared = CoreDataManager()
    lazy var context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()

    var superHero: SuperHeroData?

    func addCharacter(superHero: SuperHeroData) {
        self.superHero = superHero

        fetchSuperHero(byId: superHero.id) { (superHero) in
            if let _ = superHero {
                print("Already added")
            } else if let superHero = self.superHero {
                self.storeSuperHero(superHero: superHero)
            }
        }
    }

    private func storeSuperHero(superHero: SuperHeroData) {
        context.insert(superHero)
        do {
            try context.save()
        } catch {
            print(error)
        }
        printAll()
    }

    func removeSuperHero(superHero: SuperHeroData) {
        context.delete(superHero)
        do {
            try context.save()
        } catch {
            print(error)
        }
        printAll()
    }

    func fetchAll(completion: @escaping ([SuperHeroData]) -> ()) {
        var superHero: [SuperHeroData] = []

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SuperHero")

        do {
            superHero = try context.fetch(fetchRequest) as! [SuperHeroData]
            completion(superHero)
            return
        } catch {
            print("error")
        }

        completion([])
    }

    func fetchSuperHero(byId id: Int, completion: @escaping (SuperHeroData?) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SuperHero")
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate

        do {
            let superHero = try context.fetch(fetchRequest) as! [SuperHeroData]
            completion(superHero.first)
            return
        } catch {
            print("error")
        }

        completion(nil)
    }

    func isFavorite(superHero: SuperHeroData) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SuperHero")
        let predicate = NSPredicate(format: "id == %d", superHero.id)
        fetchRequest.predicate = predicate

        do {
            let superHero = try context.fetch(fetchRequest) as! [SuperHeroData]
            if superHero.isEmpty {
                return false
            } else {
                return true
            }
        } catch {
            print("error")
            return false
        }
    }

    func printAll() {
        var superHero  = [SuperHeroData]()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SuperHero")
        do {
            superHero = try context.fetch(fetchRequest) as! [SuperHeroData]
        } catch {
            print("error")
        }

        for superHero in superHero {
            print("------------------------------")
            print("Details of: \(superHero.name)")
            print("Description: \(superHero.descriptionText)")
            print("Comics: ")
            if let comics = superHero.comics?.items {
                for comic in comics {
                    print(comic.name)
                }
            }

            print("Events: ")
            if let events = superHero.events?.items {
                for event in events {
                    print(event.name)
                }
            }

            print("Stories: ")
            if let stories = superHero.stories?.items {
                for story in stories {
                    print(story.name)
                }
            }

            print("Series: ")
            if let series = superHero.series?.items {
                for serie in series {
                    print(serie.name)
                }
            }
        }
    }
}

