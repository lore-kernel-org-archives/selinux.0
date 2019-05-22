Return-Path: <SRS0=KxHl=TW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D6FC072A4
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 05:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636F220821
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 05:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Dkwh58On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEVFtP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 May 2019 01:49:15 -0400
Received: from rgout0604.bt.lon5.cpcloud.co.uk ([65.20.0.131]:40433 "EHLO
        rgout06.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbfEVFtO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 May 2019 01:49:14 -0400
X-OWM-Source-IP: 86.147.201.202 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtuddrvddtvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtuddrvddtvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeogihunhgthhgrnhhgsehgohhoghhlvgdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.147.201.202) by rgout06.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C3942FB0C5B0ABE; Wed, 22 May 2019 06:49:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1558504153; 
        bh=yGy1Tx0QXJVZM9Fg4onBVafDNdIjPR4YAO4XxdKyGlU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Dkwh58OnchfqxYBfcsNlCWTQ/OIDKUvozmJsnp0hWZnjFrN2zOtcEkRdvkmbjLVacQzo9fK4zB5bNLcCrXTEKw8K5w7gLVIdPrBcltEQxhazXE5OgjuUSE4iyFD0J+lW8HeA9DSszQCB/iWsm9SGyYRsYURJ4q/EuqCOSFSZeRY=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, xunchang@google.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 2/3] setfiles: Update utilities for the new digest scheme
Date:   Wed, 22 May 2019 06:49:07 +0100
Message-Id: <20190522054907.3810-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update restorecon, setfiles and restorecon_xattr to handle the
new digest scheme managed by selinux_restorecon(3).

Note that the Russian man pages require updating.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policycoreutils/setfiles/restore.c          |  7 +--
 policycoreutils/setfiles/restore.h          |  2 +-
 policycoreutils/setfiles/restorecon.8       | 10 ++--
 policycoreutils/setfiles/restorecon_xattr.8 | 19 ++----
 policycoreutils/setfiles/restorecon_xattr.c | 66 ++++-----------------
 policycoreutils/setfiles/setfiles.8         | 10 ++--
 policycoreutils/setfiles/setfiles.c         | 19 +++---
 7 files changed, 37 insertions(+), 96 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 9dea565..4421f5c 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -26,11 +26,10 @@ void restore_init(struct restore_opts *opts)
 	r_opts = opts;
 	struct selinux_opt selinux_opts[] = {
 		{ SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
-		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path },
-		{ SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
+		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path }
 	};
 
-	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
+	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 2);
 	if (!r_opts->hnd) {
 		perror(r_opts->selabel_opt_path);
 		exit(1);
@@ -44,7 +43,7 @@ void restore_init(struct restore_opts *opts)
 			   r_opts->xdev | r_opts->abort_on_error |
 			   r_opts->syslog_changes | r_opts->log_matches |
 			   r_opts->ignore_noent | r_opts->ignore_mounts |
-			   r_opts->mass_relabel;
+			   r_opts->mass_relabel | r_opts->skip_digest;
 
 	/* Use setfiles, restorecon and restorecond own handles */
 	selinux_restorecon_set_sehandle(r_opts->hnd);
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index b64042a..8e8deed 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -26,6 +26,7 @@ struct restore_opts {
 	unsigned int set_specctx;
 	unsigned int add_assoc;
 	unsigned int ignore_digest;
+	unsigned int skip_digest;
 	unsigned int recurse;
 	unsigned int userealpath;
 	unsigned int xdev;
@@ -41,7 +42,6 @@ struct restore_opts {
 	struct selabel_handle *hnd;
 	const char *selabel_opt_validate;
 	const char *selabel_opt_path;
-	const char *selabel_opt_digest;
 	int debug;
 };
 
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 0f81db4..bbfc83f 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -100,7 +100,7 @@ section for further details.
 .B \-D
 Set or update any directory SHA1 digests. Use this option to
 enable usage of the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute.
 .TP
 .B \-m
@@ -184,10 +184,10 @@ option to
 .B restorecon
 will cause it to store a SHA1 digest of the default specfiles set in an extended
 attribute named
-.IR security.restorecon_last
-on the directory specified in each
+.IR security.sehash
+on each directory specified in
 .IR pathname \ ...
-once the relabeling has been completed successfully. This digest will be
+once the relabeling has been completed successfully. These digests will be
 checked should
 .B restorecon
 .B \-D
@@ -204,7 +204,7 @@ option will ignore the SHA1 digest from each directory specified in
 and provided the
 .B \-n
 option is NOT set and recursive mode is set, files will be relabeled as
-required with the digest then being updated provided there are no errors.
+required with the digests then being updated provided there are no errors.
 
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/policycoreutils/setfiles/restorecon_xattr.8 b/policycoreutils/setfiles/restorecon_xattr.8
index 65b28ea..36fd0c1 100644
--- a/policycoreutils/setfiles/restorecon_xattr.8
+++ b/policycoreutils/setfiles/restorecon_xattr.8
@@ -1,7 +1,7 @@
 .TH "restorecon_xattr" "8" "24 Sept 2016" "" "SELinux User Command"
 .SH "NAME"
 restorecon_xattr \- manage
-.I security.restorecon_last
+.I security.sehash
 extended attribute entries added by
 .BR setfiles (8)
 or
@@ -14,7 +14,6 @@ or
 .RB [ \-m ]
 .RB [ \-n ]
 .RB [ \-r ]
-.RB [ \-v ]
 .RB [ \-e
 .IR directory ]
 .RB [ \-f
@@ -24,7 +23,7 @@ or
 .SH "DESCRIPTION"
 .B restorecon_xattr
 will display the SHA1 digests added to extended attributes
-.I security.restorecon_last
+.I security.sehash
 or delete the attribute completely. These attributes are set by
 .BR restorecon (8)
 or
@@ -43,7 +42,7 @@ from.
 and
 .B TMPFS
 filesystems do not support the
-.I security.restorecon_last
+.I security.sehash
 extended attribute and are automatically excluded from searches.
 .sp
 By default
@@ -62,12 +61,12 @@ option.
 .TP
 .B \-d
 delete all non-matching
-.I security.restorecon_last
+.I security.sehash
 directory digest entries.
 .TP
 .B \-D
 delete all
-.I security.restorecon_last
+.I security.sehash
 directory digest entries.
 .TP
 .B \-m
@@ -86,9 +85,6 @@ Do not append "Match" or "No Match" to displayed digests.
 .B \-r
 recursively descend directories.
 .TP
-.B \-v
-display SHA1 digest generated by specfile set.
-.TP
 .B \-e
 .I directory
 .br
@@ -101,11 +97,6 @@ an optional
 .I specfile
 containing file context entries as described in
 .BR file_contexts (5).
-This will be used by
-.BR selabel_open (3)
-to retrieve the set of labeling entries, with the SHA1 digest being
-retrieved by
-.BR selabel_digest (3).
 If the option is not specified, then the default file_contexts will be used.
 
 .SH "ARGUMENTS"
diff --git a/policycoreutils/setfiles/restorecon_xattr.c b/policycoreutils/setfiles/restorecon_xattr.c
index 91c087f..a32ddd7 100644
--- a/policycoreutils/setfiles/restorecon_xattr.c
+++ b/policycoreutils/setfiles/restorecon_xattr.c
@@ -17,9 +17,8 @@
 static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-		"\nusage: %s [-vnrmdD] [-e directory] [-f specfile] pathname\n"
+		"\nusage: %s [-nrmdD] [-e directory] [-f specfile] pathname\n"
 		"\nWhere:\n\t"
-		"-v  Display digest generated by specfile set.\n\t"
 		"-n  Do not append \"Match\" or \"No Match\" to displayed digests.\n\t"
 		"-r  Recursively descend directories.\n\t"
 		"-m  Do not read /proc/mounts for entries to be excluded.\n\t"
@@ -27,7 +26,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 		"-D  Delete all digest entries.\n\t"
 		"-e  Directory to exclude (repeat option for more than one directory).\n\t"
 		"-f  Optional specfile for calculating the digest.\n\t"
-		"pathname  Path to search for xattr \"security.restorecon_last\" entries.\n\n",
+		"pathname  Path to search for xattr \"security.sehash\" entries.\n\n",
 		progname);
 	exit(-1);
 }
@@ -37,10 +36,7 @@ int main(int argc, char **argv)
 	int opt, rc;
 	unsigned int xattr_flags = 0, delete_digest = 0, recurse = 0;
 	unsigned int delete_all_digests = 0, ignore_mounts = 0;
-	bool display_digest = false;
-	char *sha1_buf, **specfiles, *fc_file = NULL;
-	unsigned char *fc_digest = NULL;
-	size_t i, fc_digest_len = 0, num_specfiles;
+	char *fc_file = NULL;
 
 	struct stat sb;
 	struct selabel_handle *hnd = NULL;
@@ -59,11 +55,8 @@ int main(int argc, char **argv)
 
 	exclude_list = NULL;
 
-	while ((opt = getopt(argc, argv, "vnrmdDe:f:")) > 0) {
+	while ((opt = getopt(argc, argv, "nrmdDe:f:")) > 0) {
 		switch (opt) {
-		case 'v':
-			display_digest = true;
-			break;
 		case 'n':
 			no_comment = false;
 			break;
@@ -103,59 +96,18 @@ int main(int argc, char **argv)
 	}
 
 	struct selinux_opt selinux_opts[] = {
-		{ SELABEL_OPT_PATH, fc_file },
-		{ SELABEL_OPT_DIGEST, (char *)1 }
+		{ SELABEL_OPT_PATH, fc_file }
 	};
 
-	hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 2);
+	hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 1);
 	if (!hnd) {
-		switch (errno) {
-		case EOVERFLOW:
-			fprintf(stderr, "Error: Number of specfiles or"
-				 " specfile buffer caused an overflow.\n");
-			break;
-		default:
-			fprintf(stderr, "Error: selabel_open: %s\n",
-							    strerror(errno));
-		}
-		exit(-1);
+		fprintf(stderr, "Error: selabel_open - Could not obtain handle.\n");
+		return -1;
 	}
 
 	/* Use own handle as need to allow different file_contexts. */
 	selinux_restorecon_set_sehandle(hnd);
 
-	if (display_digest) {
-		if (selabel_digest(hnd, &fc_digest, &fc_digest_len,
-				   &specfiles, &num_specfiles) < 0) {
-			fprintf(stderr,
-				"Error: selabel_digest: Digest not available.\n");
-			selabel_close(hnd);
-			exit(-1);
-		}
-
-		sha1_buf = malloc(fc_digest_len * 2 + 1);
-		if (!sha1_buf) {
-			fprintf(stderr,
-				"Error allocating digest buffer: %s\n",
-							    strerror(errno));
-			selabel_close(hnd);
-			exit(-1);
-		}
-
-		for (i = 0; i < fc_digest_len; i++)
-			sprintf((&sha1_buf[i * 2]), "%02x", fc_digest[i]);
-
-		printf("specfiles SHA1 digest: %s\n", sha1_buf);
-
-		printf("calculated using the following specfile(s):\n");
-		if (specfiles) {
-			for (i = 0; i < num_specfiles; i++)
-				printf("%s\n", specfiles[i]);
-		}
-		free(sha1_buf);
-		printf("\n");
-	}
-
 	if (exclude_list)
 		selinux_restorecon_set_exclude_list
 						 ((const char **)exclude_list);
@@ -211,6 +163,8 @@ int main(int argc, char **argv)
 			free(current);
 			current = next;
 		}
+	} else {
+		printf("No digests available\n");
 	}
 
 	rc = 0;
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index ccaaf4d..c9f8be0 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -90,7 +90,7 @@ section for further details.
 .B \-D
 Set or update any directory SHA1 digests. Use this option to
 enable usage of the
-.IR security.restorecon_last
+.IR security.sehash
 extended attribute.
 .TP
 .B \-l
@@ -228,10 +228,10 @@ option to
 will cause it to store a SHA1 digest of the
 .B spec_file
 set in an extended attribute named
-.IR security.restorecon_last
-on the directory specified in each
+.IR security.sehash
+on each directory specified in
 .IR pathname \ ...
-once the relabeling has been completed successfully. This digest will be
+once the relabeling has been completed successfully. These digests will be
 checked should
 .B setfiles
 .B \-D
@@ -250,7 +250,7 @@ option will ignore the SHA1 digest from each directory specified in
 .IR pathname \ ...
 and provided the
 .B \-n
-option is NOT set, files will be relabeled as required with the digest then
+option is NOT set, files will be relabeled as required with the digests then
 being updated provided there are no errors.
 
 .SH "AUTHOR"
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index bc83c27..4188b8c 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -17,7 +17,6 @@
 static char *policyfile;
 static int warn_no_match;
 static int null_terminated;
-static int request_digest;
 static struct restore_opts r_opts;
 static int nerr;
 
@@ -178,7 +177,6 @@ int main(int argc, char **argv)
 	altpath = NULL;
 	null_terminated = 0;
 	warn_no_match = 0;
-	request_digest = 0;
 	policyfile = NULL;
 	nerr = 0;
 
@@ -200,6 +198,7 @@ int main(int argc, char **argv)
 		 * Validates all file contexts at init time.
 		 */
 		iamrestorecon = 0;
+		r_opts.skip_digest = SELINUX_RESTORECON_SKIP_DIGEST;
 		r_opts.recurse = SELINUX_RESTORECON_RECURSE;
 		r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
 		r_opts.abort_on_error = SELINUX_RESTORECON_ABORT_ON_ERROR;
@@ -224,6 +223,7 @@ int main(int argc, char **argv)
 				base, RESTORECON);
 
 		iamrestorecon = 1;
+		r_opts.skip_digest = SELINUX_RESTORECON_SKIP_DIGEST;
 		r_opts.recurse = 0;
 		r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
 		r_opts.abort_on_error = 0;
@@ -297,17 +297,15 @@ int main(int argc, char **argv)
 			r_opts.ignore_noent =
 					   SELINUX_RESTORECON_IGNORE_NOENTRY;
 			break;
-		case 'I': /* Force label check by ignoring directory digest. */
+		case 'I': /* Force label check by ignoring directory digest,
+			   * then update the digests.
+			   */
 			r_opts.ignore_digest =
 					   SELINUX_RESTORECON_IGNORE_DIGEST;
-			request_digest = 1;
+			r_opts.skip_digest = 0;
 			break;
-		case 'D': /*
-			   * Request file_contexts digest in selabel_open
-			   * This will effectively enable usage of the
-			   * security.restorecon_last extended attribute.
-			   */
-			request_digest = 1;
+		case 'D': /* Enable the security.sehash extended attribute. */
+			r_opts.skip_digest = 0;
 			break;
 		case 'l':
 			r_opts.syslog_changes =
@@ -434,7 +432,6 @@ int main(int argc, char **argv)
 
 	/* Set selabel_open options. */
 	r_opts.selabel_opt_validate = (ctx_validate ? (char *)1 : NULL);
-	r_opts.selabel_opt_digest = (request_digest ? (char *)1 : NULL);
 	r_opts.selabel_opt_path = altpath;
 
 	if (nerr)
-- 
2.20.1

