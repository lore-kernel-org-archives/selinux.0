Return-Path: <SRS0=CFpO=6I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87453C54FD0
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548F320706
	for <selinux@archiver.kernel.org>; Fri, 24 Apr 2020 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyczyRR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgDXPAC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:00:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48630 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbgDXPAB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Apr 2020 11:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587740400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QsvBuJwLQJPmIsoNh+Io/aBqZwx7NQPXeB6r8rMwETI=;
        b=iyczyRR5WkiTcUfMuZo68WBo/c7p04qFkpAWQ0203bX0Upzw644HGOtTczq4tB5Khhct74
        q5vQFHGaaZ7nz9aFciMe+UwmVMUQimZIm0sycAk7Gx21Wjr+iIUqE8IfjFem8xeQU2oxiS
        bhoSVTa7Nr4R8TKtwkJi3xloCd0ZA8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-lN4WRPNXNxulv6vRgYI4JQ-1; Fri, 24 Apr 2020 10:59:48 -0400
X-MC-Unique: lN4WRPNXNxulv6vRgYI4JQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0768018A4
        for <selinux@vger.kernel.org>; Fri, 24 Apr 2020 14:59:47 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.40.195.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6570A600E8;
        Fri, 24 Apr 2020 14:59:46 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/semanage: Use ipaddress module instead of IPy
Date:   Fri, 24 Apr 2020 16:59:41 +0200
Message-Id: <20200424145941.242949-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 python/semanage/seobject.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index f2a139c970bd..c89c67e491b6 100644
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
@@ -1860,13 +1860,13 @@ class nodeRecords(semanageRecords):
=20
         # verify valid combination
         if len(mask) =3D=3D 0 or mask[0] =3D=3D "/":
-            i =3D IP(addr + mask)
-            newaddr =3D i.strNormal(0)
-            newmask =3D str(i.netmask())
-            if newmask =3D=3D "0.0.0.0" and i.version() =3D=3D 6:
+            i =3D ipaddress.ip_network(addr + mask)
+            newaddr =3D str(i.network_address)
+            newmask =3D str(i.netmask)
+            if newmask =3D=3D "0.0.0.0" and i.version =3D=3D 6:
                 newmask =3D "::"
=20
-            protocol =3D "ipv%d" % i.version()
+            protocol =3D "ipv%d" % i.version
=20
         try:
             newprotocol =3D self.protocol.index(protocol)
--=20
2.26.0

