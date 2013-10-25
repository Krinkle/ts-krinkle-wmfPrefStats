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
	-- Unique id identifying this piece of information.
	-- We don't really need this for anything, but it is nice to have a stable order
	-- for storing on disk, and it helps secondary indexes.
	ph_id int unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,

	-- The database name of the origin wiki (like mw_interwiki.iw_wikiid).
	ph_wikiid varchar(64) NOT NULL,

	-- Timestamp of when this data was saved. Format: YYYYMMDD.
	ph_timestamp varbinary(14) NOT NULL default '',

	-- Key of the user preference (like mw_user_properties.up_property).
	ph_property varbinary(255) NOT NULL default '',

	-- Property value as a string (like mw_user_properties.up_value).
	-- Original is blob, we use a limited width varbinary instead so that we can
	-- better index it. It shouldn't be possible for up_value to be NULL, but it
	-- is allowed in mediawiki's table, so for here: NULL -> empty string.
	ph_value varbinary(255) NOT NULL default '',

	-- Number of users with this property/value pair.
	-- Must always be above 0 (since it is a sum, we only have property/value
	-- combination that were found).
	ph_sum int unsigned NOT NULL default 0,

	-- Number of users with this property/value pair.
	-- (Counting only active users, based on user_touched < 30 days ago)
	-- Uses user_properties_anonym.ts_user_touched_cropped.
	-- Will be 0 if all users in this sum are inactive users.
	ph_sum_active int unsigned NOT NULL default 0

) ENGINE=InnoDB, DEFAULT CHARSET=binary;

-- TODO: Technically we don't need the unique index because we will
-- not run the script more than once a day, and by the next day the timestamp
-- will be different and the data should be inserted.
-- Only keep this if it helps database performance, otherwise, drop it.
CREATE UNIQUE INDEX i_ph_item ON property_history (ph_wikiid, ph_timestamp, ph_property, ph_value);

-- List from queries.txt: Move these to their relevant indexes
-- * "Fetch all items"
-- * "Fetch all items by wiki"
-- * "Fetch all items by time"
-- * "Fetch all items by wiki by time"
-- * "Fetch all items from active users"
-- * "Fetch all items from active by wiki"
-- * "Fetch all items from active by time"
-- * "Fetch all items from active by wiki by time"
-- * "Fetch 1 set of prop values"
-- * "Fetch 1 set of prop values by wiki"
-- * "Fetch 1 set of prop values by time"
-- * "Fetch 1 set of prop values by wiki by time"
-- * "Fetch 1 set of prop values from active users"
-- * "Fetch 1 set of prop values from active by wiki"
-- * "Fetch 1 set of prop values from active by time"
-- * "Fetch 1 set of prop values from active by wiki by time"
-- * "Fetch properties"
-- * "Fetch properties by wiki"
-- * "Fetch properties by time"
-- * "Fetch properties by wiki by time"
-- * "Fetch properties from active users  active users"
-- * "Fetch properties from active users by wiki"
-- * "Fetch properties from active users by time"
-- * "Fetch properties from active users by wiki by time"

CREATE INDEX i_ph_foo_bar ON property_history (ph_foo, ph_bar);
