import Foundation
import SwiftyJSON

public class CollectionPostsEndpoint : Endpoint{
    public var path: String { get { fatalError("Please specify path") } }
    
    /// subCollectionClassType: Specify the subclass of CollectionPosts
    var subCollectionsPostsType: CollectionPosts.Type { get { fatalError("Please specify collection type") } }
    
    public func retrieveJSONObject(data: JSON, context: NSManagedObjectContext) -> NSManagedObject?{
        if let results = data["results"].array{
            let collectionPosts = subCollectionsPostsType.create(subCollectionsPostsType.self, context: context)
            
            if let posts = getPosts(results, context: context){
                collectionPosts.posts = NSSet(array: posts)
                return collectionPosts
            }else{
                collectionPosts.deleteFromContext(context)
                Logger.Error("Error parsing results")
            }
        }
        
        Logger.Error("JSON is empty")
        
        return nil
    }
    
    private func getPosts(data: [JSON], context: NSManagedObjectContext) -> [Post]?{
        var result: [Post] = []
        
        for json in data{
            if  let owner = json["owner"].int64,
                let title = json["title_post"].string,
                let desc = json["description_post"].string,
                let created = json["created"].string,
                let updated = json["updated"].string,
                let id = json["id"].int64{
                    
                    let post = Post.create(Post.self, context: context)
                    
                    post.owner = owner
                    post.title = title
                    post.post_description = desc
                    post.created_at = created
                    post.updated_at = updated
                    post.id = id
                    
                    result.append(post)
            }else{
                Logger.Error("Error parsing post")
                
                //delete
                for r in result{
                    r.deleteFromContext(context)
                }
                
                return nil
            }
        }
        
        return result
    }
    
    public func clearFromDatabase(context: NSManagedObjectContext){
        subCollectionsPostsType.clear(subCollectionsPostsType.self, context: context)
    }
    
}