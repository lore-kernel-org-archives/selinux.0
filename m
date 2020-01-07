Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6FC282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 20:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BB92077B
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 20:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Dd3/fAW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgAGUXA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:23:00 -0500
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:17462 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUXA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 15:23:00 -0500
X-EEMSG-check-017: 63653062|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; 
   d="scan'208";a="63653062"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 20:22:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578428576; x=1609964576;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F6sSfO2acNb3I4bCjjOTX3aUzKlZ3POl0Ct6UeqdYeU=;
  b=Dd3/fAW6MwhhZyb+qYfCJZ4R0xE8CRHijaevG9txhLL0gCtRo1Rvv7Wn
   Ej1Z8IeTxOkExJgHA9vixD7RHdBymlCKn/FRt6odGK8W+74KaEMfNa2LC
   JISwk3UyZW1GpJI9r6zqn0RMEEBvuKPz9EgvgxMpdNKBcI6VbjR5GVUmL
   raIcl4t7uHz4mozPvU2fngMmzHRs8Q0j3iein3dwHNxWrGLp4UFZVkLKO
   rMap4m2f7O4AcHlSwPqCMdtCBHuJLivioEg6M4awJDj2QufXGec7Hnhb4
   ECjDzNFasOH2WEnhS8J+hdpqhp/hOmn/tQjVoSHVQzW5G8qIs4WnHwvLk
   A==;
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; 
   d="scan'208";a="37459165"
IronPort-PHdr: =?us-ascii?q?9a23=3At+n2hhU5nFv6g/jNSS7PPQUP84vV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBKOt8tkgFKBZ4jH8fUM07OQ7/m7HzZdv93Y4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajItjJ6o+1x?=
 =?us-ascii?q?fEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfp6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZAo2ycZYBAeQCM+hfoIbzqEADoQe9CAS2GO/i0CNEimPw0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4EtwTrHTbss31NKcMXuCz0aLG0DDDYOlS2Tf59ofJcg0qrPaXXb?=
 =?us-ascii?q?1tasrc0lUvFgPZgVWQrozpJTWV1v8XvGSB4OpgUvyvhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?TGi48a0FzJ9Th1zJwrKdC3VkJ3e8OoHZ1NvC+ALYR2WNktQ2RwtSY/zb0JpI?=
 =?us-ascii?q?C0cTARyJQi2x7fc/uHc5WU4h77VOaePzN4hHV9dbKjnRmy60mgyvDnVsWu0V?=
 =?us-ascii?q?ZKqCRFkt7Xtn8TyxPf8NSHS/th8Ueh3jaDzQbT5f1fIU8oj6bbLp8hwroomp?=
 =?us-ascii?q?oSt0TMADP2lV3rgKKZeUgo4Oil5/n9brn4qZKQKZV4hhzmPqQrgMO/AOA4Mg?=
 =?us-ascii?q?YUX2ic/OSxzKbj8lDiQLhRkv03krXWsJDdJcgBoK65GBVa3pws6xa4ETeqyM?=
 =?us-ascii?q?4YkmUfLFJZZBKHiJDkO1bLIPD/Fve/hU6jnyt1yP3dJL3uHIjCLnjZn7f9Z7?=
 =?us-ascii?q?py90lcyA8rx9BF+51UEq0BIO70WkLpr9zXEBs5Mw2yw+b6B9RwzZ0eWW2RDa?=
 =?us-ascii?q?+DKq/SskGH5vgpI+aSYI8ZojH9K+Iq5/T2l382hUcdfbW13ZsQcH24Bu5pI1?=
 =?us-ascii?q?idYXf3mtcOC3oKvg4nQOzvj12CViRTaGioU60g4TE7DdHuMYCWXomwhJSZ1T?=
 =?us-ascii?q?q/W5hRYXpLTFuLFCTGbYKBDswQZTqSL8kpqTkNUbysWsd1zh21nBPrwLpgaO?=
 =?us-ascii?q?zP82sXsoy1h4s93PHaiRxnrW88NM+ayWzYCjwlkw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BiAwCr5xRe/wHyM5BlHgELHIFxC4F9gWwBIBIqjQyGZ?=
 =?us-ascii?q?wEBBAaLJY9NFIFnCQEBAQEBAQEBARscAQGEQIIPNAkOAhABAQEEAQEBAQEFA?=
 =?us-ascii?q?wEBbIVDgjspgygLAUaBUYJjP4JTJa4XM4VPgzKBPYE2h0CEc3mBB4FHgxuEM?=
 =?us-ascii?q?YYGBI06iiWXQIJAgkWTSwwbml4Bqy45gVgrCAIYCCEPgydQGA2NHheOQSMDM?=
 =?us-ascii?q?JB8AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Jan 2020 20:22:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007KMIGi255941;
        Tue, 7 Jan 2020 15:22:19 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux: deprecate setting checkreqprot to 1
Date:   Tue,  7 Jan 2020 15:23:22 -0500
Message-Id: <20200107202322.27380-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Deprecate setting the SELinux checkreqprot tunable to 1 via kernel
parameter or /sys/fs/selinux/checkreqprot.  Setting it to 0 is left
intact for compatibility since Android and some Linux distributions
do so for security and treat an inability to set it as a fatal error.
Eventually setting it to 0 will become a no-op and the kernel will
stop using checkreqprot's value internally altogether.

checkreqprot was originally introduced as a compatibility mechanism
for legacy userspace and the READ_IMPLIES_EXEC personality flag.
However, if set to 1, it weakens security by allowing mappings to be
made executable without authorization by policy.  The default value
for the SECURITY_SELINUX_CHECKREQPROT_VALUE config option was changed
from 1 to 0 in commit 2a35d196c160e3 ("selinux: change
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and both Android
and Linux distributions began explicitly setting
/sys/fs/selinux/checkreqprot to 0 some time ago.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
RFC-only, not yet tested.

 Documentation/admin-guide/kernel-parameters.txt | 1 +
 security/selinux/Kconfig                        | 3 +++
 security/selinux/hooks.c                        | 4 ++++
 security/selinux/selinuxfs.c                    | 6 ++++++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index eed51293d6cf..c894ddfa1393 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -512,6 +512,7 @@
 			Default value is set via a kernel config option.
 			Value can be changed at runtime via
 				/sys/fs/selinux/checkreqprot.
+			Setting checkreqprot to 1 is deprecated.
 
 	cio_ignore=	[S390]
 			See Documentation/s390/common_io.rst for details.
diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 1014cb0ee956..9e921fc72538 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -88,6 +88,9 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	  'checkreqprot=' boot parameter.  It may also be changed at runtime
 	  via /sys/fs/selinux/checkreqprot if authorized by policy.
 
+	  WARNING: this option is deprecated and will be removed in a future
+	  kernel release.
+
 	  If you are unsure how to answer this question, answer 0.
 
 config SECURITY_SELINUX_SIDTAB_HASH_BITS
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 63a6e36abe9f..11d47bb7d40a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7149,7 +7149,11 @@ static __init int selinux_init(void)
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
+
 	selinux_state.checkreqprot = selinux_checkreqprot_boot;
+	if (selinux_state.checkreqprot)
+		pr_warn("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated.\n");
+
 	selinux_ss_init(&selinux_state.ss);
 	selinux_avc_init(&selinux_state.avc);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79c710911a3c..c6c136eee371 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -668,6 +668,12 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (sscanf(page, "%u", &new_value) != 1)
 		goto out;
 
+	if (new_value) {
+		char comm[sizeof(current->comm)];
+		memcpy(comm, current->comm, sizeof(comm));
+		pr_warn_once("SELinux: %s (%d) set checkreqprot to 1.  This is deprecated.\n", comm, current->pid);
+	}
+
 	fsi->state->checkreqprot = new_value ? 1 : 0;
 	length = count;
 out:
-- 
2.24.1

