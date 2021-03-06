Shader "Hidden/Shader Forge/SFN_Cubemap" {
    Properties {
        _OutputMask ("Output Mask", Vector) = (1,1,1,1)
        _DIR ("DIR", 2D) = "black" {}
        _MIP ("MIP", 2D) = "black" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform float4 _OutputMask;
            uniform sampler2D _DIR;
            uniform sampler2D _MIP;

            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {

                // Read inputs
                float4 _dir = tex2D( _DIR, i.uv );
                float4 _mip = tex2D( _MIP, i.uv );

                // Operator
                float4 outputColor = float4(1,1,1,1);

                // Return
                return outputColor * _OutputMask;
            }
            ENDCG
        }
    }
}
