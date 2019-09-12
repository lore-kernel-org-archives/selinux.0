Return-Path: <SRS0=e2dy=XH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20120C4CEC7
	for <selinux@archiver.kernel.org>; Thu, 12 Sep 2019 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97EB20830
	for <selinux@archiver.kernel.org>; Thu, 12 Sep 2019 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lxwHq5yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfILS2p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Sep 2019 14:28:45 -0400
Received: from UHIL19PA35.eemsg.mail.mil ([214.24.21.194]:42229 "EHLO
        UHIL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfILS2p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Sep 2019 14:28:45 -0400
X-EEMSG-check-017: 24556156|UHIL19PA35_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,498,1559520000"; 
   d="scan'208";a="24556156"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Sep 2019 18:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568312922; x=1599848922;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kolkt7GJxjCO7MIX0RxOcdf0Npm32UX53hnsEDazjR8=;
  b=lxwHq5yWlgJNe9Eh222Kb5u57deJVU9zcnlrdpsrOUVF9bGgDvR0Mp7U
   a4h/TD5Jiz1p83WC7qC1YRlLGAZQd5FhwxckXrjegHG8CEjWTAwV3j2Mj
   kfIVFzto8IIomP7SxNRu+jXEaK5z72V4DYEEQG+S7QSkRZ88Wi920IBkL
   9XrV5cOjRkoOCqL1smrs//8/fl28pASPOHiqqfmJ7dWSWVvLT0gwFYGq0
   XQ6ZWsCoQQjab7hvq30NsY5rri25SPHVnq23dH+X6Gacr0YxmsDQ8KTJN
   miLrN+FYisqYebQRY6khROD4aB9zZl9TtJaEG1v8OBsDIyBzG1sh9nyor
   w==;
X-IronPort-AV: E=Sophos;i="5.64,498,1559520000"; 
   d="scan'208";a="32779496"
IronPort-PHdr: =?us-ascii?q?9a23=3AN2/W1RxD4rR7eL7XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd1OMQIJqq85mqBkHD//Il1AaPAdyAraoZwLOM6eigATVGvc/b9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMuMQam5duJ6Y+xh?=
 =?us-ascii?q?fUvHdEZfldyWd0KV6OhRrx6dq88IB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdtwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMOhcooX4oVYFsBmwChS2BO73yjFGmGL406M53e?=
 =?us-ascii?q?omHg7I0xctE84NvXnOsNn4LrseXfyzwaLVzTvDdfRW2TLl5YbMaB8hpO+DXa?=
 =?us-ascii?q?ltesfP00YvDR/FgUuKqYf4OD6V1OoMvHSB4Op6SeKjlXUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZsp7bKtgBqa6jHw9ZzJ0u6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFReeB2dlYTpNFbOIO7gAfeln1usiCtrx+zBPrD5GZXCMHzDkLbnfb?=
 =?us-ascii?q?Zg5E9R0xQzzd9B6JJOEL0BI+z8WlX3tNPGCh81KQu0w/zoCIY16oRLQm+LA6?=
 =?us-ascii?q?mEIIvMvlKSoOEiOe+BYMkSojmuBeIi4qvMhHo0ghc2dLO10IFfPHKnFf18Px?=
 =?us-ascii?q?+xfWvngtBHF3wD+AU5Urq52xW5TTdPaiPqDOoH7TYhBdfjVtbO?=
X-IPAS-Result: =?us-ascii?q?A2DmAABQjXpd/wHyM5BmHgEGBwaBVAgLAYFoBSqBPwEyK?=
 =?us-ascii?q?pMhTQEBAQEBAQaLKY8rgXsJAQEBAQEBAQEBGxkBAgEBhx4jNQgOAgwBAQEEA?=
 =?us-ascii?q?QEBAQEGAwEBbIU6gjopgxULAYIXgmM/gXcUrEszhUuDL4FJgTSHH4RZgRCBB?=
 =?us-ascii?q?4N1bIURhRYEgS8BiyKKPpU3BoIllGsMG5kJAaN0hHUBNYFYKwgCGClKgR6BT?=
 =?us-ascii?q?oNpAQ6NKyQDMIEGAQGPIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Sep 2019 18:28:39 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8CISdkF022661
        for <selinux@vger.kernel.org>; Thu, 12 Sep 2019 14:28:39 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: Make an unknown permission an error in CIL
Date:   Thu, 12 Sep 2019 14:30:35 -0400
Message-Id: <20190912183035.2946-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch is loosely based on a patch by Yuli Khodorkovskiy
<yuli@crunchydata.com> from June 13th, 2019.

Since any permission used in the policy should be defined, CIL
should return an error if it cannot resolve a permission used
in a policy. This was the original behavior of CIL.

The behavior was changed over three commits from July to November
2016 (See commits 46e157b47, da51020d6, and 2eefb20d8). The change
was motivated by Fedora trying to remove permissions from its
policy that were never upstreamed (ex/ process ptrace_child and
capability2 compromise_kernel). Local or third party modules
compiled with those permissions would break policy updates.

After three years it seems unlikely that we need to worry about
those local and third party modules and it is time for CIL to
give an error like it should.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_resolve_ast.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index ea08087d..863d9fe8 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -131,18 +131,14 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
 				}
 			}
 			if (rc != SEPOL_OK) {
-				struct cil_list *empty_list;
 				if (class_flavor == CIL_MAP_CLASS) {
 					cil_log(CIL_ERR, "Failed to resolve permission %s for map class\n", (char*)curr->data);
-					goto exit;
+				} else {
+					cil_log(CIL_ERR, "Failed to resolve permission %s\n", (char*)curr->data);
 				}
-				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
-				/* Use an empty list to represent unknown perm */
-				cil_list_init(&empty_list, perm_strs->flavor);
-				cil_list_append(*perm_datums, CIL_LIST, empty_list);
-			} else {
-				cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
+				goto exit;
 			}
+			cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
 		} else {
 			cil_list_append(*perm_datums, curr->flavor, curr->data);
 		}
-- 
2.21.0

