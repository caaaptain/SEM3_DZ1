
import Foundation
import Firebase

class Joke {
    fileprivate var _jokeRef: Firebase!
    
    fileprivate var _jokeKey: String!
    fileprivate var _jokeText: String!
    fileprivate var _jokeVotes: Int!
    fileprivate var _username: String!
    
    var jokeKey: String {
        return _jokeKey
    }
    
    var jokeText: String {
        return _jokeText
    }
    
    var jokeVotes: Int {
        return _jokeVotes
    }
    
    var username: String {
        return _username
    }
    

    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._jokeKey = key
        

        
        if let votes = dictionary["votes"] as? Int {
            self._jokeVotes = votes
        }
        
        if let joke = dictionary["jokeText"] as? String {
            self._jokeText = joke
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }

        
        self._jokeRef = DataService.dataService.JOKE_REF.childByAppendingPath(self._jokeKey)
    }
    
    func addSubtractVote(_ addVote: Bool) {
        
        if addVote {
            _jokeVotes = _jokeVotes + 1
        } else {
            _jokeVotes = _jokeVotes - 1
        }
        
        // Save the new vote total.
        
        _jokeRef.childByAppendingPath("votes").setValue(_jokeVotes)
        
    }
}

