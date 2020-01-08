Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF1C33CA2
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7F02077B
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CTQVGe00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgAHQY0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:24:26 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:13002 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgAHQYZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 11:24:25 -0500
X-EEMSG-check-017: 63890461|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="63890461"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 16:24:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578500661; x=1610036661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=js3veDBcUZMAAgc12B0/6qHyrGUofRp+zn58w/yE0+E=;
  b=CTQVGe00hn1YHYZ+W7tsrnhIXAO0aHE9n65y+uOEwnX+3C6z4C7ct5Om
   Y+rmHPjdYiX/sIAy3LmOBPBdXHq5HLfD+7SQiXJSi9nneSvF/4zU4FHGc
   Ts8OaziLVgcAmqytaOBl4jk1Mc6Ew5gdKO/pqhrJh8sXkwWEsvCSiwIWS
   KKy08OSXXXBx+aDPOEKtrMUyPoZI6ebGPaEh9qiJA45kpC3RyzIbeYJBp
   C0sSJzQtgB9Wvx6gmy9hehzQuiLA3LL+ePXdhWLi66tx5ycaRhz8a6EZB
   bXUC7ETPNfgoGIF30mDFZyPoYdQVAm4kSYwC2ruPdkU4JML7uEyK6r7Cs
   A==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="37495986"
IronPort-PHdr: =?us-ascii?q?9a23=3ArP0OGRWVVt3V5mL4q44Qh8qUEBfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbROOt8tkgFKBZ4jH8fUM07OQ7/m7HzZdsd3R7DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIthJ6o+yR?=
 =?us-ascii?q?bErWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOOR6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZAo2ycZYBAeQCM+hfoIbzqEADoQe9CAS2GO/i0CNEimPw0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4EtwTrHTbss31NKcMXuCz0aLG0DDDYOlS2Tf59ofJcg0qrPaXXb?=
 =?us-ascii?q?1tasrc0lUvFgPZgVWQrozpJTWV1v8XvGSB4OpgUvyvhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?TGi48a0FzJ9Th1zJwrKdC3VkJ3e8OoHZ1NvC+ALYR2WNktQ2RwtSY/zb0JpI?=
 =?us-ascii?q?C0cTARyJQi2x7fc/uHc5WU4h77VOaePzN4hHV9dbKjnRmy60mgyvDnVsWu0V?=
 =?us-ascii?q?ZKqCRFkt7Xtn8TyxPf8NSHS/th8Ueh3jaDzQbT5f1fIU8oj6bbLp8hwroomp?=
 =?us-ascii?q?oSt0TMADP2lV3rgKKZeUgo4Oil5/n9brn4qZKQKZV4hhzmPqQrgMO/AOA4Mg?=
 =?us-ascii?q?YUX2ic/OSxzKbj8lDiQLhRkv03krXWsJDdJcgBoK65GBVa3pws6xa4ETeqyM?=
 =?us-ascii?q?4YkmUfLFJZZBKHiJDkO1XPIPD+EPe+jE2gnypsx//aJbDhHJrNIWbZkLv7fr?=
 =?us-ascii?q?Zy9VRcyAwtwtBb/Z5UDasBIP3rUE/rqNPYFgM5MxCzw+v/FNp90ZkeVnmRDa?=
 =?us-ascii?q?+FK67StVGJ5uQ1L+mKeoAVpC73K+I56P72kX85hVgdcLGu3ZsSb3C4BfJmLF?=
 =?us-ascii?q?+FbnXymdoBC3kFsRc+TOPwlF2OSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGBxz?=
 =?us-ascii?q?m0HplXZmBAF1CNHmzld5uLW/gSciKeOMxhnSIeVbinVYAh0QuitAjgy7poNu?=
 =?us-ascii?q?DU4DEXtYr/1Nhp4O3ejQky+iZpD8SZyGyNV3t7nn4MRzMv2aB/pkt9yk2d3q?=
 =?us-ascii?q?Rin/NYEtlTtLt1VVIiPIPY5/RzFtS3XwXGZNrPQ1GjEfu8BjRkdc48298DZQ?=
 =?us-ascii?q?5GHtymih3Sl36xD6Q9i62ABJty9LnVmXf2OZAumD79yKA9ggx+EYN0Pmq8i/?=
 =?us-ascii?q?s6rVne?=
X-IPAS-Result: =?us-ascii?q?A2A7AACNABZe/wHyM5BmHQEBAQkBEQUFAYFoCAELAYF8g?=
 =?us-ascii?q?W0gEiqMLGCGaAEBAQEBAQaLFw6PTRSBZwkBAQEBAQEBAQEbHAEBhECCEDQJD?=
 =?us-ascii?q?gIQAQEBBAEBAQEBBQMBAWyFQ4I7KYMoCwFGL1NPgmM/gkcDCSWtEzOIGQ1jg?=
 =?us-ascii?q?T2BNgGHP4RzeYEHgUeDG4IbgXcfhWQiBI0/OIltd5YIRIJAgkWPN4QaDBuaY?=
 =?us-ascii?q?QGZS5FsOYFYKwgCGAghD4MnUBgNjR4XjkEjAzCOOIJDAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 08 Jan 2020 16:24:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008GNgdq029237;
        Wed, 8 Jan 2020 11:23:45 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Documentation,selinux: deprecate setting checkreqprot to 1
Date:   Wed,  8 Jan 2020 11:24:47 -0500
Message-Id: <20200108162447.3347-1-sds@tycho.nsa.gov>
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
 .../ABI/obsolete/sysfs-selinux-checkreqprot   | 23 +++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  1 +
 MAINTAINERS                                   |  1 +
 security/selinux/Kconfig                      |  3 +++
 security/selinux/hooks.c                      |  5 +++-
 security/selinux/selinuxfs.c                  |  8 +++++++
 6 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-checkreqprot

diff --git a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot b/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
new file mode 100644
index 000000000000..49ed9c8fd1e5
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
@@ -0,0 +1,23 @@
+What:		/sys/fs/selinux/checkreqprot
+Date:		April 2005 (predates git)
+KernelVersion:	2.6.12-rc2 (predates git)
+Contact:	selinux@vger.kernel.org
+Description:
+
+	The selinuxfs "checkreqprot" node allows SELinux to be configured
+	to check the protection requested by userspace for mmap/mprotect
+	calls instead of the actual protection applied by the kernel.
+	This was a compatibility mechanism for legacy userspace and
+	for the READ_IMPLIES_EXEC personality flag.  However, if set to
+	1, it weakens security by allowing mappings to be made executable
+	without authorization by policy.  The default value of checkreqprot
+	at boot was changed starting in Linux v4.4 to 0 (i.e. check the
+	actual protection), and Android and Linux distributions have been
+	explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
+	initialization for some time.  Support for setting checkreqprot to 1
+	will be	removed in a future kernel release, at which point the kernel
+	will always cease using checkreqprot internally and will always
+	check the actual protections being applied upon mmap/mprotect calls.
+	The checkreqprot selinuxfs node will remain for backward compatibility
+	but will discard writes of the "0" value and will reject writes of the
+	"1" value when this mechanism is removed.
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 9dc5767861b5..1af5e9e8abb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14807,6 +14807,7 @@ F:	security/selinux/
 F:	scripts/selinux/
 F:	Documentation/admin-guide/LSM/SELinux.rst
 F:	Documentation/ABI/obsolete/sysfs-selinux-disable
+F:	Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
 
 SENSABLE PHANTOM
 M:	Jiri Slaby <jirislaby@gmail.com>
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
index 63a6e36abe9f..6777e04fd942 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -142,8 +142,11 @@ static int __init checkreqprot_setup(char *str)
 {
 	unsigned long checkreqprot;
 
-	if (!kstrtoul(str, 0, &checkreqprot))
+	if (!kstrtoul(str, 0, &checkreqprot)) {
 		selinux_checkreqprot_boot = checkreqprot ? 1 : 0;
+		if (checkreqprot)
+			pr_warn("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated and will be rejected in a future kernel release.\n");
+	}
 	return 1;
 }
 __setup("checkreqprot=", checkreqprot_setup);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79c710911a3c..d6566adc73a6 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -668,6 +668,14 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (sscanf(page, "%u", &new_value) != 1)
 		goto out;
 
+	if (new_value) {
+		char comm[sizeof(current->comm)];
+
+		memcpy(comm, current->comm, sizeof(comm));
+		pr_warn_once("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
+			     comm, current->pid);
+	}
+
 	fsi->state->checkreqprot = new_value ? 1 : 0;
 	length = count;
 out:
-- 
2.24.1

