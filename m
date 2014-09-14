Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELgsEM009324
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:54 -0400
Received: by mail-we0-f174.google.com with SMTP id t60so3117333wes.19
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:33 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.31
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:32 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 15/20] checkpolicy: fix most gcc -Wwrite-strings warnings
Date: Sun, 14 Sep 2014 23:41:46 +0200
Message-Id: <1410730911-14512-16-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 checkpolicy/checkmodule.c   | 10 +++++-----
 checkpolicy/checkpolicy.c   |  7 ++++---
 checkpolicy/policy_define.c |  2 +-
 checkpolicy/policy_define.h |  2 +-
 checkpolicy/test/dismod.c   |  4 ++--
 checkpolicy/test/dispol.c   |  6 +++---
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index f25bc28530ee..0255928f98b6 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -41,13 +41,13 @@ static sidtab_t sidtab;
 extern int mlspol;
 
 static int handle_unknown = SEPOL_DENY_UNKNOWN;
-static char *txtfile = "policy.conf";
-static char *binfile = "policy";
+static const char *txtfile = "policy.conf";
+static const char *binfile = "policy";
 
 unsigned int policy_type = POLICY_BASE;
 unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
 
-static int read_binary_policy(policydb_t * p, char *file, char *progname)
+static int read_binary_policy(policydb_t * p, const char *file, const char *progname)
 {
 	int fd;
 	struct stat sb;
@@ -108,7 +108,7 @@ static int read_binary_policy(policydb_t * p, char *file, char *progname)
 	return 0;
 }
 
-static int write_binary_policy(policydb_t * p, char *file, char *progname)
+static int write_binary_policy(policydb_t * p, const char *file, char *progname)
 {
 	FILE *outfp = NULL;
 	struct policy_file pf;
@@ -161,7 +161,7 @@ static void usage(char *progname)
 
 int main(int argc, char **argv)
 {
-	char *file = txtfile, *outfile = NULL;
+	const char *file = txtfile, *outfile = NULL;
 	unsigned int binary = 0;
 	int ch;
 	int show_version = 0;
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 7fa37af2849b..8c199d7c8628 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -96,8 +96,8 @@ extern policydb_t *policydbp;
 extern int mlspol;
 
 static int handle_unknown = SEPOL_DENY_UNKNOWN;
-static char *txtfile = "policy.conf";
-static char *binfile = "policy";
+static const char *txtfile = "policy.conf";
+static const char *binfile = "policy";
 
 unsigned int policyvers = POLICYDB_VERSION_MAX;
 
@@ -381,7 +381,8 @@ int main(int argc, char **argv)
 	sepol_security_context_t scontext;
 	struct sepol_av_decision avd;
 	class_datum_t *cladatum;
-	char ans[80 + 1], *file = txtfile, *outfile = NULL, *path, *fstype;
+	const char *file = txtfile;
+	char ans[80 + 1], *outfile = NULL, *path, *fstype;
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 92cb8246fc4c..675ca8ce5a2f 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -107,7 +107,7 @@ int insert_separator(int push)
 	return 0;
 }
 
-int insert_id(char *id, int push)
+int insert_id(const char *id, int push)
 {
 	char *newid = 0;
 	int error;
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index 8bfd8f604bf4..4ef0f4f43f0a 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -64,7 +64,7 @@ int define_typebounds(void);
 int define_type(int alias);
 int define_user(void);
 int define_validatetrans(constraint_expr_t *expr);
-int insert_id(char *id,int push);
+int insert_id(const char *id,int push);
 int insert_separator(int push);
 role_datum_t *define_role_dom(role_datum_t *r);
 role_datum_t *merge_roles_dom(role_datum_t *r1,role_datum_t *r2);
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 96ef047f7b36..7c754c02ba77 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -65,7 +65,7 @@ static const char *symbol_labels[9] = {
 	"levels ", "cats   ", "attribs"
 };
 
-void usage(char *progname)
+void usage(const char *progname)
 {
 	printf("usage:  %s binary_pol_file\n\n", progname);
 	exit(1);
@@ -99,7 +99,7 @@ static void render_access_bitmap(ebitmap_t * map, uint32_t class,
 }
 
 static void display_id(policydb_t * p, FILE * fp, uint32_t symbol_type,
-		       uint32_t symbol_value, char *prefix)
+		       uint32_t symbol_value, const char *prefix)
 {
 	char *id = p->sym_val_to_name[symbol_type][symbol_value];
 	scope_datum_t *scope =
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index f41acdc626c1..ba4a71fde639 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -37,7 +37,7 @@
 
 static policydb_t policydb;
 
-void usage(char *progname)
+void usage(const char *progname)
 {
 	printf("usage:  %s binary_pol_file\n\n", progname);
 	exit(1);
@@ -320,9 +320,9 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 }
 
 static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
-		       uint32_t symbol_value, char *prefix)
+		       uint32_t symbol_value, const char *prefix)
 {
-	char *id = p->sym_val_to_name[symbol_type][symbol_value];
+	const char *id = p->sym_val_to_name[symbol_type][symbol_value];
 	fprintf(fp, " %s%s", prefix, id);
 }
 
-- 
2.1.0
