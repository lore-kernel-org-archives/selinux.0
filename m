Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8JJC6xq009761
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 15:12:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so3143918pff.6
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 12:09:07 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Date: Wed, 19 Sep 2018 12:08:56 -0700
Message-Id: <20180919190856.58147-1-nnk@google.com>
MIME-Version: 1.0
Subject: [PATCH] checkpolicy: remove extraneous policy build noise
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Reduce noise when calling the checkpolicy command line. In Android, this
creates unnecessary build noise which we'd like to avoid.

https://en.wikipedia.org/wiki/Unix_philosophy

  Rule of Silence
  Developers should design programs so that they do not print
  unnecessary output. This rule aims to allow other programs
  and developers to pick out the information they need from a
  program's output without having to parse verbosity.

An alternative approach would be to add a -s (silent) option to these
tools, or to have the Android build system redirect stdout to /dev/null.

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 checkpolicy/checkmodule.c |  8 --------
 checkpolicy/checkpolicy.c | 11 -----------
 2 files changed, 19 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 46ce258f..8edc1f8c 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -228,7 +228,6 @@ int main(int argc, char **argv)
 		if (optind !=3D argc)
 			usage(argv[0]);
 	}
-	printf("%s:  loading policy configuration from %s\n", argv[0], file);
=20
 	/* Set policydb and sidtab used by libsepol service functions
 	   to my structures, so that I can directly populate and
@@ -302,8 +301,6 @@ int main(int argc, char **argv)
=20
 	sepol_sidtab_destroy(&sidtab);
=20
-	printf("%s:  policy configuration loaded\n", argv[0]);
-
 	if (outfile) {
 		FILE *outfp =3D fopen(outfile, "w");
=20
@@ -313,16 +310,11 @@ int main(int argc, char **argv)
 		}
=20
 		if (!cil) {
-			printf("%s:  writing binary representation (version %d) to %s\n",
-				   argv[0], policyvers, outfile);
-
 			if (write_binary_policy(&modpolicydb, outfp) !=3D 0) {
 				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
 				exit(1);
 			}
 		} else {
-			printf("%s:  writing CIL to %s\n",argv[0], outfile);
-
 			if (sepol_module_policydb_to_cil(outfp, &modpolicydb, 0) !=3D 0) {
 				fprintf(stderr, "%s:  error writing %s\n", argv[0], outfile);
 				exit(1);
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index fbda4558..12c4c405 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -512,8 +512,6 @@ int main(int argc, char **argv)
 		if (optind !=3D argc)
 			usage(argv[0]);
 	}
-	printf("%s:  loading policy configuration from %s\n", argv[0], file);
-
 	/* Set policydb and sidtab used by libsepol service functions
 	   to my structures, so that I can directly populate and
 	   manipulate them. */
@@ -623,8 +621,6 @@ int main(int argc, char **argv)
 	if (policydb_load_isids(&policydb, &sidtab))
 		exit(1);
=20
-	printf("%s:  policy configuration loaded\n", argv[0]);
-
 	if (outfile) {
 		outfp =3D fopen(outfile, "w");
 		if (!outfp) {
@@ -636,8 +632,6 @@ int main(int argc, char **argv)
=20
 		if (!cil) {
 			if (!conf) {
-				printf("%s:  writing binary representation (version %d) to %s\n", ar=
gv[0], policyvers, outfile);
-
 				policydb.policy_type =3D POLICY_KERN;
=20
 				policy_file_init(&pf);
@@ -645,8 +639,6 @@ int main(int argc, char **argv)
 				pf.fp =3D outfp;
 				ret =3D policydb_write(&policydb, &pf);
 			} else {
-				printf("%s:  writing policy.conf to %s\n",
-				       argv[0], outfile);
 				ret =3D sepol_kernel_policydb_to_conf(outfp, policydbp);
 			}
 			if (ret) {
@@ -655,7 +647,6 @@ int main(int argc, char **argv)
 				exit(1);
 			}
 		} else {
-			printf("%s:  writing CIL to %s\n",argv[0], outfile);
 			if (binary) {
 				ret =3D sepol_kernel_policydb_to_cil(outfp, policydbp);
 			} else {
@@ -894,8 +885,6 @@ int main(int argc, char **argv)
 			FGETS(ans, sizeof(ans), stdin);
 			pathlen =3D strlen(ans);
 			ans[pathlen - 1] =3D 0;
-			printf("%s:  loading policy configuration from %s\n",
-			       argv[0], ans);
 			fd =3D open(ans, O_RDONLY);
 			if (fd < 0) {
 				fprintf(stderr, "Can't open '%s':  %s\n",
--=20
2.19.0.397.gdd90340f6a-goog
