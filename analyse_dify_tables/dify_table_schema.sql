CREATE TABLE public.account_integrates (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    provider character varying(16) NOT NULL,
    open_id character varying(255) NOT NULL,
    encrypted_token character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.accounts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    password_salt character varying(255),
    avatar character varying(255),
    interface_language character varying(255),
    interface_theme character varying(255),
    timezone character varying(255),
    last_login_at timestamp without time zone,
    last_login_ip character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    initialized_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);
CREATE TABLE public.api_based_extensions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    api_endpoint character varying(255) NOT NULL,
    api_key text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.api_requests (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    api_token_id uuid NOT NULL,
    path character varying(255) NOT NULL,
    request text,
    response text,
    ip character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.api_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid,
    type character varying(16) NOT NULL,
    token character varying(255) NOT NULL,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    tenant_id uuid
);
CREATE TABLE public.app_annotation_hit_histories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    annotation_id uuid NOT NULL,
    source text NOT NULL,
    question text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    score double precision DEFAULT 0 NOT NULL,
    message_id uuid NOT NULL,
    annotation_question text NOT NULL,
    annotation_content text NOT NULL
);
CREATE TABLE public.app_annotation_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    score_threshold double precision DEFAULT 0 NOT NULL,
    collection_binding_id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_user_id uuid NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.app_dataset_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE public.app_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    provider character varying(255),
    model_id character varying(255),
    configs json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    opening_statement text,
    suggested_questions text,
    suggested_questions_after_answer text,
    more_like_this text,
    model text,
    user_input_form text,
    pre_prompt text,
    agent_mode text,
    speech_to_text text,
    sensitive_word_avoidance text,
    retriever_resource text,
    dataset_query_variable character varying(255),
    prompt_type character varying(255) DEFAULT 'simple'::character varying NOT NULL,
    chat_prompt_config text,
    completion_prompt_config text,
    dataset_configs text,
    external_data_tools text,
    file_upload text,
    text_to_speech text
);
CREATE TABLE public.apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    mode character varying(255) NOT NULL,
    icon character varying(255),
    icon_background character varying(255),
    app_model_config_id uuid,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    enable_site boolean NOT NULL,
    enable_api boolean NOT NULL,
    api_rpm integer DEFAULT 0 NOT NULL,
    api_rph integer DEFAULT 0 NOT NULL,
    is_demo boolean DEFAULT false NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    is_universal boolean DEFAULT false NOT NULL,
    workflow_id uuid,
    description text DEFAULT ''::character varying NOT NULL,
    tracing text,
    max_active_requests integer,
    icon_type character varying(255)
);
CREATE TABLE public.celery_taskmeta (
    id integer DEFAULT nextval('public.task_id_sequence'::regclass) NOT NULL,
    task_id character varying(155),
    status character varying(50),
    result bytea,
    date_done timestamp without time zone,
    traceback text,
    name character varying(155),
    args bytea,
    kwargs bytea,
    worker character varying(155),
    retries integer,
    queue character varying(155)
);
CREATE TABLE public.celery_tasksetmeta (
    id integer DEFAULT nextval('public.taskset_id_sequence'::regclass) NOT NULL,
    taskset_id character varying(155),
    result bytea,
    date_done timestamp without time zone
);
CREATE TABLE public.conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    app_model_config_id uuid,
    model_provider character varying(255),
    override_model_configs text,
    model_id character varying(255),
    mode character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    summary text,
    inputs json,
    introduction text,
    system_instruction text,
    system_instruction_tokens integer DEFAULT 0 NOT NULL,
    status character varying(255) NOT NULL,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    read_at timestamp without time zone,
    read_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    invoke_from character varying(255),
    dialogue_count integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.data_source_api_key_auth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    category character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    credentials text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    disabled boolean DEFAULT false
);
CREATE TABLE public.data_source_oauth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    access_token character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    source_info jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    disabled boolean DEFAULT false
);
CREATE TABLE public.dataset_collection_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    provider_name character varying(40) NOT NULL,
    model_name character varying(255) NOT NULL,
    collection_name character varying(64) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    type character varying(40) DEFAULT 'dataset'::character varying NOT NULL
);
CREATE TABLE public.dataset_keyword_tables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    keyword_table text NOT NULL,
    data_source_type character varying(255) DEFAULT 'database'::character varying NOT NULL
);
CREATE TABLE public.dataset_permissions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    account_id uuid NOT NULL,
    has_permission boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    tenant_id uuid NOT NULL
);
CREATE TABLE public.dataset_process_rules (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    mode character varying(255) DEFAULT 'automatic'::character varying NOT NULL,
    rules text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.dataset_queries (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    content text NOT NULL,
    source character varying(255) NOT NULL,
    source_app_id uuid,
    created_by_role character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE public.dataset_retriever_resources (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    "position" integer NOT NULL,
    dataset_id uuid NOT NULL,
    dataset_name text NOT NULL,
    document_id uuid NOT NULL,
    document_name text NOT NULL,
    data_source_type text NOT NULL,
    segment_id uuid NOT NULL,
    score double precision,
    content text NOT NULL,
    hit_count integer,
    word_count integer,
    segment_position integer,
    index_node_hash text,
    retriever_from text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE public.datasets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    provider character varying(255) DEFAULT 'vendor'::character varying NOT NULL,
    permission character varying(255) DEFAULT 'only_me'::character varying NOT NULL,
    data_source_type character varying(255),
    indexing_technique character varying(255),
    index_struct text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    embedding_model character varying(255) DEFAULT 'text-embedding-ada-002'::character varying,
    embedding_model_provider character varying(255) DEFAULT 'openai'::character varying,
    collection_binding_id uuid,
    retrieval_model jsonb
);
CREATE TABLE public.dify_setups (
    version character varying(255) NOT NULL,
    setup_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.document_segments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    "position" integer NOT NULL,
    content text NOT NULL,
    word_count integer NOT NULL,
    tokens integer NOT NULL,
    keywords json,
    index_node_id character varying(255),
    index_node_hash character varying(255),
    hit_count integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_at timestamp without time zone,
    disabled_by uuid,
    status character varying(255) DEFAULT 'waiting'::character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    indexing_at timestamp without time zone,
    completed_at timestamp without time zone,
    error text,
    stopped_at timestamp without time zone,
    answer text,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.documents (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    "position" integer NOT NULL,
    data_source_type character varying(255) NOT NULL,
    data_source_info text,
    dataset_process_rule_id uuid,
    batch character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_from character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_api_request_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    processing_started_at timestamp without time zone,
    file_id text,
    word_count integer,
    parsing_completed_at timestamp without time zone,
    cleaning_completed_at timestamp without time zone,
    splitting_completed_at timestamp without time zone,
    tokens integer,
    indexing_latency double precision,
    completed_at timestamp without time zone,
    is_paused boolean DEFAULT false,
    paused_by uuid,
    paused_at timestamp without time zone,
    error text,
    stopped_at timestamp without time zone,
    indexing_status character varying(255) DEFAULT 'waiting'::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_at timestamp without time zone,
    disabled_by uuid,
    archived boolean DEFAULT false NOT NULL,
    archived_reason character varying(255),
    archived_by uuid,
    archived_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    doc_type character varying(40),
    doc_metadata json,
    doc_form character varying(255) DEFAULT 'text_model'::character varying NOT NULL,
    doc_language character varying(255)
);
CREATE TABLE public.embeddings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    hash character varying(64) NOT NULL,
    embedding bytea NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    model_name character varying(255) DEFAULT 'text-embedding-ada-002'::character varying NOT NULL,
    provider_name character varying(255) DEFAULT ''::character varying NOT NULL
);
CREATE TABLE public.end_users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid,
    type character varying(255) NOT NULL,
    external_user_id character varying(255),
    name character varying(255),
    is_anonymous boolean DEFAULT true NOT NULL,
    session_id character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.installed_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    app_owner_tenant_id uuid NOT NULL,
    "position" integer NOT NULL,
    is_pinned boolean DEFAULT false NOT NULL,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.invitation_codes (
    id integer NOT NULL,
    batch character varying(255) NOT NULL,
    code character varying(32) NOT NULL,
    status character varying(16) DEFAULT 'unused'::character varying NOT NULL,
    used_at timestamp without time zone,
    used_by_tenant_id uuid,
    used_by_account_id uuid,
    deprecated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.load_balancing_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    encrypted_config text,
    enabled boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.message_agent_thoughts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    message_chain_id uuid,
    "position" integer NOT NULL,
    thought text,
    tool text,
    tool_input text,
    observation text,
    tool_process_data text,
    message text,
    message_token integer,
    message_unit_price numeric,
    answer text,
    answer_token integer,
    answer_unit_price numeric,
    tokens integer,
    total_price numeric,
    currency character varying,
    latency double precision,
    created_by_role character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    message_files text,
    tool_labels_str text DEFAULT '{}'::text NOT NULL,
    tool_meta_str text DEFAULT '{}'::text NOT NULL
);
CREATE TABLE public.message_annotations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid,
    message_id uuid,
    content text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    question text,
    hit_count integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.message_chains (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    input text,
    output text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE public.message_feedbacks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    message_id uuid NOT NULL,
    rating character varying(255) NOT NULL,
    content text,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.message_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    transfer_method character varying(255) NOT NULL,
    url text,
    upload_file_id uuid,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    belongs_to character varying(255)
);
CREATE TABLE public.messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    model_provider character varying(255),
    model_id character varying(255),
    override_model_configs text,
    conversation_id uuid NOT NULL,
    inputs json,
    query text NOT NULL,
    message json NOT NULL,
    message_tokens integer DEFAULT 0 NOT NULL,
    message_unit_price numeric(10,4) NOT NULL,
    answer text NOT NULL,
    answer_tokens integer DEFAULT 0 NOT NULL,
    answer_unit_price numeric(10,4) NOT NULL,
    provider_response_latency double precision DEFAULT 0 NOT NULL,
    total_price numeric(10,7),
    currency character varying(255) NOT NULL,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    agent_based boolean DEFAULT false NOT NULL,
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    workflow_run_id uuid,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    error text,
    message_metadata text,
    invoke_from character varying(255)
);
CREATE TABLE public.operation_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    account_id uuid NOT NULL,
    action character varying(255) NOT NULL,
    content json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_ip character varying(255) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.pinned_conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL
);
CREATE TABLE public.provider_model_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    load_balancing_enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.provider_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    encrypted_config text,
    is_valid boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.provider_orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    account_id uuid NOT NULL,
    payment_product_id character varying(191) NOT NULL,
    payment_id character varying(191),
    transaction_id character varying(191),
    quantity integer DEFAULT 1 NOT NULL,
    currency character varying(40),
    total_amount integer,
    payment_status character varying(40) DEFAULT 'wait_pay'::character varying NOT NULL,
    paid_at timestamp without time zone,
    pay_failed_at timestamp without time zone,
    refunded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    provider_type character varying(40) DEFAULT 'custom'::character varying NOT NULL,
    encrypted_config text,
    is_valid boolean DEFAULT false NOT NULL,
    last_used timestamp without time zone,
    quota_type character varying(40) DEFAULT ''::character varying,
    quota_limit bigint,
    quota_used bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.recommended_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    description json NOT NULL,
    copyright character varying(255) NOT NULL,
    privacy_policy character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    "position" integer NOT NULL,
    is_listed boolean NOT NULL,
    install_count integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_disclaimer character varying(255)
);
CREATE TABLE public.saved_messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    message_id uuid NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL
);
CREATE TABLE public.sites (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    icon character varying(255),
    icon_background character varying(255),
    description text,
    default_language character varying(255) NOT NULL,
    copyright character varying(255),
    privacy_policy character varying(255),
    customize_domain character varying(255),
    customize_token_strategy character varying(255) NOT NULL,
    prompt_public boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    code character varying(255),
    custom_disclaimer character varying(255),
    show_workflow_steps boolean DEFAULT true NOT NULL,
    chat_color_theme character varying(255),
    chat_color_theme_inverted boolean DEFAULT false NOT NULL,
    icon_type character varying(255)
);
CREATE TABLE public.tag_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    tag_id uuid,
    target_id uuid,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tags (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    type character varying(16) NOT NULL,
    name character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tenant_account_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    account_id uuid NOT NULL,
    role character varying(16) DEFAULT 'normal'::character varying NOT NULL,
    invited_by uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    current boolean DEFAULT false NOT NULL
);
CREATE TABLE public.tenant_default_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tenant_preferred_model_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    preferred_provider_type character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tenants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    encrypt_public_key text,
    plan character varying(255) DEFAULT 'basic'::character varying NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    custom_config text
);
CREATE TABLE public.tool_api_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(40) NOT NULL,
    schema text NOT NULL,
    schema_type_str character varying(40) NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    tools_str text NOT NULL,
    icon character varying(255) NOT NULL,
    credentials_str text NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    privacy_policy character varying(255),
    custom_disclaimer character varying(255)
);
CREATE TABLE public.tool_builtin_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    user_id uuid NOT NULL,
    provider character varying(40) NOT NULL,
    encrypted_credentials text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tool_conversation_variables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    variables_str text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tool_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    conversation_id uuid,
    file_key character varying(255) NOT NULL,
    mimetype character varying(255) NOT NULL,
    original_url character varying(2048)
);
CREATE TABLE public.tool_label_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tool_id character varying(64) NOT NULL,
    tool_type character varying(40) NOT NULL,
    label_name character varying(40) NOT NULL
);
CREATE TABLE public.tool_model_invokes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    provider character varying(40) NOT NULL,
    tool_type character varying(40) NOT NULL,
    tool_name character varying(40) NOT NULL,
    model_parameters text NOT NULL,
    prompt_messages text NOT NULL,
    model_response text NOT NULL,
    prompt_tokens integer DEFAULT 0 NOT NULL,
    answer_tokens integer DEFAULT 0 NOT NULL,
    answer_unit_price numeric(10,4) NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    provider_response_latency double precision DEFAULT 0 NOT NULL,
    total_price numeric(10,7),
    currency character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tool_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    tool_name character varying(40) NOT NULL,
    encrypted_credentials text,
    is_enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tool_published_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    user_id uuid NOT NULL,
    description text NOT NULL,
    llm_description text NOT NULL,
    query_description text NOT NULL,
    query_name character varying(40) NOT NULL,
    tool_name character varying(40) NOT NULL,
    author character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.tool_workflow_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(40) NOT NULL,
    icon character varying(255) NOT NULL,
    app_id uuid NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    description text NOT NULL,
    parameter_configuration text DEFAULT '[]'::text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    privacy_policy character varying(255) DEFAULT ''::character varying,
    version character varying(255) DEFAULT ''::character varying NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL
);
CREATE TABLE public.trace_app_config (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    tracing_provider character varying(255),
    tracing_config json,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);
CREATE TABLE public.upload_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    storage_type character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    size integer NOT NULL,
    extension character varying(255) NOT NULL,
    mime_type character varying(255),
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    used boolean DEFAULT false NOT NULL,
    used_by uuid,
    used_at timestamp without time zone,
    hash character varying(255),
    created_by_role character varying(255) DEFAULT 'account'::character varying NOT NULL
);
CREATE TABLE public.workflow__conversation_variables (
    id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    app_id uuid NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
CREATE TABLE public.workflow_app_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    workflow_run_id uuid NOT NULL,
    created_from character varying(255) NOT NULL,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);
CREATE TABLE public.workflow_node_executions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    triggered_from character varying(255) NOT NULL,
    workflow_run_id uuid,
    index integer NOT NULL,
    predecessor_node_id character varying(255),
    node_id character varying(255) NOT NULL,
    node_type character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    inputs text,
    process_data text,
    outputs text,
    status character varying(255) NOT NULL,
    error text,
    elapsed_time double precision DEFAULT 0 NOT NULL,
    execution_metadata text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    finished_at timestamp without time zone
);
CREATE TABLE public.workflow_runs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    sequence_number integer NOT NULL,
    workflow_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    triggered_from character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    graph text,
    inputs text,
    status character varying(255) NOT NULL,
    outputs text,
    error text,
    elapsed_time double precision DEFAULT 0 NOT NULL,
    total_tokens integer DEFAULT 0 NOT NULL,
    total_steps integer DEFAULT 0,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    finished_at timestamp without time zone
);
CREATE TABLE public.workflows (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    graph text,
    features text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone,
    environment_variables text DEFAULT '{}'::text NOT NULL,
    conversation_variables text DEFAULT '{}'::text NOT NULL
);
