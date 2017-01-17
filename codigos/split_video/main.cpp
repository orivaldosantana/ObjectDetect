
#include "opencv2/contrib/contrib.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/objdetect/objdetect.hpp"

//#include <cv.h>
//#include <highgui.h>
//#include <opencv2/imgproc/imgproc.hpp>

#include <iostream>
#include <math.h>
#include <string>

using namespace std;
using namespace cv;
//  g++ -o split_video main.cpp -lopencv_core -lopencv_imgproc -lopencv_calib3d -lopencv_video -lopencv_features2d -lopencv_ml -lopencv_highgui -lopencv_objdetect -lopencv_contrib -lopencv_legacy

int main()
{
    VideoCapture video;
    Mat image;

    vector<Mat> frames;

    video.open("../../video/alvo.mp4");

    Size size(285, 160);


    int skipped_frames =0, frame_count=0;
    bool flag = 0; //this flag is set to true when the number "skipped_frames" of frames is passed.

    while(video.isOpened())
    {
        if(skipped_frames > 9)
        {
            skipped_frames = 0;
            flag = 1; // Flag set to true. Which allows to code to save the image
        }

        video >> image;
        if(!image.empty())
        {
            resize(image, image, size);
        } else{
            return -1;
        }

        if(flag ==1){

            String name = "../../video/extracao/frame";

            string frame_number;          // string which will contain the final path of the file with the specific name on it
            ostringstream convert;   // stream used for the conversion
            convert << frame_count;      // insert the textual representation of 'Number' in the characters in the stream
            frame_number = convert.str(); // set 'frame_number' to the contents of the stream
            name = name + frame_number + ".jpg";
            imwrite( name, image );
            frame_count++;
            flag = 0;
        }

        skipped_frames++;
    }

    cout <<" Obrigado! Suas fotos ja estao salvas!" << endl;
    return 0;
}

