FROM perl:5.30

RUN cpanm Text::CSV
RUN cpanm JSON
RUN cpanm JSON::Schema::Modern
RUN cpan common::sense
RUN cpanm JSON::XS

ADD --chown=root:root --chmod=755 json-validate.pl /usr/local/bin/json-validate.pl

CMD json-validate.pl /repo/json-schemas/brp/schemas/2024Q3/berichten.schema.json /repo/voorbeelden/berichten/*.json
