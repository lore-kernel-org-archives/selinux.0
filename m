Return-Path: <SRS0=61sA=XS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9DFC3A5A6
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC2D2087C
	for <selinux@archiver.kernel.org>; Mon, 23 Sep 2019 09:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvHrNPm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407458AbfIWJ6q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:58:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49370 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405009AbfIWJ6q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Sep 2019 05:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569232725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O45lB1kENRrYJWIp22bilZyB12ry832mqJdndeqiOq4=;
        b=IvHrNPm2RErcIlp/NhfHnw4r3GRTYEcI9UT2W93rlvWXwXEcYsSW7wQUluUekTSu+dSOeR
        T78RGPgeyUCovEGljF6K0+NW/1Ay9jlXAdHhRxqvxJEL8xdpQtMYBwCseKYN8wAg96jx4K
        6128Mbz4BnpXIHsHeMSVq4ZY3aTj16w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-UmhwW-tLP7mF8ihnJwGY7Q-1; Mon, 23 Sep 2019 05:58:42 -0400
Received: by mail-wr1-f69.google.com with SMTP id z17so4647100wru.13
        for <selinux@vger.kernel.org>; Mon, 23 Sep 2019 02:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDm32ZpxEVeYnvi9g3Vt9ykCfvT83Ek21C8JhualbbE=;
        b=uaqTfZswZcP4pAm+NCh5FryMz1wBn9/bT5gNdkunnGZJoPsrEYYQJ8i1FfRb4azICQ
         vpfhU6Tf9i3OPvrbY8uW120lmCFdztQVNde0wXwnw3PWRgafnwtyiSU5Q3yDlpb4Pl++
         kWUW6BZbjESnCruuuZ4zvhuvciKoTqrdX3IIDUdHY+f2z+thyKq83FwifrCGohWJyzA8
         prJ8poTJz2+TkhhIUesWee6tvhzf7u6Pihbd7zGU0tAhZvvoHRTupeL4cVTD5EUdRCBj
         0HnBlPkLz9x2nZBFymDBqGUxH/JbADbysRc/GBTpPyOdX6oTL14T5O0uqN86g2hCDKdx
         fOyg==
X-Gm-Message-State: APjAAAVwL2r6ayMe9oHC1NJFwogaEzhp+YfYOY29neOARDDXN+C4LDI7
        SNpLftoLvzy4WbpYbeCdH+nCyAQvnBcXreMI3obPCMMi5MCj+KRUfFkThVPicyvOLBszQOYcK61
        iG5bMlYighcApVha6vg==
X-Received: by 2002:a5d:5231:: with SMTP id i17mr8251747wra.142.1569232720608;
        Mon, 23 Sep 2019 02:58:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKryXpwvRcDDhu7mYlMgEkX7hB7L4gSfBD5hTleNiPLW/FF+P+xHy51sIeOFFp/Qyj4ljZlw==
X-Received: by 2002:a5d:5231:: with SMTP id i17mr8251730wra.142.1569232720374;
        Mon, 23 Sep 2019 02:58:40 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a6sm10586374wrr.85.2019.09.23.02.58.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 02:58:39 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: do not rebuild policy package if already built
Date:   Mon, 23 Sep 2019 11:58:37 +0200
Message-Id: <20190923095837.25752-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: UmhwW-tLP7mF8ihnJwGY7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Right now, test_policy.pp is rebuilt on every make invocation. Tweak the
Makefile so that it is only build when it hasn't been built, it has been
cleaned, or the source files changed.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index a5942b3..cc0f140 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -86,7 +86,7 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6=
))
 TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $=
(TARGETS))
 endif
=20
-all: build
+all: test_policy/test_policy.pp
=20
 expand_check:
 =09# Test for "expand-check =3D 0" in /etc/selinux/semanage.conf
@@ -94,7 +94,7 @@ expand_check:
 =09=09(echo "ERROR: set 'expand-check =3D 0' in /etc/selinux/semanage.conf=
"; \
 =09=09 /bin/false)
=20
-build: $(TARGETS)
+test_policy/test_policy.pp: $(TARGETS) test_policy.if
 =09# General policy build
 =09@if [ -d $(POLDEV) ]; then \
 =09=09mkdir -p test_policy; \
--=20
2.21.0

