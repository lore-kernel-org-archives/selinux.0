Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EAC43603
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F432077B
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUbAHFe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfLMJRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:17:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbfLMJRs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 04:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576228667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CPi9mX9SGz/5SurmYHvw6CcLMJuG0bawaIAmBxFUwaQ=;
        b=SUbAHFe4MqOOf8yIygoNwO94YX4tGV0DCPM7rcIkKsJhbVBLqjTVCud+5+P/qotwAZ0rqs
        6nRpzETDHeJvCx49UgQD46vIyVuvfxzuv+dPRwAfEPpbT6/JVSKA1sYyqBH/ZIwqJ9n/P0
        7uJS+y+YCC/Tt1+sP+4DT7/BOIQhmPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-6TH2duYZPqS4ETs3N1wB9w-1; Fri, 13 Dec 2019 04:17:46 -0500
X-MC-Unique: 6TH2duYZPqS4ETs3N1wB9w-1
Received: by mail-wm1-f70.google.com with SMTP id p5so1614632wmc.4
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2019 01:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPi9mX9SGz/5SurmYHvw6CcLMJuG0bawaIAmBxFUwaQ=;
        b=WZvLxsjRDUC8ICqzjxfxAOEXjx069kG9kMnRSD2mMLQQwDyUFTO5Gjy2ABi2y+7nIX
         WgWhY3gh0J1anBUDNqEXfCesEDAF/eRN0z9GdSOT/2ky63DAfGIg/o/IHsXczo8hxQxy
         B2/wZyro1SQZXsx4wSUarlpDUBDb0QL5Ry2yu0MX/SWNFdScX8pE6OxMjnvSrpQsBdaE
         YDTiv1eErUOePO/+wDNHwK4Ux9Gwc/WeR7OgnfI+BtxaCpXVnFjS/ofQAmyNErZlqzmd
         NGOcSTSlb55vbQDSmDa3ooND23HgVV+C+vJV/a4u9GZBUYfQLyuDcFMU0HXLCcnq8ME6
         Pk2g==
X-Gm-Message-State: APjAAAWaC4pVzJFifLN6Vcb+19HFGvUZb+TXSrK6nSmpP0k+OHOxGnVZ
        mWfLis45dmBRotQysdNMRhNIWUEIApzKgrtPLG1lz4IsxYVUOg1LmuKbKqzKSciG3SuxRXKeyX2
        J2dKqH7kprH4CEtPAXQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr11466069wrq.176.1576228664705;
        Fri, 13 Dec 2019 01:17:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyf7FDLa5Cm9LlD4WUElkmCtYBMVURaaxC4wORpm59gdaP2fubI54NqmO56BL3SYi99hiEHsA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr11466050wrq.176.1576228664482;
        Fri, 13 Dec 2019 01:17:44 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a14sm9494833wrx.81.2019.12.13.01.17.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 01:17:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] selinux-testsuite: fix tun_tap checks
Date:   Fri, 13 Dec 2019 10:17:33 +0100
Message-Id: <20191213091733.1058949-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The attach_queue permission was introduced later than the tun_socket
class itself. So check for that instead of the class, since the policy
fails to build without it.

Fixes: 4e0f6d5a52d2 ("selinux-testsuite: Add TUN/TAP driver tests")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile | 2 +-
 tests/Makefile  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index f0de669..909594a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -101,7 +101,7 @@ ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && ech
 TARGETS+=test_module_load.te
 endif
 
-ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell grep -q attach_queue $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_tun_tap.te
 endif
 
diff --git a/tests/Makefile b/tests/Makefile
index 9a890be..45c9885 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -79,7 +79,7 @@ SUBDIRS+=module_load
 endif
 endif
 
-ifeq ($(shell grep -q tun_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell grep -q attach_queue $(POLDEV)/include/support/all_perms.spt && echo true),true)
 SUBDIRS += tun_tap
 endif
 
-- 
2.23.0

