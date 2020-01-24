FROM python:3.7

ENV REVIEWDOG_VERSION='v0.9.15'

RUN pip install wemake-python-styleguide flakehell \
  # Installing reviewdog to optionally comment on pull requests:
  && wget -O - -q 'https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh' \
  | sh -s -- -b /usr/local/bin/ "$REVIEWDOG_VERSION"

# Custom configuration for this action:
ADD scripts /

# Entrypoint:
COPY scripts/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
