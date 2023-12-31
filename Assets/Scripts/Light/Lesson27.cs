using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lesson27 : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        #region 知识回顾 光照模型
        //光照模型就是用来计算光照效果的数学公式
        //是业界前辈们探索出来的计算规则

        //提出问题
        //具体的光照效果相关的计算
        //应该写在顶点还是片元着色器中呢？
        //本节课学习的必备知识就是用来回答该问题的
        #endregion

        #region 知识点一 逐顶点光照
        //在哪计算：
        //顶点着色器 回调函数中

        //计算方式：
        //逐顶点光照会在每个物体的顶点上进行光照计算
        //这意味着光照计算只在物体的顶点位置上执行
        //而在顶点之间的内部区域使用插值来获得颜色信息

        //优点：
        //逐顶点光照的计算量较小，通常在移动设备上性能较好，适用于移动游戏等要求性能的场景

        //缺点:
        //照明效果可能不够精细，特别是在物体表面上的细节区域，因为颜色插值可能不足以捕捉到细微的照明变化

        //适用场景：
        //逐顶点光照适用于需要在有限资源下获得较好性能的场景，例如移动游戏
        #endregion

        #region 知识点二 逐片元光照
        //在哪计算：
        //片元着色器 回调函数中

        //计算方式：
        //逐片元光照会在每个像素（片元）上进行光照计算
        //这意味着每个像素都会根据其位置、法线、材质等信息独立地进行光照计算

        //优点：
        //逐片元光照提供了更高的精细度，可以捕捉到物体表面上的细微照明变化，提供更逼真的效果

        //缺点:
        //计算量较大，对于像素密集的场景需要更多的计算资源

        //适用场景：
        //逐片元光照通常用于需要高质量照明效果的PC和主机游戏，以及要求视觉逼真度较高的场景
        #endregion

        #region 知识点三 关于逐顶点光照的插值运算
        //我们不需要自己去处理这个插值运算
        //插值运算是由图形硬件（GPU）来执行的
        //GPU负责处理3D图形的渲染，包括顶点插值和像素插值等操作
        //这个过程在图形硬件中被高度优化过，因此在实时渲染中能够快速而高效地执行

        //我们只需要了解插值运算的大概规则即可
        //假设：
        //三角面片的三个顶点A、B、C
        //该三角面片中的任何像素P，首先会计算出它相对于3个顶点的位置权重
        //然后使用这个权重参与到P点的颜色计算中
        //PixelColorP = WeightA * ColorA + WeightB * ColorB + WeightC * ColorC
        #endregion

        #region 总结
        //光照效果的计算在顶点着色器和片元着色器中都可以做
        //在顶点着色器回调函数中：消耗低，效果差，适合低配设备
        //在片元着色器回调函数中：消耗高，效果好，适合高配设备
        //具体在哪里实现，根据项目实际情况而定

        //我们之后在学习光照模型时
        //每一种光照模型都会讲解两种实现
        //即 逐顶点 和 逐片元 光照
        #endregion
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
