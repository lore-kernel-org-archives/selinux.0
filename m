Return-Path: <SRS0=xdbR=5S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA1C2D0F3
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 15:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BE02063A
	for <selinux@archiver.kernel.org>; Thu,  2 Apr 2020 15:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TfM6v+Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgDBPpX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:45:23 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbgDBPpX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Apr 2020 11:45:23 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 563E720B46F0
        for <selinux@vger.kernel.org>; Thu,  2 Apr 2020 08:45:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 563E720B46F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1585842321;
        bh=IQFuHtFI2P2ex+YFi1KhBSPzE6ZSMyyv+Roju8Rk7HI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TfM6v+RsLOTv45OIbInDvdMXWbITjVXweWdk+EtSo8JpyCn6mhoXHxojnw6KgMIjT
         18yMSEz3Es0PijZkFSWvIKhUmLB8Zw42XEMSMlh/i+cjY+3jeFsObeas2IiuUw6T0n
         uCFordtE8Z2V7/GEOikwHUPUOKWTOT6rys48ubWo=
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] setfiles: Add -E option to treat conflicting specifications as errors.
Date:   Thu,  2 Apr 2020 11:45:09 -0400
Message-Id: <20200402154509.3640-2-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200402154509.3640-1-chpebeni@linux.microsoft.com>
References: <20200402154509.3640-1-chpebeni@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 policycoreutils/setfiles/restore.c  |  2 +-
 policycoreutils/setfiles/restore.h  |  1 +
 policycoreutils/setfiles/setfiles.8 |  5 +++++
 policycoreutils/setfiles/setfiles.c | 10 +++++++---
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index d3335d1a..9d688c60 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -41,7 +41,7 @@ void restore_init(struct restore_opts *opts)
 			   opts->xdev | opts->abort_on_error |
 			   opts->syslog_changes | opts->log_matches |
 			   opts->ignore_noent | opts->ignore_mounts |
-			   opts->mass_relabel;
+			   opts->mass_relabel | opts->conflict_error;
 
 	/* Use setfiles, restorecon and restorecond own handles */
 	selinux_restorecon_set_sehandle(opts->hnd);
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index b64042a6..ac6ad680 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -34,6 +34,7 @@ struct restore_opts {
 	unsigned int log_matches;
 	unsigned int ignore_noent;
 	unsigned int ignore_mounts;
+	unsigned int conflict_error;
 	/* restorecon_flags holds | of above for restore_init() */
 	unsigned int restorecon_flags;
 	char *rootpath;
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index c9f8be06..0188a75a 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -12,6 +12,7 @@ setfiles \- set SELinux file security contexts.
 .RB [ \-n ]
 .RB [ \-e
 .IR directory ]
+.RB [ \-E ]
 .RB [ \-p ]
 .RB [ \-s ]
 .RB [ \-v ]
@@ -62,6 +63,10 @@ after ABORT_ON_ERRORS errors).
 .BI \-e \ directory
 directory to exclude (repeat option for more than one directory).
 .TP
+.BI \-E
+treat conflicting specifications as errors, such as where two hardlinks for
+the same inode have different contexts.
+.TP
 .BI \-f \ infilename
 .I infilename
 contains a list of files to be processed. Use
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index bc83c27b..16bd592c 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -48,8 +48,8 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-diIDlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
-			"usage:  %s [-diIDlmnpqvFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
+			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
+			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
 			"usage:  %s -s [-diIDlmnpqvFW] spec_file\n"
 			"usage:  %s -c policyfile spec_file\n",
 			name, name, name, name);
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
 	const char *base;
 	int errors = 0;
 	const char *ropts = "e:f:hiIDlmno:pqrsvFRW0";
-	const char *sopts = "c:de:f:hiIDlmno:pqr:svFR:W0";
+	const char *sopts = "c:de:f:hiIDlmno:pqr:svEFR:W0";
 	const char *opts;
 	union selinux_callback cb;
 
@@ -313,6 +313,10 @@ int main(int argc, char **argv)
 			r_opts.syslog_changes =
 					   SELINUX_RESTORECON_SYSLOG_CHANGES;
 			break;
+		case 'E':
+			r_opts.conflict_error =
+					   SELINUX_RESTORECON_CONFLICT_ERROR;
+			break;
 		case 'F':
 			r_opts.set_specctx =
 					   SELINUX_RESTORECON_SET_SPECFILE_CTX;
-- 
2.21.1

