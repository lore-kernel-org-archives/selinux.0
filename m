Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p85FUijx013176
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2011 11:30:44 -0400
Received: from nm1.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p85FUhcV020663
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2011 15:30:43 GMT
Message-ID: <1315236620.76591.YahooMailClassic@web87015.mail.ird.yahoo.com>
Date: Mon, 5 Sep 2011 16:30:20 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] Modify 'mdp' to output MLS and CIL policy source files.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The 'make dummy policy' application will now output policy source files to build a basic MLS policy and also support the CIL compiler. See the SELinux.txt file for further information.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 Documentation/security/SELinux.txt |   34 +++++
 scripts/selinux/mdp/mdp.c          |  269 +++++++++++++++++++++++++++++-------
 2 files changed, 253 insertions(+), 50 deletions(-)

diff --git a/Documentation/security/SELinux.txt b/Documentation/security/SELinux.txt
index 07eae00..0a38c36 100644
--- a/Documentation/security/SELinux.txt
+++ b/Documentation/security/SELinux.txt
@@ -25,3 +25,37 @@ kernel, with a single selinux user, role, and type.
 It will compile the policy, will set your SELINUXTYPE to
 dummy in /etc/selinux/config, install the compiled policy
 as 'dummy', and relabel your filesystem.
+
+NOTES:
+
+mdp supports building the following policy source file types:
+
+	1. Output a non mls source file suitable for building a binary policy
+	   with checkpolicy (this is the default when using step 4 above):
+			./mdp <policy_file> <file_contexts>
+
+	2. Output an mls source file suitable for building an MLS binary policy
+	   with checkpolicy:
+			./mdp -M <policy_file> <file_contexts>
+
+	3. Output a CIL source file suitable for building either a non-mls or mls 
+	   binary policy using the CIL compiler:
+			./mdp -c <policy_file> <file_contexts>
+
+If mdp is called locally, a path will need to point to the classmap.h and
+initial_sid_to_string.h files located in the "security/selinux/include" 
+directory.
+
+You are advised to set the SELinux configuration file 'config' to permissive
+as follows when testing these policies:
+
+	SELINUX=permissive
+
+Once loaded, then 'setenforce 1' can be used to enforce the policy.
+
+
+
+
+
+
+
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 62b34ce..99d0e8f 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -22,6 +22,7 @@
  * Copyright (C) IBM Corporation, 2006
  *
  * Authors: Serge E. Hallyn <serue@us.ibm.com>
+ *			Richard Haines <richard_c_haines@btinternet.com>
  */
 
 #include <stdio.h>
@@ -29,9 +30,16 @@
 #include <unistd.h>
 #include <string.h>
 
+void policy_conf(FILE *fout, int mls);
+void policy_cil(FILE *fout, int mls);
+
 static void usage(char *name)
 {
-	printf("usage: %s [-m] policy_file context_file\n", name);
+	printf("usage: %s [-M] [-c] policy_file context_file\n", name);
+	printf("Option -M will generate an MLS policy.\n");
+	printf("Option -c will generate a CIL policy.\n");
+	printf("If no options are given a basic non-MLS policy will be "
+				"generated that can be built using checkpolicy.\n");
 	exit(1);
 }
 
@@ -44,23 +52,34 @@ struct security_class_mapping {
 #include "classmap.h"
 #include "initial_sid_to_string.h"
 
+static char *user = "user_u";
+static char *role = "base_r";
+static char *type = "base_t";
+
+
 int main(int argc, char *argv[])
 {
-	int i, j, mls = 0;
-	int initial_sid_to_string_len;
-	char **arg, *polout, *ctxout;
-
+	int cil, mls = 0;
+	int opt;
+	char *polout, *ctxout;
 	FILE *fout;
 
-	if (argc < 3)
-		usage(argv[0]);
-	arg = argv+1;
-	if (argc==4 && strcmp(argv[1], "-m") == 0) {
-		mls = 1;
-		arg++;
+	while ((opt = getopt(argc, argv, "Mc")) != -1) {
+		switch (opt) {
+			case 'M':
+				mls = 1;
+				break;
+			case 'c':
+				cil = 1;
+				break;
+			default:
+				usage(argv[0]);
+			break;
+		}
 	}
-	polout = *arg++;
-	ctxout = *arg;
+
+	polout = argv[optind++];
+	ctxout = argv[optind];
 
 	fout = fopen(polout, "w");
 	if (!fout) {
@@ -68,6 +87,36 @@ int main(int argc, char *argv[])
 		usage(argv[0]);
 	}
 
+	if (cil)
+		policy_cil(fout, mls);
+	else
+		policy_conf(fout, mls);
+
+	/* Write out a file contexts file for both cases */
+	fout = fopen(ctxout, "w");
+	if (!fout) {
+		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
+		usage(argv[0]);
+	}
+
+	if (mls) {
+		fprintf(fout, "/ %s:%s:%s:s0\n", user, role, type);
+		fprintf(fout, "/.* %s:%s:%s:s0\n", user, role, type);
+	}
+	else {
+		fprintf(fout, "/ %s:%s:%s\n", user, role, type);
+		fprintf(fout, "/.* %s:%s:%s\n", user, role, type);
+	}
+	fclose(fout);
+	return 0;
+}
+
+
+
+void policy_conf(FILE *fout, int mls)
+{
+	int i, j, initial_sid_to_string_len;
+
 	/* print out the classes */
 	for (i = 0; secclass_map[i].name; i++)
 		fprintf(fout, "class %s\n", secclass_map[i].name);
@@ -88,60 +137,180 @@ int main(int argc, char *argv[])
 			fprintf(fout, "\t%s\n", map->perms[j]);
 		fprintf(fout, "}\n\n");
 	}
-	fprintf(fout, "\n");
 
 	/* NOW PRINT OUT MLS STUFF */
 	if (mls) {
-		printf("MLS not yet implemented\n");
-		exit(1);
+		fprintf(fout, "sensitivity s0;\n");
+		fprintf(fout, "dominance { s0 }\n");
+		fprintf(fout, "category c0;\n");
+		fprintf(fout, "level s0:c0;\n");
+		fprintf(fout, "# checkpolicy always wants an mlsconstrain or fails to "
+				"build. This is a simple one:\n");
+		fprintf(fout, "mlsconstrain { filesystem } { relabelto } "
+				"( h1 dom h2 );\n\n");
 	}
 
 	/* types, roles, and allows */
-	fprintf(fout, "type base_t;\n");
-	fprintf(fout, "role base_r types { base_t };\n");
+	fprintf(fout, "type %s;\n\n", type);
+	fprintf(fout, "role %s;\n", role);
+	fprintf(fout, "role %s types { %s };\n\n", role, type);
 	for (i = 0; secclass_map[i].name; i++)
-		fprintf(fout, "allow base_t base_t:%s *;\n",
-			secclass_map[i].name);
-	fprintf(fout, "user user_u roles { base_r };\n");
+		fprintf(fout, "allow %s %s : %s *;\n", type, type, secclass_map[i].name);
 	fprintf(fout, "\n");
 
-	/* default sids */
-	for (i = 1; i < initial_sid_to_string_len; i++)
-		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
+	if (mls)
+		fprintf(fout, "user %s roles { %s } level s0 range s0;\n", user, role);
+	else
+		fprintf(fout, "user %s roles { %s };\n", user, role);
 	fprintf(fout, "\n");
 
-	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_xattr lustre user_u:base_r:base_t;\n");
+	if (mls) {
+			/* default MLS sids */
+		for (i = 1; i < initial_sid_to_string_len; i++)
+			fprintf(fout, "sid %s %s:%s:%s:s0\n", initial_sid_to_string[i], user, role, type);
+		fprintf(fout, "\n");
 
-	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
+		fprintf(fout, "fs_use_xattr ext2 %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr ext3 %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr ext4 %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr jfs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr xfs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr reiserfs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr jffs2 %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr gfs2 %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr lustre %s:%s:%s:s0;\n\n", user, role, type);
+	
+		fprintf(fout, "fs_use_task eventpollfs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_task pipefs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_task sockfs %s:%s:%s:s0;\n\n", user, role, type);
 
-	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
-	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
+		fprintf(fout, "fs_use_trans mqueue %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_trans devpts %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_trans hugetlbfs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_trans tmpfs %s:%s:%s:s0;\n", user, role, type);
+		fprintf(fout, "fs_use_trans shm %s:%s:%s:s0;\n\n", user, role, type);
+		fprintf(fout, "genfscon proc / %s:%s:%s:s0\n\n", user, role, type);
+	}
+	else {
+		/* default sids */
+		for (i = 1; i < initial_sid_to_string_len; i++)
+			fprintf(fout, "sid %s %s:%s:%s\n", initial_sid_to_string[i], user, role, type);
+		fprintf(fout, "\n");
 
-	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
+		fprintf(fout, "fs_use_xattr ext2 %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr ext3 %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr ext4 %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr jfs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr xfs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr reiserfs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr jffs2 %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr gfs2 %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_xattr lustre %s:%s:%s;\n\n", user, role, type);
+	
+		fprintf(fout, "fs_use_task eventpollfs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_task pipefs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_task sockfs %s:%s:%s;\n\n", user, role, type);
+
+		fprintf(fout, "fs_use_trans mqueue %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_trans devpts %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_trans hugetlbfs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_trans tmpfs %s:%s:%s;\n", user, role, type);
+		fprintf(fout, "fs_use_trans shm %s:%s:%s;\n\n", user, role, type);
+		fprintf(fout, "genfscon proc / %s:%s:%s\n\n", user, role, type);
+	}
 
 	fclose(fout);
+	return;
+}
 
-	fout = fopen(ctxout, "w");
-	if (!fout) {
-		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
-		usage(argv[0]);
+
+
+void policy_cil(FILE *fout, int mls)
+{
+	int i, j, initial_sid_to_string_len;
+
+	/* 
+	 * Set up the required default MLS information. This will be discarded 
+	 * by the CIL policy build process as this is a non-MLS policy. It will
+	 * allow the generation of a suitable default context.
+	 */
+	fprintf(fout, "(category c0)\n");
+	fprintf(fout, "(categoryorder (c0))\n");
+	fprintf(fout, "(sensitivity s0)\n");
+	fprintf(fout, "(dominance (s0))\n");
+	fprintf(fout, "(sensitivitycategory s0 (c0))\n");
+	fprintf(fout, "(levelrange default ((s0 (c0)) (s0 (c0))))\n");
+	fprintf(fout, "(level low (s0 (c0)))\n\n");
+
+	initial_sid_to_string_len = sizeof(initial_sid_to_string) / sizeof (char *);
+	/* print out the sids */
+	for (i = 1; i < initial_sid_to_string_len; i++)
+		fprintf(fout, "(sid %s)\n", initial_sid_to_string[i]);
+	fprintf(fout, "\n");
+
+	/* print out the class permissions */
+	for (i = 0; secclass_map[i].name; i++) {
+		struct security_class_mapping *map = &secclass_map[i];
+		fprintf(fout, "(class %s (", map->name);
+		for (j = 0; map->perms[j]; j++)
+			fprintf(fout, " %s", map->perms[j]);
+		fprintf(fout, "))\n");
 	}
-	fprintf(fout, "/ user_u:base_r:base_t\n");
-	fprintf(fout, "/.* user_u:base_r:base_t\n");
-	fclose(fout);
+	fprintf(fout, "\n");
 
-	return 0;
+	/* types, roles, and allows */
+	fprintf(fout, "(type  %s)\n", type);
+	fprintf(fout, "(role  %s)\n", role);
+	fprintf(fout, "(roletype %s %s)\n\n", role, type);
+
+	for (i = 0; secclass_map[i].name; i++) {
+		struct security_class_mapping *map = &secclass_map[i];
+		fprintf(fout, "(allow  %s  %s %s (", type, type, secclass_map[i].name);
+		for (j = 0; map->perms[j]; j++)
+			fprintf(fout, " %s", map->perms[j]);
+		fprintf(fout, "))\n");
+	}
+	fprintf(fout, "\n");
+
+	fprintf(fout, "(user  %s)\n", user);
+	fprintf(fout, "(userrole  %s  %s)\n\n", user, role);
+	fprintf(fout, "(userrange %s (low low))\n", user);
+	fprintf(fout, "(userlevel %s low)\n\n", user);
+
+	fprintf(fout, "(context default_context (%s %s %s default))\n\n", user, role, type);
+
+	/* default sids */
+	for (i = 1; i < initial_sid_to_string_len; i++)
+		fprintf(fout, "(sidcontext %s default_context)\n", initial_sid_to_string[i]);
+	fprintf(fout, "\n");
+
+	fprintf(fout, "(fsuse xattr ext2 default_context)\n");
+	fprintf(fout, "(fsuse xattr ext3 default_context)\n");
+	fprintf(fout, "(fsuse xattr ext4 default_context)\n");
+	fprintf(fout, "(fsuse xattr jfs default_context)\n");
+	fprintf(fout, "(fsuse xattr xfs default_context)\n");
+	fprintf(fout, "(fsuse xattr reiserfs default_context)\n");
+	fprintf(fout, "(fsuse xattr jffs2 default_context)\n");
+	fprintf(fout, "(fsuse xattr gfs2 default_context)\n");
+	fprintf(fout, "(fsuse xattr lustre default_context)\n");
+
+	fprintf(fout, "(fsuse task eventpollfs default_context)\n");
+	fprintf(fout, "(fsuse task pipefs default_context)\n");
+	fprintf(fout, "(fsuse task sockfs default_context)\n");
+
+	fprintf(fout, "(fsuse trans mqueue default_context)\n");
+	fprintf(fout, "(fsuse trans devpts default_context)\n");
+	fprintf(fout, "(fsuse trans hugetlbfs default_context)\n");
+	fprintf(fout, "(fsuse trans tmpfs default_context)\n");
+	fprintf(fout, "(fsuse trans shm default_context)\n");
+
+	fprintf(fout, "(genfscon proc / default_context)\n\n");
+
+	fprintf(fout, "(filecon \"/\" \"\" file default_context)\n");
+	fprintf(fout, "(filecon \"/\" \".*\" file default_context)\n\n");
+
+	fclose(fout);
+	return;
 }
+
+
-- 
1.7.6.1

Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
