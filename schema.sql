CREATE TYPE public.entry_point_version AS ENUM ('v0.6', 'v0.7');

CREATE TYPE public.proxy_type AS ENUM (
    'eip1167',
    'eip1967',
    'eip1822',
    'eip930',
    'master_copy',
    'basic_implementation',
    'basic_get_implementation',
    'comptroller',
    'eip2535',
    'clone_with_immutable_arguments',
    'unknown'
);

CREATE TYPE public.sponsor_type AS ENUM (
    'wallet_deposit',
    'wallet_balance',
    'paymaster_sponsor',
    'paymaster_hybrid'
);

CREATE TYPE public.transaction_actions_protocol AS ENUM (
    'uniswap_v3',
    'opensea_v1_1',
    'wrapping',
    'approval',
    'zkbob',
    'aave_v3'
);

CREATE TYPE public.transaction_actions_type AS ENUM (
    'mint_nft',
    'mint',
    'burn',
    'collect',
    'swap',
    'sale',
    'cancel',
    'transfer',
    'wrap',
    'unwrap',
    'approve',
    'revoke',
    'withdraw',
    'deposit',
    'borrow',
    'supply',
    'repay',
    'flash_loan',
    'enable_collateral',
    'disable_collateral',
    'liquidation_call'
);

CREATE TABLE public.account_api_keys (
    identity_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    value uuid NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);

CREATE TABLE public.account_api_plans (
    id integer NOT NULL,
    max_req_per_second smallint,
    name character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);

CREATE TABLE public.account_custom_abis (
    id integer NOT NULL,
    identity_id bigint NOT NULL,
    abi jsonb NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    address_hash_hash bytea,
    address_hash bytea,
    name bytea
);

CREATE TABLE public.account_identities (
    id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    plan_id bigint DEFAULT 1,
    uid bytea,
    uid_hash bytea,
    email bytea,
    name bytea,
    nickname bytea,
    avatar bytea,
    verification_email_sent_at timestamp without time zone
);

CREATE TABLE public.account_public_tags_requests (
    id bigint NOT NULL,
    identity_id bigint,
    company character varying(255),
    website character varying(255),
    tags character varying(255),
    description text,
    additional_comment character varying(255),
    request_type character varying(255),
    is_owner boolean,
    remove_reason text,
    request_id character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    addresses bytea [],
    email bytea,
    full_name bytea
);

CREATE TABLE public.account_tag_addresses (
    id bigint NOT NULL,
    identity_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    address_hash_hash bytea,
    name bytea,
    address_hash bytea
);

CREATE TABLE public.account_tag_transactions (
    id bigint NOT NULL,
    identity_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    tx_hash_hash bytea,
    name bytea,
    tx_hash bytea
);

CREATE TABLE public.account_watchlist_addresses (
    id bigint NOT NULL,
    watchlist_id bigint,
    watch_coin_input boolean DEFAULT true,
    watch_coin_output boolean DEFAULT true,
    watch_erc_20_input boolean DEFAULT true,
    watch_erc_20_output boolean DEFAULT true,
    watch_erc_721_input boolean DEFAULT true,
    watch_erc_721_output boolean DEFAULT true,
    watch_erc_1155_input boolean DEFAULT true,
    watch_erc_1155_output boolean DEFAULT true,
    notify_email boolean DEFAULT true,
    notify_epns boolean DEFAULT false,
    notify_feed boolean DEFAULT true,
    notify_inapp boolean DEFAULT false,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    address_hash_hash bytea,
    name bytea,
    address_hash bytea,
    watch_erc_404_input boolean DEFAULT true,
    watch_erc_404_output boolean DEFAULT true
);

CREATE TABLE public.account_watchlist_notifications (
    id bigint NOT NULL,
    watchlist_address_id bigint,
    direction character varying(255),
    type character varying(255),
    method character varying(255),
    block_number integer,
    amount numeric,
    tx_fee numeric,
    viewed_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name bytea,
    subject bytea,
    from_address_hash bytea,
    to_address_hash bytea,
    transaction_hash bytea,
    subject_hash bytea,
    from_address_hash_hash bytea,
    to_address_hash_hash bytea,
    transaction_hash_hash bytea,
    watchlist_id bigint NOT NULL
);

CREATE TABLE public.account_watchlists (
    id bigint NOT NULL,
    name character varying(255) DEFAULT 'default' :: character varying,
    identity_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);

CREATE TABLE public.address_coin_balances (
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    value numeric(100, 0) DEFAULT NULL :: numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.address_coin_balances_daily (
    address_hash bytea NOT NULL,
    day date NOT NULL,
    value numeric(100, 0) DEFAULT NULL :: numeric,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.address_contract_code_fetch_attempts (
    address_hash bytea NOT NULL,
    retries_number smallint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.address_current_token_balances (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    value numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old_value numeric,
    token_id numeric(78, 0),
    token_type character varying(255)
);

CREATE TABLE public.address_names (
    address_hash bytea NOT NULL,
    name character varying(255) NOT NULL,
    "primary" boolean DEFAULT false NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    metadata jsonb,
    id integer NOT NULL
);

CREATE TABLE public.address_tags (
    id integer NOT NULL,
    label character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    display_name character varying(255)
);

CREATE TABLE public.address_to_tags (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    tag_id integer NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.address_token_balances (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    block_number bigint NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    value numeric,
    value_fetched_at timestamp without time zone,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    token_id numeric(78, 0),
    token_type character varying(255)
);

CREATE TABLE public.addresses (
    fetched_coin_balance numeric(100, 0),
    fetched_coin_balance_block_number bigint,
    hash bytea NOT NULL,
    contract_code bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    nonce integer,
    decompiled boolean,
    verified boolean,
    gas_used bigint,
    transactions_count integer,
    token_transfers_count integer
);

CREATE TABLE public.administrators (
    id bigint NOT NULL,
    role character varying(255) NOT NULL,
    user_id bigint NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.block_rewards (
    address_hash bytea NOT NULL,
    address_type character varying(255) NOT NULL,
    block_hash bytea NOT NULL,
    reward numeric(100, 0),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);

CREATE TABLE public.block_second_degree_relations (
    nephew_hash bytea NOT NULL,
    uncle_hash bytea NOT NULL,
    uncle_fetched_at timestamp without time zone,
    index integer
);

CREATE TABLE public.blocks (
    consensus boolean NOT NULL,
    difficulty numeric(50, 0),
    gas_limit numeric(100, 0) NOT NULL,
    gas_used numeric(100, 0) NOT NULL,
    hash bytea NOT NULL,
    miner_hash bytea NOT NULL,
    nonce bytea NOT NULL,
    number bigint NOT NULL,
    parent_hash bytea NOT NULL,
    size integer,
    "timestamp" timestamp without time zone NOT NULL,
    total_difficulty numeric(50, 0),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    refetch_needed boolean DEFAULT false,
    base_fee_per_gas numeric(100, 0),
    is_empty boolean
);

CREATE TABLE public.constants (
    key character varying(255) NOT NULL,
    value character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.contract_methods (
    id bigint NOT NULL,
    identifier integer NOT NULL,
    abi jsonb NOT NULL,
    type character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.contract_verification_status (
    uid character varying(64) NOT NULL,
    status smallint NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.decompiled_smart_contracts (
    id bigint NOT NULL,
    decompiler_version character varying(255) NOT NULL,
    decompiled_source_code text NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.emission_rewards (
    block_range int8range NOT NULL,
    reward numeric
);

CREATE TABLE public.event_notifications (id bigint NOT NULL, data text NOT NULL);

CREATE TABLE public.internal_transactions (
    call_type character varying(255),
    created_contract_code bytea,
    error character varying(255),
    gas numeric(100, 0),
    gas_used numeric(100, 0),
    index integer NOT NULL,
    init bytea,
    input bytea,
    output bytea,
    trace_address integer [] NOT NULL,
    type character varying(255) NOT NULL,
    value numeric(100, 0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_contract_address_hash bytea,
    from_address_hash bytea,
    to_address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_number integer,
    transaction_index integer,
    block_hash bytea NOT NULL,
    block_index integer NOT NULL,
    CONSTRAINT call_has_error_or_result CHECK (
        (
            ((type) :: text <> 'call' :: text)
            OR (
                (gas IS NOT NULL)
                AND (
                    (
                        (error IS NULL)
                        AND (gas_used IS NOT NULL)
                        AND (output IS NOT NULL)
                    )
                    OR (
                        (error IS NOT NULL)
                        AND (output IS NULL)
                    )
                )
            )
        )
    ),
    CONSTRAINT create_has_error_or_result CHECK (
        (
            ((type) :: text <> 'create' :: text)
            OR (
                (gas IS NOT NULL)
                AND (
                    (
                        (error IS NULL)
                        AND (created_contract_address_hash IS NOT NULL)
                        AND (created_contract_code IS NOT NULL)
                        AND (gas_used IS NOT NULL)
                    )
                    OR (
                        (error IS NOT NULL)
                        AND (created_contract_address_hash IS NULL)
                        AND (created_contract_code IS NULL)
                        AND (gas_used IS NULL)
                    )
                )
            )
        )
    )
);

CREATE TABLE public.last_fetched_counters (
    counter_type character varying(255) NOT NULL,
    value numeric(100, 0),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.logs (
    data bytea NOT NULL,
    index integer NOT NULL,
    first_topic bytea,
    second_topic bytea,
    third_topic bytea,
    fourth_topic bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_hash bytea NOT NULL,
    block_number integer
);

CREATE TABLE public.market_history (
    id bigint NOT NULL,
    date date NOT NULL,
    closing_price numeric,
    opening_price numeric,
    market_cap numeric,
    tvl numeric,
    secondary_coin boolean DEFAULT false
);

CREATE TABLE public.massive_blocks (
    number bigint NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.migrations_status (
    migration_name character varying(255) NOT NULL,
    status character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.missing_balance_of_tokens (
    token_contract_address_hash bytea NOT NULL,
    block_number bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    currently_implemented boolean
);

CREATE TABLE public.missing_block_ranges (
    id bigint NOT NULL,
    from_number integer,
    to_number integer
);

CREATE TABLE public.pending_block_operations (
    block_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_number integer
);

CREATE TABLE public.proxy_implementations (
    proxy_address_hash bytea NOT NULL,
    address_hashes bytea [] NOT NULL,
    names character varying(255) [] NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    proxy_type public.proxy_type
);

CREATE TABLE public.proxy_smart_contract_verification_statuses (
    uid character varying(64) NOT NULL,
    status smallint NOT NULL,
    contract_address_hash bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);

CREATE TABLE public.smart_contract_audit_reports (
    id bigint NOT NULL,
    address_hash bytea NOT NULL,
    is_approved boolean DEFAULT false,
    submitter_name character varying(255) NOT NULL,
    submitter_email character varying(255) NOT NULL,
    is_project_owner boolean DEFAULT false,
    project_name character varying(255) NOT NULL,
    project_url character varying(255) NOT NULL,
    audit_company_name character varying(255) NOT NULL,
    audit_report_url character varying(255) NOT NULL,
    audit_publish_date date NOT NULL,
    request_id character varying(255),
    comment text,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.smart_contracts (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    compiler_version character varying(255) NOT NULL,
    optimization boolean NOT NULL,
    contract_source_code text NOT NULL,
    abi jsonb,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    constructor_arguments text,
    optimization_runs bigint,
    evm_version character varying(255),
    external_libraries jsonb [] DEFAULT ARRAY [] :: jsonb [],
    verified_via_sourcify boolean,
    is_vyper_contract boolean,
    partially_verified boolean,
    file_path text,
    is_changed_bytecode boolean DEFAULT false,
    bytecode_checked_at timestamp without time zone DEFAULT (
        timezone('utc' :: text, now()) - '1 day' :: interval
    ),
    contract_code_md5 character varying(255) NOT NULL,
    compiler_settings jsonb,
    verified_via_eth_bytecode_db boolean,
    license_type smallint DEFAULT 1 NOT NULL,
    verified_via_verifier_alliance boolean,
    certified boolean,
    is_blueprint boolean
);

CREATE TABLE public.smart_contracts_additional_sources (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    contract_source_code text NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.token_instance_metadata_refetch_attempts (
    token_contract_address_hash bytea NOT NULL,
    token_id numeric(78, 0) NOT NULL,
    retries_number smallint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.token_instances (
    token_id numeric(78, 0) NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    metadata jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    error character varying(255),
    owner_address_hash bytea,
    owner_updated_at_block bigint,
    owner_updated_at_log_index integer,
    refetch_after timestamp without time zone,
    retries_count smallint DEFAULT 0 NOT NULL
);

CREATE TABLE public.token_transfer_token_id_migrator_progress (
    id bigint NOT NULL,
    last_processed_block_number integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.token_transfers (
    transaction_hash bytea NOT NULL,
    log_index integer NOT NULL,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea NOT NULL,
    amount numeric,
    token_contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_number integer,
    block_hash bytea NOT NULL,
    amounts numeric [],
    token_ids numeric(78, 0) [],
    token_type character varying(255),
    block_consensus boolean DEFAULT true
);

CREATE TABLE public.tokens (
    name text,
    symbol text,
    total_supply numeric,
    decimals numeric,
    type character varying(255) NOT NULL,
    cataloged boolean DEFAULT false,
    contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    holder_count integer,
    skip_metadata boolean,
    fiat_value numeric,
    circulating_market_cap numeric,
    total_supply_updated_at_block bigint,
    icon_url character varying(255),
    is_verified_via_admin_panel boolean DEFAULT false,
    volume_24h numeric
);

CREATE TABLE public.transaction_actions (
    hash bytea NOT NULL,
    protocol public.transaction_actions_protocol NOT NULL,
    data jsonb DEFAULT '{}' :: jsonb NOT NULL,
    type public.transaction_actions_type NOT NULL,
    log_index integer NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.transaction_forks (
    hash bytea NOT NULL,
    index integer NOT NULL,
    uncle_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.transaction_stats (
    id bigint NOT NULL,
    date date,
    number_of_transactions integer,
    gas_used numeric(100, 0),
    total_fee numeric(100, 0)
);

CREATE TABLE public.transactions (
    cumulative_gas_used numeric(100, 0),
    error character varying(255),
    gas numeric(100, 0) NOT NULL,
    gas_price numeric(100, 0),
    gas_used numeric(100, 0),
    hash bytea NOT NULL,
    index integer,
    input bytea NOT NULL,
    nonce integer NOT NULL,
    r numeric(100, 0) NOT NULL,
    s numeric(100, 0) NOT NULL,
    status integer,
    v numeric(100, 0) NOT NULL,
    value numeric(100, 0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_hash bytea,
    block_number integer,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea,
    created_contract_address_hash bytea,
    created_contract_code_indexed_at timestamp without time zone,
    earliest_processing_start timestamp without time zone,
    old_block_hash bytea,
    revert_reason text,
    max_priority_fee_per_gas numeric(100, 0),
    max_fee_per_gas numeric(100, 0),
    type integer,
    has_error_in_internal_txs boolean,
    block_timestamp timestamp without time zone,
    block_consensus boolean DEFAULT true,
    CONSTRAINT collated_block_number CHECK (
        (
            (block_hash IS NULL)
            OR (block_number IS NOT NULL)
        )
    ),
    CONSTRAINT collated_cumalative_gas_used CHECK (
        (
            (block_hash IS NULL)
            OR (cumulative_gas_used IS NOT NULL)
        )
    ),
    CONSTRAINT collated_gas_price CHECK (
        (
            (block_hash IS NULL)
            OR (gas_price IS NOT NULL)
        )
    ),
    CONSTRAINT collated_gas_used CHECK (
        (
            (block_hash IS NULL)
            OR (gas_used IS NOT NULL)
        )
    ),
    CONSTRAINT collated_index CHECK (
        (
            (block_hash IS NULL)
            OR (index IS NOT NULL)
        )
    ),
    CONSTRAINT error CHECK (
        (
            (status = 0)
            OR (
                (status <> 0)
                AND (error IS NULL)
            )
        )
    ),
    CONSTRAINT pending_block_number CHECK (
        (
            (block_hash IS NOT NULL)
            OR (block_number IS NULL)
        )
    ),
    CONSTRAINT pending_cumalative_gas_used CHECK (
        (
            (block_hash IS NOT NULL)
            OR (cumulative_gas_used IS NULL)
        )
    ),
    CONSTRAINT pending_gas_used CHECK (
        (
            (block_hash IS NOT NULL)
            OR (gas_used IS NULL)
        )
    ),
    CONSTRAINT pending_index CHECK (
        (
            (block_hash IS NOT NULL)
            OR (index IS NULL)
        )
    ),
    CONSTRAINT status CHECK (
        (
            (
                (block_hash IS NULL)
                AND (status IS NULL)
            )
            OR (block_hash IS NOT NULL)
            OR (
                (status = 0)
                AND ((error) :: text = 'dropped/replaced' :: text)
            )
        )
    )
);

CREATE TABLE public.user_contacts (
    id bigint NOT NULL,
    email public.citext NOT NULL,
    user_id bigint NOT NULL,
    "primary" boolean DEFAULT false,
    verified boolean DEFAULT false,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.user_operations (
    hash bytea NOT NULL,
    sender bytea NOT NULL,
    nonce bytea NOT NULL,
    init_code bytea,
    call_data bytea NOT NULL,
    call_gas_limit numeric(100, 0) NOT NULL,
    verification_gas_limit numeric(100, 0) NOT NULL,
    pre_verification_gas numeric(100, 0) NOT NULL,
    max_fee_per_gas numeric(100, 0) NOT NULL,
    max_priority_fee_per_gas numeric(100, 0) NOT NULL,
    paymaster_and_data bytea,
    signature bytea NOT NULL,
    aggregator bytea,
    aggregator_signature bytea,
    entry_point bytea NOT NULL,
    transaction_hash bytea NOT NULL,
    block_number integer NOT NULL,
    block_hash bytea NOT NULL,
    bundle_index integer NOT NULL,
    index integer NOT NULL,
    user_logs_start_index integer NOT NULL,
    user_logs_count integer NOT NULL,
    bundler bytea NOT NULL,
    factory bytea,
    paymaster bytea,
    status boolean NOT NULL,
    revert_reason bytea,
    gas numeric(100, 0) NOT NULL,
    gas_price numeric(100, 0) NOT NULL,
    gas_used numeric(100, 0) NOT NULL,
    sponsor_type public.sponsor_type NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    entry_point_version public.entry_point_version DEFAULT 'v0.6' :: public.entry_point_version NOT NULL
);

CREATE TABLE public.user_ops_indexer_migrations (
    version character varying NOT NULL,
    applied_at bigint NOT NULL
);

CREATE TABLE public.users (
    id bigint NOT NULL,
    username public.citext NOT NULL,
    password_hash character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.validators (
    address_hash bytea NOT NULL,
    is_validator boolean,
    payout_key_hash bytea,
    info_updated_at_block bigint,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.withdrawals (
    index integer NOT NULL,
    validator_index integer NOT NULL,
    amount numeric(100, 0) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address_hash bytea NOT NULL,
    block_hash bytea NOT NULL
);