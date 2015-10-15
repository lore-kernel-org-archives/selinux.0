Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9FFU8ID011944
 for <selinux@tycho.nsa.gov>; Thu, 15 Oct 2015 11:30:08 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix selabel_open(3) services if no digest
 requested
Date: Thu, 15 Oct 2015 16:29:54 +0100
Message-Id: <1444922994-17404-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If selabel_open is called with no request for a digest it will fail
with ENOENT. This fixes all the labeling routines to resolve this
problem. The utils/selabel_digest example has also been updated
to allow calling selabel_open with and without digest requests to
aid testing.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_android_property.c |  2 +-
 libselinux/src/label_db.c               |  3 +--
 libselinux/src/label_file.c             |  4 +---
 libselinux/src/label_internal.h         |  2 +-
 libselinux/src/label_media.c            |  2 +-
 libselinux/src/label_support.c          | 10 ++++++----
 libselinux/src/label_x.c                |  2 +-
 libselinux/utils/selabel_digest.c       | 13 +++++++++----
 8 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index b8fab79..712eecb 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -203,7 +203,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (status)
 		goto finish;
 
-	status = digest_gen_hash(rec->digest);
+	digest_gen_hash(rec->digest);
 
 finish:
 	fclose(fp);
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 18c5967..1155bcc 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -322,8 +322,7 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 	if (digest_add_specfile(rec->digest, filp, NULL, sb.st_size, path) < 0)
 		goto out_error;
 
-	if (digest_gen_hash(rec->digest) < 0)
-		goto out_error;
+	digest_gen_hash(rec->digest);
 
 	fclose(filp);
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index cb43cb9..1a0c15f 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -574,9 +574,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			goto finish;
 	}
 
-	status = digest_gen_hash(rec->digest);
-	if (status)
-		goto finish;
+	digest_gen_hash(rec->digest);
 
 	status = sort_specs(data);
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 45bbe6c..2aa7a7b 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -65,7 +65,7 @@ extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 						    char *from_addr,
 						    size_t buf_len,
 						    const char *path);
-extern int digest_gen_hash(struct selabel_digest *digest);
+extern void digest_gen_hash(struct selabel_digest *digest);
 
 extern struct selabel_sub *selabel_subs_init(const char *path,
 				    struct selabel_sub *list,
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 16a7ced..622741b 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -140,7 +140,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (status)
 		goto finish;
 
-	status = digest_gen_hash(rec->digest);
+	digest_gen_hash(rec->digest);
 
 finish:
 	fclose(fp);
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 08757b2..ac52885 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -98,15 +98,16 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
 }
 
 /* Once all the specfiles are in the hash_buf, generate the hash. */
-int hidden digest_gen_hash(struct selabel_digest *digest)
+void hidden digest_gen_hash(struct selabel_digest *digest)
 {
+	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
-		return -1;
+		return;
 
 	SHA1(digest->hashbuf, digest->hashbuf_size, digest->digest);
 	free(digest->hashbuf);
 	digest->hashbuf = NULL;
-	return 0;
+	return;
 }
 
 /**
@@ -127,8 +128,9 @@ int hidden digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 {
 	unsigned char *tmp_buf;
 
+	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
-		return -1;
+		return 0;
 
 	if (digest->hashbuf_size + buf_len < digest->hashbuf_size) {
 		errno = EOVERFLOW;
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 309deae..700def1 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -167,7 +167,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (status)
 		goto finish;
 
-	status = digest_gen_hash(rec->digest);
+	digest_gen_hash(rec->digest);
 
 finish:
 	fclose(fp);
diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 16706b5..1e9fb34 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -11,13 +11,14 @@ static size_t digest_len;
 static void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage: %s -b backend [-d] [-v] [-B] [-f file]\n\n"
+		"usage: %s -b backend [-d] [-v] [-B] [-i] [-f file]\n\n"
 		"Where:\n\t"
 		"-b  The backend - \"file\", \"media\", \"x\", \"db\" or "
 			"\"prop\"\n\t"
 		"-v  Run \"cat <specfile_list> | openssl dgst -sha1 -hex\"\n\t"
 		"    on the list of specfiles to compare the SHA1 digests.\n\t"
 		"-B  Use base specfiles only (valid for \"-b file\" only).\n\t"
+		"-i  Do not request a digest.\n\t"
 		"-f  Optional file containing the specs (defaults to\n\t"
 		"    those used by loaded policy).\n\n",
 		progname);
@@ -59,7 +60,7 @@ static int run_check_digest(char *cmd, char *selabel_digest)
 int main(int argc, char **argv)
 {
 	int backend = 0, rc, opt, i, validate = 0;
-	char *baseonly = NULL, *file = NULL;
+	char *baseonly = NULL, *file = NULL, *digest = (char *)1;
 	char **specfiles = NULL;
 	unsigned char *sha1_digest = NULL;
 	size_t num_specfiles;
@@ -72,13 +73,13 @@ int main(int argc, char **argv)
 	struct selinux_opt selabel_option[] = {
 		{ SELABEL_OPT_PATH, file },
 		{ SELABEL_OPT_BASEONLY, baseonly },
-		{ SELABEL_OPT_DIGEST, (char *)1 }
+		{ SELABEL_OPT_DIGEST, digest }
 	};
 
 	if (argc < 3)
 		usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "b:Bvf:")) > 0) {
+	while ((opt = getopt(argc, argv, "ib:Bvf:")) > 0) {
 		switch (opt) {
 		case 'b':
 			if (!strcasecmp(optarg, "file")) {
@@ -103,6 +104,9 @@ int main(int argc, char **argv)
 		case 'v':
 			validate = 1;
 			break;
+		case 'i':
+			digest = NULL;
+			break;
 		case 'f':
 			file = optarg;
 			break;
@@ -115,6 +119,7 @@ int main(int argc, char **argv)
 
 	selabel_option[0].value = file;
 	selabel_option[1].value = baseonly;
+	selabel_option[2].value = digest;
 
 	hnd = selabel_open(backend, selabel_option, 3);
 	if (!hnd) {
-- 
2.4.3
