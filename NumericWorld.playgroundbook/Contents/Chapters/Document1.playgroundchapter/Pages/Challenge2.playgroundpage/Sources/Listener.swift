import PlaygroundSupport
///Classe implementando o protocolo necessario para receber mensagens da LiveView
/// Documentação: https://developer.apple.com/library/content/documentation/Xcode/Conceptual/swift_playgrounds_doc_format/PlaygroundRemoteLiveViewProxyDelegateProtocol.html#//apple_ref/doc/uid/TP40017343-CH43-SW1
public class Listener : PlaygroundRemoteLiveViewProxyDelegate {
    
    private weak var page : PlaygroundPage?
    
    public init(page : PlaygroundPage){
        self.page = page
        if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy{
            proxy.delegate = self //Mensagens enviadas para essa page serão passadas para esse objeto
        }
    }
    
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy){
    }
    
    /// Método que recebe mensagens enviadas pela LiveView (no caso GameView)
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundRemoteLiveViewProxy, received message: PlaygroundValue){
        let msg = message.toString()!
        if msg == "finished"{
            page?.finishExecution() //Para deixar o runCode voltar
        }
    }
}
