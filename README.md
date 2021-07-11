<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">Automated Image Quality Analysis for Medical Images</h3>
  <p align="center">
   Assessing image quality in medical images is extremely important to ensure effective care diagnosis of pathologies in patients. This code consists of three respective algorithms for the automatic detection of image noise, contrast, and edge strength in medical images. The validation methods used in this paper show promising results for the techniques that were used. Future work should involve the comparison of presented results with subjective assessments from medical professionals that work closely in the imaging domain. This project was completed for the Biomedical Image Analysis (BME872) at Ryerson University.
    <br />
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

</br>
Medical imaging is a crucial tool used in healthcare settings to assist in the diagnosis of countless pathologies. Medical image quality is pivotal for effective and correct diagnosis, and as such, image quality analysis (IQA) has become an important field in the biomedical industry . This paper will feature a solution for the automatic extraction and evaluation of three features associated with image quality: (1) noise, (2) contrast, and (3) edge quality. These quality evaluation parameters can then be used for assessment of new medical imaging hardware, software, and preprocessing algorithms to understand their effect on image quality. In addition, quality information for an image can be an important input to adaptive image enhancement algorithms. For example, a denoising algorithm can be tailored to the amount of noise present in the image before processing and be able to perform superior noise-removal as a result.
</br>
</p>
For full theory and background on the the techniques used in these algorithms, please see our full project write-up [here](https://drive.google.com/file/d/19TvjEQ3iRs9mDEMU79QRSca_xMjK9h8u/view?usp=sharing) !
</br>

### Built With

* [MATLAB2020a](https://www.mathworks.com/products/new_products/release2020a.html?s_tid=srchtitle)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Pre-Requisites

* [MATLAB2020a](https://www.mathworks.com/products/new_products/release2020a.html?s_tid=srchtitle)
* [MATLAB Image Processing Toolbox](https://www.mathworks.com/products/image.html?s_tid=srchtitle)

### Installation

1. Install pre-requisites via links provided
2. Clone the repo
   ```sh
   git clone https://github.com/ghartell/biomedical-IQA.git
   ```

<!-- CONTACT -->
## Contact

1. Johnny Libenzon - [LinkedIn](https://www.linkedin.com/in/johnny-libenzon/)
2. Ginette Hartell - [LinkedIn](https://www.linkedin.com/in/ginette-hartell/)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

We would also like to extend our appreciation to our Biomedical Image Analysis Professor, Dr. April Khademi. Dr. Khademi has been instrumental in our learning of the core concepts of image processing, and was an excellent mentor througout this course.
