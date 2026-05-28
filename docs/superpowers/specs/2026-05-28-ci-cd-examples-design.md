# Design Spec: CI/CD Pipeline Examples (Phase 3, Task 2)

## Goal
Provide comprehensive, skeleton-based CI/CD pipeline configurations for GitLab and Jenkins to serve as examples in the `devops_playground` repository.

## Architecture
The examples will be placed in `devops_playground/ci/` and will demonstrate a standard DevSecOps flow.

### GitLab CI (`gitlab-ci.yml`)
- **File Path**: `devops_playground/ci/gitlab-ci.yml`
- **Stages**:
  1. `lint`: Code quality check.
  2. `test`: Unit and integration tests.
  3. `secret_scan`: Searching for exposed credentials.
  4. `sast`: Static Application Security Testing.
  5. `build`: Container image creation.
  6. `image_scan`: Vulnerability scanning of the container image.
  7. `helm_lint`: Helm chart validation.
  8. `deploy_manual`: Manual trigger for deployment.
- **Implementation**: Standard YAML structure using `stages`, `image`, and `script` tags.

### Jenkins Pipeline (`Jenkinsfile`)
- **File Path**: `devops_playground/ci/Jenkinsfile`
- **Structure**: Declarative Groovy pipeline (`pipeline { agent any ... }`).
- **Stages**:
  1. `Checkout`: SCM retrieval.
  2. `Test`: Running application tests.
  3. `Secret Scan`: Security check for secrets.
  4. `Build Image`: Docker image build.
  5. `Trivy Scan`: Container security scan.
  6. `Helm Lint`: Chart validation.
  7. `Deploy manual placeholder`: Manual approval step for deployment.
- **Implementation**: `pipeline` block with `stages` and `steps`.

## Requirements
- Use `echo` placeholders to describe actions.
- Adhere to platform-specific syntax (YAML for GitLab, Groovy for Jenkins).
- Ensure consistency with the existing `app/` and `helm/` directories in the repository.

## Verification
- Manual inspection of syntax.
- Ensure all requested stages are present.
- Verify file placement in `devops_playground/ci/`.
