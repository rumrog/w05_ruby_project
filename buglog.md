# Bug Log

## 0. Access to db/seeds.rb denied. Tables halted.

```
ruby db/seeds.rb
```
```
Traceback (most recent call last):
	3: from db/seeds.rb:6:in `<main>'
	2: from /Users/rumenroger/e40/e40_classwork/hw/w05_ruby_project/models/tag.rb:50:in `delete_all'
	1: from /Users/rumenroger/e40/e40_classwork/hw/w05_ruby_project/db/sql_runner.rb:9:in `run'
/Users/rumenroger/e40/e40_classwork/hw/w05_ruby_project/db/sql_runner.rb:9:in `exec_prepared': ERROR:  update or delete on table "tags" violates foreign key constraint "transactions_tag_id_fkey" on table "transactions" (PG::ForeignKeyViolation)
DETAIL:  Key (id)=(1) is still referenced from table "transactions".
```
**Triggered by:** Trying to access `db/seeds.rb` a second time.
**Caused by:** 
**Solution:**