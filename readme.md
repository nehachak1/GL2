# Solution Description

We first started by going through the instructions all together, and reviewing the necessary functions from the glMatrix library, we then tackled the first task. 
The explanations were clear and concise for the first task 2.1.1, so we just applied the knowledge we had from the course, calculating the normals and angle weights. And successfully solved it after a bit of back and forth.
For 2.1.2, we struggled a little bit got through it after some time, the tricky thing about this part would be its correlation to 2.1.1, so if this was wrong, we couldn't know if it was from this part or the previous.
In 2.2.1, we found it hard to navigate between all the js and glsl files, and this is where a mistake would come back to bite us: interpolation error of the normal in fragment shader. In fact, due to this error (not normalizing again the normal in normals.frag)we struggled a ton in 2.2.2, though it should've been an easy task. The colors around was dimmed due to this error and we couldn't find a way to get the normals-to-view matrix from the model-view matrix since we did not know a function Mat3.fromMat4 existed. But with the TA's help we managed to go through it.
Finally, we split up to work on the lighting models seperately. This part was pretty feasible, the only difficulty was we forgot an ambiant light_color coefficient in the ambiant frag_color.



# Contributions

Neha Chakraborty (373384): 1/3

Khanh Nam Le (379672): 1/3

Boxuan Wu (372197): 1/3 