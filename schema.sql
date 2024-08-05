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
    metadata jsonb
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

CREATE TABLE public.bridged_tokens (
    foreign_chain_id numeric NOT NULL,
    foreign_token_contract_address_hash bytea NOT NULL,
    home_token_contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    custom_metadata character varying(255),
    type character varying(255),
    exchange_rate numeric,
    lp_token boolean,
    custom_cap numeric
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
    block_range int8range,
    reward numeric
);


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
                        AND (gas_used IS NULL)
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
    type character varying(255),
    first_topic character varying(255),
    second_topic character varying(255),
    third_topic character varying(255),
    fourth_topic character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address_hash bytea,
    transaction_hash bytea NOT NULL,
    block_hash bytea NOT NULL,
    block_number integer
);

CREATE TABLE public.market_history (
    id bigint NOT NULL,
    date date,
    closing_price numeric,
    opening_price numeric
);

CREATE TABLE public.pending_block_operations (
    block_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    fetch_internal_transactions boolean NOT NULL
);

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);

CREATE TABLE public.smart_contracts (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    compiler_version character varying(255) NOT NULL,
    optimization boolean NOT NULL,
    contract_source_code text NOT NULL,
    abi jsonb NOT NULL,
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
        (now() AT TIME ZONE 'utc' :: text) - '1 day' :: interval
    ),
    contract_code_md5 character varying(255) NOT NULL,
    implementation_name character varying(255)
);

CREATE TABLE public.smart_contracts_additional_sources (
    id bigint NOT NULL,
    file_name character varying(255) NOT NULL,
    contract_source_code text NOT NULL,
    address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.staking_pools (
    id bigint NOT NULL,
    are_delegators_banned boolean DEFAULT false,
    banned_delegators_until bigint,
    banned_until bigint,
    ban_reason character varying(255),
    delegators_count integer,
    is_active boolean DEFAULT false NOT NULL,
    is_banned boolean DEFAULT false NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    is_unremovable boolean DEFAULT false NOT NULL,
    is_validator boolean DEFAULT false NOT NULL,
    likelihood numeric(5, 2),
    mining_address_hash bytea,
    self_staked_amount numeric(100, 0),
    snapshotted_self_staked_amount numeric(100, 0),
    snapshotted_total_staked_amount numeric(100, 0),
    snapshotted_validator_reward_ratio numeric(5, 2),
    stakes_ratio numeric(5, 2),
    staking_address_hash bytea,
    total_staked_amount numeric(100, 0),
    validator_reward_percent numeric(5, 2),
    validator_reward_ratio numeric(5, 2),
    was_banned_count integer,
    was_validator_count integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying(256),
    description character varying(1024)
);

CREATE TABLE public.staking_pools_delegators (
    id bigint NOT NULL,
    address_hash bytea,
    is_active boolean DEFAULT true,
    is_deleted boolean DEFAULT false,
    max_ordered_withdraw_allowed numeric(100, 0),
    max_withdraw_allowed numeric(100, 0),
    ordered_withdraw numeric(100, 0),
    ordered_withdraw_epoch integer,
    reward_ratio numeric(5, 2),
    snapshotted_reward_ratio numeric(5, 2),
    snapshotted_stake_amount numeric(100, 0),
    stake_amount numeric(100, 0),
    staking_address_hash bytea,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE public.token_instances (
    token_id numeric(78, 0) NOT NULL,
    token_contract_address_hash bytea NOT NULL,
    metadata jsonb,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    error character varying(255)
);

CREATE TABLE public.token_transfers (
    transaction_hash bytea NOT NULL,
    log_index integer NOT NULL,
    from_address_hash bytea NOT NULL,
    to_address_hash bytea NOT NULL,
    amount numeric,
    token_id numeric(78, 0),
    token_contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    block_number integer,
    block_hash bytea NOT NULL,
    amounts numeric [],
    token_ids numeric(78, 0) []
);

CREATE TABLE public.tokens (
    name character varying(255),
    symbol character varying(255),
    total_supply numeric,
    decimals numeric,
    type character varying(255) NOT NULL,
    cataloged boolean DEFAULT false,
    contract_address_hash bytea NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    holder_count integer,
    bridged boolean,
    skip_metadata boolean
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
    gas_price numeric(100, 0) NOT NULL,
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

CREATE TABLE public.users (
    id bigint NOT NULL,
    username public.citext NOT NULL,
    password_hash character varying(255) NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);