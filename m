Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40CC43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E2E2073D
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaUapPiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLIQmE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:42:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44351 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbfLIQmE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 11:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575909723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hm6dEMqLmR2mPUC6qUoTwYnpBwWDphm54SqO3q6FRrk=;
        b=MaUapPiSLQCF8ioPK4fk5JKAhqdheACrTmtwSKGt/7TCJkrbc4YOq+ryC7eIXjoGQfDd0z
        wNxGJDoYBZi9GbEXAkFH0QGZurETZWHg2gWulXSqWZGtA5dGk71QL57E/cpCE6LKHXcnwi
        wssG11aR80bIp/b+Tn0NjRF4SqIKATI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-eyHOT_dtMvG_jqnwRH_0tw-1; Mon, 09 Dec 2019 11:42:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC98580589B;
        Mon,  9 Dec 2019 16:41:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D9FC6E3F3;
        Mon,  9 Dec 2019 16:41:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/4] afs: Fix SELinux setting security label on /afs
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        dhowells@redhat.com
Date:   Mon, 09 Dec 2019 16:41:58 +0000
Message-ID: <157590971828.21604.4748701398112202168.stgit@warthog.procyon.org.uk>
In-Reply-To: <157590971161.21604.14727023636839480425.stgit@warthog.procyon.org.uk>
References: <157590971161.21604.14727023636839480425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eyHOT_dtMvG_jqnwRH_0tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make the AFS dynamic root superblock R/W so that SELinux can set the
security label on it.  Without this, upgrades to, say, the Fedora
filesystem-afs RPM fail if afs is mounted on it because the SELinux label
can't be (re-)applied.

It might be better to make it possible to bypass the R/O check for LSM
label application through setxattr.

Fixes: 4d673da14533 ("afs: Support the AFS dynamic root")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: selinux@vger.kernel.org
cc: linux-security-module@vger.kernel.org
---

 fs/afs/super.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index 488641b1a418..d9a6036b70b9 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -448,7 +448,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	/* allocate the root inode and dentry */
 	if (as->dyn_root) {
 		inode = afs_iget_pseudo_dir(sb, true);
-		sb->s_flags	|= SB_RDONLY;
 	} else {
 		sprintf(sb->s_id, "%llu", as->volume->vid);
 		afs_activate_volume(as->volume);

