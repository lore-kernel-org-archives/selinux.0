Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAIhIIi022348
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 13:43:18 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAIhKR8008120
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 18:43:21 GMT
Subject: Re: Manipulating user roles without policy-sources installed
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102696635.1628.132.camel@moss-spartans.epoch.ncsc.mil>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614049.32175.168.camel@moss-spartans.epoch.ncsc.mil>
	 <41B9CD6A.2030008@redhat.com>
	 <1102696635.1628.132.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1102703905.1628.173.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 13:38:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-10 at 11:37, Stephen Smalley wrote:
> On Fri, 2004-12-10 at 11:23, Daniel J Walsh wrote:
> > I want to change genpolusers syntax to be
> > 
> > genpolusers inpolicy outpolicy userfile1 [userfile2 ... ]
> 
> Yes, that's easy enough to do, and as no one has used genpolusers to
> date AFAIK, changing the interface is ok with me.

Patch below should do it.

Index: checkpolicy/genpolusers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/genpolusers.c,v
retrieving revision 1.5
diff -u -r1.5 genpolusers.c
--- checkpolicy/genpolusers.c	11 Aug 2004 14:03:19 -0000	1.5
+++ checkpolicy/genpolusers.c	10 Dec 2004 18:31:49 -0000
@@ -1,8 +1,8 @@
 /*
- * genpolusers old-policy new-users new-policy
+ * genpolusers inpolicy outpolicy users1 [users2 ... ]
  *
- * Given an existing binary policy configuration and a new source users 
- * configuration (post-processed), generate a new binary policy 
+ * Given an existing binary policy configuration and a set of source users 
+ * configurations (post-processed), generate a new binary policy 
  * configuration that is identical to the old one except that it has
  * the new user declarations.  User declarations from the old binary
  * policy are replaced if they also exist in the new source users 
@@ -39,7 +39,7 @@
 
 void usage(char *progname)
 {
-	printf("usage:  %s old-policy new-users new-policy\n", progname);
+	printf("usage:  %s inpolicy outpolicy users1 [users2 ...]\n", progname);
 	exit(1);
 }
 
@@ -111,10 +111,10 @@
 	struct policy_file pf;
 	struct stat sb;
 	FILE *outfp;
-	int fd, rc;
+	int fd, rc, i;
 	void *map;
 
-	if (argc != 4) 
+	if (argc < 4) 
 		usage(argv[0]);
 
 	fd = open(argv[1], O_RDONLY);
@@ -148,12 +148,6 @@
 	   for the new policy. */
 	sepol_set_policyvers(policydb.policyvers);
 
-	yyin = fopen(argv[2], "r");
-	if (!yyin) {
-		fprintf(stderr, "%s:  unable to open %s\n", argv[0], 
-			argv[2]);
-		exit(1);
-	}
 	id_queue = queue_create();
 	if (!id_queue) {
 		fprintf(stderr, "%s:  out of memory\n", argv[0]);
@@ -161,21 +155,28 @@
 	}
 	policydbp = &policydb;
 	policydb_errors = 0;
-	if (yyparse() || policydb_errors) {
-		fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", argv[0]);
-		exit(1);
+
+	for (i = 3; i < argc; i++) {
+		yyin = fopen(argv[i], "r");
+		if (!yyin) {
+			fprintf(stderr, "%s:  unable to open %s\n", argv[0], 
+				argv[i]);
+			exit(1);
+		}
+
+		if (yyparse() || policydb_errors) {
+			fprintf(stderr, "%s:  error(s) encountered while parsing configuration %s\n", argv[0], argv[i]);
+			exit(1);
+		}
 	}
 	queue_destroy(id_queue);
 
-	if (policydb_errors) 
-		exit(1);
-
 	hashtab_map_remove_on_error(policydb.p_users.table, select_user, kill_user, &policydb);
 	hashtab_map(policydb.p_users.table, remap_users, &policydb);
 
-	outfp = fopen(argv[3], "w");
+	outfp = fopen(argv[2], "w");
 	if (!outfp) {
-		perror(argv[3]);
+		perror(argv[2]);
 		exit(1);
 	}
 	pf.type = PF_USE_STDIO;
@@ -183,7 +184,7 @@
 	rc = policydb_write(&policydb, &pf);
 	if (rc) {
 		fprintf(stderr, "%s:  error writing %s\n",
-			argv[0], argv[3]);
+			argv[0], argv[2]);
 		exit(1);
 	}
 	fclose(outfp);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
