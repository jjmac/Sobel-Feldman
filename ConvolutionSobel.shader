Shader "Custom/Convolution"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            //#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;




            fixed4 frag (v2f i) : SV_Target
            {
                // Sobel-Feldman filter convolution matrices
                fixed kernel1[9] = {1, 0, -1, 2, 0, -2, 1, 0, -1};
                #define WEIGHT1(index, value) value.rgb*kernel1[index]

                fixed4 topleft  = tex2D(_MainTex, float2(i.uv.x-_MainTex_TexelSize.x, i.uv.y-_MainTex_TexelSize.y));
                fixed4 top      = tex2D(_MainTex, float2(i.uv.x, i.uv.y-_MainTex_TexelSize.y));
                fixed4 topright = tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x, i.uv.y-_MainTex_TexelSize.y));
                fixed4 left     = tex2D(_MainTex, float2(i.uv.x-_MainTex_TexelSize.x, i.uv.y));
                fixed4 centre   = tex2D(_MainTex, float2(i.uv.x, i.uv.y));
                fixed4 right    = tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x, i.uv.y));
                fixed4 downleft = tex2D(_MainTex, float2(i.uv.x-_MainTex_TexelSize.x, i.uv.y+_MainTex_TexelSize.y));
                fixed4 down     = tex2D(_MainTex, float2(i.uv.x, i.uv.y+_MainTex_TexelSize.y));
                fixed4 downright= tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x, i.uv.y+_MainTex_TexelSize.y));    


                fixed4 col = tex2D(_MainTex, i.uv);
                fixed3 rgb = WEIGHT1(0, topleft)+WEIGHT1(1, top)+WEIGHT1(2, topright)+WEIGHT1(3, left)+WEIGHT1(4, centre)+WEIGHT1(5, right)+WEIGHT1(6, downleft)+WEIGHT1(7, down)+WEIGHT1(8, downright);
                col.rgb = rgb;
                return col;
            }
            ENDCG
        }
        Pass
        {
            CGPROGRAM
            //#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;




            fixed4 frag (v2f i) : SV_Target
            {
                // Sobel-Feldman filter convolution matrices
                fixed kernel2[9] = {1, 2, 1, 0, 0, 0, -1, -2, -1};
                #define WEIGHT2(index, value) value.rgb*kernel2[index]
                fixed4 topleft  = tex2D(_MainTex, float2(i.uv.x-_MainTex_TexelSize.x, i.uv.y-_MainTex_TexelSize.y));
                fixed4 top      = tex2D(_MainTex, float2(i.uv.x, i.uv.y-_MainTex_TexelSize.y));
                fixed4 topright = tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x, i.uv.y-_MainTex_TexelSize.y));
                fixed4 left     = tex2D(_MainTex, float2(i.uv.x-_MainTex_TexelSize.x, i.uv.y));
                fixed4 centre   = tex2D(_MainTex, float2(i.uv.x, i.uv.y));
                fixed4 right    = tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x, i.uv.y));
                fixed4 downleft = tex2D(_MainTex, float2(i.uv.x-_MainTex_TexelSize.x, i.uv.y+_MainTex_TexelSize.y));
                fixed4 down     = tex2D(_MainTex, float2(i.uv.x, i.uv.y+_MainTex_TexelSize.y));
                fixed4 downright= tex2D(_MainTex, float2(i.uv.x+_MainTex_TexelSize.x, i.uv.y+_MainTex_TexelSize.y));    


                fixed4 col = tex2D(_MainTex, i.uv);
                fixed3 rgb = WEIGHT2(0, topleft)+WEIGHT2(1, top)+WEIGHT2(2, topright)+WEIGHT2(3, left)+WEIGHT2(4, centre)+WEIGHT2(5, right)+WEIGHT2(6, downleft)+WEIGHT2(7, down)+WEIGHT2(8, downright);
                col.rgb = rgb;
                return col;
            }
            ENDCG
        }
    }
}
