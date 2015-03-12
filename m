From: Daniel De Graaf <dgdegra@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] checkpolicy: Expand allowed character set in paths
Date: Thu, 12 Mar 2015 13:12:30 -0400
Message-Id: <1426180350-16259-5-git-send-email-dgdegra@tycho.nsa.gov>
In-Reply-To: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
References: <1426180350-16259-1-git-send-email-dgdegra@tycho.nsa.gov>
Cc: xen-devel@lists.xenproject.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to support paths containing spaces or other characters, allow a
quoted string with these characters to be parsed as a path in addition
to the existing unquoted string.

Signed-off-by: Daniel De Graaf <dgdegra@tycho.nsa.gov>
---
 checkpolicy/policy_parse.y | 3 +++
 checkpolicy/policy_scan.l  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 889df57..8b81f04 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -83,6 +83,7 @@ typedef int (* require_func_t)(int pass);
 %type <require_func> require_decl_def
 
 %token PATH
+%token QPATH
 %token FILENAME
 %token CLONE
 %token COMMON
@@ -811,6 +812,8 @@ filesystem		: FILESYSTEM
                         ;
 path     		: PATH
 			{ if (insert_id(yytext,0)) return -1; }
+			| QPATH
+			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
 			;
 filename		: FILENAME
 			{ yytext[strlen(yytext) - 1] = '\0'; if (insert_id(yytext + 1,0)) return -1; }
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index d0ba13a..108edbc 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -242,6 +242,7 @@ HIGH				{ return(HIGH); }
 low |
 LOW				{ return(LOW); }
 "/"({alnum}|[_\.\-/])*	        { return(PATH); }
+\""/"[ !#-~]*\" 		{ return(QPATH); }
 \"({alnum}|[_\.\-\+\~\: ])+\"	{ return(FILENAME); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
-- 
2.1.0
