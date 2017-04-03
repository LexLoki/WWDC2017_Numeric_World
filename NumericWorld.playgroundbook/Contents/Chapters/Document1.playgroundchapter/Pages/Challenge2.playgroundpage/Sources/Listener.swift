import PlaygroundSupport

public class Listener : PlaygroundRemoteLiveViewProxyDelegate {
    
    private weak var page : PlaygroundPage?
    
    public init(page : PlaygroundPage){
        self.page = page
        if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy{
            proxy.delegate = self
        }
    }
    
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy){
    }
    
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue){
        let msg = message.stringFromDict(withKey: "message")!
        if msg == "finished"{
            page?.finishExecution()
        }
        else if msg == "assert"{
            let status = message.integerFromDict(withKey: "status")!
            if status == 0{
                page?.assessmentStatus = .pass(message: "### Well jumped 👍! You have successfully beaten the jump game!\nFeel free to try different combinations of jumps.\n Hope you enjoyed ❤️")
            }
            else{
                let str = status == -1 ? "You went too far to the left. Try moving to the right more." : status == 1 ? "You went too far to the right. Try moving to the left more" :  "Your final land should be on zero!"

                page?.assessmentStatus = .fail(hints: [str], solution: "You can jump 3 times to the right and then twice to the left!")
            }
        }
    }
}
