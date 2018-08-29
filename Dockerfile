ARG TERRAGRUNT_VERSION=0.16.7

FROM appropriate/curl as download
ARG TERRAGRUNT_VERSION
RUN curl --location --output /terragrunt \
 "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64"

FROM hashicorp/terraform:light
COPY --from=download /terragrunt /bin
RUN apk add libc6-compat && chmod +x /bin/terragrunt
ENTRYPOINT ["/bin/terragrunt"]
