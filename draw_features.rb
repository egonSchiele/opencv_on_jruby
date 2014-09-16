$CLASSPATH << "helpers"
$CLASSPATH << "/home/adit/opencv_2.4.9_old/lib"

require 'java'
require '/home/adit/opencv_2.4.9_old/bin/opencv-249.jar'
Java::org.opencv.LdLibraryLoader

java_import org.opencv.core.Mat
java_import org.opencv.core.Core
java_import org.opencv.core.MatOfKeyPoint
java_import org.opencv.highgui.Highgui
java_import org.opencv.features2d.FeatureDetector
java_import org.opencv.features2d.Features2d
# java.lang.System.loadLibrary(Core::NATIVE_LIBRARY_NAME)


src = Highgui.imread(ARGV.first)

keypoints = MatOfKeyPoint.new
detector = FeatureDetector.create(FeatureDetector::SIFT)
detector.detect src, keypoints

keypoints.to_array.each do |keypoint|
  point = keypoint.pt
  puts "x: #{point.x}, y: #{point.y}"
end

dst = Mat.new
Features2d.drawKeypoints src, keypoints, dst

Highgui.imwrite "./feature_out.png", dst

