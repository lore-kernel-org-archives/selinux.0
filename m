Return-Path: <SRS0=ebWe=YZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62ACA9ECF
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0FA2053B
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="h7So7yrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKAPZz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:25:55 -0400
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:45261 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfKAPZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Nov 2019 11:25:54 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 11:25:54 EDT
X-EEMSG-check-017: 23201662|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,256,1569283200"; 
   d="scan'208";a="23201662"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Nov 2019 15:18:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572621530; x=1604157530;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IfP7eKN6lx0hkK30P7E59WHWned0bjng0PfPeUpxr+g=;
  b=h7So7yrjAwJDGFAbCV8N1g+qHL53l6sPltAelA7TaN8zTbQbbnNfl98G
   lckHSOZKnYPlZ1KH8AqpiSGcKvN+UZZGUXY6AVJq77Sfj1GdOI7yTljcx
   3k9KIcr12g0/S1lVCr2DDTkgxgQaVgAUu4RX53l0/nxOUOO8VqULZ1M47
   G4T1eM5TtpXuIji0YhUFOU1I7tlUK/r3UEad/IjWNWUiGmAx0JoubmZ3Z
   iEyLDxLoIO+ALap9IS0tadbi//011+Np3aprIoXvnf+g1nVkcYp0PFojJ
   8OLwj/5cGeGibyP2i7sPsAWtLLkPHWKTfAso6yuIeyafdDj4uZTYE8wPt
   A==;
X-IronPort-AV: E=Sophos;i="5.68,256,1569283200"; 
   d="scan'208";a="29660746"
IronPort-PHdr: =?us-ascii?q?9a23=3APMynchIU25EMaqTgHNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgRLPzxwZ3uMQTl6Ol3ixeRBMOHsqkC0rKJ+P+7EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm6sQfcusYUjIZsN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhykdNz497WrZlMp+gqxGqx6lvhByw4rZbISTOfFjfK3SYMkaSH?=
 =?us-ascii?q?JBUMhPSiJPDICyYYwAAOQOJutUs4rwqkESoRakGQWgGOXiwSJIiH/s2q061v?=
 =?us-ascii?q?wsHwXc0wwlAd0Oq2nfocvvO6cITeC60rPIxijEYvNU1zby9JLHcgo9of2SRr?=
 =?us-ascii?q?9wbcrQxlUvFwPClFmQr5flMCmP2uQCtGib8fNtWOSygGAkswF8uiWjy8gjh4?=
 =?us-ascii?q?XTho8Z10rI+Tt2zYorP9G0VUh2asO+HpRKrSGVLY52T9snQ2FvpSk11KULuY?=
 =?us-ascii?q?W+fCgW0JQnwAPfa+Cff4iI/B3jUOGRLC9khH1/YrK/hguy8VO6xu3gVsi7zF?=
 =?us-ascii?q?ZKri1fntnKqn8NzADc5tKCSvt8+ketwTeP1wbN5eFYOU04iKXWJpE7zrMwi5?=
 =?us-ascii?q?Yfq1rPEyDolEnskaOabkAk9fKp6+TjbLXmvJicN4pshwH8PKUhhtawAf4kMg?=
 =?us-ascii?q?QQRGWb5eS926Hj/U3+WrlKiOY2nbPDvJDVIsQbuLa1AxVJ3YY79xa/EzCm3c?=
 =?us-ascii?q?wDnXYZKFJFeRSHj5XmOlzVPvD4Aumwg062nDdo2f/GJLvhDYvJLnTZl7fhZ7?=
 =?us-ascii?q?l9uAZgz18owNRe4Y9EIq8OLei1WULrstHcSBgjPF+a2eHiXfd0044FEUmGGL?=
 =?us-ascii?q?OUKuuGs0CD7/gzecGQdYQVv3D7MPFj6Pnw2yxq0WQBdLWkiMNEIEuzGe5rdg?=
 =?us-ascii?q?DEMHc=3D?=
X-IPAS-Result: =?us-ascii?q?A2ACAQA7TLxd/wHyM5BlHQEBAQkBEQUFAYFrBgELAYFzL?=
 =?us-ascii?q?IFAATIqkzRUBosZj0eBewkBAQEBAQEBAQEbGQECAQGIPSQ2Bw4CDgEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOymDGwsBgheCYz+CUyWxUoF0M4VOgz2BSIE2AYc3hFmBE?=
 =?us-ascii?q?IEHgRGCZGxphCmFIQSBOwGLTYhQgheWAgaCKJUpDBuZZAGqFQUtgVgrCAIYK?=
 =?us-ascii?q?YFogU5QERSDPo4qJQMwgQUBAY1lAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 01 Nov 2019 15:18:49 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA1FIlF6026308
        for <selinux@vger.kernel.org>; Fri, 1 Nov 2019 11:18:47 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: Report disabling an optional block only at high verbose levels
Date:   Fri,  1 Nov 2019 11:19:03 -0400
Message-Id: <20191101151903.15554-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since failing to resolve a statement in an optional block is normal,
only display messages about the statement failing to resolve and the
optional block being disabled at the highest verbosity level.

These messages are now only at log level CIL_INFO instead of CIL_WARN.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_resolve_ast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 70a60bdf..87575860 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3761,14 +3761,16 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 		enum cil_log_level lvl = CIL_ERR;
 
 		if (optstack != NULL) {
-			lvl = CIL_WARN;
+			lvl = CIL_INFO;
 
 			struct cil_optional *opt = (struct cil_optional *)optstack->data;
 			struct cil_tree_node *opt_node = opt->datum.nodes->head->data;
-			cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
 			/* disable an optional if something failed to resolve */
 			opt->enabled = CIL_FALSE;
+			cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
+			cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
 			rc = SEPOL_OK;
+			goto exit;
 		}
 
 		cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
-- 
2.21.0

