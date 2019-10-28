Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE4BCA9EC2
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B320578
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 12:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTkgontG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbfJ1MoX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:44:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25474 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727308AbfJ1MoW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 08:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572266661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R0Q7AIh4fXeUIo8N1ZgebBUMzEXLld5IiUHisAWSmb0=;
        b=QTkgontGuUJy6ii8XFc5tfD7nauQZfXlG6R4ijNdljQlCOsV36LkRrkcc0/5eBleth4sqr
        09RxXcO24UUSMAeN4kFYan8clMk7lw/2V4s9sicvnCeleRaX0gXuyvPp+OJPAQU4BhMueY
        Fj5Pwz4rw16dTQOdlZ9KQjcM766iN9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-vFvHoGRZNEGEI2bQnpHsuQ-1; Mon, 28 Oct 2019 08:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97CE9185A79B
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2019 12:44:19 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA04F53D3;
        Mon, 28 Oct 2019 12:44:18 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 2/2] docs: sysctl: delete the description about inode-max
Date:   Mon, 28 Oct 2019 21:43:53 +0900
Message-Id: <20191028124353.25276-2-yamato@redhat.com>
In-Reply-To: <20191028124353.25276-1-yamato@redhat.com>
References: <20191028124353.25276-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-MC-Unique: vFvHoGRZNEGEI2bQnpHsuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code for inode-max was deleted long time ago
(< Linux-2.6.12-rc2).

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-=
guide/sysctl/fs.rst
index 596f84a1748d..5a99e37b5000 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -33,7 +33,6 @@ Currently, these files are in /proc/sys/fs:
 - dquot-nr
 - file-max
 - file-nr
-- inode-max
 - inode-nr
 - inode-state
 - nr_open
@@ -136,18 +135,12 @@ enough for most machines. Actual limit depends on RLI=
MIT_NOFILE
 resource limit.
=20
=20
-inode-max, inode-nr & inode-state
+inode-nr & inode-state
 ---------------------------------
=20
 As with file handles, the kernel allocates the inode structures
 dynamically, but can't free them yet.
=20
-The value in inode-max denotes the maximum number of inode
-handlers. This value should be 3-4 times larger than the value
-in file-max, since stdin, stdout and network sockets also
-need an inode struct to handle them. When you regularly run
-out of inodes, you need to increase this value.
-
 The file inode-nr contains the first two items from
 inode-state, so we'll skip to that file...
=20
@@ -156,8 +149,7 @@ The actual numbers are, in order of appearance, nr_inod=
es
 and nr_free_inodes.
=20
 Nr_inodes stands for the number of inodes the system has
-allocated, this can be slightly more than inode-max because
-Linux allocates them one pageful at a time.
+allocated.
=20
 Nr_free_inodes represents the number of free inodes.
=20
--=20
2.17.2

