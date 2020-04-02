Return-Path: <SRS0=xdbR=5S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DABC2BA12
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2EE2063A
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pUfvrh4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389435AbgDBPpW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:45:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40148 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBPpW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Apr 2020 11:45:22 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id CD8E920B4749
        for <selinux@vger.kernel.org>; Thu,  2 Apr 2020 08:45:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD8E920B4749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585842321;
        bh=W0VNCKXyTkJNpyPJBQ5t+gOcfSEN6OlFUhpF+pGvitM=;
        h=From:To:Subject:Date:From;
        b=pUfvrh4STUcQWi+104eLsPFPoPtrCEgiQsurVHR1/WlC8yvwzlxqPSsKE7b+N2gyu
         C8pjchj85PeuJhdd23TE9pcj7dfxNI41oNNCj3cW6GmznPpPxCScUq2N0+hM9YNijk
         6Ww+GcxVgVDQrmatywtn96KH6OfmTovkM1QDEapM=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libselinux: Add selinux_restorecon option to treat conflicting specifications as an error.
Date:   Thu,  2 Apr 2020 11:45:08 -0400
Message-Id: <20200402154509.3640-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 libselinux/include/selinux/restorecon.h  | 37 ++++++++++++++----------
 libselinux/man/man3/selinux_restorecon.3 |  4 +++
 libselinux/src/selinux_restorecon.c      | 13 +++++++--
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index 754b8645..466de39a 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -30,77 +30,82 @@ extern int selinux_restorecon(const char *pathname,
  * Force the checking of labels even if the stored SHA1 digest
  * matches the specfiles SHA1 digest (requires CAP_SYS_ADMIN).
  */
-#define SELINUX_RESTORECON_IGNORE_DIGEST		0x0001
+#define SELINUX_RESTORECON_IGNORE_DIGEST		0x00001
 /*
  * Do not change file labels.
  */
-#define SELINUX_RESTORECON_NOCHANGE			0x0002
+#define SELINUX_RESTORECON_NOCHANGE			0x00002
 /*
  * If set, change file label to that in spec file.
  * If not, only change type component to that in spec file.
  */
-#define SELINUX_RESTORECON_SET_SPECFILE_CTX		0x0004
+#define SELINUX_RESTORECON_SET_SPECFILE_CTX		0x00004
 /*
  * Recursively descend directories.
  */
-#define SELINUX_RESTORECON_RECURSE			0x0008
+#define SELINUX_RESTORECON_RECURSE			0x00008
 /*
  * Log changes to selinux log. Note that if VERBOSE and
  * PROGRESS are set, then PROGRESS will take precedence.
  */
-#define SELINUX_RESTORECON_VERBOSE			0x0010
+#define SELINUX_RESTORECON_VERBOSE			0x00010
 /*
  * If SELINUX_RESTORECON_PROGRESS is true and
  * SELINUX_RESTORECON_MASS_RELABEL is true, then output approx % complete,
  * else output the number of files in 1k blocks processed to stdout.
  */
-#define SELINUX_RESTORECON_PROGRESS			0x0020
+#define SELINUX_RESTORECON_PROGRESS			0x00020
 /*
  * Convert passed-in pathname to canonical pathname.
  */
-#define SELINUX_RESTORECON_REALPATH			0x0040
+#define SELINUX_RESTORECON_REALPATH			0x00040
 /*
  * Prevent descending into directories that have a different
  * device number than the pathname from which the descent began.
  */
-#define SELINUX_RESTORECON_XDEV				0x0080
+#define SELINUX_RESTORECON_XDEV				0x00080
 /*
  * Attempt to add an association between an inode and a specification.
  * If there is already an association for the inode and it conflicts
  * with the specification, then use the last matching specification.
  */
-#define SELINUX_RESTORECON_ADD_ASSOC			0x0100
+#define SELINUX_RESTORECON_ADD_ASSOC			0x00100
 /*
  * Abort on errors during the file tree walk.
  */
-#define SELINUX_RESTORECON_ABORT_ON_ERROR		0x0200
+#define SELINUX_RESTORECON_ABORT_ON_ERROR		0x00200
 /*
  * Log any label changes to syslog.
  */
-#define SELINUX_RESTORECON_SYSLOG_CHANGES		0x0400
+#define SELINUX_RESTORECON_SYSLOG_CHANGES		0x00400
 /*
  * Log what spec matched each file.
  */
-#define SELINUX_RESTORECON_LOG_MATCHES			0x0800
+#define SELINUX_RESTORECON_LOG_MATCHES			0x00800
 /*
  * Ignore files that do not exist.
  */
-#define SELINUX_RESTORECON_IGNORE_NOENTRY		0x1000
+#define SELINUX_RESTORECON_IGNORE_NOENTRY		0x01000
 /*
  * Do not read /proc/mounts to obtain a list of non-seclabel
  * mounts to be excluded from relabeling checks.
  */
-#define SELINUX_RESTORECON_IGNORE_MOUNTS		0x2000
+#define SELINUX_RESTORECON_IGNORE_MOUNTS		0x02000
 /*
  * Set if there is a mass relabel required.
  * See SELINUX_RESTORECON_PROGRESS flag for details.
  */
-#define SELINUX_RESTORECON_MASS_RELABEL			0x4000
+#define SELINUX_RESTORECON_MASS_RELABEL			0x04000
 /*
  * Set if no digest is to be read or written (as only processes
  * running with CAP_SYS_ADMIN can read/write digests).
  */
-#define SELINUX_RESTORECON_SKIP_DIGEST			0x8000
+#define SELINUX_RESTORECON_SKIP_DIGEST			0x08000
+
+/*
+ * Set to treat conflicting specifications as errors.
+ */
+#define SELINUX_RESTORECON_CONFLICT_ERROR		0x10000
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index f6e5f2d7..ad637406 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -152,6 +152,10 @@ Setting
 .B SELINUX_RESTORECON_IGNORE_MOUNTS
 is useful where there is a non-seclabel fs mounted with a seclabel fs mounted
 on a directory below this.
+.sp
+.B SELINUX_RESTORECON_CONFLICT_ERROR
+to treat conflicting specifications, such as where two hardlinks for the
+same inode have different contexts, as errors.
 .RE
 .sp
 The behavior regarding the checking and updating of the SHA1 digest described
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 028d8924..91dfeb66 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -81,6 +81,7 @@ struct rest_flags {
 	bool log_matches;
 	bool ignore_noent;
 	bool warnonnomatch;
+	bool conflicterror;
 };
 
 static void restorecon_init(void)
@@ -418,7 +419,8 @@ static file_spec_t *fl_head;
  * different context that matched the inode, then use the first context
  * that matched.
  */
-static int filespec_add(ino_t ino, const char *con, const char *file)
+static int filespec_add(ino_t ino, const char *con, const char *file,
+			struct rest_flags *flags)
 {
 	file_spec_t *prevfl, *fl;
 	int h, ret;
@@ -458,6 +460,11 @@ static int filespec_add(ino_t ino, const char *con, const char *file)
 			fl->file = strdup(file);
 			if (!fl->file)
 				goto oom;
+			if (flags->conflicterror) {
+				selinux_log(SELINUX_ERROR,
+				"treating conflicting specifications as an error.\n");
+				return -1;
+			}
 			return 1;
 		}
 
@@ -645,7 +652,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (flags->add_assoc) {
-		rc = filespec_add(sb->st_ino, newcon, pathname);
+		rc = filespec_add(sb->st_ino, newcon, pathname, flags);
 
 		if (rc < 0) {
 			selinux_log(SELINUX_ERROR,
@@ -833,6 +840,8 @@ int selinux_restorecon(const char *pathname_orig,
 	flags.ignore_noent = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_NOENTRY) ? true : false;
 	flags.warnonnomatch = true;
+	flags.conflicterror = (restorecon_flags &
+		   SELINUX_RESTORECON_CONFLICT_ERROR) ? true : false;
 	ignore_mounts = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
 	bool ignore_digest = (restorecon_flags &
-- 
2.21.1

