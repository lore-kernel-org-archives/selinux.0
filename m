Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348AC43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 10:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566512073B
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcJAlo0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfLKK1y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:27:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45884 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbfLKK1y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 05:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576060073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hm6dEMqLmR2mPUC6qUoTwYnpBwWDphm54SqO3q6FRrk=;
        b=fcJAlo0L03te1DvC0IWZXtCjNmhof3Uumi73i/g6zd+QSjtGYpqlPdcaTIHJabzOUE2CN6
        JIrLtNHI1noG6LIB/BNTpc4xKajeFEPHmQfd3kqFqe9qeO8DhAwTCHYifyhe3Ywgmy7lrX
        b/BW4f9cV2jiyjLxaq7p0wrLb6PTBqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-9wzdE_EeNn6lgmdrJ1GzzQ-1; Wed, 11 Dec 2019 05:27:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25BBC107ACC5;
        Wed, 11 Dec 2019 10:27:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 537405D6AE;
        Wed, 11 Dec 2019 10:27:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/8] afs: Fix SELinux setting security label on /afs
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 11 Dec 2019 10:27:47 +0000
Message-ID: <157606006753.21869.7998834848686645767.stgit@warthog.procyon.org.uk>
In-Reply-To: <157606006065.21869.6615813521356169209.stgit@warthog.procyon.org.uk>
References: <157606006065.21869.6615813521356169209.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9wzdE_EeNn6lgmdrJ1GzzQ-1
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

