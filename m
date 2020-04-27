Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B218C54FD0
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7489F20656
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 15:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvxiQhFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0PfR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:35:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbgD0PfQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588001715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h76vANqeUMrppq1MyM5+mG2iaU6uXMCAsMD+mc3myrQ=;
        b=AvxiQhFlSIBfrElssRu0arvy+cM/cTh1fkc7jHQWguoup/HUTi1JAjUXgPcm3yvZFqg7CQ
        hGHArl0jnGDbkKQoT+v4nrSjtyzU8nNNcIToA3bSQCAWWPEUA/QRkqLeJdb1khsd+cEEfq
        Xh27Y1yizuouttmKy8F0o1TcG+bwvns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-z2ShQf5BNJGkgV666zwB_Q-1; Mon, 27 Apr 2020 11:35:11 -0400
X-MC-Unique: z2ShQf5BNJGkgV666zwB_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ABAB835B41
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 15:35:10 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.193.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EE8160635;
        Mon, 27 Apr 2020 15:35:08 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] python/semanage: Use ipaddress module instead of IPy
Date:   Mon, 27 Apr 2020 17:34:39 +0200
Message-Id: <20200427153438.17061-1-plautrba@redhat.com>
In-Reply-To: <CAJfZ7=mv_e7zo2T8MBOmODW8NHc48cr3GB1Jvi8=Gg-qm7QPTQ@mail.gmail.com>
References: <CAJfZ7=mv_e7zo2T8MBOmODW8NHc48cr3GB1Jvi8=Gg-qm7QPTQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ipaddress python module was added to standard library in Python 3.3 -
https://docs.python.org/3/library/ipaddress.html

seobject.py was the only consumer of IPy module so this dependency is not=
 needed
anymore.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

Based on Nicolas input:

- improved the check comment
- dropped the unnecessary check

 python/semanage/seobject.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index f2a139c970bd..6e0b87f2fa3c 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -32,7 +32,7 @@ from semanage import *
 PROGNAME =3D "policycoreutils"
 import sepolicy
 import setools
-from IPy import IP
+import ipaddress
=20
 try:
     import gettext
@@ -1858,15 +1858,12 @@ class nodeRecords(semanageRecords):
         if addr =3D=3D "":
             raise ValueError(_("Node Address is required"))
=20
-        # verify valid combination
+        # verify that (addr, mask) is either a IP address (without a mas=
k) or a valid network mask
         if len(mask) =3D=3D 0 or mask[0] =3D=3D "/":
-            i =3D IP(addr + mask)
-            newaddr =3D i.strNormal(0)
-            newmask =3D str(i.netmask())
-            if newmask =3D=3D "0.0.0.0" and i.version() =3D=3D 6:
-                newmask =3D "::"
-
-            protocol =3D "ipv%d" % i.version()
+            i =3D ipaddress.ip_network(addr + mask)
+            newaddr =3D str(i.network_address)
+            newmask =3D str(i.netmask)
+            protocol =3D "ipv%d" % i.version
=20
         try:
             newprotocol =3D self.protocol.index(protocol)
--=20
2.26.2

