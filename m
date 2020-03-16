Return-Path: <SRS0=RXLG=5B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2446EC0044D
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 09:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8EB20663
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpDgNakm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgCPJzf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:55:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730423AbgCPJzf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Mar 2020 05:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584352533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wsgt4vWlscGuOQeWZQpaYQV5iCmAQ9fH4xN/BxTZF9A=;
        b=LpDgNakmIh2s/pHvQMMOF38ldIKEGe6bWB4yNt6TAjexrB+WZv9IB/vK633we9D2U1XwcK
        mndW9lojgCuFw0QvOGNml7qHBV/JSrqCreIJ0HC1aJbAzVyrDFT0wai0HSKVBoT1yxsbuq
        +FRD7Q6Xm4WyxwdDhpoR1wGyEabPHOg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-dpZNzdZANYm64X2NDO00Rg-1; Mon, 16 Mar 2020 05:55:29 -0400
X-MC-Unique: dpZNzdZANYm64X2NDO00Rg-1
Received: by mail-wm1-f70.google.com with SMTP id z16so499231wmi.2
        for <selinux@vger.kernel.org>; Mon, 16 Mar 2020 02:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wsgt4vWlscGuOQeWZQpaYQV5iCmAQ9fH4xN/BxTZF9A=;
        b=oTq87ybWFb8vT6IeyFJ6aUcJbsAsro0UhkO9ex2HEMIFUQr5+8Q9nNNM688DAlO2lu
         SS3Pll2VcLl3DWKegNUjdm84g5aE9h+rdJ4oWVBqCwplJRX0mLn4V3jGHgE34x0kDCVK
         eQz99vdud68iS9UjuhhXJmpmE/0yNcmLUMGIpRaQDXSaaLxvoLqijFx0zInY+/s7zcjt
         GzTf1MQK13s4dfLdxjAEgO4miCs/fA6mLUUqxIcfR6gLdtosnAwT+t6TiNqev+tNrH9k
         NdXOYj0MFG90jZrHcr14tiYlZt3ZBtZy5m1ir6VHRgIRNtOAJ+td4+Ry1ea6VDqNfnLW
         NpZA==
X-Gm-Message-State: ANhLgQ2n+sOTbQ+7S+To1QftX5K8ocQtCs4NxgIw3Bg/9dHPywExoC0h
        /8SFyQMQFT+kJBSUB4qoUrub5wa5yG9BOYllAMNu9iOc4+JfM+tkdgz1HT7WJPGV7YsbfCsKcQO
        E0IEV3EcGoSf0gpeKvw==
X-Received: by 2002:adf:8023:: with SMTP id 32mr24936418wrk.189.1584352527495;
        Mon, 16 Mar 2020 02:55:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUTU0hQ5GVQRVoj7Tu3jhjDYWPQ/rsxu8y0xIHBJaQz0lHtrYvEqwupXzrhHGlhGaNZMEpJA==
X-Received: by 2002:adf:8023:: with SMTP id 32mr24936392wrk.189.1584352527186;
        Mon, 16 Mar 2020 02:55:27 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id l5sm28279284wml.3.2020.03.16.02.55.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:55:26 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] secilc: add basic test for policy optimization
Date:   Mon, 16 Mar 2020 10:55:23 +0100
Message-Id: <20200316095523.335474-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a simple test for secilc -O to make sure that it produces the
expected output. This might produce some false positives when the output
of secilc/checkpolicy changes slightly, in which case the expected CIL
will need to be updated along with the change.

The test should normally work even with a checkpolicy built from an
older tree, as long as it produces the same CIL output, so it uses the
checkpolicy it finds in PATH by default.

The test policy is taken from an e-mail from James Carter:
https://lore.kernel.org/selinux/CAP+JOzTQQx6aM81QyVe0yoiPJeDU+7xE6nn=0UMAB1EZ_c9ryA@mail.gmail.com/T/

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2:
 - move test policies to the 'test' subdirectory
 - use a simplified test policy supplied by James

 secilc/.gitignore            |  2 ++
 secilc/Makefile              |  9 +++++
 secilc/test/opt-expected.cil | 57 +++++++++++++++++++++++++++++++
 secilc/test/opt-input.cil    | 65 ++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 secilc/test/opt-expected.cil
 create mode 100644 secilc/test/opt-input.cil

diff --git a/secilc/.gitignore b/secilc/.gitignore
index 2d3ff405..164523b0 100644
--- a/secilc/.gitignore
+++ b/secilc/.gitignore
@@ -7,3 +7,5 @@ file_contexts
 docs/html
 docs/pdf
 docs/tmp
+opt-actual.bin
+opt-actual.cil
diff --git a/secilc/Makefile b/secilc/Makefile
index 16640098..d4a1c35a 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -13,6 +13,10 @@ SECIL2CONF_OBJS := $(patsubst %.c,%.o,$(SECIL2CONF_SRCS))
 SECILC_MANPAGE = secilc.8
 SECIL2CONF_MANPAGE = secil2conf.8
 XMLTO = xmlto
+DIFF = diff
+
+CHECKPOLICY = checkpolicy
+POL_VERS = $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
 
 CFLAGS ?= -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
 
@@ -26,6 +30,9 @@ $(SECILC): $(SECILC_OBJS)
 
 test: $(SECILC)
 	./$(SECILC) test/policy.cil
+	./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.cil
+	$(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
+	$(DIFF) test/opt-expected.cil opt-actual.cil
 
 $(SECIL2CONF): $(SECIL2CONF_OBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
@@ -58,6 +65,8 @@ clean:
 	rm -f file_contexts
 	rm -f $(SECILC_MANPAGE)
 	rm -f $(SECIL2CONF_MANPAGE)
+	rm -f opt-actual.cil
+	rm -f opt-actual.bin
 	$(MAKE) -C docs clean
 
 relabel:
diff --git a/secilc/test/opt-expected.cil b/secilc/test/opt-expected.cil
new file mode 100644
index 00000000..73ac9045
--- /dev/null
+++ b/secilc/test/opt-expected.cil
@@ -0,0 +1,57 @@
+(handleunknown deny)
+(class cl01 (p01a p01b p11a p11b))
+(classorder (cl01))
+(sid kernel)
+(sidorder (kernel))
+(mls true)
+(sensitivity s01)
+(sensitivityorder (s01))
+(category c01)
+(categoryorder (c01))
+(sensitivitycategory s01 (c01))
+(typeattribute at02)
+(boolean b01 false)
+(type tp01)
+(type tp02)
+(type tp04)
+(type tpr1)
+(type tpr2)
+(type tpr3)
+(type tpr4)
+(type tpr5)
+(typeattributeset at02 (tp01 tp02))
+(allow at02 tpr1 (cl01 (p01a p01b p11a)))
+(allow at02 tpr3 (cl01 (p01a p01b p11a)))
+(allow tp01 self (cl01 (p01a p01b p11a p11b)))
+(allow tp01 tpr1 (cl01 (p11b)))
+(dontaudit at02 tpr2 (cl01 (p01a p01b p11a)))
+(dontaudit at02 tpr4 (cl01 (p01a p01b p11a)))
+(dontaudit tp01 tpr2 (cl01 (p11b)))
+(booleanif b01
+    (true
+        (allow tp01 tpr3 (cl01 (p11b)))
+        (allow tp01 tpr5 (cl01 (p01a p01b p11a p11b)))
+        (allow tp02 tpr5 (cl01 (p01a p11a)))
+        (dontaudit tp01 tpr4 (cl01 (p11b)))
+    )
+    (false
+        (allow at02 tpr5 (cl01 (p01a p01b p11a)))
+    )
+)
+(role object_r)
+(role rl01)
+(roletype rl01 tp01)
+(roletype object_r tp01)
+(roletype object_r tp02)
+(roletype object_r tp04)
+(roletype object_r tpr1)
+(roletype object_r tpr2)
+(roletype object_r tpr3)
+(roletype object_r tpr4)
+(roletype object_r tpr5)
+(user us01)
+(userrole us01 object_r)
+(userrole us01 rl01)
+(userlevel us01 (s01))
+(userrange us01 ((s01) (s01)))
+(sidcontext kernel (us01 rl01 tp01 ((s01) (s01))))
diff --git a/secilc/test/opt-input.cil b/secilc/test/opt-input.cil
new file mode 100644
index 00000000..5bb6c266
--- /dev/null
+++ b/secilc/test/opt-input.cil
@@ -0,0 +1,65 @@
+(handleunknown deny)
+(class cl01 (p01a p01b p11a p11b))
+(classorder (cl01))
+(sid kernel)
+(sidorder (kernel))
+(mls true)
+(sensitivity s01)
+(sensitivityorder (s01))
+(category c01)
+(categoryorder (c01))
+(sensitivitycategory s01 (c01))
+(typeattribute at01)
+(typeattribute at02)
+(boolean b01 false)
+(type tp01)
+(type tp02)
+(type tp04)
+(type tpr1)
+(type tpr2)
+(type tpr3)
+(type tpr4)
+(type tpr5)
+(typeattributeset at01 (tp01))
+(typeattributeset at02 (tp01 tp02))
+(allow at02 tpr1 (cl01 (p11a p01a p01b)))
+(allow at02 tpr3 (cl01 (p11a p01a p01b)))
+(allow tp01 at01 (cl01 (p11b)))
+(allow tp01 self (cl01 (p11a p01a)))
+(allow tp01 tp01 (cl01 (p01b)))
+(allow tp01 tpr1 (cl01 (p11a p11b p01a p01b)))
+(allow tp02 tpr1 (cl01 (p11a p01a)))
+(dontaudit at02 tpr2 (cl01 (p11a p01a p01b)))
+(dontaudit at02 tpr4 (cl01 (p11a p01a p01b)))
+(dontaudit tp01 tpr2 (cl01 (p11a p11b p01a p01b)))
+(dontaudit tp02 tpr2 (cl01 (p11a p01a)))
+(booleanif (b01)
+    (true
+        (allow tp01 tpr3 (cl01 (p11a p11b p01a p01b)))
+        (allow tp01 tpr5 (cl01 (p11a p11b p01a p01b)))
+        (allow tp02 tpr3 (cl01 (p11a p01a)))
+        (allow tp02 tpr5 (cl01 (p11a p01a)))
+        (dontaudit tp01 tpr4 (cl01 (p11a p11b p01a p01b)))
+        (dontaudit tp02 tpr4 (cl01 (p11a p01a)))
+    )
+    (false
+        (allow at02 tpr5 (cl01 (p11a p01a p01b)))
+    )
+)
+(role object_r)
+(role rl01)
+(roletype rl01 tp01)
+(roletype object_r tp01)
+(roletype object_r tp02)
+(roletype object_r tp04)
+(roletype object_r tpr1)
+(roletype object_r tpr2)
+(roletype object_r tpr3)
+(roletype object_r tpr4)
+(roletype object_r tpr5)
+(user us01)
+(userrole us01 object_r)
+(userrole us01 rl01)
+(userlevel us01 (s01))
+(userrange us01 ((s01) (s01)))
+(sidcontext kernel (us01 rl01 tp01 ((s01) (s01))))
-- 
2.24.1

