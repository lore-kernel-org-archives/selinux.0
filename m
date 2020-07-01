Return-Path: <SRS0=TSKA=AM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685FDC433E0
	for <selinux@archiver.kernel.org>; Wed,  1 Jul 2020 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E651206C3
	for <selinux@archiver.kernel.org>; Wed,  1 Jul 2020 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgGAPJj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:09:39 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45559 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgGAPJc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Jul 2020 11:09:32 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2E04A4000A;
        Wed,  1 Jul 2020 15:09:30 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     selinux@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Subject: [PATCH] policycoreutils: setfiles: do not restrict checks against a binary policy
Date:   Wed,  1 Jul 2020 17:06:27 +0200
Message-Id: <20200701150627.1643297-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The -c option allows to check the validity of contexts against a
specified binary policy. Its use is restricted: no pathname can be used
when a binary policy is given to setfiles. It's not clear if this is
intentional as the built-in help and the man page are not stating the
same thing about this (the man page document -c as a normal option,
while the built-in help shows it is restricted).

When generating full system images later used with SELinux in enforcing
mode, the extended attributed of files have to be set by the build
machine. The issue is setfiles always checks the contexts against a
policy (ctx_validate = 1) and using an external binary policy is not
currently possible when using a pathname. This ends up in setfiles
failing early as the contexts of the target image are not always
compatible with the ones of the build machine.

This patch reworks a check on optind only made when -c is used, that
enforced the use of a single argument to allow 1+ arguments, allowing to
use setfiles with an external binary policy and pathnames. The following
command is then allowed, as already documented in the man page:

  $ setfiles -m -r target/ -c policy.32 file_contexts target/

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 policycoreutils/setfiles/setfiles.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index ed67b5f12245..4844875cfc6b 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -48,10 +48,9 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
-			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
-			"usage:  %s -s [-diIDlmnpqvFW] spec_file\n"
-			"usage:  %s -c policyfile spec_file\n",
+			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
+			"usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
+			"usage:  %s -s [-diIDlmnpqvFW] spec_file\n",
 			name, name, name, name);
 	}
 	exit(-1);
@@ -409,7 +408,7 @@ int main(int argc, char **argv)
 
 	if (!iamrestorecon) {
 		if (policyfile) {
-			if (optind != (argc - 1))
+			if (optind > (argc - 1))
 				usage(argv[0]);
 		} else if (use_input_file) {
 			if (optind != (argc - 1)) {
-- 
2.26.2

