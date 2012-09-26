-- Database schema for wmfPrefStats.

-- @package ts-krinkle-wmfPrefStats
-- @seealso: https://toolserver.org/~krinkle/wmfPrefStats
-- @seealso: https://github.com/Krinkle/ts-krinkle-wmfPrefStats
--

--
-- Table containining historical data of user preferences 
-- on Wikimedia Foundation wikis.
--
CREATE TABLE property_history (

	-- The database name of the origin wiki.
	-- (like mw_interwiki.iw_wikiid)
	ph_wikiid varchar(64) NOT NULL,

	-- Timestamp of when this data was saved.
	-- Format: YYYYMMDD
	ph_timestamp varbinary(14) NOT NULL default '',

	-- Key of the user preference.
	-- (like mw_user_properties.up_property)
	ph_property varbinary(255) NOT NULL,

	-- Property value as a string.
	-- (like mw_user_properties.up_value)
	ph_value blob,

	-- Number of users with this property/value pair.
	-- Always above 0.
	ph_sum int unsigned NOT NULL default 0,

	-- Number of users with this property/value pair.
	-- (Counting only active users, based on user_touched < 30 days ago)
	-- Through user_properties_anonym.ts_user_touched_cropped
	-- Can be 0.
	ph_sum_active int unsigned NOT NULL default 0

) ENGINE=InnoDB, DEFAULT CHARSET=binary;


-- The population script must be ran no more than once a day because
-- we identify batches by timestamp and a time-group can only contain
-- each key/value pair once for every wiki.
CREATE UNIQUE INDEX i_ph_item ON property_history (ph_wikiid, ph_timestamp, ph_property, ph_value);

-- See queries.txt for an overview of queries we need to optimize for
CREATE INDEX on property_history ();