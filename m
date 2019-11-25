Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DDBC432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE9C20740
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXVeP2Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfKYPNS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:13:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728172AbfKYPNS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 10:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574694797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=st6IdoyfGUDKIXEGUYfGJweOXhkSupt3envE3d3Lf1Q=;
        b=OXVeP2WbFmHui0ozaMPhpd41rEAbSjglTQ/0GTqCf79yLlE6IoRfABPQorx6HXqCGyuQIY
        EDFKObJIn16MBPq8HTY888WFXoYD04K9/oTmzAcpFxgT3A3F7CkveLuCf3lvzGsnNhBEya
        mkw5rjwaTlsBVw8DZxScgH4CHqPoh6g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-ahf_LQDoOGGYNpuk-I7lyQ-1; Mon, 25 Nov 2019 10:13:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id a3so8987131wrn.13
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2019 07:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ljfNXlT3oCj630C7t2YKk0MotcO/vqhhRsDrhOrOUYA=;
        b=b9GIvqVWC2g/Sag0Mhl8zDDep8uyoUs6+9fRHVELO8NDp8r1Pud7nP2cpHf+2Mdc38
         6z+Dk+GnARwbHaOOLRnC8Lsr/H8rXiirQA6xn2lEri4Y7q82YpUctCBKv+cziQhvMfTw
         iJb8TbROy4ahroJIH1VsbJdrt/l2gOe1D2Nh8PdLZC34sJwvWpVxb3O0aafEWEgI+D68
         J9SJz1MqBLYEsDSpUcAyY28F5XlYU2P6tvV/dgS1nc/aiPhVnMQkuJqjlwEj5jjK738/
         INWfL0kXVylwzu+iLNhFIupPC7YpWQNr1B4Fjpraqh1cwOlgny27nDMM0+j0kQk4Rh+C
         wB2Q==
X-Gm-Message-State: APjAAAVggwRSOKDYYgLPSbjY1FLoiVAkhswfZ1hGA8wwujLKi1CdqIBf
        7b1kJbvmhVdtlFHnGmSlIPcifDDMbP5ZtqE9xwAOmsf3fjSH6HVU7L8yxyW1McCGy/EJuJnFlXq
        vybExwHpPnZBDUCutQg==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr10212219wrm.264.1574694794445;
        Mon, 25 Nov 2019 07:13:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBwFQxXkg8VUQ+zoLSx+dh2RMwdLTHzwmlzAfET1NEyNqcwrJSouhWqq2BgERikGVPxISw9A==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr10212197wrm.264.1574694794141;
        Mon, 25 Nov 2019 07:13:14 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a6sm118637wmb.1.2019.11.25.07.13.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 07:13:13 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: check for module_request support for key_socket
Date:   Mon, 25 Nov 2019 16:13:23 +0100
Message-Id: <20191125151323.701716-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: ahf_LQDoOGGYNpuk-I7lyQ-1
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
 1 file changed, 2 insertions(+)

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
--=20
2.23.0

