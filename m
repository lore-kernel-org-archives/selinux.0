Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049B314B96
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798187; cv=none; b=mOvXKf0IKw486EZSfryegQclG22XS6hELhGNG0+sM51/ptKwbWAf+4y9aowZpDlxnezCvHahJs6FjMmq113Pqky/0F7/ELjJs0vMp3UoLWrYxIsHRssXVRhyNWAyC2/TxL2Pv6ASW6TPqwyrmGqBIh7/JtMFN6cjNjLYFtwWgPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798187; c=relaxed/simple;
	bh=2RnSx4ANsCJEUfjndibglJz7FW+dkmQmVx/xo80Ilaw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ldpg2WrhMsOaEGNvxGrbeL3soUyqvntN3PLuJdRU1Htu8UjxzNlJ36sf14Ww4xq+KotAaDRjZw5/uL/gdQzFaS30ZtZfmDFUkSDn8a3CX6E1eZJbc6tjqi/q7g3j+jkI20JpsluO5aqV3Pg7UyTLjUS6A6nm9wdxS2yQYZ58Lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDBeFaBH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDBeFaBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762798184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vVEeRpKhFaRbbP302Dv18pC1rdWIFKOHktSmYTzUCaQ=;
	b=QDBeFaBHXWalvjcoeyGMXIo0wTLAK6KVT6MGiGzypdaXFS8vOxXtRAQ9qczejZgn816mGR
	XNmOCgVUkM2xaIBkVTdIuOAjj2/ums+VZqJjXVJTnYQ+ATKCU0Q3y5YoRXgBdBIy7mkgcE
	zTwPyypCJupoWLwUSuhEUfLu1A6qBYA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-yPAZS5o0MJOck3GG4GDb_g-1; Mon,
 10 Nov 2025 13:09:43 -0500
X-MC-Unique: yPAZS5o0MJOck3GG4GDb_g-1
X-Mimecast-MFC-AGG-ID: yPAZS5o0MJOck3GG4GDb_g_1762798182
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4923E18002DD
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 18:09:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E12291800367
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 18:09:40 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] restorecon: Add option to count number of relabeled files
Date: Mon, 10 Nov 2025 19:05:50 +0100
Message-ID: <20251110180935.202229-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is useful in case we want to check that a remediation using
restorecon was successful (otherwise 0 is always returned, even if no
files where relabeled).

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libselinux/include/selinux/restorecon.h |  9 +++++++++
 libselinux/src/libselinux.map           |  1 +
 libselinux/src/selinux_restorecon.c     | 14 ++++++++++++++
 policycoreutils/setfiles/restore.h      |  1 +
 policycoreutils/setfiles/restorecon.8   |  3 +++
 policycoreutils/setfiles/setfiles.c     | 24 ++++++++++++++++++++----
 6 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 0ccf73a6..736481bb 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -228,6 +228,15 @@ extern int selinux_restorecon_xattr(const char *pathname,
  */
 extern long unsigned selinux_restorecon_get_skipped_errors(void);
 
+/* selinux_restorecon_get_relabeled_files - Get the number of relabeled files
+ *
+ * If selinux_restorecon(3) or selinux_restorecon_parallel(3) was called,
+ * this function returns the number of files that were successfully relabeled.
+ * If the SELINUX_RESTORECON_NOCHANGE flag was set, this function returns
+ * the number of files that would be relabeled.
+ */
+extern long unsigned selinux_restorecon_get_relabeled_files(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index ab002f01..f21e089e 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -244,6 +244,7 @@ LIBSELINUX_1.0 {
 LIBSELINUX_3.4 {
   global:
     selinux_restorecon_get_skipped_errors;
+    selinux_restorecon_get_relabeled_files;
     selinux_restorecon_parallel;
 } LIBSELINUX_1.0;
 
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 681c69db..6e9a159e 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -69,6 +69,9 @@ static struct dir_xattr *dir_xattr_last;
 /* Number of errors ignored during the file tree walk. */
 static long unsigned skipped_errors;
 
+/* Number of successfully relabeled files or files that would be relabeled */
+static long unsigned relabeled_files;
+
 /* restorecon_flags for passing to restorecon_sb() */
 struct rest_flags {
 	bool nochange;
@@ -796,6 +799,10 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 				syslog(LOG_INFO, "labeling %s to %s\n",
 					    pathname, newcon);
 		}
+
+		/* Count relabeled files (or would be relabeled if "nochange" was not set) */
+		relabeled_files++;
+
 	}
 
 out:
@@ -1096,6 +1103,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	state.skipped_errors = 0;
 	state.saved_errno = 0;
 
+	relabeled_files = 0;
+
 	struct stat sb;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
 	char *paths[2] = { NULL, NULL };
@@ -1618,3 +1627,8 @@ long unsigned selinux_restorecon_get_skipped_errors(void)
 {
 	return skipped_errors;
 }
+
+long unsigned selinux_restorecon_get_relabeled_files(void)
+{
+	return relabeled_files;
+}
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index 95afb960..7c949c1c 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -37,6 +37,7 @@ struct restore_opts {
 	unsigned int ignore_mounts;
 	unsigned int conflict_error;
 	unsigned int count_errors;
+	unsigned int count_relabeled;
 	/* restorecon_flags holds | of above for restore_init() */
 	unsigned int restorecon_flags;
 	char *rootpath;
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 1134420e..e9bd16b6 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -153,6 +153,9 @@ display warnings about entries that had no matching files by outputting the
 .BR selabel_stats (3)
 results.
 .TP
+.B \-c
+count and display the number of (would be) relabeled files. The exit code will be set to the number of relabeled files (capped at 254).
+.TP
 .B \-0
 the separator for the input items is assumed to be the null character
 (instead of the white space).  The quotes and the backslash characters are
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 31034316..6323f56c 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -35,8 +35,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] pathname...\n"
-			"usage:  %s [-iIDFUmnprRv0xT] [-e excludedir] -f filename\n",
+			"usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] pathname...\n"
+			"usage:  %s [-ciIDFUmnprRv0xT] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
@@ -146,7 +146,7 @@ int main(int argc, char **argv)
 	size_t buf_len, nthreads = 1;
 	const char *base;
 	int errors = 0;
-	const char *ropts = "e:f:hiIDlmno:pqrsvFURW0xT:";
+	const char *ropts = "ce:f:hiIDlmno:pqrsvFURW0xT:";
 	const char *sopts = "c:de:f:hiIDlmno:pqr:svACEFUR:W0T:";
 	const char *opts;
 	union selinux_callback cb;
@@ -223,7 +223,10 @@ int main(int argc, char **argv)
 	while ((opt = getopt(argc, argv, opts)) > 0) {
 		switch (opt) {
 		case 'c':
-			{
+			if (iamrestorecon) {
+				r_opts.count_relabeled = 1;
+				break;
+			} else {
 				FILE *policystream;
 
 				policyfile = optarg;
@@ -479,5 +482,18 @@ int main(int argc, char **argv)
 	if (r_opts.progress)
 		fprintf(stdout, "\n");
 
+	/* Output relabeled file count if requested */
+	if (r_opts.count_relabeled) {
+		long unsigned relabeled_count = selinux_restorecon_get_relabeled_files();
+		printf("Relabeled %lu files\n", relabeled_count);
+
+		/* Set exit code to number of relabeled files (capped at 254) */
+		if (errors) {
+			exit(-1);
+		} else {
+			exit(relabeled_count > 254 ? 254 : (int)relabeled_count);
+		}
+	}
+
 	exit(errors ? -1 : skipped_errors ? 1 : 0);
 }
-- 
2.51.0

