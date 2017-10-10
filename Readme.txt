***********************************************************************************************************


Training code for "Single Infrared Image Stripe Noise Removal Using Deep Convolutional Networks" 

***********************************************************************************************************



Usage:


1. Place the "Train_SNRCNN" folder into "($Caffe_Dir)/examples/" and modify the folder name as "SNRCNN"



2. Open MATLAB and direct to ($Caffe_Dir)/example/SNRCNN, run 
"generate_train.m" and "generate_test.m" to generate training and test data.



3. To train our SNRCNN, run
./build/tools/caffe train --solver examples/SNRCNN/SNRCNN_solver.prototxt



4. After training, you can extract parameters from the caffe model and save them in the format that can be used in our test package (SNRCNN_Matlab). To do this, you need to install mat-caffe first, then open MATLAB and direct to ($Caffe_Dir) and run "saveFilters.m". The "($Caffe_Dir)/examples/SNRCNN/x1.mat" will be there for you.

## Contact with me
If you have any questions, please contact with me. (1007642157@qq.com)
