//
//  ViewController.m
//  OpenGL--Demo
//
//  Created by WT－WD on 17/7/3.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ViewController.h"
/**************三角形**************/
typedef struct { // 这个数据类型用于存储每一个顶点数据
    GLKVector3 positionCoords;
}SceneVertex;

// 创建本例中要用到的三角形顶点数据
const SceneVertex vertices []  ={
    {{-0.5, -0.5, 0.0}},  // 左下
    {{ 0.5, -0.5, 0.0}},  // 右下
    {{-0.5,  0.5, 0.0}}  // 左上
};
/**************图片**************/
// 这个数据类型用于存储每一个顶点数据
typedef struct {
    GLKVector3 positionCoordsImg;  // 顶点数据
    GLKVector2 textureCoordsImg;   // 纹理坐标
} SceneVertexImg;
// 创建本例中要用到的三角形顶点数据
// 这里的数据比上一个例子新增了纹理数据
static const SceneVertexImg verticesImg[] =
{
    // 1/4屏，居中
//    {{-0.5, -0.5, 0.0}, {0.0, 0.0}},  // 左下
//    {{ 0.5, -0.5, 0.0}, {1.0, 0.0}},  // 右下
//    {{-0.5,  0.5, 0.0}, {0.0, 1.0}},  // 左上
//    
//    // 解决图片只有一半显示的问题 begin
//    {{ 0.5, -0.5, 0.0}, {1.0, 0.0}},//右下
//    {{-0.5,  0.5, 0.0}, {0.0, 1.0}},//左上
//    {{ 0.5,  0.5, 0.0}, {1.0, 1.0}}//右上
//    // 解决图片只有一半显示的问题 end
    
    //全屏
    {{-1.0, -1.0, 0.0}, {0.0, 0.0}},  // 左下
    {{ 1.0, -1.0, 0.0}, {1.0, 0.0}},  // 右下
    {{-1.0,  1.0, 0.0}, {0.0, 1.0}},  // 左上
    
    // 解决图片只有一半显示的问题 begin
    {{ 1.0, -1.0, 0.0}, {1.0, 0.0}},//右下
    {{-1.0,  1.0, 0.0}, {0.0, 1.0}},//左上
    {{ 1.0,  1.0, 0.0}, {1.0, 1.0}}//右上
    // 解决图片只有一半显示的问题 end
};
@interface ViewController ()<GLKViewDelegate>
{
 GLuint vertexBufferId;//此变量用于保存盛放本例即将用到的顶点数据的缓存的OpenGL ES标识符。
}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;//GLKBaseEffect隐藏了iOS设备支持的多个OpenGL ES版本之间的差异。在应用中使用GLKBaseEffect能减少代码的数量。
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self demo1];
    [self demo2];
}
//opengl 画三角形
-(void)demo1{
    
    GLKView *view = (GLKView*)self.view;
    
    NSAssert([view isKindOfClass:[GLKView class]], @"ViewController's view is not a GLKView");
    
    //创建一个opengl es 2.0 context（上下文） 并将其提供给view
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //将刚刚创建的context设置为当前的context
    [EAGLContext setCurrentContext:view.context];
    //创建一个提供标准的opengl es 2.0 的GLKBaseEffect
    self.baseEffect = [[GLKBaseEffect alloc]init];
    //启用shading language progress（着色语言程序）
    self.baseEffect.useConstantColor = GL_TRUE;
    //设置渲染图形用的颜色为白色
    self.baseEffect.constantColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
    //设置当前context的背景色为黑色
    glClearColor(0.0, 0.0, 0.0, 1.0);
    
    /*
     * glGenBuffers(GLsizei n, GLuint *buffers);
     * 生成缓存，指定缓存数量，并保存在vertexBufferId中
     * 第一个参数：指定要生成的缓存标识符的数量
     * 第二个参数：指针，指向生成的标识符的内存位置（熟悉C和C++的小伙伴应该不陌生了）
     */
    glGenBuffers(1, &vertexBufferId);
    
    /*
     * glBindBuffer(GLenum target, GLuint buffer);
     * 绑定由于指定标识符的缓存到当前缓存
     * 第一个参数：用于指定要绑定哪一类型的内存(GL_ARRAY_BUFFER | GL_ELEMENT_ARRAY_BUFFER)，GL_ARRAY_BUFFER用于指定一个顶点属性数组
     * 第二个参数：要绑定魂缓存的标识符
     */
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferId);
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_DYNAMIC_DRAW);
}
//渲染一张纹理图片
-(void)demo2{
    GLKView *view = (GLKView*)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"ViewController's view is not a GLKView");
    
    //创建一个opengl es 2.0 context（上下文）并将其提供给view
    view.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //将刚刚创建的context设置为当前context
    [EAGLContext setCurrentContext:view.context];
    // 创建一个提供标准OpenGL ES 2.0的GLKBaseEffect
    self.baseEffect = [[GLKBaseEffect alloc]init];
    // 启用Shading Language programs（着色语言程序）
    self.baseEffect.useConstantColor = GL_TRUE;
    // 设置渲染使用的颜色
    self.baseEffect.constantColor = GLKVector4Make(1.0, 1.0, 1.0, 1.0);
    // 设置当前context的背景色为白色
    glClearColor(0.0, 0.0, 0.0, 1.0);
    // 生成缓存，并保存在vertexBufferId中
    glGenBuffers(1, &vertexBufferId);
    // 绑定缓存
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferId);
    // 缓存数据
    glBufferData(GL_ARRAY_BUFFER, sizeof(verticesImg), verticesImg, GL_DYNAMIC_DRAW);
    
    //读入需要绘制的图片的 CGImageRef 内容
    CGImageRef imageRefTulip = [UIImage imageNamed:@"meinv2.jpg"].CGImage;
    //使用GLKTextureLoader（纹理读取）从上边得到的imageRefTulip读取纹理信息
    // 解决纹理倒置问题 begin
    //GLKTextureLoaderOriginBottomLeft此方法可以转换一下坐标系(默认是左下角为原点)
    GLKTextureInfo *textureInfoTulip = [GLKTextureLoader textureWithCGImage:imageRefTulip
                                                                    options:@{GLKTextureLoaderOriginBottomLeft: @(YES)}
                                                                      error:nil];
    // 解决纹理倒置问题 end
    //将读取到的纹理信息缓存到baseEffec的texture2d0中
    self.baseEffect.texture2d0.name = textureInfoTulip.name;
    self.baseEffect.texture2d0.target = textureInfoTulip.target;
}
#pragma mark - GLKViewDelegate
-(void)glkView:(GLKView*)view drawInRect:(CGRect)rect{
    [self draw1];//绘制三角形
    [self draw2];//绘制图片
}
//绘制纹理图片
-(void)draw2{
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition,
                          3,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(SceneVertexImg),
                          NULL + offsetof(SceneVertexImg, positionCoordsImg));
    //绘制纹理数据准备
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);//启用纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0,
                          2,
                          GL_FLOAT,
                          GL_FALSE,
                          sizeof(SceneVertexImg),
                          NULL+offsetof(SceneVertexImg,textureCoordsImg));
    
    // 执行绘画操作
    glDrawArrays(GL_TRIANGLES,
                 0,
                 sizeof(verticesImg) / sizeof(SceneVertexImg));
}
//绘制三角形
-(void)draw1{
    //告诉baseEffect准备好当前的opengl es 的context ， 马上就要给绘画了
    [self.baseEffect prepareToDraw];
    
    //清除当前绑定绑定的帧缓存的像素颜色渲染缓存中的每一个像素的颜色为当前使用glclearcolor 函数设置的值
    glClear(GL_COLOR_BUFFER_BIT);
    
    /*
     * glEnableVertexAttribArray(GLuint index)
     * 启动某项缓存的渲染操作（GLKVertexAttribPosition | GLKVertexAttribNormal | GLKVertexAttribTexCoord0 | GLKVertexAttribTexCoord1）
     * GLKVertexAttribPosition 用于顶点数据
     * GLKVertexAttribNormal 用于法线
     * GLKVertexAttribTexCoord0 与 GLKVertexAttribTexCoord1 均为纹理
     */
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    /*
     * glVertexAttribPointer(GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *ptr);
     * 渲染相应数据（此处绘制顶点数据）
     * 第一个参数：当前要绘制的值什么类型的数据，与glEnableVertexAttribArray()相同
     * 第二个参数：每个位置有3个部分
     * 第三个参数：每个部分都保存为一个float值
     * 第四个参数：告诉OpenGL ES小数点固定数据是否可以被改变
     * 第五个参数：“步幅”，即从一个顶点的内存开始位置转到下一个顶点的内存开始位置需要跳过多少字节
     * 第六个参数：告诉OpenGL ES从当前的绑定的顶点缓存的开始位置访问顶点数据
     */
    glVertexAttribPointer(GLKVertexAttribPosition,//当前绘制顶点数据
                          3,//每个顶点3个值
                          GL_FLOAT,//数据为float
                          GL_FALSE,//不需要做任何转化
                          sizeof(SceneVertex),//每个顶点之间的内存间隔为sizeof(SceneVertex)
                          NULL);//偏移量为0，从开始绘制，也可以传0
    
    glDrawArrays(GL_TRIANGLES,//绘制三角形
                 0,//从开始绘制
                 3);//共3个顶点
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
