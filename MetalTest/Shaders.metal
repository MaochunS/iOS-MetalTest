//
//  Shaders.metal
//  MetalTest
//
//  Created by Maochun on 2023/9/13.
//

#include <metal_stdlib>
using namespace metal;

vertex float4 basic_vertex(                           // 1
  const device packed_float3* vertex_array [[ buffer(0) ]], // 2
  unsigned int vid [[ vertex_id ]]) {                 // 3
  return float4(vertex_array[vid], 1.0);              // 4
}

fragment half4 basic_fragment() { // 1
  return half4(1.0);              // 2
}

struct VertexIn{
    packed_float3 position;
    packed_float4 color;
};

struct VertexOut{
  float4 position [[position]];  //1
  float4 color;
};

struct Uniforms{
  float4x4 modelMatrix;
  float4x4 projectionMatrix;
};

vertex VertexOut basic_vertex2(                           // 1
    const device VertexIn* vertex_array [[ buffer(0) ]],   // 2
    unsigned int vid [[ vertex_id ]]) {

    VertexIn VertexIn = vertex_array[vid];                 // 3

    VertexOut VertexOut;
    VertexOut.position = float4(VertexIn.position,1);
    VertexOut.color = VertexIn.color;                       // 4

    return VertexOut;
}

fragment half4 basic_fragment2(VertexOut interpolated [[stage_in]]) {  //1
    return half4(interpolated.color[0], interpolated.color[1], interpolated.color[2], interpolated.color[3]); //2
}

vertex VertexOut basic_vertex3(
    const device VertexIn* vertex_array [[ buffer(0) ]],
    const device Uniforms&  uniforms    [[ buffer(1) ]],           //1
    unsigned int vid [[ vertex_id ]]) {

    float4x4 mv_Matrix = uniforms.modelMatrix;                     //2
    float4x4 proj_Matrix = uniforms.projectionMatrix;

    VertexIn VertexIn = vertex_array[vid];

    VertexOut VertexOut;
//    VertexOut.position = mv_Matrix * float4(VertexIn.position,1);  //3
    VertexOut.position = proj_Matrix * mv_Matrix * float4(VertexIn.position,1);

    VertexOut.color = VertexIn.color;

    return VertexOut;
}
