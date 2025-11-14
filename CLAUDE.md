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

## 🚨 CRITICAL DEPLOYMENT SAFETY CHECK 🚨

**BEFORE ANY FLY.IO DEPLOYMENT - ALWAYS VERIFY CORRECT LOGIN:**

1. **Check current Fly.io login**: `fly auth whoami`
2. **Verify correct app context**: `fly status` (should show chromium-funds app)
3. **Double-check target app**: Confirm you're deploying to the right application

**Wrong login = accidental site overwrite!** 

This prevents deploying ChromiumFunds code to a different user's Fly.io app by accident.

## 🔒 CSP COMPLIANCE REQUIREMENT 🔒

**⚠️ CRITICAL - CSP VIOLATIONS WILL BREAK THE SITE IN MODERN BROWSERS ⚠️**

This application enforces **STRICT** Content Security Policy in production. ANY violation will cause functionality to fail.

### ❌ ABSOLUTELY FORBIDDEN - WILL BREAK IN BROWSERS:

1. **Inline Styles** - `style="..."` attributes
   ```erb
   ❌ BAD:  <div style="color: red;">
   ✅ GOOD: <div class="text-red">
   ```

2. **Inline Event Handlers** - `onclick`, `onload`, `onsubmit`, etc.
   ```erb
   ❌ BAD:  <button onclick="alert('hi')">
   ✅ GOOD: <button data-action="click->controller#method">
   ```

3. **Inline `<script>` Tags** in views
   ```erb
   ❌ BAD:  <script>console.log('test')</script>
   ✅ GOOD: Create app/javascript/controllers/feature_controller.js
   ```

4. **JavaScript URLs**
   ```erb
   ❌ BAD:  <a href="javascript:void(0)">
   ✅ GOOD: <a href="#" data-action="click->controller#method">
   ```

### ✅ REQUIRED IMPLEMENTATIONS:

**For Styling:**
- Add CSS class to `app/assets/stylesheets/application.css`
- Reference with `class="my-class"`

**For JavaScript:**
- Create Stimulus controller in `app/javascript/controllers/`
- Use `data-controller` and `data-action` attributes
- Example: `data-action="click->confirm#confirm"`

**For Confirmations:**
- Use `confirm_controller.js` with `data-confirm-message-value`

**For Dynamic Behavior:**
- Use Stimulus targets and classes
- Toggle CSS classes, don't set inline styles

### 🛡️ WHY THIS MATTERS:

**CSP prevents XSS attacks** - Without it, attackers can inject malicious code.

**Modern browsers enforce CSP** - Chrome, Firefox, Safari, Edge all block CSP violations.

**Production CSP policy** (`application_controller.rb`):
```ruby
"script-src 'self'"    # No unsafe-inline!
"style-src 'self' https:"  # No unsafe-inline!
```

### 📋 BEFORE EVERY COMMIT:

Run: `bin/rails csp:report`

If ANY violations found → FIX THEM IMMEDIATELY

**ZERO TOLERANCE for CSP violations. They WILL break production.**
- memorize - do not deploy unless asked.