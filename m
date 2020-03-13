Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34198C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 11:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4C720724
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 11:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt/DY6mL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCML3c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:29:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49041 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgCML3c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 07:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584098969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XpoWQBJHvBzDxkHyKp9w5W1oXyr/+XJWRiNCTaY/iVw=;
        b=Wt/DY6mLL6To4wt+yEnxlOCodZmzjVgRyuMjmIBi44vdZFRsDH3UWSBWiF6uYZlWHQ1VDt
        9xpR4cZj21fcOUp7sYFcqMY4XbuTJ4qRRN2/ccgBUPngP7nc2VHdt1EmQi5h+zfX1GqsAb
        5RuwhRHxNQY5Vy81Hm+JbaD5lMUG8DI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-ENbAs5RKN-W16LNwlc2L7g-1; Fri, 13 Mar 2020 07:29:26 -0400
X-MC-Unique: ENbAs5RKN-W16LNwlc2L7g-1
Received: by mail-wr1-f72.google.com with SMTP id c16so4169810wrt.2
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 04:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpoWQBJHvBzDxkHyKp9w5W1oXyr/+XJWRiNCTaY/iVw=;
        b=EL4r4WnkpcbW6gHrWnwU8E/Gl5adLpTTZud8tnq/ph5J9dISy6EBNMiz4+GYmjoSII
         Pp2Kt7Kn5RSol1ghXGKtoBtrvbTW2/baUFLV2xAjiQSnqZLTvc4Ysu//t4/eM8dEH3Vd
         KhAE7V9/ZvgaxIsPqqi/3E7Govkp/RMii4jj1q7gNehb8Spoy80uyAALQCqgcffJxzCG
         7+PmC372no+18h3rzaclU+pfIHzM1DeZGjXsZb0bxqznhKm53WnZbp8XtdIPsKbNUf8c
         2/pVETMlM+XzPic//k76MWmdX+VEwOEN6cQwvvgrBMBSUpfqm1p6Sv7ZcocmQAEK384u
         batw==
X-Gm-Message-State: ANhLgQ1wox//WSpWPQF+iz5xk7YiB9HR78sUSjaKeG3bXGULKNDaSD9S
        EOcPDIjP/nADdUPmrvqIkpdnBIKusbwaI6rML1VF0wgAlidXj0glC4l1CJ1HfIXvLCwfWDd9Th2
        WNxBFEGJlooXLO/GyHw==
X-Received: by 2002:adf:b19e:: with SMTP id q30mr17075826wra.163.1584098964526;
        Fri, 13 Mar 2020 04:29:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvV+/5G1ibOaNvCcuJbiNyj3KU1CQ3gc7Z9QMngmPuHEMa8ZdJeb9My/nkEV7yXZeq3HQHa/A==
X-Received: by 2002:adf:b19e:: with SMTP id q30mr17075785wra.163.1584098964021;
        Fri, 13 Mar 2020 04:29:24 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id c72sm16198990wme.35.2020.03.13.04.29.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 04:29:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] secilc: add basic test for policy optimization
Date:   Fri, 13 Mar 2020 12:29:21 +0100
Message-Id: <20200313112921.166817-1-omosnace@redhat.com>
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

The test policy is taken from an e-mail from James Carter [1] (converted
to CIL). I have low creativity, so I encourage others to come up with a
better alternative as a follow-up :)

[1] https://lore.kernel.org/selinux/0480cc58-a4f4-bd0f-9edb-f2befe546578@tycho.nsa.gov/

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 secilc/.gitignore       |   2 +
 secilc/Makefile         |   9 +++
 secilc/opt-expected.cil | 139 +++++++++++++++++++++++++++++++++
 secilc/opt-input.cil    | 169 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 319 insertions(+)
 create mode 100644 secilc/opt-expected.cil
 create mode 100644 secilc/opt-input.cil

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
index 16640098..12df982b 100644
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
+	./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin opt-input.cil
+	$(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
+	$(DIFF) opt-expected.cil opt-actual.cil
 
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
diff --git a/secilc/opt-expected.cil b/secilc/opt-expected.cil
new file mode 100644
index 00000000..49e1c2a5
--- /dev/null
+++ b/secilc/opt-expected.cil
@@ -0,0 +1,139 @@
+(handleunknown deny)
+(class cl01 (p01a p01b))
+(class cl02 ())
+(class cl03 (p03a p03b))
+(class cl04 (p04a p04b))
+(class clx (ioctl))
+(classorder (cl01 cl02 cl03 cl04 clx))
+(classcommon cl01 cm01)
+(classcommon cl02 cm02)
+(common cm01 (p11a p11b))
+(common cm02 (p22a p22b))
+(sid kernel)
+(sid security)
+(sid unlabeled)
+(sidorder (kernel security unlabeled))
+(defaultuser cl01 source)
+(defaultuser cl02 source)
+(defaultuser cl03 source)
+(defaultrole cl01 source)
+(defaulttype cl02 target)
+(defaultrange cl03 target low-high)
+(mls true)
+(sensitivity s01)
+(sensitivity s02)
+(sensitivity s03)
+(sensitivityorder (s01 s02 s03))
+(category c01)
+(category c02)
+(category c03)
+(categoryorder (c01 c02 c03))
+(sensitivitycategory s02 (c01 c03))
+(sensitivitycategory s03 ((range c01 c03)))
+(mlsconstrain (cl01 (p01a)) (and (dom h1 h2) (domby l1 h1)))
+(mlsvalidatetrans cl02 (or (eq l1 l2) (eq t3 tpo)))
+(mlsvalidatetrans cl02 (or (eq l1 l2) (incomp l1 l2)))
+(mlsvalidatetrans cl02 (or (eq u1 u2) (eq t3 tpo)))
+(policycap network_peer_controls)
+(policycap open_perms)
+(typeattribute at02)
+(boolean b01 false)
+(boolean b02 true)
+(type tp01)
+(type tp02)
+(type tp03c)
+(type tp03p)
+(type tp04)
+(type tpo)
+(type tpr1)
+(type tpr2)
+(type tpr3)
+(type tpr4)
+(type tpr5)
+(type tpx)
+(typebounds tp03p tp03c)
+(typeattributeset at02 (tp01 tp02))
+(typepermissive tp01)
+(allow at02 tpo (cl02 (p22b)))
+(allow at02 tpr1 (cl01 (p11a p01a p01b)))
+(allow at02 tpr3 (cl01 (p11a p01a p01b)))
+(allow tp01 self (cl01 (p11a p11b p01a p01b)))
+(allow tp01 tpo (cl02 (p22a)))
+(allow tp01 tpr1 (cl01 (p11b)))
+(allow tp03c tpo (cl03 (p03a)))
+(allow tp03p tpo (cl03 (p03a p03b)))
+(allow tp04 tpx (clx (ioctl)))
+(auditallow tp01 tpo (cl01 (p01a)))
+(dontaudit at02 tpr2 (cl01 (p11a p01a p01b)))
+(dontaudit at02 tpr4 (cl01 (p11a p01a p01b)))
+(dontaudit tp01 tpo (cl01 (p01b)))
+(dontaudit tp01 tpr2 (cl01 (p11b)))
+(allowx tp04 tpx (ioctl clx ((0x1234))))
+(auditallowx tp04 tpx (ioctl clx ((0x9911))))
+(dontauditx tp04 tpx (ioctl clx ((0x9922))))
+(typetransition tp01 tpo cl01 tp02)
+(typemember tp01 tpo cl02 tp02)
+(typechange tp01 tpo cl03 tp02)
+(typetransition tp01 tpo cl04 file01 tp02)
+(rangetransition tp01 tpo cl01 ((s02) (s02)))
+(rangetransition tp01 tpo cl02 ((s02) (s03 (c01 c02))))
+(booleanif b01
+    (true
+        (allow tp01 tpr3 (cl01 (p11b)))
+        (allow tp01 tpr5 (cl01 (p11a p11b p01a p01b)))
+        (allow tp02 tpr5 (cl01 (p11a p01a)))
+        (dontaudit tp01 tpr4 (cl01 (p11b)))
+    )
+    (false
+        (allow at02 tpr5 (cl01 (p11a p01a p01b)))
+    )
+)
+(role auditadm_r)
+(role object_r)
+(role rl01)
+(role rl02)
+(role rl03c)
+(role rl03p)
+(role secadm_r)
+(roletype rl01 tp01)
+(roletype rl01 tp02)
+(roletype rl02 tp02)
+(roletype rl03c tp03c)
+(roletype rl03p tp03p)
+(roletype object_r tp01)
+(roletype object_r tp02)
+(roletype object_r tp03c)
+(roletype object_r tp03p)
+(roletype object_r tp04)
+(roletype object_r tpo)
+(roletype object_r tpr1)
+(roletype object_r tpr2)
+(roletype object_r tpr3)
+(roletype object_r tpr4)
+(roletype object_r tpr5)
+(roletype object_r tpx)
+(roletransition rl01 tpo cl01 rl02)
+(roleallow rl01 rl02)
+(user us01)
+(userrole us01 object_r)
+(userrole us01 rl01)
+(userlevel us01 (s01))
+(userrange us01 ((s01) (s03 ((range c01 c03)))))
+(constrain (cl01 (p01b)) (not (and (eq t1 tpo) (neq u1 u2))))
+(validatetrans cl02 (or (eq u1 u2) (eq r1 r2)))
+(sidcontext kernel (us01 rl01 tp01 ((s01) (s03 ((range c01 c03))))))
+(sidcontext security (us01 rl01 tp01 ((s01) (s02))))
+(sidcontext unlabeled (us01 rl01 tp01 ((s02 (c01 c03)) (s03 (c01 c03)))))
+(fsuse xattr fs01 (us01 rl01 tp01 ((s01) (s01))))
+(fsuse trans fs03 (us01 rl01 tp01 ((s01) (s01))))
+(fsuse task fs02 (us01 rl01 tp01 ((s01) (s01))))
+(genfscon fs04 / (us01 rl01 tp01 ((s01) (s01))))
+(portcon udp 1000 (us01 rl01 tp01 ((s01) (s01))))
+(portcon tcp 2000 (us01 rl01 tp01 ((s01) (s01))))
+(portcon dccp 3000 (us01 rl01 tp01 ((s01) (s01))))
+(portcon udp (1001 1009) (us01 rl01 tp01 ((s01) (s01))))
+(portcon tcp (2001 2009) (us01 rl01 tp01 ((s01) (s01))))
+(portcon dccp (3001 3009) (us01 rl01 tp01 ((s01) (s01))))
+(netifcon if01 (us01 rl01 tp01 ((s01) (s01))) (us01 rl01 tp02 ((s01) (s01))))
+(nodecon (10.0.0.1) (255.255.255.0) (us01 rl01 tp01 ((s01) (s01))))
+(nodecon (fc00::1) (fc00::ffff) (us01 rl01 tp01 ((s01) (s01))))
diff --git a/secilc/opt-input.cil b/secilc/opt-input.cil
new file mode 100644
index 00000000..8951360b
--- /dev/null
+++ b/secilc/opt-input.cil
@@ -0,0 +1,169 @@
+(role object_r)
+(role auditadm_r)
+(role secadm_r)
+(typeattribute cil_gen_require)
+(roleattribute cil_gen_require)
+(handleunknown deny)
+(mls true)
+(policycap network_peer_controls)
+(policycap open_perms)
+(sid unlabeled)
+(sidcontext unlabeled (us01 rl01 tp01 ((s02(c01 c03 )) (s03(c01 c03 )))))
+(sid security)
+(sidcontext security (us01 rl01 tp01 ((s01) (s02))))
+(sid kernel)
+(sidcontext kernel (us01 rl01 tp01 ((s01) (s03(c01 c02 c03 )))))
+(sidorder (kernel security unlabeled ))
+(portcon udp 1000 (us01 rl01 tp01 ((s01) (s01))))
+(portcon udp (1001 1009) (us01 rl01 tp01 ((s01) (s01))))
+(portcon tcp 2000 (us01 rl01 tp01 ((s01) (s01))))
+(portcon tcp (2001 2009) (us01 rl01 tp01 ((s01) (s01))))
+(portcon dccp 3000 (us01 rl01 tp01 ((s01) (s01))))
+(portcon dccp (3001 3009) (us01 rl01 tp01 ((s01) (s01))))
+(netifcon if01 (us01 rl01 tp01 ((s01) (s01))) (us01 rl01 tp02 ((s01) (s01))))
+(nodecon (10.0.0.1) (255.255.255.0) (us01 rl01 tp01 ((s01) (s01))))
+(fsuse trans fs03 (us01 rl01 tp01 ((s01) (s01))))
+(fsuse task fs02 (us01 rl01 tp01 ((s01) (s01))))
+(fsuse xattr fs01 (us01 rl01 tp01 ((s01) (s01))))
+(nodecon (fc00::1) (fc00::ffff) (us01 rl01 tp01 ((s01) (s01))))
+(genfscon fs04 / (us01 rl01 tp01 ((s01) (s01))))
+(common cm02 (p22a p22b ))
+(common cm01 (p11a p11b ))
+(typealias ta01b)
+(typealiasactual ta01b tp01)
+(typealias ta01a)
+(typealiasactual ta01a tp01)
+(typealias ta02)
+(typealiasactual ta02 tp02)
+(class cl01 (p01a p01b ))
+(classcommon cl01 cm01)
+(defaultuser cl01 source)
+(defaultrole cl01 source)
+(mlsconstrain (cl01 (p01b)) (not (and (eq t1 tpo) (neq u1 u2))))
+(mlsconstrain (cl01 (p01a)) (and (dom h1 h2) (domby l1 h1)))
+(class cl02 ())
+(classcommon cl02 cm02)
+(defaultuser cl02 source)
+(defaulttype cl02 target)
+(mlsvalidatetrans cl02 (or (eq u1 u2) (eq t3 tpo)))
+(mlsvalidatetrans cl02 (or (eq u1 u2) (eq r1 r2)))
+(mlsvalidatetrans cl02 (or (eq l1 l2) (eq t3 tpo)))
+(mlsvalidatetrans cl02 (or (eq l1 l2) (incomp l1 l2)))
+(class cl03 (p03a p03b ))
+(defaultuser cl03 source)
+(defaultrange cl03 target low-high)
+(class cl04 (p04a p04b ))
+(class clx (ioctl ))
+(classorder (cl01 cl02 cl03 cl04 clx ))
+(roleattribute ar01)
+(roleattributeset ar01 (rl01 ))
+(roleattribute ar02)
+(roleattributeset ar02 (rl01 rl02 ))
+(role rl01)
+(roletype rl01 tp01)
+(roletype rl01 tp02)
+(role rl02)
+(roletype rl02 tp02)
+(role rl03p)
+(roletype rl03p tp03p)
+(role rl03c)
+(roletype rl03c tp03c)
+(typeattribute at01)
+(typeattributeset at01 (tp01 ))
+(typeattribute at02)
+(typeattributeset at02 (tp01 tp02 ))
+(type tpo)
+(roletype object_r tpo)
+(type tpx)
+(roletype object_r tpx)
+(type tp01)
+(roletype object_r tp01)
+(typepermissive tp01)
+(type tp02)
+(roletype object_r tp02)
+(type tp03p)
+(roletype object_r tp03p)
+(type tp03c)
+(roletype object_r tp03c)
+(typebounds tp03p tp03c)
+(type tp04)
+(roletype object_r tp04)
+(type tpr1)
+(roletype object_r tpr1)
+(type tpr2)
+(roletype object_r tpr2)
+(type tpr3)
+(roletype object_r tpr3)
+(type tpr4)
+(roletype object_r tpr4)
+(type tpr5)
+(roletype object_r tpr5)
+(user us01)
+(userrole us01 object_r)
+(userrole us01 rl01)
+(userlevel us01 (s01 ))
+(userrange us01 ((s01 ) (s03 (range c01 c03))))
+(boolean b01 false)
+(boolean b02 true)
+(sensitivity s01)
+(sensitivity s02)
+(sensitivitycategory s02 (c01 c03 ))
+(sensitivity s03)
+(sensitivitycategory s03 (c01 c02 c03 ))
+(sensitivityorder (s01 s02 s03 ))
+(category c01)
+(category c02)
+(category c03)
+(categoryorder (c01 c02 c03 ))
+(allow tp01 self (cl01 (p11a p01a)))
+(allow tp01 tp01 (cl01 (p01b)))
+(allow tp01 at01 (cl01 (p11b)))
+(allow tp01 tpo (cl02 (p22a)))
+(allow at02 tpo (cl02 (p22b)))
+(allow tp03p tpo (cl03 (p03a p03b)))
+(allow tp03c tpo (cl03 (p03a)))
+(allow tp04 tpx (clx (ioctl)))
+(auditallow tp01 tpo (cl01 (p01a)))
+(dontaudit tp01 tpo (cl01 (p01b)))
+;;* lmx 92 test_01.conf
+
+(neverallow tp01 tpo (cl01 (p11a)))
+;;* lme
+
+(allow tp01 tpr1 (cl01 (p11a p11b p01a p01b)))
+(allow tp02 tpr1 (cl01 (p11a p01a)))
+(allow at02 tpr1 (cl01 (p11a p01a p01b)))
+(dontaudit tp01 tpr2 (cl01 (p11a p11b p01a p01b)))
+(dontaudit tp02 tpr2 (cl01 (p11a p01a)))
+(dontaudit at02 tpr2 (cl01 (p11a p01a p01b)))
+(allow at02 tpr3 (cl01 (p11a p01a p01b)))
+(dontaudit at02 tpr4 (cl01 (p11a p01a p01b)))
+(allowx tp04 tpx (ioctl clx (0x1234)))
+(auditallowx tp04 tpx (ioctl clx (0x9911)))
+(dontauditx tp04 tpx (ioctl clx (0x9922)))
+;;* lmx 130 test_01.conf
+
+(neverallowx tp04 tpx (ioctl clx (0x9933)))
+;;* lme
+
+(typetransition tp01 tpo cl01 tp02)
+(typemember tp01 tpo cl02 tp02)
+(typechange tp01 tpo cl03 tp02)
+(roletransition rl01 tpo cl01 rl02)
+(roleallow rl01 rl02)
+(rangetransition tp01 tpo cl02 ((s02 ) (s03 (c02 c01))))
+(rangetransition tp01 tpo cl01 ((s02 ) (s02 )))
+(typetransition tp01 tpo cl04 "file01" tp02)
+(booleanif (b01)
+    (true
+        (allow tp02 tpr3 (cl01 (p11a p01a)))
+        (allow tp01 tpr3 (cl01 (p11a p11b p01a p01b)))
+        (dontaudit tp02 tpr4 (cl01 (p11a p01a)))
+        (dontaudit tp01 tpr4 (cl01 (p11a p11b p01a p01b)))
+        (allow tp02 tpr5 (cl01 (p11a p01a)))
+        (allow tp01 tpr5 (cl01 (p11a p11b p01a p01b)))
+    )
+    (false
+        (allow at02 tpr5 (cl01 (p11a p01a p01b)))
+    )
+)
-- 
2.24.1

