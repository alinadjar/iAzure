
# Promotion Pipeline

This pipeline automates version promotion across environments following our Git branch strategy: `dev` → `alpha` → `beta` → `master`.

## Branch Strategy

| Branch  | Purpose           | Version Format    |
|---------|-------------------|-------------------|
| `dev`   | Development       | `---`             |
| `alpha` | Internal testing  | `v1.2.3-alpha.n`  |
| `rc`    | External testing  | `v1.2.3-rc.n`     |
| `beta`  | Production        | `v1.2.3-beta.n`   |
| `master`| Production        | `v1.2.3`          |

## Promotion Flow

```text
dev → alpha (v1.2.3-alpha.1) → beta (v1.2.3-beta.1) → master (v1.2.3)