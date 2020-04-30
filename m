Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49438C8300A
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 11:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1869120757
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 11:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8/5J+vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD3LIw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:08:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52209 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3LIw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 07:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588244931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pKKkDEnws8iIIaTniLMP1CDG9TPu6nO/nJ42zNpRoV4=;
        b=O8/5J+vch3ntFbDs9jSeqyIj8bA8Kv04tQRdGFJlHBtfX6msnFZ2LWVlRxwzSr25hLjh70
        tNm3zvSEEo2fkfBaosn++AV/Iecws9UEFUQR7y82RX+iZLcaXV8szDZZTXeKoU+fjEbbqc
        2aI5Xu+Xm7dmEG1sIwj1lXV5q5sSSok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-aTQ-2PByOjKZdUftbu0foQ-1; Thu, 30 Apr 2020 07:08:49 -0400
X-MC-Unique: aTQ-2PByOjKZdUftbu0foQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9C30835B40
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 11:08:48 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.195.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99161001920;
        Thu, 30 Apr 2020 11:08:47 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/2] restorecond: Rename restorecond-user.service to restorecond_user.service
Date:   Thu, 30 Apr 2020 13:08:34 +0200
Message-Id: <20200430110835.138643-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make user restorecond systemd service consistent with restorecond_user.co=
nf file
used by `restorecond -u`

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 restorecond/Makefile                                            | 2 +-
 restorecond/org.selinux.Restorecond.service                     | 2 +-
 .../{restorecond-user.service =3D> restorecond_user.service}      | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename restorecond/{restorecond-user.service =3D> restorecond_user.servi=
ce} (100%)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 501f89dfca57..4de9642b0f6a 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -51,7 +51,7 @@ install: all
 	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/system
 	install -m 644 restorecond.service $(DESTDIR)$(SYSTEMDDIR)/system/
 	-mkdir -p $(DESTDIR)$(SYSTEMDDIR)/user
-	install -m 644 restorecond-user.service $(DESTDIR)$(SYSTEMDDIR)/user/
+	install -m 644 restorecond_user.service $(DESTDIR)$(SYSTEMDDIR)/user/
 relabel: install
 	/sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond=20
=20
diff --git a/restorecond/org.selinux.Restorecond.service b/restorecond/or=
g.selinux.Restorecond.service
index 55989a9cbbd0..45aeb7aac806 100644
--- a/restorecond/org.selinux.Restorecond.service
+++ b/restorecond/org.selinux.Restorecond.service
@@ -1,4 +1,4 @@
 [D-BUS Service]
 Name=3Dorg.selinux.Restorecond
 Exec=3D/usr/sbin/restorecond -u
-SystemdService=3Drestorecond-user.service
+SystemdService=3Drestorecond_user.service
diff --git a/restorecond/restorecond-user.service b/restorecond/restoreco=
nd_user.service
similarity index 100%
rename from restorecond/restorecond-user.service
rename to restorecond/restorecond_user.service
--=20
2.26.2

