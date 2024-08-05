CREATE TABLE public.logs (
	"data" bytea NOT NULL,
	"index" int4 NOT NULL,
	"type" varchar(255) NULL,
	first_topic varchar(255) NULL,
	second_topic varchar(255) NULL,
	third_topic varchar(255) NULL,
	fourth_topic varchar(255) NULL,
	inserted_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	address_hash bytea NULL,
	transaction_hash bytea NOT NULL,
	block_hash bytea NOT NULL,
	block_number int4 NULL,
);

CREATE TABLE public.pending_block_operations (
	block_hash bytea NOT NULL,
	inserted_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	fetch_internal_transactions bool NOT NULL,
);

CREATE TABLE public.smart_contracts (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	compiler_version varchar(255) NOT NULL,
	optimization bool NOT NULL,
	contract_source_code text NOT NULL,
	abi jsonb NULL,
	address_hash bytea NOT NULL,
	inserted_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	constructor_arguments text NULL,
	optimization_runs int8 NULL,
	evm_version varchar(255) NULL,
	external_libraries _jsonb DEFAULT ARRAY[]::jsonb[] NULL,
	verified_via_sourcify bool NULL,
	is_vyper_contract bool NULL,
	partially_verified bool NULL,
	file_path text NULL,
	is_changed_bytecode bool DEFAULT false NULL,
	bytecode_checked_at timestamp DEFAULT (now() AT TIME ZONE 'utc'::text) - '1 day'::interval NULL,
	contract_code_md5 varchar(255) NOT NULL,
	implementation_name varchar(255) NULL,
);

CREATE TABLE public.token_transfers (
	transaction_hash bytea NOT NULL,
	log_index int4 NOT NULL,
	from_address_hash bytea NOT NULL,
	to_address_hash bytea NOT NULL,
	amount numeric NULL,
	token_id numeric(78) NULL,
	token_contract_address_hash bytea NOT NULL,
	inserted_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	block_number int4 NULL,
	block_hash bytea NOT NULL,
	amounts _numeric NULL,
	token_ids _numeric NULL,
);

CREATE TABLE public.tokens (
	"name" varchar(255) NULL,
	symbol varchar(255) NULL,
	total_supply numeric NULL,
	decimals numeric NULL,
	"type" varchar(255) NOT NULL,
	cataloged bool DEFAULT false NULL,
	contract_address_hash bytea NOT NULL,
	inserted_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	holder_count int4 NULL,
	bridged bool NULL,
	skip_metadata bool NULL,
);

