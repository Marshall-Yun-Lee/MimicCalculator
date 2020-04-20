class Logger {
    static let shared = Logger()
    private init() {}
    
    func warn(msg: String) {
        print("WARNING: " + msg)
    }
    
    func success(msg: String) {
        print("SUCCESS: " + msg)
    }
    
    func fail(msg: String) {
        print("FAIL: " + msg)
    }
    
    func info(msg: String) {
        print("INFO: " + msg)
    }
    
    func debug(msg: String) {
        print("DEBUG: " + msg)
    }
}
