Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5189BC433E0
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BE023107
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 21:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbhAMVNO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 16:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728972AbhAMVKe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 16:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610572197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dcO0MHo6KUP+SR9TaiZEieWe40Zda7jOsSF1+tMrVeQ=;
        b=h8NC9xdKK2Pvn3IrSlCOExTaGSsuITDYXhGMJgPN7whGYeH7rKpVWH8XBQhbZjWj86zSDw
        7FzahJZk5lYU+DplWSXEdKjV2Dws6tGu1jgWbpkos/f725J4wIZcBjtT6rt4uX8h7XEPY2
        R8GKyO8EbOIyZh+Qi7G9LPd6/arU2CE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-CsKFuD14NhGczp1t46rpdg-1; Wed, 13 Jan 2021 16:09:56 -0500
X-MC-Unique: CsKFuD14NhGczp1t46rpdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B79F190D340
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5542A60871;
        Wed, 13 Jan 2021 21:09:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2 1/2] setfiles: Do not abort on labeling error
Date:   Wed, 13 Jan 2021 22:09:47 +0100
Message-Id: <20210113210948.217575-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 602347c7422e ("policycoreutils: setfiles - Modify to use
selinux_restorecon") changed behavior of setfiles. Original
implementation skipped files which it couldn't set context to while the
new implementation aborts on them. setfiles should abort only if it
can't validate a context from spec_file.

Reproducer:

    # mkdir -p r/1 r/2 r/3
    # touch r/1/1 r/2/1
    # chattr +i r/2/1
    # touch r/3/1
    # setfiles -r r -v /etc/selinux/targeted/contexts/files/file_contexts r
    Relabeled r from unconfined_u:object_r:mnt_t:s0 to unconfined_u:object_r:root_t:s0
    Relabeled r/2 from unconfined_u:object_r:mnt_t:s0 to unconfined_u:object_r:default_t:s0
    setfiles: Could not set context for r/2/1:  Operation not permitted

r/3 and r/1 are not relabeled.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/setfiles/setfiles.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 422c3767b845..10692d6d94a0 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -181,6 +181,7 @@ int main(int argc, char **argv)
 	policyfile = NULL;
 	nerr = 0;
 
+	r_opts.abort_on_error = 0;
 	r_opts.progname = strdup(argv[0]);
 	if (!r_opts.progname) {
 		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
@@ -193,7 +194,6 @@ int main(int argc, char **argv)
 		 * setfiles:
 		 * Recursive descent,
 		 * Does not expand paths via realpath,
-		 * Aborts on errors during the file tree walk,
 		 * Try to track inode associations for conflict detection,
 		 * Does not follow mounts (sets SELINUX_RESTORECON_XDEV),
 		 * Validates all file contexts at init time.
@@ -201,7 +201,6 @@ int main(int argc, char **argv)
 		iamrestorecon = 0;
 		r_opts.recurse = SELINUX_RESTORECON_RECURSE;
 		r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
-		r_opts.abort_on_error = SELINUX_RESTORECON_ABORT_ON_ERROR;
 		r_opts.add_assoc = SELINUX_RESTORECON_ADD_ASSOC;
 		/* FTS_PHYSICAL and FTS_NOCHDIR are always set by selinux_restorecon(3) */
 		r_opts.xdev = SELINUX_RESTORECON_XDEV;
@@ -225,7 +224,6 @@ int main(int argc, char **argv)
 		iamrestorecon = 1;
 		r_opts.recurse = 0;
 		r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
-		r_opts.abort_on_error = 0;
 		r_opts.add_assoc = 0;
 		r_opts.xdev = 0;
 		r_opts.ignore_mounts = 0;
-- 
2.30.0

