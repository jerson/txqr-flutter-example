package github.com.divan.txqr;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import txqr.Decoder;
import txqr.Txqr;

/**
 * TxqrPlugin
 */
public class TxqrPlugin implements MethodCallHandler {

    private Decoder decoder;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "txqr");
        channel.setMethodCallHandler(new TxqrPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        switch (call.method) {
            case "newDecoder":
                decoder = Txqr.newDecoder();
                result.success(true);
                break;
            case "isCompleted":
                result.success(decoder.isCompleted());
                break;
            case "data":
                result.success(decoder.data());
                break;
            case "speed":
                result.success(decoder.speed());
                break;
            case "dataBytes":
                result.success(decoder.dataBytes());
                break;
            case "decode":
                try {
                    decoder.decode((String) call.argument("data"));
                    result.success(true);
                } catch (Exception e) {
                    result.error(e.getMessage(), null, null);
                }
                break;
            case "incRefnum":
                result.success(decoder.incRefnum());
                break;
            case "length":
                result.success(decoder.length());
                break;
            case "progress":
                result.success(decoder.progress());
                break;
            case "totalSize":
                result.success(decoder.totalSize());
                break;
            case "totalTime":
                result.success(decoder.totalTime());
                break;
            case "totalTimeMs":
                result.success(decoder.totalTimeMs());
                break;
            case "toString":
                result.success(decoder.toString());
                break;
            case "read":
                result.success(decoder.read());
                break;
            case "readInterval":
                result.success(decoder.readInterval());
                break;
            case "reset":
                decoder.reset();
                result.success(true);
                break;
            default:

                result.notImplemented();
                break;
        }
    }
}
