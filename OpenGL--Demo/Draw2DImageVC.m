//
//  Draw2DImageVC.m
//  OpenGL--Demo
//
//  Created by zhaokaile on 2018/7/25.
//  Copyright © 2018年 none. All rights reserved.
//

#import "Draw2DImageVC.h"
// 这个数据类型用于存储每一个顶点数据
typedef struct {
    GLKVector3 positionCoordsImg;  // 顶点数据
    GLKVector2 textureCoordsImg;   // 纹理坐标
} SceneVertexImg;
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
@interface Draw2DImageVC ()<GLKViewDelegate>
{
   GLuint vertexBufferId;//此变量用于保存盛放本例即将用到的顶点数据的缓存的OpenGL ES标识符。
}
@property(nonatomic,strong)GLKBaseEffect *baseEffect;
@end

@implementation Draw2DImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //准备所需绘图数据
    [self initData];
}
-(void)initData{
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
    //1. 生成缓存，并保存在vertexBufferId中
    glGenBuffers(1, &vertexBufferId);
    //2. 绑定缓存
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferId);
    //3. 缓存数据
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
    
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); //顶点数据缓存
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertexImg), NULL + offsetof(SceneVertexImg, positionCoordsImg));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(SceneVertexImg), NULL + offsetof(SceneVertexImg,textureCoordsImg));
    
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.baseEffect prepareToDraw];
//        glClear(GL_COLOR_BUFFER_BIT);
//
//        // 执行绘画操作
//        glDrawArrays(GL_TRIANGLES,
//                     0,
//                     sizeof(verticesImg) / sizeof(SceneVertexImg));
//    });
    
}
#pragma mark - GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
//    NSLog(@"绘制");
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);

    // 执行绘画操作
    glDrawArrays(GL_TRIANGLES,
                 0,
                 sizeof(verticesImg) / sizeof(SceneVertexImg));
    
}



-(void)dealloc{
//    GLKView *view = (GLKView *)self.view;
//    [EAGLContext setCurrentContext:view.context];
    if ( 0 != vertexBufferId) {
        glDeleteBuffers(1,
                        &vertexBufferId);
        vertexBufferId = 0;
    }
    NSLog(@"%@销毁了!!",self.view);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
