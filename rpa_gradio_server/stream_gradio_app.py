import gradio as gr
import time

def stream_text(input_text):
    for i in range(1, 6):
        time.sleep(1)  # 模拟一些延迟，表示正在处理
        yield f"Step {i}: {input_text}"

# 使用gradio的Generator模式
output = gr.Textbox()
gr.Interface(fn=stream_text, inputs="text", outputs=output, live=True).launch()
