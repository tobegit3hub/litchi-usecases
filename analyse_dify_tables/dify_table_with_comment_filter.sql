
-- 创建 `accounts` 表，用于存储用户账号信息
CREATE TABLE public.accounts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    name character varying(255) NOT NULL, -- 用户名
    email character varying(255) NOT NULL, -- 用户邮箱
    password character varying(255), -- 用户密码
    password_salt character varying(255), -- 密码加盐
    avatar character varying(255), -- 用户头像
    interface_language character varying(255), -- 用户界面语言偏好
    interface_theme character varying(255), -- 用户界面主题偏好
    timezone character varying(255), -- 用户所在时区
    last_login_at timestamp without time zone, -- 上次登录时间
    last_login_ip character varying(255), -- 上次登录IP
    status character varying(16) DEFAULT 'active'::character varying NOT NULL, -- 账号状态（如活跃、禁用等）
    initialized_at timestamp without time zone, -- 账号初始化时间
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 最后活跃时间
);


-- 创建 `api_requests` 表，用于存储API请求记录
CREATE TABLE public.api_requests (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    api_token_id uuid NOT NULL, -- 关联的API令牌ID
    path character varying(255) NOT NULL, -- 请求路径
    request text, -- 请求内容
    response text, -- 响应内容
    ip character varying(255) NOT NULL, -- 发起请求的IP地址
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
);


-- 创建 `app_dataset_joins` 表，用于存储应用与数据集的关联信息
CREATE TABLE public.app_dataset_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL -- 记录创建时间
);


-- 创建 `conversations` 表，用于存储对话记录
CREATE TABLE public.conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    app_model_config_id uuid, -- 关联的应用模型配置ID
    model_provider character varying(255), -- 模型提供商
    override_model_configs text, -- 重写的模型配置
    model_id character varying(255), -- 模型ID
    mode character varying(255) NOT NULL, -- 对话模式
    name character varying(255) NOT NULL, -- 对话名称
    summary text, -- 对话摘要
    inputs json, -- 输入数据（JSON格式）
    introduction text, -- 对话介绍
    system_instruction text, -- 系统指令
    system_instruction_tokens integer DEFAULT 0 NOT NULL, -- 系统指令的Token数量
    status character varying(255) NOT NULL, -- 对话状态
    from_source character varying(255) NOT NULL, -- 来源信息
    from_end_user_id uuid, -- 来源用户ID
    from_account_id uuid, -- 来源账号ID
    read_at timestamp without time zone, -- 阅读时间
    read_account_id uuid, -- 阅读账号ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    is_deleted boolean DEFAULT false NOT NULL, -- 是否被删除
    invoke_from character varying(255), -- 调用来源
    dialogue_count integer DEFAULT 0 NOT NULL -- 对话轮次
);


-- 创建 `dataset_collection_bindings` 表，用于存储数据集与集合的绑定信息
CREATE TABLE public.dataset_collection_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    provider_name character varying(40) NOT NULL, -- 提供商名称
    model_name character varying(255) NOT NULL, -- 模型名称
    collection_name character varying(64) NOT NULL, -- 集合名称
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    type character varying(40) DEFAULT 'dataset'::character varying NOT NULL -- 绑定类型
);

-- 创建 `dataset_keyword_tables` 表，用于存储数据集关键词表信息
CREATE TABLE public.dataset_keyword_tables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    keyword_table text NOT NULL, -- 关键词表内容
    data_source_type character varying(255) DEFAULT 'database'::character varying NOT NULL -- 数据源类型
);


-- 创建 `dataset_queries` 表，用于存储数据集查询信息
CREATE TABLE public.dataset_queries (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    content text NOT NULL, -- 查询内容
    source character varying(255) NOT NULL, -- 数据来源
    source_app_id uuid, -- 关联的应用ID
    created_by_role character varying NOT NULL, -- 创建用户的角色
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL -- 记录创建时间
);

-- 创建 `dataset_retriever_resources` 表，用于存储数据集检索资源信息
CREATE TABLE public.dataset_retriever_resources (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    message_id uuid NOT NULL, -- 关联的消息ID
    "position" integer NOT NULL, -- 数据位置
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    dataset_name text NOT NULL, -- 数据集名称
    document_id uuid NOT NULL, -- 关联的文档ID
    document_name text NOT NULL, -- 文档名称
    data_source_type text NOT NULL, -- 数据源类型
    segment_id uuid NOT NULL, -- 关联的分段ID
    score double precision, -- 评分
    content text NOT NULL, -- 内容
    hit_count integer, -- 命中次数
    word_count integer, -- 词数
    segment_position integer, -- 分段位置
    index_node_hash text, -- 索引节点哈希值
    retriever_from text NOT NULL, -- 检索来源
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL -- 记录创建时间
);

-- 创建 `datasets` 表，用于存储数据集信息
CREATE TABLE public.datasets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    name character varying(255) NOT NULL, -- 数据集名称
    description text, -- 数据集描述
    provider character varying(255) DEFAULT 'vendor'::character varying NOT NULL, -- 数据集提供商
    permission character varying(255) DEFAULT 'only_me'::character varying NOT NULL, -- 数据集权限
    data_source_type character varying(255), -- 数据源类型
    indexing_technique character varying(255), -- 索引技术
    index_struct text, -- 索引结构
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_by uuid, -- 更新用户ID
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    embedding_model character varying(255) DEFAULT 'text-embedding-ada-002'::character varying, -- 嵌入模型
    embedding_model_provider character varying(255) DEFAULT 'openai'::character varying, -- 嵌入模型提供商
    collection_binding_id uuid, -- 关联的集合绑定ID
    retrieval_model jsonb -- 检索模型
);

-- 创建 `document_segments` 表，用于存储文档分段信息
CREATE TABLE public.document_segments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    document_id uuid NOT NULL, -- 关联的文档ID
    "position" integer NOT NULL, -- 文档位置
    content text NOT NULL, -- 文档内容
    word_count integer NOT NULL, -- 词数
    tokens integer NOT NULL, -- Token数量
    keywords json, -- 关键词信息
    index_node_id character varying(255), -- 索引节点ID
    index_node_hash character varying(255), -- 索引节点哈希值
    hit_count integer NOT NULL, -- 命中次数
    enabled boolean DEFAULT true NOT NULL, -- 是否启用
    disabled_at timestamp without time zone, -- 禁用时间
    disabled_by uuid, -- 禁用用户ID
    status character varying(255) DEFAULT 'waiting'::character varying NOT NULL, -- 分段状态
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    indexing_at timestamp without time zone, -- 索引时间
    completed_at timestamp without time zone, -- 完成时间
    error text, -- 错误信息
    stopped_at timestamp without time zone, -- 停止时间
    answer text, -- 回答内容
    updated_by uuid, -- 更新用户ID
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `documents` 表，用于存储文档信息
CREATE TABLE public.documents (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    "position" integer NOT NULL, -- 文档位置
    data_source_type character varying(255) NOT NULL, -- 数据源类型
    data_source_info text, -- 数据源信息
    dataset_process_rule_id uuid, -- 关联的数据集处理规则ID
    batch character varying(255) NOT NULL, -- 批次信息
    name character varying(255) NOT NULL, -- 文档名称
    created_from character varying(255) NOT NULL, -- 文档创建来源
    created_by uuid NOT NULL, -- 创建用户ID
    created_api_request_id uuid, -- 关联的API请求ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    processing_started_at timestamp without time zone, -- 处理开始时间
    file_id text, -- 文件ID
    word_count integer, -- 词数
    parsing_completed_at timestamp without time zone, -- 解析完成时间
    cleaning_completed_at timestamp without time zone, -- 清理完成时间
    splitting_completed_at timestamp without time zone, -- 分段完成时间
    tokens integer, -- Token数量
    indexing_latency double precision, -- 索引延迟
    completed_at timestamp without time zone, -- 完成时间
    is_paused boolean DEFAULT false, -- 是否暂停
    paused_by uuid, -- 暂停用户ID
    paused_at timestamp without time zone, -- 暂停时间
    error text, -- 错误信息
    stopped_at timestamp without time zone, -- 停止时间
    indexing_status character varying(255) DEFAULT 'waiting'::character varying NOT NULL, -- 索引状态
    enabled boolean DEFAULT true NOT NULL, -- 是否启用
    disabled_at timestamp without time zone, -- 禁用时间
    disabled_by uuid, -- 禁用用户ID
    archived boolean DEFAULT false NOT NULL, -- 是否归档
    archived_reason character varying(255), -- 归档原因
    archived_by uuid, -- 归档用户ID
    archived_at timestamp without time zone, -- 归档时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    doc_type character varying(40), -- 文档类型
    doc_metadata json, -- 文档元数据
    doc_form character varying(255) DEFAULT 'text_model'::character varying NOT NULL, -- 文档形式
    doc_language character varying(255) -- 文档语言
);

-- 创建 `embeddings` 表，用于存储嵌入向量
CREATE TABLE public.embeddings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    hash character varying(64) NOT NULL, -- 向量哈希值
    embedding bytea NOT NULL, -- 嵌入向量（二进制数据）
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    model_name character varying(255) DEFAULT 'text-embedding-ada-002'::character varying NOT NULL, -- 模型名称
    provider_name character varying(255) DEFAULT ''::character varying NOT NULL -- 提供商名称
);

-- 创建 `end_users` 表，用于存储终端用户信息
CREATE TABLE public.end_users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    app_id uuid, -- 关联的应用ID
    type character varying(255) NOT NULL, -- 用户类型
    external_user_id character varying(255), -- 外部用户ID
    name character varying(255), -- 用户名
    is_anonymous boolean DEFAULT true NOT NULL, -- 是否匿名
    session_id character varying(255) NOT NULL, -- 会话ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `installed_apps` 表，用于存储已安装的应用信息
CREATE TABLE public.installed_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    app_id uuid NOT NULL, -- 关联的应用ID
    app_owner_tenant_id uuid NOT NULL, -- 关联的应用所有者租户ID
    "position" integer NOT NULL, -- 安装位置
    is_pinned boolean DEFAULT false NOT NULL, -- 是否固定
    last_used_at timestamp without time zone, -- 最后使用时间
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
);


-- 创建 `message_feedbacks` 表，用于存储消息反馈信息
CREATE TABLE public.message_feedbacks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    conversation_id uuid NOT NULL, -- 关联的对话ID
    message_id uuid NOT NULL, -- 关联的消息ID
    rating character varying(255) NOT NULL, -- 评分
    content text, -- 反馈内容
    from_source character varying(255) NOT NULL, -- 来源信息
    from_end_user_id uuid, -- 来源用户ID
    from_account_id uuid, -- 来源账号ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `messages` 表，用于存储消息信息
CREATE TABLE public.messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    model_provider character varying(255), -- 模型提供商
    model_id character varying(255), -- 模型ID
    override_model_configs text, -- 重写的模型配置
    conversation_id uuid NOT NULL, -- 关联的对话ID
    inputs json, -- 输入数据（JSON格式）
    query text NOT NULL, -- 查询内容
    message json NOT NULL, -- 消息内容（JSON格式）
    message_tokens integer DEFAULT 0 NOT NULL, -- 消息Token数量
    message_unit_price numeric(10,4) NOT NULL, -- 消息单价
    answer text NOT NULL, -- 回答内容
    answer_tokens integer DEFAULT 0 NOT NULL, -- 回答Token数量
    answer_unit_price numeric(10,4) NOT NULL, -- 回答单价
    provider_response_latency double precision DEFAULT 0 NOT NULL, -- 提供商响应延迟
    total_price numeric(10,7), -- 总价格
    currency character varying(255) NOT NULL, -- 货币单位
    from_source character varying(255) NOT NULL, -- 来源信息
    from_end_user_id uuid, -- 来源用户ID
    from_account_id uuid, -- 来源账号ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    agent_based boolean DEFAULT false NOT NULL, -- 是否基于代理
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL, -- 消息单价单位
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL, -- 回答单价单位
    workflow_run_id uuid, -- 关联的工作流运行ID
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL, -- 消息状态
    error text, -- 错误信息
    message_metadata text, -- 消息元数据
    invoke_from character varying(255) -- 调用来源
);


-- 创建 `pinned_conversations` 表，用于存储固定的对话信息
CREATE TABLE public.pinned_conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    conversation_id uuid NOT NULL, -- 关联的对话ID
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL -- 创建者角色
);

-- 创建 `saved_messages` 表，用于存储已保存的消息
CREATE TABLE public.saved_messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    message_id uuid NOT NULL, -- 关联的消息ID
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL -- 创建者角色
);


-- 创建 `tenant_account_joins` 表，用于存储租户与用户账号的关联信息
CREATE TABLE public.tenant_account_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    account_id uuid NOT NULL, -- 关联的用户账号ID
    role character varying(16) DEFAULT 'normal'::character varying NOT NULL, -- 用户角色
    invited_by uuid, -- 邀请者ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    current boolean DEFAULT false NOT NULL -- 是否当前租户
);


-- 创建 `tenants` 表，用于存储租户信息
CREATE TABLE public.tenants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    name character varying(255) NOT NULL, -- 租户名称
    encrypt_public_key text, -- 公钥加密信息
    plan character varying(255) DEFAULT 'basic'::character varying NOT NULL, -- 计划类型
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL, -- 租户状态
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    custom_config text -- 自定义配置
);

-- 创建 `workflow_app_logs` 表，用于存储工作流应用日志
CREATE TABLE public.workflow_app_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    app_id uuid NOT NULL, -- 关联的应用ID
    workflow_id uuid NOT NULL, -- 关联的工作流ID
    workflow_run_id uuid NOT NULL, -- 关联的工作流运行ID
    created_from character varying(255) NOT NULL, -- 创建来源
    created_by_role character varying(255) NOT NULL, -- 创建者角色
    created_by uuid NOT NULL, -- 创建者ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
);

-- 创建 `workflow_node_executions` 表，用于存储工作流节点执行信息
CREATE TABLE public.workflow_node_executions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    app_id uuid NOT NULL, -- 关联的应用ID
    workflow_id uuid NOT NULL, -- 关联的工作流ID
    triggered_from character varying(255) NOT NULL, -- 触发来源
    workflow_run_id uuid, -- 关联的工作流运行ID
    index integer NOT NULL, -- 节点索引
    predecessor_node_id character varying(255), -- 前置节点ID
    node_id character varying(255) NOT NULL, -- 节点ID
    node_type character varying(255) NOT NULL, -- 节点类型
    title character varying(255) NOT NULL, -- 节点标题
    inputs text, -- 输入数据
    process_data text, -- 处理数据
    outputs text, -- 输出数据
    status character varying(255) NOT NULL, -- 节点状态
    error text, -- 错误信息
    elapsed_time double precision DEFAULT 0 NOT NULL, -- 执行耗时
    execution_metadata text, -- 执行元数据
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    created_by_role character varying(255) NOT NULL, -- 创建者角色
    created_by uuid NOT NULL, -- 创建者ID
    finished_at timestamp without time zone -- 完成时间
);

-- 创建 `workflow_runs` 表，用于存储工作流运行信息
CREATE TABLE public.workflow_runs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    app_id uuid NOT NULL, -- 关联的应用ID
    sequence_number integer NOT NULL, -- 运行序列号
    workflow_id uuid NOT NULL, -- 关联的工作流ID
    type character varying(255) NOT NULL, -- 运行类型
    triggered_from character varying(255) NOT NULL, -- 触发来源
    version character varying(255) NOT NULL, -- 版本号
    graph text, -- 图形数据
    inputs text, -- 输入数据
    status character varying(255) NOT NULL, -- 运行状态
    outputs text, -- 输出数据
    error text, -- 错误信息
    elapsed_time double precision DEFAULT 0 NOT NULL, -- 执行耗时
    total_tokens integer DEFAULT 0 NOT NULL, -- 总Token数量
    total_steps integer DEFAULT 0, -- 总步骤数量
    created_by_role character varying(255) NOT NULL, -- 创建者角色
    created_by uuid NOT NULL, -- 创建者ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    finished_at timestamp without time zone -- 完成时间
);

-- 创建 `workflows` 表，用于存储工作流信息
CREATE TABLE public.workflows (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    app_id uuid NOT NULL, -- 关联的应用ID
    type character varying(255) NOT NULL, -- 工作流类型
    version character varying(255) NOT NULL, -- 版本号
    graph text, -- 图形数据
    features text, -- 特性信息
    created_by uuid NOT NULL, -- 创建者ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_by uuid, -- 更新者ID
    updated_at timestamp without time zone, -- 更新时间
    environment_variables text DEFAULT '{}'::text NOT NULL, -- 环境变量
    conversation_variables text DEFAULT '{}'::text NOT NULL -- 对话变量
);

