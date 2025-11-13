## ClaudeOnRails Configuration

You are working on Constellate, a Rails application. Review the ClaudeOnRails context file at @.claude-on-rails/context.md

## 🔴 CRITICAL DATA SAFETY RULE 🔴

**NEVER DELETE OR TRUNCATE ANY DATABASE (LOCAL OR PRODUCTION) WITHOUT EXPLICIT PERMISSION**

⚠️ **ABSOLUTELY FORBIDDEN WITHOUT EXPLICIT PERMISSION:**
- Running `rails db:drop`, `rails db:reset`, `rails db:setup`
- Truncating or deleting records from any table
- Running destructive migrations that drop tables or columns
- Executing any SQL DELETE, TRUNCATE, or DROP statements
- Modifying database.yml to point to different databases

**ALWAYS ASK PERMISSION BEFORE:**
- Any database schema changes
- Any data modification operations
- Running seeds that might overwrite data
- Changing database connections or configurations

**This is a ZERO TOLERANCE rule - data loss is unacceptable.**

## Development Environment
- **Development Server**: http://localhost:3000
