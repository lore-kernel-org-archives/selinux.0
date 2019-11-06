Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216BC5DF63
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA1E2067B
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 16:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl4LmDk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfKFQa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:30:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35371 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732169AbfKFQa4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 11:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573057854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UJt3KrLqpH06r+SdjXHSb5mJDhZRvO9vkNXES+xlPVw=;
        b=Fl4LmDk+sOSRf3OKnwv3WVoHBibEk5C0qgin+kGVerputGlLrSBE57OVzfEYfF/i4kCuGw
        8l51bdWM5UuEMqijvkrDYtquIF9Agx8qQu4154Q/F0yDlSJ61cKkeL9acxe4IZJx/URcYk
        +B/yyhFfVnjfdk7JAA4W3yq9LieHOy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Z88HhmrsOy6zyqKd-r9sLQ-1; Wed, 06 Nov 2019 11:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42CA91005500
        for <selinux@vger.kernel.org>; Wed,  6 Nov 2019 16:30:52 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.34.245.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62E5A60CD3;
        Wed,  6 Nov 2019 16:30:51 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Replace www.nsa.gov references by github.com/SELinuxProject
Date:   Wed,  6 Nov 2019 17:30:43 +0100
Message-Id: <20191106163043.1081424-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Z88HhmrsOy6zyqKd-r9sLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The original page doesn't exist anymore.

Fixes: https://github.com/SELinuxProject/selinux/issues/170

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 checkpolicy/checkmodule.8        | 3 +--
 checkpolicy/checkpolicy.8        | 3 +--
 checkpolicy/ru/checkmodule.8     | 3 +--
 checkpolicy/ru/checkpolicy.8     | 4 +---
 libselinux/man/man8/selinux.8    | 2 +-
 libselinux/man/ru/man8/selinux.8 | 2 +-
 python/sepolgen/HACKING          | 2 --
 7 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index e55582f3..e597d9d4 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -59,8 +59,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
=20
 .SH "SEE ALSO"
 .B semodule(8), semodule_package(8)
-SELinux documentation at http://www.nsa.gov/research/selinux,
-especially "Configuring the SELinux Policy".
+SELinux Reference Policy documentation at https://github.com/SELinuxProjec=
t/refpolicy/wiki
=20
=20
 .SH AUTHOR
diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index bdfd6acd..97e10ca7 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -60,8 +60,7 @@ Show version information.
 Show usage information.
=20
 .SH "SEE ALSO"
-SELinux documentation at http://www.nsa.gov/research/selinux,
-especially "Configuring the SELinux Policy".
+SELinux Reference Policy documentation at https://github.com/SELinuxProjec=
t/refpolicy/wiki
=20
=20
 .SH AUTHOR
diff --git a/checkpolicy/ru/checkmodule.8 b/checkpolicy/ru/checkmodule.8
index 93e68e70..a1d687e3 100644
--- a/checkpolicy/ru/checkmodule.8
+++ b/checkpolicy/ru/checkmodule.8
@@ -46,8 +46,7 @@ $ checkmodule \-M \-m httpd.te \-o httpd.mod
=20
 .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95"
 .B semodule(8), semodule_package(8)
-=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=8F S=
ELinux =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 http://www.nsa.gov=
/research/selinux,
-=D0=B2 =D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=BE=D1=81=D1=82=D0=B8 - "=D0=9D=D0=
=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=
=82=D0=B8=D0=BA=D0=B8 SELinux".
+=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=8F S=
ELinux Reference Policy =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 h=
ttps://github.com/SELinuxProject/refpolicy/wiki
=20
=20
 .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
diff --git a/checkpolicy/ru/checkpolicy.8 b/checkpolicy/ru/checkpolicy.8
index 2ad39b8e..25b0e555 100644
--- a/checkpolicy/ru/checkpolicy.8
+++ b/checkpolicy/ru/checkpolicy.8
@@ -51,9 +51,7 @@ checkpolicy \- =D0=BA=D0=BE=D0=BC=D0=BF=D0=B8=D0=BB=D1=8F=
=D1=82=D0=BE=D1=80 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
 =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=81=D0=B2=D0=B5=D0=B4=
=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D0=B1 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B8.
=20
 .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95"
-=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=8F S=
ELinux =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 http://www.nsa.gov=
/research/selinux,
-=D0=B2 =D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=BE=D1=81=D1=82=D0=B8 - "=D0=9D=D0=
=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=
=82=D0=B8=D0=BA=D0=B8 SELinux".
-
+=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=B8=D1=8F S=
ELinux Reference Policy =D0=BF=D0=BE =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 h=
ttps://github.com/SELinuxProject/refpolicy/wiki
=20
 .SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
 =D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D1=80=
=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=D1=8B=
=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Arpad Magosan=
yi <mag@bunuel.tii.matav.hu>,
diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index e37aee68..31364271 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -10,7 +10,7 @@ enforcement of many kinds of mandatory access control pol=
icies,
 including those based on the concepts of Type Enforcement=C2=AE, Role-
 Based Access Control, and Multi-Level Security.  Background
 information and technical documentation about SELinux can be found at
-http://www.nsa.gov/research/selinux.
+https://github.com/SELinuxProject.
=20
 The
 .I /etc/selinux/config
diff --git a/libselinux/man/ru/man8/selinux.8 b/libselinux/man/ru/man8/seli=
nux.8
index 5cc48df8..271809de 100644
--- a/libselinux/man/ru/man8/selinux.8
+++ b/libselinux/man/ru/man8/selinux.8
@@ -9,7 +9,7 @@ Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=
=81=D1=82=D1=8C=D1=8E =D0=BE=D1=82 NSA - =D1=8D=D1=82=D0=BE =D1=80=D0=B5
 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B0=D1=8F =D0=BE=D1=81=D0=BD=D0=BE=D0=B2=
=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=86=D0=B5=
=D0=BF=D1=86=D0=B8=D1=8F=D1=85 Type Enforcement=C2=AE (=D0=BF=D1=80=D0=B8=
=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=BF=
=D1=80=D0=B8=D1=81=D0=B2=D0=BE=D0=B5=D0=BD=D0=B8=D0=B5 =D1=82=D0=B8=D0=BF=
=D0=BE=D0=B2),
 Role-Based Access Control (=D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=B8=D0=B5 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BE=D0=BC =D0=BD=D0=
=B0 =D0=BE=D1=81=D0=BD=D0=BE=D0=B2=D0=B5 =D1=80=D0=BE=D0=BB=D0=B5=D0=B9) =
=D0=B8 Multi-Level Security
 (=D0=BC=D0=BD=D0=BE=D0=B3=D0=BE=D1=83=D1=80=D0=BE=D0=B2=D0=BD=D0=B5=D0=B2=
=D0=B0=D1=8F =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=
=D1=82=D1=8C). =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=
=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=
=D0=B8=D1=8F =D0=B8 =D1=82=D0=B5=D1=85=D0=BD=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=B0=D1=8F =D0=B4=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=
=D0=B8=D1=8F =D0=BF=D0=BE
-SELinux =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D0=B0 =D0=BF=D0=BE =D0=
=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 http://www.nsa.gov/research/selinux.
+SELinux =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D0=B0 =D0=BF=D0=BE =D0=
=B0=D0=B4=D1=80=D0=B5=D1=81=D1=83 https://github.com/SELinuxProject.
=20
 =D0=A4=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=
=D0=B0=D1=86=D0=B8=D0=B8
 .I /etc/selinux/config
diff --git a/python/sepolgen/HACKING b/python/sepolgen/HACKING
index e624a1b4..f7d07774 100644
--- a/python/sepolgen/HACKING
+++ b/python/sepolgen/HACKING
@@ -75,5 +75,3 @@ Information about the SELinux object classes. This is sem=
antic
 information about the object classes - including information flow. It
 is separated to keep the core from being concerned about the details
 of the object classes.
-
-[selist]: http://www.nsa.gov/research/selinux/info/list.cfm
--=20
2.23.0

