Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F03C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E1720720
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="St1G1WT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgAHRXr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:23:47 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:31111 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbgAHRXq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 12:23:46 -0500
X-EEMSG-check-017: 67252440|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="67252440"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 17:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578504224; x=1610040224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zn7OW3vnyZio5OIIt4Uy/LjHL0GDo2AZuCW2RBlmtM0=;
  b=St1G1WT/KEBVQ3xqMOtMK7uBWSKcb2E8ZuHEQjHJx3Psic+XNKKyArIl
   FEncYayXPtk6eRo4roXpxMSTdrxmG/KfuKyQ7KBzZdgC4i08vw86lnh9F
   pcnsFNmAtom4+3buLJyPbJfogjxYIwWkdmfvBx3v27ms3NkYBkRLOfalK
   gYb4MBgwoTMwzktFvYHtA0/BJ+rooN07Ca9hkG51NyLl5/5Hzjk42H7LL
   YCc+8LPJSj8ynyrPBJp31bx3zksYhVf923/QJjOVQJo5QVs2e2QuPwJZv
   aVlSHVUhlhJ9eg7FHvbQbKllUoi97r38gyRzwx8c59OF5mcTmEnRXUhPn
   w==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31729572"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ8+kCRR3qWzq9TjFvSwnFBjME9psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yYh2N2/xhgRfzUJnB7Loc0qyK6vumAzFQqsfe+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgYhvJqk1xx?=
 =?us-ascii?q?bLv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/2/Nisx0kalVvhSvqRJiyILQeY2YNP5zcqbbcNgHR2?=
 =?us-ascii?q?ROQ9xRWjRBDI2icoUBAekPM+FXoIfyvFYCsRizCBOwCO711jNEmnn71rA63e?=
 =?us-ascii?q?Q7FgHG2RQtEc8SsHvKtNX1NLkdUeaox6fVyDXMdfdW2TPj54nIbxsspuqMUq?=
 =?us-ascii?q?9rccfK1UkuFx/KjlWXqYD/OTOVzf4Cv3KU7+pnS+KikmgqoBxyrDi33sogl4?=
 =?us-ascii?q?bEi40Pxl3E6Cl12pg5KNKmREJhfNKpFoZbuTuAOItsWMwiRnlluCM9yrIbp5?=
 =?us-ascii?q?G2ZDMKyJE7xx7HbPyHbpSI7grjVOmPJTd4g2poeK6liBao8Eig1/b8WtO10F?=
 =?us-ascii?q?ZMoCpFlcLMuW4R2BDJ9siGSudy/kem2TqV0QDc9vpELlwumareKp4hxqY8lp?=
 =?us-ascii?q?sVsUvdAi/7gFj6gaCZe0k++uWk9v7rbqvpq5OCLYN4lxnyMqE0lcy+BeQ4PB?=
 =?us-ascii?q?IOX2+e+emkz73s4Fb5Ta5Wjvw2jqbZsJfaKd4dpq6iGQBZyIkj6xGhDzu+yt?=
 =?us-ascii?q?QXgWEHLE5ZeBKAl4XpPFTOIPfjDfe5mVujjClkyuvcPrL/H5rNLmLMkKv7cb?=
 =?us-ascii?q?lh7E5czRI5zcpD6JJMFrEBPPXzV1fqtNPGCh85Mgq0w/voCdhmyIMeVnyAAr?=
 =?us-ascii?q?WDPKPRr1CI/OQvLPeIZIMPvzb9Mfcl7eb0jXAlgV8dYbWp3ZwPZXCgBPtmPk?=
 =?us-ascii?q?GZbGH0gtgbDGcKuhMyTOntiF2FSz5ceWy+UL475jE+W8qaCtLbT52pqKSIwS?=
 =?us-ascii?q?P+G5pRfG0AAVeJQlnycIDRYOsBcCKfJIdalzUAUbWwA9s62QqGqB7xy70hKP?=
 =?us-ascii?q?HdvCIfq8Swh5BO++TPmERqpnRPBMOH3jTIEjB5?=
X-IPAS-Result: =?us-ascii?q?A2BdAADPDxZe/wHyM5BmHQEBAQkBEQUFAYFpBwELAYF8g?=
 =?us-ascii?q?W0gEiqNDIZdAQEBAQEBBoslj02BewkBAQEBAQEBAQEbHAEBhECCEDUIDgIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KYMzAUaBUYJjP4JTJa1whU+DPIE9gTYBhz+Ec?=
 =?us-ascii?q?3mBB4FHgxuEEoEEhSEEl2SXQ4JAgkWTUQwbgkeMQYtZAS2rDAE2gVgrCAIYC?=
 =?us-ascii?q?CEPgydQGA2bdiMDMI44gkMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 17:23:25 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008HMmYF057916;
        Wed, 8 Jan 2020 12:22:51 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: make default_noexec read-only after init
Date:   Wed,  8 Jan 2020 12:23:56 -0500
Message-Id: <20200108172356.35193-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SELinux checks whether VM_EXEC is set in the VM_DATA_DEFAULT_FLAGS
during initialization and saves the result in default_noexec for use
in its mmap and mprotect hook function implementations to decide
whether to apply EXECMEM, EXECHEAP, EXECSTACK, and EXECMOD checks.
Mark default_noexec as ro_after_init to prevent later clearing it
and thereby disabling these checks.  It is only set legitimately from
init code.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6777e04fd942..7834f0a4c2a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3650,7 +3650,7 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return error;
 }
 
-static int default_noexec;
+static int default_noexec __ro_after_init;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
-- 
2.24.1

