import gradio as gr
import requests

API_URL = 'http://ai-dify-api.sit.sf-express.com/v1/chat-messages'
HEADERS = {
    'Authorization': 'Bearer app-3BombSIZXh3SeE7DQQDLdE2f',
    'Content-Type': 'application/json'
}


def call_backend(query, stage, process_list, step_list, component_list):
    payload = {
        'query': query,
        'inputs': {
            'stage': stage,
            'disassembly_processes': process_list,
            'disassembly_steps': step_list,
            'generate_components': component_list
        },
        'response_mode': 'blocking',
        'conversation_id': '',
        'user': '123456'
    }
    response = requests.post(API_URL, headers=HEADERS, json=payload)

    #print(response)
    #import ipdb;ipdb.set_trace()

    if response.status_code == 200:
        return response.json()["answer"]
    else:
        return '调用后端服务时发生错误：' + response.text


def gradio_app(query, stage, process_list, step_list, component_list):#
    result = call_backend(query, stage, process_list, step_list, component_list)
    return result


iface = gr.Interface(
    fn=gradio_app,
    inputs=[
        gr.components.Textbox(lines=5, label='自然语言需求描述', value='合并2023年和2024年的《地区月度销售数据》，剔除《地区月度销售数据》和《网点明细销售数据》的港澳台数据，然后写入模板，刷新透视表和公式，生成报表和看板图片。'),
        gr.components.Dropdown(['拆解流程', '拆解步骤', '生成组件', '生成XML'], label='生成阶段', value='拆解流程'),
        gr.components.Textbox(lines=5, label='流程列表'),
        gr.components.Textbox(lines=5, label='步骤列表'),
        gr.components.Textbox(lines=5, label='组件列表')
    ],
    outputs=gr.components.Textbox(label='当前阶段结果'),
    title='RPA Assistant'
)

iface.launch(server_name="0.0.0.0", server_port=7888)
