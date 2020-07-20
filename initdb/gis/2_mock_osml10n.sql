CREATE OR REPLACE FUNCTION osml10n_contains_cyrillic(text) RETURNS boolean
AS $func$ SELECT FALSE; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_is_latin(text) RETURNS boolean
AS $func$ SELECT FALSE; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_contains_cjk(text) RETURNS boolean
AS $func$ SELECT FALSE; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_geo_translit(name text, place geometry DEFAULT NULL::geometry) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_get_country_name(tags hstore, separator text DEFAULT chr(10), targetlang text DEFAULT 'de'::text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_get_country(feature geometry) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev(longname text, langcode text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_de(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_fr(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_es(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_pt(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_en(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_ru(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_uk(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_latin(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_non_latin(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_street_abbrev_all(longname text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_gen_combined_name(local_name text, name text, tags hstore, loc_in_brackets boolean, show_brackets boolean DEFAULT true, separator text DEFAULT ' '::text, is_street boolean DEFAULT false, use_tags boolean DEFAULT false, non_latin boolean DEFAULT false) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_get_name_from_tags(tags hstore, loc_in_brackets boolean, is_street boolean DEFAULT false, show_brackets boolean DEFAULT false, separator text DEFAULT chr(10), targetlang text DEFAULT 'de'::text, place geometry DEFAULT NULL::geometry) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_get_name_without_brackets_from_tags(tags hstore, targetlang text DEFAULT 'de'::text, place geometry DEFAULT NULL::geometry, name text DEFAULT NULL::text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_get_placename_from_tags(tags hstore, loc_in_brackets boolean, show_brackets boolean DEFAULT false, separator text DEFAULT chr(10), targetlang text DEFAULT 'de'::text, place geometry DEFAULT NULL::geometry, name text DEFAULT NULL::text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_get_streetname_from_tags(tags hstore, loc_in_brackets boolean, show_brackets boolean DEFAULT false, separator text DEFAULT ' - '::text, targetlang text DEFAULT 'de'::text, place geometry DEFAULT NULL::geometry, name text DEFAULT NULL::text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_kanji_transcript(text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_version() RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_translit(text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;


CREATE OR REPLACE FUNCTION osml10n_cc_transscript(name text, country text) RETURNS text
AS $func$ SELECT ''::text; $func$
IMMUTABLE
LANGUAGE SQL;
