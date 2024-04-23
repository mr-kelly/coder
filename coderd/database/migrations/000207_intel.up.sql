CREATE TABLE intel_cohorts (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_by UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    display_name TEXT NOT NULL,
    description TEXT NOT NULL,

    filter_regex_operating_system VARCHAR(255) NOT NULL,
    filter_regex_operating_system_version VARCHAR(255) NOT NULL,
    filter_regex_architecture VARCHAR(255) NOT NULL,
    filter_regex_repositories VARCHAR(255) NOT NULL,

    tracked_executables TEXT[] NOT NULL
);

CREATE TABLE intel_machines (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    machine_id UUID NOT NULL,
    user_id UUID NOT NULL,
    ip_address TEXT NOT NULL,
    hostname TEXT NOT NULL,
    operating_system VARCHAR(255) NOT NULL,
    operating_system_version VARCHAR(255) NOT NULL,
    cpu_cores INT NOT NULL,
    memory_mb_total INT NOT NULL,
    architecture VARCHAR(255) NOT NULL,
    daemon_version VARCHAR(255) NOT NULL,
    git_config_email VARCHAR(255) NOT NULL,
    git_config_name VARCHAR(255) NOT NULL,
    tags VARCHAR(64)[]
);

COMMENT ON COLUMN intel_machines.operating_system IS 'GOOS';
COMMENT ON COLUMN intel_machines.memory_mb_total IS 'in MB';
COMMENT ON COLUMN intel_machines.architecture IS 'GOARCH. e.g. amd64';
COMMENT ON COLUMN intel_machines.daemon_version IS 'Version of the daemon running on the machine';
COMMENT ON COLUMN intel_machines.git_config_email IS 'git config --get user.email';
COMMENT ON COLUMN intel_machines.git_config_name IS 'git config --get user.name';
COMMENT ON COLUMN intel_machines.tags IS 'Arbitrary user-defined tags. e.g. "coder-v1" or "coder-v2"';

CREATE TABLE intel_invocations (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    machine_id UUID NOT NULL,
    user_id UUID NOT NULL,
    binary_hash TEXT NOT NULL,
    binary_path TEXT NOT NULL,
    binary_args VARCHAR(255) NOT NULL,
    binary_version TEXT NOT NULL,
    working_directory TEXT NOT NULL,
    git_remote_url TEXT NOT NULL,
    started_at TIMESTAMPTZ NOT NULL,
    duration_ms INT NOT NULL
);

CREATE TABLE intel_git_commits (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    invocation_id UUID NOT NULL,
    commit_hash TEXT NOT NULL,
    commit_message TEXT NOT NULL,
    commit_author TEXT NOT NULL,
    commit_author_email VARCHAR(255) NOT NULL,
    commit_author_date TIMESTAMPTZ NOT NULL,
    commit_committer TEXT NOT NULL,
    commit_committer_email VARCHAR(255) NOT NULL,
    commit_committer_date TIMESTAMPTZ NOT NULL
);

CREATE TABLE intel_path_executables (
    machine_id UUID NOT NULL,
    user_id UUID NOT NULL,
    id uuid NOT NULL,
    hash TEXT NOT NULL,
    basename TEXT NOT NULL,
    version TEXT NOT NULL,
    PRIMARY KEY (machine_id, user_id, id)
);
