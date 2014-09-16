$CLASSPATH << "helpers"
$CLASSPATH << "/home/adit/opencv_2.4.9_old/lib"

require 'java'
require '/home/adit/opencv_2.4.9_old/bin/opencv-249.jar'
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

def resize(path)
    img = Highgui.imread(path)
    dst = Mat.new
    sz = Size.new(100,100);
    Imgproc.resize(img, dst, sz)
    buf = MatOfByte.new
    Highgui.imencode(".png", dst, buf)
    arr = buf.toArray
    arr
end

print resize("/tmp/test.png")

class App
  def call(env)
    p env
    [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]
  end
end

#Rack::Handler::Puma.run HelloWorld.new, :Port => 9999
