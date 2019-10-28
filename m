Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA07CA9EC1
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 12:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D9021734
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 12:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d64zmDN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfJ1MoO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:44:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727308AbfJ1MoN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 08:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572266652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UoJnlVL6iUFYAedpqgcBRuvzbcqQJ5OMnOvE+mu68sc=;
        b=d64zmDN+KVbYO4UqMO8wP099WlEXVq0TnvVdXHlQsljio+ZTk7iz0JkhS2uajtfBbJ3x6L
        4R2WLwn6W68QXdp+CJhQNqHJHf7zI5fY0bnnaH6wSLuW/6xNCsX9vzig6pPuAXdNIqmZuQ
        tsDaKzlMW5IPlMwJJAH7lSwEevEyYJ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-UAhg-iBUPwqcA4PEh8pO3A-1; Mon, 28 Oct 2019 08:44:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC91D867455
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2019 12:44:09 +0000 (UTC)
Received: from slave.localdomain.com (unknown [10.64.193.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C26553D3;
        Mon, 28 Oct 2019 12:44:08 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 1/2] docs: sysctl: update description for inode-state
Date:   Mon, 28 Oct 2019 21:43:52 +0900
Message-Id: <20191028124353.25276-1-yamato@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-MC-Unique: UAhg-iBUPwqcA4PEh8pO3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The third field of inode-state is dummy (=3D=3D 0).
Update the description about the actual fields and
dummies.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-=
guide/sysctl/fs.rst
index 2a45119e3331..596f84a1748d 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -151,18 +151,15 @@ out of inodes, you need to increase this value.
 The file inode-nr contains the first two items from
 inode-state, so we'll skip to that file...
=20
-Inode-state contains three actual numbers and four dummies.
-The actual numbers are, in order of appearance, nr_inodes,
-nr_free_inodes and preshrink.
+Inode-state contains two actual numbers and five dummies.
+The actual numbers are, in order of appearance, nr_inodes
+and nr_free_inodes.
=20
 Nr_inodes stands for the number of inodes the system has
 allocated, this can be slightly more than inode-max because
 Linux allocates them one pageful at a time.
=20
-Nr_free_inodes represents the number of free inodes (?) and
-preshrink is nonzero when the nr_inodes > inode-max and the
-system needs to prune the inode list instead of allocating
-more.
+Nr_free_inodes represents the number of free inodes.
=20
=20
 overflowgid & overflowuid
--=20
2.17.2

