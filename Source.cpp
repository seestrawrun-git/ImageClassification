#include <opencv2/opencv.hpp>
#include <random>
#include <ctime>
#include <string>
#include <iostream>

cv::Scalar generateRandomColor(std::mt19937& rng) {
    std::uniform_int_distribution<> dist(0, 255);
    return cv::Scalar(dist(rng), dist(rng), dist(rng));
}

int main() {
    std::mt19937 rng(static_cast<long unsigned int>(std::time(0)));
    cv::Size newSize(1024, 791);

    for (int img_count = 0; img_count < 200; ++img_count) {
        cv::Mat image = cv::imread("C:\\PNG\\Tiger\\TigerBase\\TigerBase.png", cv::IMREAD_UNCHANGED);

        if (image.empty()) {
            std::cerr << "Could not read the image" << std::endl;
            return 1;
        }

        if (image.channels() != 4) {
            std::cerr << "The image does not have an alpha channel" << std::endl;
            return 1;
        }

        cv::Mat rgbImage, alphaChannel;
        // Split into RGB and Alpha
        cv::Mat channels[4];
        cv::split(image, channels);
        cv::merge(channels, 3, rgbImage);
        alphaChannel = channels[3];

        // Create a mask for floodFill
        cv::Mat mask = cv::Mat::zeros(image.rows + 2, image.cols + 2, CV_8U);

        for (int y = 0; y < image.rows; ++y) {
            for (int x = 0; x < image.cols; ++x) {
                // Only apply floodFill to pixels that are white and fully opaque
                if (channels[0].at<uchar>(y, x) == 255 && channels[1].at<uchar>(y, x) == 255 && channels[2].at<uchar>(y, x) == 255 && alphaChannel.at<uchar>(y, x) == 255) {
                    cv::Scalar newVal = generateRandomColor(rng);
                    cv::floodFill(rgbImage, mask, cv::Point(x, y), newVal, 0, cv::Scalar(), cv::Scalar(), 4);
                }
            }
        }

        // Merge the alpha channel back into the RGB image to get a 4-channel image
        cv::Mat result;
        cv::merge(std::vector<cv::Mat>{rgbImage, alphaChannel}, result);

        cv::Mat resizedImage;
        cv::resize(result, resizedImage, newSize);

        std::string filename = "C:\\PNG\\Tiger\\TigerProcess\\color_" + std::to_string(img_count) + ".png";
        if (!cv::imwrite(filename, resizedImage)) {
            std::cerr << "Failed to write the image: " << filename << std::endl;
            return 1;
        }
        std::cout << "Image done" << std::endl;
    }

    return 0;
}
