Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sJ009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:16 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so3188667wib.2
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:22 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.21
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:22 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 08/20] checkpolicy: constify the message written by yyerror
 and yywarn
Date: Sun, 14 Sep 2014 23:41:39 +0200
Message-Id: <1410730911-14512-9-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 checkpolicy/module_compiler.c | 4 ++--
 checkpolicy/policy_define.c   | 6 +++---
 checkpolicy/policy_parse.y    | 4 ++--
 checkpolicy/policy_scan.l     | 6 +++---
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index cdb361e04766..8ac81f78f4e2 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -39,9 +39,9 @@ typedef struct scope_stack {
 
 extern policydb_t *policydbp;
 extern queue_t id_queue;
-extern int yyerror(char *msg);
+extern int yyerror(const char *msg);
 __attribute__ ((format(printf, 1, 2)))
-extern void yyerror2(char *fmt, ...);
+extern void yyerror2(const char *fmt, ...);
 
 static int push_stack(int stack_type, ...);
 static void pop_stack(void);
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index cf3245a17d60..7e6091e41179 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -63,8 +63,8 @@ extern unsigned long source_lineno;
 extern unsigned int policydb_errors;
 extern char source_file[PATH_MAX];
 
-extern int yywarn(char *msg);
-extern int yyerror(char *msg);
+extern int yywarn(const char *msg);
+extern int yyerror(const char *msg);
 
 #define ERRORMSG_LEN 255
 static char errormsg[ERRORMSG_LEN + 1] = {0};
@@ -82,7 +82,7 @@ void init_parser(int pass_number)
 }
 
 __attribute__ ((format(printf, 1, 2)))
-void yyerror2(char *fmt, ...)
+void yyerror2(const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index b40f4137378a..d31773a412e7 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -58,8 +58,8 @@ extern unsigned int pass;
 
 extern char yytext[];
 extern int yylex(void);
-extern int yywarn(char *msg);
-extern int yyerror(char *msg);
+extern int yywarn(const char *msg);
+extern int yyerror(const char *msg);
 
 typedef int (* require_func_t)();
 
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 454bb84a8995..131613faa422 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -35,7 +35,7 @@ typedef int (* require_func_t)();
 
 static char linebuf[2][255];
 static unsigned int lno = 0;
-int yywarn(char *msg);
+int yywarn(const char *msg);
 
 void set_source_file(const char *name);
 
@@ -272,7 +272,7 @@ LOW				{ return(LOW); }
 "*"				{ return(yytext[0]); } 
 .                               { yywarn("unrecognized character");}
 %%
-int yyerror(char *msg)
+int yyerror(const char *msg)
 {
 	if (source_file[0])
 		fprintf(stderr, "%s:%ld:",
@@ -288,7 +288,7 @@ int yyerror(char *msg)
 	return -1;
 }
 
-int yywarn(char *msg)
+int yywarn(const char *msg)
 {
 	if (source_file[0])
 		fprintf(stderr, "%s:%ld:",
-- 
2.1.0
