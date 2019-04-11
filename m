Return-Path: <SRS0=m7/L=SN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D65C10F13
	for <selinux@archiver.kernel.org>; Thu, 11 Apr 2019 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C176C2133D
	for <selinux@archiver.kernel.org>; Thu, 11 Apr 2019 12:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="vUF6/36n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfDKMbJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:31:09 -0400
Received: from rgout0103.bt.lon5.cpcloud.co.uk ([65.20.0.123]:64305 "EHLO
        rgout01.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbfDKMbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Apr 2019 08:31:09 -0400
X-OWM-Source-IP: 86.147.205.173 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddthedrudejfeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddthedrudejfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.147.205.173) by rgout01.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5B321EA01AC52716; Thu, 11 Apr 2019 13:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1554985868; 
        bh=ounv2q/qEv9BgGH96SyU40cTfsEk2Hq2JakRZEe1r8M=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=vUF6/36nkalu7iKjR1qcPJMmtnq6XonIKH9FM8yZqd7Z+qK6USMOiQ0P9JKrRhwYY5DzhnfXKelIxA1END5QT2pRt3SdfAyW3mDkiVDBvzb68MczozD6Nru5CoU9+5TiEZQrquyR6DKurXHgLYTxL/EXhCrTo516gnyjftM2d1A=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux testsuite: Do not build SCTP unless kernel support
Date:   Thu, 11 Apr 2019 13:31:03 +0100
Message-Id: <20190411123103.23485-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not build/run SCTP tests unless the kernel is 4.20.17 or
greater as they support SELinux SCTP.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index fb6de5c..1bd643e 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -24,8 +24,10 @@ SUBDIRS += extended_socket_class
 endif
 
 ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/corenetwork.if && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && echo true),true)
+ifneq ($(shell ./kvercmp $$(uname -r) 4.20.17),-1)
 SUBDIRS += sctp
 endif
+endif
 
 ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
 SUBDIRS += netlink_socket
-- 
2.20.1

