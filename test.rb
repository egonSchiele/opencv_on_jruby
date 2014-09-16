$CLASSPATH << "helpers"
$CLASSPATH << "/home/adit/opencv_2.4.9_old/lib"

require 'java'
require '/home/adit/opencv_2.4.9_old/bin/opencv-249.jar'
require 'open-uri'
Java::org.opencv.LdLibraryLoader

java_import org.opencv.core.Mat
java_import org.opencv.core.MatOfByte
java_import org.opencv.imgproc.Imgproc
java_import org.opencv.core.Size
java_import org.opencv.core.Core
java_import org.opencv.core.MatOfKeyPoint
java_import org.opencv.highgui.Highgui
java_import org.opencv.features2d.FeatureDetector
java_import org.opencv.features2d.Features2d
# java.lang.System.loadLibrary(Core::NATIVE_LIBRARY_NAME)

def resize(data)
    # img = Highgui.imdecode(data, Highgui::CV_LOAD_IMAGE_COLOR)
    File.open("/tmp/out.png", "wb+") do |f|
      f.write(data)
    end
    img = Highgui.imread("/tmp/out.png")
    dst = Mat.new
    sz = Size.new(100,100);
    Imgproc.resize(img, dst, sz)
    buf = MatOfByte.new
    Highgui.imencode(".png", dst, buf)
    arr = buf.toArray
    arr.to_s
end

class App
  def call(env)
    if env["REQUEST_PATH"] == "/favicon.ico"
      return [200, {}, [""]]
    end
    url = "http:/" + env['REQUEST_PATH']
    p url
    data = open(url).read
    resized = resize(data)
    [200, {"Content-Type" => "image/png"}, [resized]]
  end
end

# Rack::Handler::Puma.run HelloWorld.new, :Port => 9999
