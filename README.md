# 2D and 3D Graph Plot

![Main2DUI](https://github.com/user-attachments/assets/d8a2edb2-b4a5-4a99-85c8-1d6eb32ea36a)

![Main3DUI](https://github.com/user-attachments/assets/3da206c6-33f0-4c79-ae50-3268ad235f06)

Create different types of graphs (curves, surfaces) to represent simple mathematical functions and their derivatives.

## Installation

Download and double-click on the GraphPlot.mlapp to execute MATLAB and run the app. Alternatively, the complete code is in the GraphPlot_Code.m file.

## Usage

Select the range for the x-axis (horizontal axis). The default value is from -10 to 10. When plotting a 3D graph, you will select a range for both x and y-axis.

![setRange](https://github.com/user-attachments/assets/73127544-c1a4-4d4e-8e3c-8cb4447747c4)

Then select the function to plot, or insert a custom one.

![chooseTheFunction](https://github.com/user-attachments/assets/a26913df-ec7d-4994-9a02-a4d7545fb338)

WARNING!

If you write a custom function, it is important to use the dot notation. 
Examples:
x.*sin(x)
x.^2
2*sin(x)

To plot the function, click the "Plot" button. The "Clear" button will clear the graph.

![plot](https://github.com/user-attachments/assets/70189a3d-1f6a-486b-bcee-a93a1ceb32ec)

With the 3D plot, you can drag the graph to rotate the view, and zoom in and out with your mouse wheel.

To export a graph, click on the save as icon.

![exportGraph](https://github.com/user-attachments/assets/5bfbbfac-4e08-4681-87a5-3e7dd8fb9e22)

## Roadmap

I may add animated plots in the future.

## Contributing

Just to let you know, pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.


## License

[MIT](https://choosealicense.com/licenses/mit/)
