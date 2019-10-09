Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E358C47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ADA20B7C
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dkvlmN3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfJIOUf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:20:35 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:49525 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOUe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 10:20:34 -0400
X-EEMSG-check-017: 35220246|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="35220246"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Oct 2019 14:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570630833; x=1602166833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d2azdq9tjJjwV9XjURlDxTY7r7O2zHljmh88+Dkb/io=;
  b=dkvlmN3pUspzh+E9ucMWfKNZskioMqrRPF0Bpd6xQw4TkXxOTJ74RX0x
   StqA8MzRDSYKPQvbCudk9aipr7zKK1fc1F9nNlwUv3788K9XipY9OQK72
   tl2WtKRgOHUEsy+npbs6Y+L8spZ1Ttel+GH7u72Nv2KD/t3Hlra0Si+Eh
   Oevo6vB4jIbD5RACaJRZxaYDz/SRjcESegBARkc1bmLpEe5P/lGWZ0iNY
   PeFsLjn7wV37qRROvrswIj9r1iWYWh7udz471sR9t2UMeUYChlUuTJlRY
   v1FSGKn1IYCTwlQ+nX5AH1i9lqqUpjki6HN0TNNTCqR+fqls7U4Rxq3Ay
   w==;
X-IronPort-AV: E=Sophos;i="5.67,276,1566864000"; 
   d="scan'208";a="28812121"
IronPort-PHdr: =?us-ascii?q?9a23=3ARVkYYx9C+mfeOf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32uwcTK2v8tzYMVDF4r011RmVBN6dtasP1rKempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC8bL9vIxm7rRndvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/4ahrUhvogzoZOTA//m/cl8h8gLtVrR+lohByxZPfboOIO/pkZq7Tfc0US3?=
 =?us-ascii?q?dPUMhSUCJODYyyYpATA+cCJ+tUs5Pwq0cSoRa4GAKiBPnvyjhNhnLuwKM6z/?=
 =?us-ascii?q?ouERnG3AM+GdIFrWnarNDvO6cWVeC60qnJxijEYvNNxDj985PFcgwhoP6QXb?=
 =?us-ascii?q?JwdtDdyU80FwzflFmQpovlPy2M2+kLrmOV4e1gVee1hG4mrQF8ujevxsYwio?=
 =?us-ascii?q?nJm4Ia0UrI+jl+wIYwI9CzVU11Yca8HZdNuCyXOJF6T8M/T21ypio3xaMKtY?=
 =?us-ascii?q?SmcCUM1Z8p3QTQa+adfIiN+h/jUeGRLipmi399Y7K/ggqy8VCnyu3hSsm4yF?=
 =?us-ascii?q?ZKoTRBktnLrn0Nywbc6tKGSvtg5UetwyqP1gDP5eFEJkA4j6zbJII6wrEsjJ?=
 =?us-ascii?q?YTtEXDHivulEX3iq+ZaFkk9/C15+nobbjqvJ+RO5Juhg3gPakihNazDfkgPg?=
 =?us-ascii?q?gLRWeb+OC81LP5/U3+RbVHluY2nbTCsJ3BOcQaprK2Aw9S0oo57Ra/FC2p3M?=
 =?us-ascii?q?4XnXkAMlJJYAiHgJTxO1HSPPD4Cu+yg0yokDhx2vDGIqfhDY7XIXXYirfuY6?=
 =?us-ascii?q?ty605Gxwov19xQ+5VUCrQZKvLpRkDxrMDYDgM+MwGsxebnCcly1oQaWW2VGa?=
 =?us-ascii?q?+VKqLSsViP5uI0OOmBf4oVtTnyKvQ/4P7ul3A5k0cHfaa1xZsXdGy4HvN+Lk?=
 =?us-ascii?q?WCf3XshtYBEWEXvgsxV+HqllKCXiBJZ3qoXKIz+Cs7CIS4AofHXIyth6aB3C?=
 =?us-ascii?q?joVqFRM3tLDlGKDGfAaYqJQbEPZTiUL8snlSYLBpa7TIp07g2jrA/3zfJcK+?=
 =?us-ascii?q?PQ/iAJ/cb42MNd+/zYlRZ08yd9ScuazTfeHClPgmoUSmpuj+hEqktnxwLGiv?=
 =?us-ascii?q?l1?=
X-IPAS-Result: =?us-ascii?q?A2DPCAD96p1d/wHyM5BlHgELHIFwC4F0Km1SATIqk1AGi?=
 =?us-ascii?q?y6PM4F7CQEBAQEBAQEBARsQCQECAQGDe0WCUSM0CQ4CDAEBAQQBAQEBAQUDA?=
 =?us-ascii?q?QFshS0MgjopgyEBRoFRgmM/AYF2FA+xVIVNgzCBSIE0hzWEWRh4gQeEYYJhA?=
 =?us-ascii?q?oEqgQSFGQStQ4Isgi+EWY4FDBuDLJYUlk+TDjmBWCsIAhgIIQ+DJwlHEBSFQ?=
 =?us-ascii?q?oVlhQolAzCBBgEBkQmCVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Oct 2019 14:20:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x99EKU5R016518;
        Wed, 9 Oct 2019 10:20:30 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, plautrba@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] python/sepolicy: call segenxml.py with python3
Date:   Wed,  9 Oct 2019 10:20:24 -0400
Message-Id: <20191009142024.9278-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fixes: https://github.com/SELinuxProject/selinux/issues/61
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 wraps basedir + filename in parentheses as per Nicolas Iooss' suggestion.

 python/sepolicy/sepolicy/interface.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 583091ae18aa..187419fa7822 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -196,7 +196,7 @@ def get_xml_file(if_file):
         from subprocess import getstatusoutput
     basedir = os.path.dirname(if_file) + "/"
     filename = os.path.basename(if_file).split(".")[0]
-    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
+    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % (basedir + filename))
     if rc != 0:
         sys.stderr.write("\n Could not proceed selected interface file.\n")
         sys.stderr.write("\n%s" % output)
-- 
2.21.0

