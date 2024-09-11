-- 创建 `account_integrates` 表，用于存储用户账号整合信息
CREATE TABLE public.account_integrates (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    account_id uuid NOT NULL, -- 关联的用户账号ID
    provider character varying(16) NOT NULL, -- 第三方账号提供商的名称
    open_id character varying(255) NOT NULL, -- 第三方账号的唯一标识
    encrypted_token character varying(255) NOT NULL, -- 加密的访问令牌
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

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

-- 创建 `alembic_version` 表，用于存储数据库版本信息（由Alembic管理）
CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL -- 版本号
);

-- 创建 `api_based_extensions` 表，用于存储基于API的扩展信息
CREATE TABLE public.api_based_extensions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    name character varying(255) NOT NULL, -- 扩展名称
    api_endpoint character varying(255) NOT NULL, -- API端点URL
    api_key text NOT NULL, -- API密钥
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
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

-- 创建 `api_tokens` 表，用于存储API访问令牌
CREATE TABLE public.api_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid, -- 关联的应用ID
    type character varying(16) NOT NULL, -- 令牌类型
    token character varying(255) NOT NULL, -- 令牌值
    last_used_at timestamp without time zone, -- 最后使用时间
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    tenant_id uuid -- 关联的租户ID
);

-- 创建 `app_annotation_hit_histories` 表，用于存储应用标注命中历史记录
CREATE TABLE public.app_annotation_hit_histories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    annotation_id uuid NOT NULL, -- 关联的标注ID
    source text NOT NULL, -- 数据来源
    question text NOT NULL, -- 问题文本
    account_id uuid NOT NULL, -- 关联的用户账号ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    score double precision DEFAULT 0 NOT NULL, -- 评分
    message_id uuid NOT NULL, -- 关联的消息ID
    annotation_question text NOT NULL, -- 标注问题
    annotation_content text NOT NULL -- 标注内容
);

-- 创建 `app_annotation_settings` 表，用于存储应用标注设置
CREATE TABLE public.app_annotation_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    score_threshold double precision DEFAULT 0 NOT NULL, -- 评分阈值
    collection_binding_id uuid NOT NULL, -- 关联的数据集绑定ID
    created_user_id uuid NOT NULL, -- 创建用户的ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_user_id uuid NOT NULL, -- 更新用户的ID
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `app_dataset_joins` 表，用于存储应用与数据集的关联信息
CREATE TABLE public.app_dataset_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL -- 记录创建时间
);

-- 创建 `app_model_configs` 表，用于存储应用模型配置
CREATE TABLE public.app_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    provider character varying(255), -- 模型提供商
    model_id character varying(255), -- 模型ID
    configs json, -- 配置信息（JSON格式）
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    opening_statement text, -- 开场白
    suggested_questions text, -- 建议问题
    suggested_questions_after_answer text, -- 回答后的建议问题
    more_like_this text, -- 更多类似内容
    model text, -- 模型描述
    user_input_form text, -- 用户输入表单
    pre_prompt text, -- 前置提示
    agent_mode text, -- 代理模式
    speech_to_text text, -- 语音转文字
    sensitive_word_avoidance text, -- 敏感词规避
    retriever_resource text, -- 检索资源
    dataset_query_variable character varying(255), -- 数据集查询变量
    prompt_type character varying(255) DEFAULT 'simple'::character varying NOT NULL, -- 提示类型
    chat_prompt_config text, -- 聊天提示配置
    completion_prompt_config text, -- 完成提示配置
    dataset_configs text, -- 数据集配置
    external_data_tools text, -- 外部数据工具
    file_upload text, -- 文件上传配置
    text_to_speech text -- 文字转语音配置
);

-- 创建 `apps` 表，用于存储应用信息
CREATE TABLE public.apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    name character varying(255) NOT NULL, -- 应用名称
    mode character varying(255) NOT NULL, -- 应用模式
    icon character varying(255), -- 应用图标
    icon_background character varying(255), -- 应用图标背景
    app_model_config_id uuid, -- 关联的应用模型配置ID
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL, -- 应用状态
    enable_site boolean NOT NULL, -- 是否启用网站功能
    enable_api boolean NOT NULL, -- 是否启用API功能
    api_rpm integer DEFAULT 0 NOT NULL, -- API每分钟请求数限制
    api_rph integer DEFAULT 0 NOT NULL, -- API每小时请求数限制
    is_demo boolean DEFAULT false NOT NULL, -- 是否为演示应用
    is_public boolean DEFAULT false NOT NULL, -- 是否公开应用
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    is_universal boolean DEFAULT false NOT NULL, -- 是否为通用应用
    workflow_id uuid, -- 关联的工作流ID
    description text DEFAULT ''::character varying NOT NULL, -- 应用描述
    tracing text, -- 跟踪信息
    max_active_requests integer, -- 最大活跃请求数
    icon_type character varying(255) -- 图标类型
);

-- 创建 `celery_taskmeta` 表，用于存储Celery任务元数据
CREATE TABLE public.celery_taskmeta (
    id integer DEFAULT nextval('public.task_id_sequence'::regclass) NOT NULL, -- 主键，使用自动递增的整数ID
    task_id character varying(155), -- 任务ID
    status character varying(50), -- 任务状态
    result bytea, -- 任务结果（二进制数据）
    date_done timestamp without time zone, -- 任务完成时间
    traceback text, -- 错误回溯信息
    name character varying(155), -- 任务名称
    args bytea, -- 任务参数（二进制数据）
    kwargs bytea, -- 任务关键字参数（二进制数据）
    worker character varying(155), -- 执行任务的工作进程
    retries integer, -- 重试次数
    queue character varying(155) -- 任务队列名称
);

-- 创建 `celery_tasksetmeta` 表，用于存储Celery任务集元数据
CREATE TABLE public.celery_tasksetmeta (
    id integer DEFAULT nextval('public.taskset_id_sequence'::regclass) NOT NULL, -- 主键，使用自动递增的整数ID
    taskset_id character varying(155), -- 任务集ID
    result bytea, -- 任务集结果（二进制数据）
    date_done timestamp without time zone -- 任务集完成时间
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

-- 创建 `data_source_api_key_auth_bindings` 表，用于存储数据源API密钥绑定信息
CREATE TABLE public.data_source_api_key_auth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    category character varying(255) NOT NULL, -- 分类信息
    provider character varying(255) NOT NULL, -- 提供商信息
    credentials text, -- 凭据信息
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    disabled boolean DEFAULT false -- 是否禁用
);

-- 创建 `data_source_oauth_bindings` 表，用于存储数据源OAuth绑定信息
CREATE TABLE public.data_source_oauth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    access_token character varying(255) NOT NULL, -- 访问令牌
    provider character varying(255) NOT NULL, -- 提供商信息
    source_info jsonb NOT NULL, -- 来源信息（JSONB格式）
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    disabled boolean DEFAULT false -- 是否禁用
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

-- 创建 `dataset_permissions` 表，用于存储数据集权限信息
CREATE TABLE public.dataset_permissions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    account_id uuid NOT NULL, -- 关联的用户账号ID
    has_permission boolean DEFAULT true NOT NULL, -- 是否拥有权限
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    tenant_id uuid NOT NULL -- 关联的租户ID
);

-- 创建 `dataset_process_rules` 表，用于存储数据集处理规则
CREATE TABLE public.dataset_process_rules (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    dataset_id uuid NOT NULL, -- 关联的数据集ID
    mode character varying(255) DEFAULT 'automatic'::character varying NOT NULL, -- 处理模式
    rules text, -- 处理规则
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
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

-- 创建 `dify_setups` 表，用于存储系统设置
CREATE TABLE public.dify_setups (
    version character varying(255) NOT NULL, -- 版本号
    setup_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 设置时间
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

-- 创建 `invitation_codes` 表，用于存储邀请码信息
CREATE TABLE public.invitation_codes (
    id integer NOT NULL, -- 主键
    batch character varying(255) NOT NULL, -- 批次信息
    code character varying(32) NOT NULL, -- 邀请码
    status character varying(16) DEFAULT 'unused'::character varying NOT NULL, -- 邀请码状态
    used_at timestamp without time zone, -- 使用时间
    used_by_tenant_id uuid, -- 使用者的租户ID
    used_by_account_id uuid, -- 使用者的账号ID
    deprecated_at timestamp without time zone, -- 作废时间
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
);

-- 创建 `load_balancing_model_configs` 表，用于存储负载均衡模型配置
CREATE TABLE public.load_balancing_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    model_name character varying(255) NOT NULL, -- 模型名称
    model_type character varying(40) NOT NULL, -- 模型类型
    name character varying(255) NOT NULL, -- 配置名称
    encrypted_config text, -- 加密的配置
    enabled boolean DEFAULT true NOT NULL, -- 是否启用
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `message_agent_thoughts` 表，用于存储消息代理思维记录
CREATE TABLE public.message_agent_thoughts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    message_id uuid NOT NULL, -- 关联的消息ID
    message_chain_id uuid, -- 关联的消息链ID
    "position" integer NOT NULL, -- 位置
    thought text, -- 思维内容
    tool text, -- 工具名称
    tool_input text, -- 工具输入
    observation text, -- 观察结果
    tool_process_data text, -- 工具处理数据
    message text, -- 消息内容
    message_token integer, -- 消息Token数
    message_unit_price numeric, -- 消息单价
    answer text, -- 回答内容
    answer_token integer, -- 回答Token数
    answer_unit_price numeric, -- 回答单价
    tokens integer, -- Token数量
    total_price numeric, -- 总价格
    currency character varying, -- 货币单位
    latency double precision, -- 延迟
    created_by_role character varying NOT NULL, -- 创建者角色
    created_by uuid NOT NULL, -- 创建者ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 记录创建时间
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL, -- 消息单价单位
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL, -- 回答单价单位
    message_files text, -- 消息文件
    tool_labels_str text DEFAULT '{}'::text NOT NULL, -- 工具标签
    tool_meta_str text DEFAULT '{}'::text NOT NULL -- 工具元数据
);

-- 创建 `message_annotations` 表，用于存储消息标注信息
CREATE TABLE public.message_annotations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    conversation_id uuid, -- 关联的对话ID
    message_id uuid, -- 关联的消息ID
    content text NOT NULL, -- 标注内容
    account_id uuid NOT NULL, -- 关联的用户账号ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    question text, -- 问题文本
    hit_count integer DEFAULT 0 NOT NULL -- 命中次数
);

-- 创建 `message_chains` 表，用于存储消息链信息
CREATE TABLE public.message_chains (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    message_id uuid NOT NULL, -- 关联的消息ID
    type character varying(255) NOT NULL, -- 消息链类型
    input text, -- 输入内容
    output text, -- 输出内容
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL -- 记录创建时间
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

-- 创建 `message_files` 表，用于存储消息文件信息
CREATE TABLE public.message_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    message_id uuid NOT NULL, -- 关联的消息ID
    type character varying(255) NOT NULL, -- 文件类型
    transfer_method character varying(255) NOT NULL, -- 传输方法
    url text, -- 文件URL
    upload_file_id uuid, -- 关联的上传文件ID
    created_by_role character varying(255) NOT NULL, -- 创建者角色
    created_by uuid NOT NULL, -- 创建者ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    belongs_to character varying(255) -- 归属信息
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

-- 创建 `operation_logs` 表，用于存储操作日志
CREATE TABLE public.operation_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    account_id uuid NOT NULL, -- 关联的用户账号ID
    action character varying(255) NOT NULL, -- 操作类型
    content json, -- 操作内容（JSON格式）
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    created_ip character varying(255) NOT NULL, -- 操作IP地址
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
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

-- 创建 `provider_model_settings` 表，用于存储提供商模型设置
CREATE TABLE public.provider_model_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    model_name character varying(255) NOT NULL, -- 模型名称
    model_type character varying(40) NOT NULL, -- 模型类型
    enabled boolean DEFAULT true NOT NULL, -- 是否启用
    load_balancing_enabled boolean DEFAULT false NOT NULL, -- 是否启用负载均衡
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `provider_models` 表，用于存储提供商模型信息
CREATE TABLE public.provider_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    model_name character varying(255) NOT NULL, -- 模型名称
    model_type character varying(40) NOT NULL, -- 模型类型
    encrypted_config text, -- 加密配置
    is_valid boolean DEFAULT false NOT NULL, -- 是否有效
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `provider_orders` 表，用于存储提供商订单信息
CREATE TABLE public.provider_orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    account_id uuid NOT NULL, -- 关联的用户账号ID
    payment_product_id character varying(191) NOT NULL, -- 支付产品ID
    payment_id character varying(191), -- 支付ID
    transaction_id character varying(191), -- 交易ID
    quantity integer DEFAULT 1 NOT NULL, -- 数量
    currency character varying(40), -- 货币单位
    total_amount integer, -- 总金额
    payment_status character varying(40) DEFAULT 'wait_pay'::character varying NOT NULL, -- 支付状态
    paid_at timestamp without time zone, -- 支付时间
    pay_failed_at timestamp without time zone, -- 支付失败时间
    refunded_at timestamp without time zone, -- 退款时间
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `providers` 表，用于存储提供商信息
CREATE TABLE public.providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    provider_type character varying(40) DEFAULT 'custom'::character varying NOT NULL, -- 提供商类型
    encrypted_config text, -- 加密配置
    is_valid boolean DEFAULT false NOT NULL, -- 是否有效
    last_used timestamp without time zone, -- 最后使用时间
    quota_type character varying(40) DEFAULT ''::character varying, -- 配额类型
    quota_limit bigint, -- 配额上限
    quota_used bigint, -- 已用配额
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `recommended_apps` 表，用于存储推荐应用信息
CREATE TABLE public.recommended_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    description json NOT NULL, -- 描述信息（JSON格式）
    copyright character varying(255) NOT NULL, -- 版权信息
    privacy_policy character varying(255) NOT NULL, -- 隐私政策
    category character varying(255) NOT NULL, -- 应用类别
    "position" integer NOT NULL, -- 排名位置
    is_listed boolean NOT NULL, -- 是否列出
    install_count integer NOT NULL, -- 安装次数
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    language character varying(255) DEFAULT 'en-US'::character varying NOT NULL, -- 语言设置
    custom_disclaimer character varying(255) -- 自定义免责声明
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

-- 创建 `sites` 表，用于存储站点信息
CREATE TABLE public.sites (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    title character varying(255) NOT NULL, -- 站点标题
    icon character varying(255), -- 站点图标
    icon_background character varying(255), -- 图标背景
    description text, -- 站点描述
    default_language character varying(255) NOT NULL, -- 默认语言
    copyright character varying(255), -- 版权信息
    privacy_policy character varying(255), -- 隐私政策
    customize_domain character varying(255), -- 自定义域名
    customize_token_strategy character varying(255) NOT NULL, -- 自定义令牌策略
    prompt_public boolean DEFAULT false NOT NULL, -- 是否公开提示
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL, -- 站点状态
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    code character varying(255), -- 站点代码
    custom_disclaimer character varying(255), -- 自定义免责声明
    show_workflow_steps boolean DEFAULT true NOT NULL, -- 是否显示工作流程步骤
    chat_color_theme character varying(255), -- 聊天颜色主题
    chat_color_theme_inverted boolean DEFAULT false NOT NULL, -- 是否反转颜色主题
    icon_type character varying(255) -- 图标类型
);

-- 创建 `tag_bindings` 表，用于存储标签绑定信息
CREATE TABLE public.tag_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid, -- 关联的租户ID
    tag_id uuid, -- 关联的标签ID
    target_id uuid, -- 关联的目标ID
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
);

-- 创建 `tags` 表，用于存储标签信息
CREATE TABLE public.tags (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid, -- 关联的租户ID
    type character varying(16) NOT NULL, -- 标签类型
    name character varying(255) NOT NULL, -- 标签名称
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录创建时间
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

-- 创建 `tenant_default_models` 表，用于存储租户默认模型信息
CREATE TABLE public.tenant_default_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    model_name character varying(255) NOT NULL, -- 模型名称
    model_type character varying(40) NOT NULL, -- 模型类型
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `tenant_preferred_model_providers` 表，用于存储租户首选模型提供商信息
CREATE TABLE public.tenant_preferred_model_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    provider_name character varying(255) NOT NULL, -- 提供商名称
    preferred_provider_type character varying(40) NOT NULL, -- 首选提供商类型
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
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

-- 创建 `tool_api_providers` 表，用于存储工具API提供商信息
CREATE TABLE public.tool_api_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    name character varying(40) NOT NULL, -- 提供商名称
    schema text NOT NULL, -- 模式信息
    schema_type_str character varying(40) NOT NULL, -- 模式类型
    user_id uuid NOT NULL, -- 用户ID
    tenant_id uuid NOT NULL, -- 租户ID
    tools_str text NOT NULL, -- 工具信息
    icon character varying(255) NOT NULL, -- 图标
    credentials_str text NOT NULL, -- 凭据信息
    description text NOT NULL, -- 描述信息
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    privacy_policy character varying(255), -- 隐私政策
    custom_disclaimer character varying(255) -- 自定义免责声明
);

-- 创建 `tool_builtin_providers` 表，用于存储内置工具提供商信息
CREATE TABLE public.tool_builtin_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid, -- 关联的租户ID
    user_id uuid NOT NULL, -- 用户ID
    provider character varying(40) NOT NULL, -- 提供商名称
    encrypted_credentials text, -- 加密凭证
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `tool_conversation_variables` 表，用于存储工具对话变量信息
CREATE TABLE public.tool_conversation_variables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    user_id uuid NOT NULL, -- 用户ID
    tenant_id uuid NOT NULL, -- 租户ID
    conversation_id uuid NOT NULL, -- 对话ID
    variables_str text NOT NULL, -- 变量信息
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `tool_files` 表，用于存储工具文件信息
CREATE TABLE public.tool_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    user_id uuid NOT NULL, -- 用户ID
    tenant_id uuid NOT NULL, -- 租户ID
    conversation_id uuid, -- 关联的对话ID
    file_key character varying(255) NOT NULL, -- 文件键
    mimetype character varying(255) NOT NULL, -- 文件类型
    original_url character varying(2048) -- 原始文件URL
);

-- 创建 `tool_label_bindings` 表，用于存储工具标签绑定信息
CREATE TABLE public.tool_label_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tool_id character varying(64) NOT NULL, -- 工具ID
    tool_type character varying(40) NOT NULL, -- 工具类型
    label_name character varying(40) NOT NULL -- 标签名称
);

-- 创建 `tool_model_invokes` 表，用于存储工具模型调用信息
CREATE TABLE public.tool_model_invokes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    user_id uuid NOT NULL, -- 用户ID
    tenant_id uuid NOT NULL, -- 租户ID
    provider character varying(40) NOT NULL, -- 提供商名称
    tool_type character varying(40) NOT NULL, -- 工具类型
    tool_name character varying(40) NOT NULL, -- 工具名称
    model_parameters text NOT NULL, -- 模型参数
    prompt_messages text NOT NULL, -- 提示消息
    model_response text NOT NULL, -- 模型响应
    prompt_tokens integer DEFAULT 0 NOT NULL, -- 提示Token数量
    answer_tokens integer DEFAULT 0 NOT NULL, -- 回答Token数量
    answer_unit_price numeric(10,4) NOT NULL, -- 回答单价
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL, -- 回答单价单位
    provider_response_latency double precision DEFAULT 0 NOT NULL, -- 提供商响应延迟
    total_price numeric(10,7), -- 总价格
    currency character varying(255) NOT NULL, -- 货币单位
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `tool_providers` 表，用于存储工具提供商信息
CREATE TABLE public.tool_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    tool_name character varying(40) NOT NULL, -- 工具名称
    encrypted_credentials text, -- 加密凭证
    is_enabled boolean DEFAULT false NOT NULL, -- 是否启用
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `tool_published_apps` 表，用于存储已发布的工具应用信息
CREATE TABLE public.tool_published_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    user_id uuid NOT NULL, -- 用户ID
    description text NOT NULL, -- 描述信息
    llm_description text NOT NULL, -- LLM描述
    query_description text NOT NULL, -- 查询描述
    query_name character varying(40) NOT NULL, -- 查询名称
    tool_name character varying(40) NOT NULL, -- 工具名称
    author character varying(40) NOT NULL, -- 作者名称
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL -- 记录更新时间
);

-- 创建 `tool_workflow_providers` 表，用于存储工具工作流提供商信息
CREATE TABLE public.tool_workflow_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    name character varying(40) NOT NULL, -- 提供商名称
    icon character varying(255) NOT NULL, -- 图标
    app_id uuid NOT NULL, -- 关联的应用ID
    user_id uuid NOT NULL, -- 用户ID
    tenant_id uuid NOT NULL, -- 租户ID
    description text NOT NULL, -- 描述信息
    parameter_configuration text DEFAULT '[]'::text NOT NULL, -- 参数配置
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录更新时间
    privacy_policy character varying(255) DEFAULT ''::character varying, -- 隐私政策
    version character varying(255) DEFAULT ''::character varying NOT NULL, -- 版本号
    label character varying(255) DEFAULT ''::character varying NOT NULL -- 标签
);

-- 创建 `trace_app_config` 表，用于存储跟踪应用配置
CREATE TABLE public.trace_app_config (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    app_id uuid NOT NULL, -- 关联的应用ID
    tracing_provider character varying(255), -- 跟踪提供商
    tracing_config json, -- 跟踪配置
    created_at timestamp without time zone DEFAULT now() NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT now() NOT NULL, -- 记录更新时间
    is_active boolean DEFAULT true NOT NULL -- 是否激活
);

-- 创建 `upload_files` 表，用于存储上传的文件信息
CREATE TABLE public.upload_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL, -- 主键，使用UUID自动生成
    tenant_id uuid NOT NULL, -- 关联的租户ID
    storage_type character varying(255) NOT NULL, -- 存储类型
    key character varying(255) NOT NULL, -- 文件键
    name character varying(255) NOT NULL, -- 文件名称
    size integer NOT NULL, -- 文件大小
    extension character varying(255) NOT NULL, -- 文件扩展名
    mime_type character varying(255), -- 文件MIME类型
    created_by uuid NOT NULL, -- 创建用户ID
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    used boolean DEFAULT false NOT NULL, -- 是否使用
    used_by uuid, -- 使用者ID
    used_at timestamp without time zone, -- 使用时间
    hash character varying(255), -- 文件哈希值
    created_by_role character varying(255) DEFAULT 'account'::character varying NOT NULL -- 创建者角色
);

-- 创建 `workflow__conversation_variables` 表，用于存储工作流对话变量信息
CREATE TABLE public.workflow__conversation_variables (
    id uuid NOT NULL, -- 主键，使用UUID自动生成
    conversation_id uuid NOT NULL, -- 关联的对话ID
    app_id uuid NOT NULL, -- 关联的应用ID
    data text NOT NULL, -- 数据内容
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, -- 记录创建时间
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL -- 记录更新时间
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

