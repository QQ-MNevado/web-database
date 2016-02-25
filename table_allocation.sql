CREATE TABLE allocation.catch_type (
    catch_type_id smallint DEFAULT 0 PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE allocation.sector_type (
    sector_type_id smallint DEFAULT 0 PRIMARY KEY,
    name character varying(50) NOT NULL
);

CREATE TABLE allocation.allocation_area_type (
    allocation_area_type_id smallint DEFAULT 0 PRIMARY KEY,
    name character varying(50) NOT NULL,
    remarks character varying(255) NOT NULL
);

CREATE TABLE allocation.layer (
    layer_id smallint DEFAULT 0 PRIMARY KEY,
    name character varying(255) NOT NULL
);

CREATE TABLE allocation.fishing_entity(
  fishing_entity_id smallint PRIMARY KEY,
  name varchar(100) NOT NULL,
  geo_entity_id int NULL,
  date_allowed_to_fish_other_eEZs int NOT NULL,
  date_allowed_to_fish_high_seas int NOT NULL,
  legacy_c_number int NULL,
  is_currently_used_for_web boolean DEFAULT true NOT NULL,
  is_currently_used_for_reconstruction boolean DEFAULT true NOT NULL,
  is_allowed_to_fish_pre_eez_by_default boolean DEFAULT true NOT NULL,
  remarks varchar(50) NULL
);

CREATE TABLE allocation.simple_area_cell_assignment_raw (
    id serial PRIMARY KEY,
    marine_layer_id smallint,
    area_id integer,
    fao_area_id smallint,
    cell_id integer,
    water_area double precision,
    CONSTRAINT simple_area_cell_assignment_raw_uk UNIQUE (marine_layer_id, area_id, fao_area_Id, cell_id)
);

CREATE TABLE allocation.cell (
    cell_id integer PRIMARY KEY,
    total_area double precision,
    water_area double precision
);

CREATE TABLE allocation.allocation_result_distribution (
    universal_data_id integer primary key,
    record_count int not null
);

CREATE TABLE allocation.allocation_result_partition_map (
    partition_id int primary key,
    begin_universal_data_id integer not null,
    end_universal_data_id integer not null,
    record_count int not null
);

CREATE TABLE allocation.allocation_result (
    row_id serial PRIMARY KEY,
    universal_data_id integer NOT NULL,
    allocation_simple_area_id integer NOT NULL,
    cell_id integer NOT NULL,
    allocated_catch double precision NOT NULL
);

CREATE TABLE allocation.allocation_data ( 
    universal_data_id integer PRIMARY KEY,
    allocation_area_type_id smallint DEFAULT 0 NOT NULL,
    generic_allocation_area_id integer NOT NULL,
    data_layer_id smallint DEFAULT 0 NOT NULL,
    fishing_entity_id integer NOT NULL,
    year integer NOT NULL,
    taxon_key integer NOT NULL,
    catch_amount double precision NOT NULL,
    sector_type_id smallint DEFAULT 0 NOT NULL,
    catch_type_id smallint DEFAULT 0 NOT NULL,
    input_type_id smallint DEFAULT 0 NOT NULL,
    unique_area_id_auto_gen integer,
    original_fishing_entity_id integer NOT NULL,
    unit_price double precision NOT NULL DEFAULT 1466
);

CREATE TABLE allocation.price(
	year int,
	fishing_entity_id int,
	taxon_key int,
	price float null,
    CONSTRAINT price_pkey PRIMARY KEY (year, fishing_entity_id, taxon_key)
); 

CREATE TABLE allocation.allocation_simple_area (
    allocation_simple_area_id serial PRIMARY KEY,
    marine_layer_id smallint DEFAULT 0 NOT NULL,
    area_id integer NOT NULL,
    fao_area_id smallint DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    inherited_att_belongs_to_reconstruction_eez_id integer NOT NULL,
    inherited_att_is_ifa boolean DEFAULT true NOT NULL,
    inherited_att_allows_coastal_fishing_for_layer2_data boolean DEFAULT true NOT NULL
);

CREATE TABLE allocation.allocation_result_eez(
	universal_data_id int not null,
	eez_id int not null,            
	fao_area_id int not null,
	total_catch float null
);

CREATE TABLE allocation.allocation_result_high_seas(
	universal_data_id int not null,
	fao_area_id int not null,
	total_catch float null
);

CREATE TABLE allocation.allocation_result_global(      
	universal_data_id int not null,
	area_id int not null,
	total_catch float null
);

CREATE TABLE allocation.allocation_result_lme(
	universal_data_id int not null,
	lme_id int null,
	total_catch float null
);
                           
CREATE TABLE allocation.allocation_result_rfmo(
	universal_data_id int not null,
	rfmo_id int not null,            
	total_catch float null
);

CREATE TABLE allocation.taxon_distribution (
    taxon_key integer NOT NULL,
    cell_id integer NOT NULL,
    relative_abundance integer NOT NULL,
    taxon_distribution_id serial PRIMARY KEY
);

CREATE TABLE allocation.taxon_distribution_substitute(
  original_taxon_key int primary key,
  use_this_taxon_key_instead int not null
);

CREATE TABLE allocation.ices_area(
  ices_division varchar(255) NULL,
  ices_subdivision varchar(255) NULL,
  ices_area_id varchar(255) NOT NULL
);

CREATE TABLE allocation.ifa(
  eez_id int NOT NULL,
  ifa_is_located_in_this_fao int NOT NULL
);

/* These tables were needed temporarily for Whaleshark work
CREATE TABLE allocation.final_catch_data_ver40(
	id int not null,
	fishing_entity_id float,
	original_country_fishing text,
	eez_id float,
	sub_area_eez text,
	archive_sub_area_eez text,
	fao_area float,
	sub_regional_area text,
	archive_sub_regional_eez text,
	province_state text,
	ices_area_id_eric text,
	nafo_division text,
	archive_nafo_division text,
	ccamlr_area text,
	layer float,
	year float,
	taxon_key float,
	orig_taxon_key float,
	taxon_name text,
	original_fao_name text,
	catch_amount float,
	adjustment_factor text,
	gear_type text,
	sector text,
	original_sector text,
	catch_type text,
	catch_type_id int,
	input text,
	forward_carry_rule text,
	reference_id float,
	notes text,
	taxon_notes text,
	ices_division text,
	ices_subdivision text
);

CREATE TABLE allocation.final_catch_data_ver41(
	id int not null,
	fishing_entity_id float,
	original_country_fishing text,
	eez_id float,
	sub_area_eez text,
	archive_sub_area_eez text,
	fao_area float,
	sub_regional_area text,
	archive_sub_regional_eez text,
	province_state text,
	ices_area_id text,
	nafo_division text,
	archive_nafo_division text,
	ccamlr_area text,
	layer float,
	year float,
	taxon_key float,
	orig_taxon_key float,
	taxon_name text,
	original_fao_name text,
	catch_amount float,
	adjustment_factor text,
	gear_type text,
	sector text,
	original_sector text,
	catch_type text,
	catch_type_id int,
	input text,
	forward_carry_rule text,
	reference_id float,
	notes text,
	taxon_notes text,
	ices_division text,
	ices_subdivision text
);
*/
