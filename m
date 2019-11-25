Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136BAC432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1B82082F
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjrtPJzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfKYP1y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:27:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727785AbfKYP1y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 10:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574695673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M8LFLtLSIpUU6Sl6LLV4NFHSd/Li85HQEYJayIafhJE=;
        b=LjrtPJzw/HqvjiV97UIqN5XesN9Obs8llRynSNRz0zCoSZgKyaJmTQ2QB1COyOWQqKm+up
        /JGgsfMReIT0lbxVD9yLAFjW0DATQJeHA6XYxGzha5zAPoMvrv5jfADELD8e3vVJVRKtXT
        YjfkYB19RJ9CfJ6wpFRHF7tCV0IcaKw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-4TmPOdXBPPiKP-SZAo7KYg-1; Mon, 25 Nov 2019 10:27:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id m17so8910247wrn.23
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2019 07:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rNasTY16emuqtonHktBGaXViPAagMsnTWQ2IBFKSmwA=;
        b=HpZM0/HtZjpCr9BCbpaBq8UaLetLxh7BhvjtlyHmHi9KOlc3vJaleKs+xN2pIN/3z/
         U60fyNwQlBfc1lhorMzd17kxESxv2QWxen0VHsgabJLDDgzWNJ+JuOfO0tmbj1IuL1W3
         bFPCn101xKk0QH/hNFRp456eUUw+iZcayeuj9mCCUKxS1oNViPl0k06r1QNZS3ajTH3p
         q+M8gRIo9w+rxgLwFs8x1SrRewv666vMOttwQJWe8p3Pf4oQevmeBLkg+z6S1TwBsy08
         Ui4xm346j0x6Ginb2gY3lLv6P0nTef9COedy/cSEo0AczCwravjaBjvuRawy++YGG5WF
         IJ+Q==
X-Gm-Message-State: APjAAAV7TBcaqZKkGSUkIlAueR+v5CaR0BMxKncNfESNZecz/0WRBVGR
        Yua0c2EXSrnDW71NRcKolmV6We1jwwslB+I7yVzRh+lqQi1iCdm4TZlt7wA/Jzodx63ERMxUe2D
        qCdI+I7nN71l8ssfDog==
X-Received: by 2002:adf:978c:: with SMTP id s12mr31302988wrb.47.1574695671056;
        Mon, 25 Nov 2019 07:27:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8QKxn+FoXHw1RRTgt01XI1N3uWYq8MvbeY32I92qFOv2nBuMA1N3woEIShHmrGbGEA9gR8w==
X-Received: by 2002:adf:978c:: with SMTP id s12mr31302974wrb.47.1574695670783;
        Mon, 25 Nov 2019 07:27:50 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x7sm10665526wrq.41.2019.11.25.07.27.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:27:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2] policy: check for module_request support for key_socket
Date:   Mon, 25 Nov 2019 16:28:00 +0100
Message-Id: <20191125152800.702007-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: 4TmPOdXBPPiKP-SZAo7KYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

E.g. RHEL-5 has key_socket class in the policy, but not the
system::module_request permission.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile | 2 ++
 tests/Makefile  | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

Change in v2: update also tests/Makefile for consistency

diff --git a/policy/Makefile b/policy/Makefile
index 57cc172..7c2d21e 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -94,8 +94,10 @@ TARGETS+=3Dtest_notify.te
 endif
=20
 ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt &=
& echo true),true)
+ifeq ($(shell grep -q module_request $(POLDEV)/include/support/all_perms.s=
pt && echo true),true)
 TARGETS +=3D test_key_socket.te
 endif
+endif
=20
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $=
(TARGETS))
diff --git a/tests/Makefile b/tests/Makefile
index cca6648..55fd16d 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -52,9 +52,13 @@ ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/su=
pport/all_perms.spt && e
 SUBDIRS +=3D keys
 endif
=20
-ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt &=
& test -e $(INCLUDEDIR)/keyutils.h && echo true),true)
+ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt &=
& echo true),true)
+ifeq ($(shell grep -q module_request $(POLDEV)/include/support/all_perms.s=
pt && echo true),true)
+ifeq ($(shell test -e $(INCLUDEDIR)/keyutils.h && echo true),true)
 SUBDIRS +=3D key_socket
 endif
+endif
+endif
=20
 ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=3D" infiniband_endpor=
t/ibendport_test.conf | cut -d'=3D' -f 2),1)
 SUBDIRS +=3D infiniband_endport
--=20
2.23.0

