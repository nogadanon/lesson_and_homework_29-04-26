-- Add a TEXT column called tier to the sales table, then fill it: 'high' where amount > 1000, 'low' otherwise
ALTER TABLE sales
ADD COLUMN tier TEXT DEFAULT 'low';
UPDATE sales
SET tier = 'high' WHERE amount > 1000;

-- Add a REAL column called tax with DEFAULT 0, then update it to amount * 0.07 where amount IS NOT NULL
ALTER TABLE sales
ADD COLUMN tax REAL DEFAULT 0;
UPDATE sales 
SET tax = amount * 0.07;

-- Rename the sales table to sales_backup, then rename it back to sales
ALTER TABLE sales
RENAME TO sales_backup;

ALTER TABLE sales_backup
RENAME TO sales;

-- Rename the column product to item
ALTER TABLE sales
RENAME COLUMN product TO item;

-- Drop the tier column you created in step 1, then run PRAGMA table_info(sales) to verify it is gone
ALTER TABLE sales
DROP COLUMN tier;

PRAGMA table_info(sales);
