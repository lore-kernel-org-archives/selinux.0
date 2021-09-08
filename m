Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55057C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Sep 2021 11:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C76E61026
	for <selinux@archiver.kernel.org>; Wed,  8 Sep 2021 11:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhIHLIk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232630AbhIHLIj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Sep 2021 07:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631099250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yT/CdT80kU9pPafxaVvqdJinNdiM1XgR8HR8IMLfB2c=;
        b=cEg2h9+onb4J6sYX+RfMSUr1co+5UF6qIW9DVUQQ1EaoF6G+34Sl8yI+b1sJXAFCKtynHU
        ptGWzVg8/dxtdjUFqH6+l5nCgRkWHT30F3ha/45Rzprjeze9PllYpSd5sBQNk/I37ssXc2
        HVFPenoLosa49huxTWd43kAqdjuQtKg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-w_AP2lHrOWKBepFj4Vyopw-1; Wed, 08 Sep 2021 07:07:28 -0400
X-MC-Unique: w_AP2lHrOWKBepFj4Vyopw-1
Received: by mail-wm1-f69.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so703624wmr.9
        for <selinux@vger.kernel.org>; Wed, 08 Sep 2021 04:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yT/CdT80kU9pPafxaVvqdJinNdiM1XgR8HR8IMLfB2c=;
        b=MeUOAgSnHfzhvU9H9c3GCCEUf1jnSsSZ1SMsHN3doOClVaN9gau+CyAKU0PwjZmtKE
         W9v9s2Oy1WKcjFBogTutz0IWSvmFd14FG023emCyjbAeI966eJDRNjSSzkZdmuPl2RKH
         TKZMWJET6I8GsfJUMpJBSXJJIKBseaXkKdqkFbBQ9ATpdCm9UeoCUA2WIpbZ5DWJvflf
         3ycwzkfJiufl3aeCAInvXDipvvBkSiRv8xWA7UFSO6esk510GES85UhRjgOReprVyaCu
         bHJOY6UFvmnO6u/P1OaID9AzUu/AjIhk00BEPqiGjWn1n1eUsmAtlF/6hVxrbJRpJKTX
         QEAA==
X-Gm-Message-State: AOAM5323c1nqwE5opRkjC2u6qluxdY8KCcsWkR2swTerqeCxa1m1kKUi
        qNu3c7xxjDBquhmrmDf4yPG70DFxwB0lBsUIH+QoD2bjSUFwUjdOguOGHD0xKQoUo1hizLez2fc
        50GsCF7Pvr+57SH8XdM+flZivE8Ip1VaNyv52reXcH0JHtNPpx+srU8axZy+CjyAK9NIQgg==
X-Received: by 2002:a5d:6cca:: with SMTP id c10mr3299601wrc.224.1631099246860;
        Wed, 08 Sep 2021 04:07:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRvHm6rTXp3Jk6KMgXgd+ud1GCMfyczjSfhWXbMt0IlJC+rMB8m7iJpQROExtUgFWHOzulsQ==
X-Received: by 2002:a5d:6cca:: with SMTP id c10mr3299566wrc.224.1631099246556;
        Wed, 08 Sep 2021 04:07:26 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s13sm1761882wmc.47.2021.09.08.04.07.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:07:26 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2] tests: exclude vsock_socket test where it wouldn't build
Date:   Wed,  8 Sep 2021 13:07:25 +0200
Message-Id: <20210908110725.258108-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The test requires the <linux/vm_sockets.h> header to be available and
contain th definition for VMADDR_CID_LOCAL, so wrap it in a check for
these preconditions.

Likewise, the vsock_socket test policy requires the vsock_socket class
to be defined in the base policy, so wrap the policy bit and test in a
check for this, too.

Without this patch the testsuite wouldn't build on older distros such as
RHEL-7.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: also check for vsock_socket class in policy

 policy/Makefile | 6 +++++-
 tests/Makefile  | 8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/policy/Makefile b/policy/Makefile
index a4cc98f..5e5ccda 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -27,7 +27,7 @@ TARGETS = \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
-	test_transition.te test_unix_socket.te test_vsock_socket.te \
+	test_transition.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
 	test_ibpkey.te test_atsecure.te test_cgroupfs.te
 
@@ -125,6 +125,10 @@ ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && echo
 TARGETS += test_key_socket.te
 endif
 
+ifeq ($(shell grep -q vsock_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_vsock_socket.te
+endif
+
 ifeq ($(shell grep -q module_load $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS+=test_module_load.te
 endif
diff --git a/tests/Makefile b/tests/Makefile
index e59ddc0..cbff490 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-	inet_socket overlay checkreqprot mqueue mac_admin atsecure vsock_socket
+	inet_socket overlay checkreqprot mqueue mac_admin atsecure
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
@@ -141,6 +141,12 @@ SUBDIRS += userfaultfd
 endif
 endif
 
+ifeq ($(shell grep -q vsock_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell grep -qs VMADDR_CID_LOCAL $(INCLUDEDIR)/linux/vm_sockets.h && echo true),true)
+SUBDIRS += vsock_socket
+endif
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
-- 
2.31.1

