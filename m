Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9591C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 13:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A363B2073F
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhQ6ak2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0Nqh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:46:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbfK0Nqh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 08:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574862396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GTLjiXLIruyFO2VshcQdpPwnvoZ/4VyGIWbWmpxmVjA=;
        b=fhQ6ak2lrEGghAZ1xTAgU5CYNhJOOJ1IdZI6TmUT21stcJQ0TEw7PrEhJrGHVx1m/sgk8w
        VOKq2WpG9iezUGFMpp2LgieRbE7nKYwXGkd070TCrPm04knqqm0DC1VhsfA3dpDHlC413I
        4FFOOzPNSFFF5+YoJ7deqXJGr2X55tw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-sE5IT2b7MaabixAceGM0Yg-1; Wed, 27 Nov 2019 08:46:34 -0500
Received: by mail-wr1-f72.google.com with SMTP id h7so12245674wrb.2
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 05:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihhHNpgBE7UzQ0HUKqHHN/a81NciiY3dmRjLnePfUtI=;
        b=e6XNBXK6VipUhdj0fPd5E17ir0WTdVBsNqmfOlkVPoBr4GKQZ7Om7hwVihnsAPoKpz
         quZqJu/D4lMZe3s82f47vkZLdyek6LO3yLJ8GolWdMJhxQZz8zap24JKyiTXJ7UT6VQS
         y3GhaqYtuieDS9RiObAm6ju2Umk5HRTnEsb30bKvwZzLQ+j2cVO7ElifsJYSIp+e5F4E
         bO3m6hNTcIuXdYWK5HIRllVpp7/vEhNDHkLB1WdfJhEJHy0vIfDxE6gqLqQ+ivAmfdKV
         l7E426vAKQNYTe0Lqq23tgaKIC40MpWVoqTeMtuQ6U7Z70hREGPJ3gLdak/xABFY1B/Y
         KnoQ==
X-Gm-Message-State: APjAAAXPjIJe3ZslO1OX81oQMfVmPiqLu9XH/hUE4eKEasYff6t5Ikyj
        u4r7+qBRgtr1FmfZHX9AHvAnavEf4ud0ULnJgdzQJwlSt8u/rRpc6lVEUDdHdm5ZK7A+LNz1W1g
        EPKdX14aVZf+8AEyTbg==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr45285984wrr.287.1574862393080;
        Wed, 27 Nov 2019 05:46:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxh4Ji2vrjwUDCKDPitm4F0uNPFKqh/TY4z3+vFake+g6jkCjSmZOme5XDdMFr2Uqf9kLE3eQ==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr45285963wrr.287.1574862392756;
        Wed, 27 Nov 2019 05:46:32 -0800 (PST)
Received: from localhost.localdomain.com ([2a02:8308:b13e:ee00:435d:e8f:90ca:755e])
        by smtp.gmail.com with ESMTPSA id c15sm19479151wrx.78.2019.11.27.05.46.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:46:31 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] travis: improve selinuxfs mocking
Date:   Wed, 27 Nov 2019 14:46:43 +0100
Message-Id: <20191127134643.822677-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: sE5IT2b7MaabixAceGM0Yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Modify all Makefiles to allow overriding the path to the selinuxfs
mountpoint via the SELINUXFS variable and use it in the Travis script to
allow more stuff to be built (namely the extended_socket_class subdir).

This patch also drops the auto-detection of selinuxfs mount from
policy/Makefile in favor of overriding it via the variable if it differs
from the usual /sys/fs/selinux/.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 .travis.yml     | 8 ++++----
 policy/Makefile | 2 +-
 tests/Makefile  | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d1e5056..2c8e416 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,15 +51,15 @@ before_install:
   - bash travis-ci/setup-policy-fedora.sh
   - bash travis-ci/setup-policy-refpolicy.sh
   # establish a fake "selinuxfs" mount (policy/Makefile just greps for sel=
inuxfs)
-  - sudo mkdir -p /tmp/fake-selinuxfs
-  - sudo mount -t tmpfs tmpfs /tmp/fake-selinuxfs
+  - mkdir -p /tmp/fake-selinuxfs/policy_capabilities
+  - echo 1 > /tmp/fake-selinuxfs/policy_capabilities/extended_socket_class
   - echo 999 >/tmp/fake-selinuxfs/policyvers
=20
 script:
   - tools/check-syntax -f && git diff --exit-code
   - |
     bash travis-ci/enable-policy.sh targeted &&
-    make PREFIX=3D/usr/local POLDEV=3D/usr/share/selinux/targeted
+    make SELINUXFS=3D/tmp/fake-selinuxfs PREFIX=3D/usr/local POLDEV=3D/usr=
/share/selinux/targeted
   - |
     bash travis-ci/enable-policy.sh refpolicy &&
-    make PREFIX=3D/usr/local POLDEV=3D/usr/share/selinux/refpolicy
+    make SELINUXFS=3D/tmp/fake-selinuxfs PREFIX=3D/usr/local POLDEV=3D/usr=
/share/selinux/refpolicy
diff --git a/policy/Makefile b/policy/Makefile
index 87b2856..dda2e16 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -3,6 +3,7 @@ PREFIX ?=3D /usr
 BINDIR ?=3D $(PREFIX)/bin
 SBINDIR ?=3D $(PREFIX)/sbin
 POLDEV ?=3D $(PREFIX)/share/selinux/devel
+SELINUXFS ?=3D /sys/fs/selinux
 SEMODULE =3D $(SBINDIR)/semodule
 CHECKPOLICY =3D $(BINDIR)/checkpolicy
 CHECKMODULE =3D $(BINDIR)/checkmodule
@@ -11,7 +12,6 @@ DISTRO=3D$(shell ../tests/os_detect)
=20
 POL_VERS :=3D $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
 MOD_POL_VERS :=3D $(shell $(CHECKMODULE) -V |cut -f 2 -d '-')
-SELINUXFS :=3D $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' '=
)
 MAX_KERNEL_POLICY :=3D $(shell cat $(SELINUXFS)/policyvers)
=20
 TARGETS =3D \
diff --git a/tests/Makefile b/tests/Makefile
index 1cdb1ac..0d33fbf 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,5 +1,6 @@
 INCLUDEDIR ?=3D /usr/include
 POLDEV ?=3D /usr/share/selinux/devel
+SELINUXFS ?=3D /sys/fs/selinux
=20
 export CFLAGS+=3D-g -O0 -Wall -D_GNU_SOURCE
=20
@@ -19,11 +20,11 @@ SUBDIRS +=3D cap_userns
 endif
 endif
=20
-ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt =
&& grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && e=
cho true),true)
+ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt =
&& grep -q 1 $(SELINUXFS)/policy_capabilities/extended_socket_class && echo=
 true),true)
 SUBDIRS +=3D extended_socket_class
 endif
=20
-ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel=
/corenetwork.if && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_s=
ocket_class && echo true),true)
+ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel=
/corenetwork.if && grep -q 1 $(SELINUXFS)/policy_capabilities/extended_sock=
et_class && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.20.17),-1)
 SUBDIRS +=3D sctp
 endif
--=20
2.23.0

