Return-Path: <SRS0=VC3m=Y6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C428C5DF62
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 10:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57E62173E
	for <selinux@archiver.kernel.org>; Wed,  6 Nov 2019 10:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnpCYw4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKFK7U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:59:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24897 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfKFK7U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Nov 2019 05:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573037959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qKMHPiKMUKdHSFlHwTfjJQ1Vq+rHhX1LbBoditmi/zA=;
        b=DnpCYw4dyaP2+nFSzgTCeR+Flqku9jFNk5TMaUBBFjOadVMDhvgGwQRG5kYgUYb7QHmDnW
        tw/15/iZ1a5aNA+9FdFbZCSrBCXsV+IMsA+Xg6pkntSp+PNO3x2AzNmODPqBvQ3cri/ugS
        7aL2CgCOOG5rvOcpiW8Wis9XE3xuYSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-t8iwsRUAMg2YU_8g44dmWg-1; Wed, 06 Nov 2019 05:59:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB0B61800D53
        for <selinux@vger.kernel.org>; Wed,  6 Nov 2019 10:59:14 +0000 (UTC)
Received: from workstation.brq.redhat.com (unknown [10.34.245.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1913A60852;
        Wed,  6 Nov 2019 10:59:13 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] python/sepolicy: Revert "Only invoke RPM on RPM-enabled Linux distributions"
Date:   Wed,  6 Nov 2019 11:59:07 +0100
Message-Id: <20191106105907.1064568-1-plautrba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: t8iwsRUAMg2YU_8g44dmWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 8ad76337d09d4b0080275d74392a258ea4ed0273 ("Only invoke RPM on RPM-en=
abled
Linux distributions") used platform.linux_distribution() function to detect
whether the system is rpm based. This function is deprecated since Python 3=
.5
and it's removed from Python 3.8 - https://bugs.python.org/issue28167

The original problem is already fixed by another commit
671f83b42ba2 ("policycoreutils/sepolicy: Check get_rpm_nvr_list() return
value"):

    $ sepolicy generate --customize -p mypolicy -n testpolicy -d httpd_sys_=
script_t -w /home
    Failed to retrieve rpm info for selinux-policy
    Created the following files:
    mypolicy/testpolicy.te # Type Enforcement file
    mypolicy/testpolicy.if # Interface file
    mypolicy/testpolicy.fc # File Contexts file
    mypolicy/testpolicy_selinux.spec # Spec file
    mypolicy/testpolicy.sh # Setup Script

Fixes:
     File "/usr/lib/python3.8/site-packages/sepolicy/generate.py", line 138=
4, in generate
       if (platform.linux_distribution(full_distribution_name=3D0)[0] in ("=
redhat", "centos", "SuSE", "fedora", "mandrake", "mandriva")):
     AttributeError: module 'platform' has no attribute 'linux_distribution=
'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/generate.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolic=
y/generate.py
index 973edb9d..e8d07e7d 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -26,7 +26,6 @@ import re
 import sepolicy
 from sepolicy import get_all_types, get_all_attributes, get_all_roles
 import time
-import platform
=20
 from .templates import executable
 from .templates import boolean
@@ -1178,8 +1177,7 @@ allow %s_t %s_t:%s_socket name_%s;
                 newsh +=3D re.sub("TEMPLATETYPE", self.name, t1)
=20
         newsh +=3D self.generate_user_sh()
-        if (platform.linux_distribution(full_distribution_name=3D0)[0] in =
("redhat", "centos", "SuSE", "fedora", "mandrake", "mandriva")):
-            newsh +=3D re.sub("TEMPLATEFILE", self.file_name, script.rpm)
+        newsh +=3D re.sub("TEMPLATEFILE", self.file_name, script.rpm)
=20
         return newsh
=20
@@ -1379,7 +1377,6 @@ Warning %s does not exist
         out +=3D "%s # %s\n" % (self.write_if(out_dir), _("Interface file"=
))
         out +=3D "%s # %s\n" % (self.write_fc(out_dir), _("File Contexts f=
ile"))
         if self.type !=3D NEWTYPE:
-            if (platform.linux_distribution(full_distribution_name=3D0)[0]=
 in ("redhat", "centos", "SuSE", "fedora", "mandrake", "mandriva")):
-                out +=3D "%s # %s\n" % (self.write_spec(out_dir), _("Spec =
file"))
+            out +=3D "%s # %s\n" % (self.write_spec(out_dir), _("Spec file=
"))
             out +=3D "%s # %s\n" % (self.write_sh(out_dir), _("Setup Scrip=
t"))
         return out
--=20
2.23.0

