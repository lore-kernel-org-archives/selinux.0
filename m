Subject: [PATCH] Checkpolicy: Allow filesystem names to start with a digit
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Jan 2011 16:29:02 -0500
Message-ID: <1294867742.2276.38.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch below allows filesystem names in fs_use_* and genfscon
statements to start with a digit, but still requires at least one
character to be a letter.  A new token type for filesystem names is
created since these names having nothing to do with SELinux.

This patch is needed because some filesystem names (such as 9p) start
with a digit.


Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

---
 policy_parse.y |   14 ++++++++++----
 policy_scan.l  |    1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 8d1bc37..0777238 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -138,6 +138,7 @@ typedef int (* require_func_t)();
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
 %token POLICYCAP
 %token PERMISSIVE
+%token FILESYSTEM
 
 %left OR
 %left XOR
@@ -637,7 +638,7 @@ opt_fs_uses             : fs_uses
 fs_uses                 : fs_use_def
                         | fs_uses fs_use_def
                         ;
-fs_use_def              : FSUSEXATTR identifier security_context_def ';'
+fs_use_def              : FSUSEXATTR filesystem security_context_def ';'
                         {if (define_fs_use(SECURITY_FS_USE_XATTR)) return -1;}
                         | FSUSETASK identifier security_context_def ';'
                         {if (define_fs_use(SECURITY_FS_USE_TASK)) return -1;}
@@ -650,11 +651,11 @@ opt_genfs_contexts      : genfs_contexts
 genfs_contexts          : genfs_context_def
                         | genfs_contexts genfs_context_def
                         ;
-genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
+genfs_context_def	: GENFSCON filesystem path '-' identifier security_context_def
 			{if (define_genfs_context(1)) return -1;}
-			| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
+			| GENFSCON filesystem path '-' '-' {insert_id("-", 0);} security_context_def
 			{if (define_genfs_context(1)) return -1;}
-                        | GENFSCON identifier path security_context_def
+                        | GENFSCON filesystem path security_context_def
 			{if (define_genfs_context(0)) return -1;}
 			;
 ipv4_addr_def		: IPV4_ADDR
@@ -728,6 +729,11 @@ nested_id_element       : identifier | '-' { if (insert_id("-", 0)) return -1; }
 identifier		: IDENTIFIER
 			{ if (insert_id(yytext,0)) return -1; }
 			;
+filesystem		: FILESYSTEM
+                        { if (insert_id(yytext,0)) return -1; }
+                        | IDENTIFIER
+			{ if (insert_id(yytext,0)) return -1; }
+                        ;
 path     		: PATH
 			{ if (insert_id(yytext,0)) return -1; }
 			;
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 48128a8..65aff8d 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -217,6 +217,7 @@ permissive |
 PERMISSIVE			{ return(PERMISSIVE); }
 "/"({alnum}|[_\.\-/])*	        { return(PATH); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
+{alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
 {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
