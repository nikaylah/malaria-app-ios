import Foundation

public class UserSettingsManager{
    
    public enum UserSetting: String{
        static let allValues = [DidConfiguredMedicine]
        
        case DidConfiguredMedicine = "DidConfiguredMedicine"
        case ClearTripHistory = "ClearTripHistory"
        case ClearMedicineHistory = "ClearMedicineHistory"
        case MedicineReminderSwitch = "MedicineReminderSwitch"
        case TripReminderOption = "TripReminderOption"
        
        public func isSet() -> Bool{
            return NSUserDefaults.standardUserDefaults().objectForKey(self.rawValue) != nil
        }
        
        /// Sets settings boolean flag to the value given by argument
        /// :param: `Bool`: value
        public func setBool(value: Bool){
            NSUserDefaults.standardUserDefaults().setBool(value, forKey: self.rawValue)
        }
        
        /// Gets the value of the boolean user setting
        /// :returns: `Bool`: The value
        public func getBool() -> Bool{
            return NSUserDefaults.standardUserDefaults().boolForKey(self.rawValue) ?? false
        }
        
        /// Sets settings String value of the user setting
        /// :param: `String`: value
        public func setString(value: String){
            NSUserDefaults.standardUserDefaults().setObject(value, forKey: self.rawValue)
        }
        
        /// Gets the string value for the key. If it is not set, returns empty string
        /// :returns: `String`:  The value
        public func getString() -> String{
            return (NSUserDefaults.standardUserDefaults().objectForKey(self.rawValue) ?? "") as! String
        }
        
        /// clears the key from UserDefaults
        public func removeKey() {
            return NSUserDefaults.standardUserDefaults().removeObjectForKey(self.rawValue)
        }
    }
    
    /// Syncronize standardUserDefaults
    public class func syncronize(){
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    /// Clears all values
    public class func clear(){
        UserSetting.allValues.map({$0.removeKey()})
    }
}