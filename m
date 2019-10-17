Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EEC4CECE
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 07:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2420640
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 07:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392761AbfJQHFj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:05:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390955AbfJQHFj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 17 Oct 2019 03:05:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 948998012661
        for <selinux@vger.kernel.org>; Thu, 17 Oct 2019 07:05:37 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCCAF2156A2F;
        Thu, 17 Oct 2019 07:05:36 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 3/3] checkpolicy: allow to write policy to stdout
Date:   Thu, 17 Oct 2019 16:05:13 +0900
Message-Id: <20191017070513.13445-3-yamato@redhat.com>
In-Reply-To: <20191017070513.13445-1-yamato@redhat.com>
References: <20191017070513.13445-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 17 Oct 2019 07:05:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 17 Oct 2019 07:05:37 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'yamato@redhat.com' RCPT:''
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If - is given as filename for -o option, checkpolicy
writes the policy to standard output. This helps users
to read policy.conf and/or CIL policy file with pager
like less command:

 $ checkpolicy -M -F -b /sys/fs/selinux/policy  -o - | less

The users don't have to make a temporary file.
/dev/stdout can be used instead. However, - reduces the number of
typing for the purpose. Using - for standard output (and/or standard
input) is popular convention.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/checkpolicy.8 |  5 +++--
 checkpolicy/checkpolicy.c | 24 +++++++++++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index db57751c..bdfd6acd 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -3,7 +3,7 @@
 checkpolicy \- SELinux policy compiler
 .SH SYNOPSIS
 .B checkpolicy
-.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
+.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file|\-] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
 .br
 .SH "DESCRIPTION"
 This manual page describes the
@@ -41,7 +41,8 @@ Specify the policy version, defaults to the latest.
 .TP
 .B \-o,\-\-output filename
 Write a policy file (binary, policy.conf, or CIL policy)
-to the specified filename.
+to the specified filename. If - is given as filename,
+write it to standard output.
 .TP
 .B \-S,\-\-sort
 Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index e18de171..81bd2a9d 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -112,7 +112,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
 	    ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
-	     "[-c policyvers (%d-%d)] [-o output_file] [-S] "
+	     "[-c policyvers (%d-%d)] [-o output_file|-] [-S] "
 	     "[-t target_platform (selinux,xen)] [-V] [input_file]\n",
 	     progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
 	exit(1);
@@ -390,7 +390,8 @@ int main(int argc, char **argv)
 	struct sepol_av_decision avd;
 	class_datum_t *cladatum;
 	const char *file = txtfile;
-	char ans[80 + 1], *outfile = NULL, *path, *fstype;
+	char ans[80 + 1], *path, *fstype;
+	const char *outfile = NULL;
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
@@ -638,9 +639,20 @@ int main(int argc, char **argv)
 	}
 
 	if (outfile) {
-		outfp = fopen(outfile, "w");
+		int use_stdout = !strcmp(outfile, "-");
+		if (use_stdout) {
+			outfp = stdout;
+			outfile = "<STDOUT>";
+		} else {
+			outfp = fopen(outfile, "w");
+		}
+
 		if (!outfp) {
-			perror(outfile);
+			if (use_stdout)
+				fprintf(stderr, "%s: error to use %s\n",
+					argv[0], outfile);
+			else
+				perror(outfile);
 			exit(1);
 		}
 
@@ -682,7 +694,9 @@ int main(int argc, char **argv)
 			}
 		}
 
-		fclose(outfp);
+		if (outfp != stdout) {
+			fclose(outfp);
+		}
 	} else if (cil) {
 		fprintf(stderr, "%s:  No file to write CIL was specified\n", argv[0]);
 		exit(1);
-- 
2.21.0

