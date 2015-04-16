Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3GFMVu2021821
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 11:22:31 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id D5D6D63
 for <selinux@tycho.nsa.gov>; Thu, 16 Apr 2015 15:22:29 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: setfiles/restorecon: fix -r/-R option
Date: Thu, 16 Apr 2015 17:22:22 +0200
Message-Id: <1429197742-11618-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A spec file was incorrectly stored as rootpath when -r option was used

Fixes:
/sbin/setfiles:  /tmp/install_root is not located in /etc/selinux/targeted/contexts/files/file_contexts

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

This patch is based on the patch from Dan Walsh [1]. Furthermore it fixes problem with using argv[optind] and use
optarg instead. It was discovered in Fedora bug #1211721 [2]

[1] https://github.com/fedora-selinux/selinux/commit/f907db936ed038bf794a0145fed05cf3f828f1a1
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1211721

 policycoreutils/setfiles/setfiles.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 86d3f28..9ac3ebd 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -153,6 +153,9 @@ int main(int argc, char **argv)
 	int recurse; /* Recursive descent. */
 	const char *base;
 	int mass_relabel = 0, errors = 0;
+	const char *ropts = "e:f:hilno:pqrsvFRW0";
+	const char *sopts = "c:de:f:hilno:pqr:svFR:W0";
+	const char *opts;
 	
 	memset(&r_opts, 0, sizeof(r_opts));
 
@@ -196,6 +199,7 @@ int main(int argc, char **argv)
 		r_opts.add_assoc = 1;
 		r_opts.fts_flags = FTS_PHYSICAL | FTS_XDEV;
 		ctx_validate = 1;
+		opts = sopts;
 	} else {
 		/*
 		 * restorecon:  
@@ -215,6 +219,7 @@ int main(int argc, char **argv)
 		r_opts.add_assoc = 0;
 		r_opts.fts_flags = FTS_PHYSICAL;
 		ctx_validate = 0;
+		opts = ropts;
 
 		/* restorecon only:  silent exit if no SELinux.
 		   Allows unconditional execution by scripts. */
@@ -226,7 +231,7 @@ int main(int argc, char **argv)
 	r_opts.nfile = exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:hilno:pqrsvFRW0")) > 0) {
+	while ((opt = getopt(argc, argv, opts)) > 0) {
 		switch (opt) {
 		case 'c':
 			{
@@ -315,18 +320,13 @@ int main(int argc, char **argv)
 				recurse = 1;
 				break;
 			}
-			if (optind + 1 >= argc) {
-				fprintf(stderr, "usage:  %s -r rootpath\n",
-					argv[0]);
-				exit(-1);
-			}
 			if (NULL != r_opts.rootpath) {
 				fprintf(stderr,
 					"%s: only one -r can be specified\n",
 					argv[0]);
 				exit(-1);
 			}
-			set_rootpath(argv[optind++]);
+			set_rootpath(optarg);
 			break;
 		case 's':
 			use_input_file = 1;
-- 
2.3.5
