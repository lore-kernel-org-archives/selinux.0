Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EFC4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFEC222C0
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="L273WoJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfIZMw0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:52:26 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:59313 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZMw0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 08:52:26 -0400
X-EEMSG-check-017: 17240770|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="17240770"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 12:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569502343; x=1601038343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i5FKG32i5EstQItxWk94bCCYLK6jcZBqgZqnfQDUXKA=;
  b=L273WoJAh4uc+8n0/cefLRzWHWpqDqWFZuWnZxaHLUgjezKB1BQ8aRf3
   6zEJ3/L9KAejDFn/fk7CvpppP/C66wjkXzGtaY0v00TD6NPezQu+Wt/mz
   u2iRggyph5KauJvlCTzTUwFJuy4rwdVtFznlv7SsoN2HTrzH7gPAoaTXh
   c57VTRCQq7M5WaK7kDmcLn11WnzW4+c7CWX3U8/iNneituXs3tD0pGMrm
   UwI3oeY0BIFY+S0CrsczlpG/4cxqdl5KOhZXWpphfdM9F2dRKev2CYcAb
   gNl2oLlnpjymtYFHiQfuQnzJ01koje9IJidhmxoe91IEzS3hSqioyZhY/
   w==;
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="28346025"
IronPort-PHdr: =?us-ascii?q?9a23=3ArGRNwBY5XIXKHmksTLR25a//LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZoMS+bnLW6fgltlLVR4KTs6sC17ON9fu8EjFbqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsowjcucYajItsJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlSkINyQ98GrKlMJ+iqxVqw+lqxBmzYPZZISZOfxjda3fYNwaX3?=
 =?us-ascii?q?JMUMZPWSJcDI2ybIwBAOUOM+tDs4XwpEEDoQekCAWwGO/izCJDiH/s3a091u?=
 =?us-ascii?q?QsCRzI3BA+ENIWsHTbstP1P7oPX+Cw1qbIyTHDYO1W2Dzg74XIaQ0uoeqXUL?=
 =?us-ascii?q?Jsccve1UkvFwTfglWWsozqJSmZ1usKs2iF9udtU/+khWAgqwF0uDevx8Esh5?=
 =?us-ascii?q?HGhoIU1lDE9Th5z50vKdKkT057ZNipG4ZTuSGCL4Z6X8wvTm5ytCs617EKo4?=
 =?us-ascii?q?C3cScUxJg92hLSbeGMfZKS7RL5TumRJC91hHdieL2imRm/6VOgyujgVsms11?=
 =?us-ascii?q?ZKszZFnsHMtn8T0xzT7dCKSudn8Ue72DaPyhvT5vtYIUE0iaXbK5khzqQ2lp?=
 =?us-ascii?q?UPqkTMAjX6mED3jK+Sbkkk++6o5Pr7Yrj+u5OROIB5hhv+P6gzgMCzH+s1Ph?=
 =?us-ascii?q?YUU2SG4ei80afs/Uz9QLVElP02lazZvYjBJcsGva60GBNV04Y/5Ba/CDeqyt?=
 =?us-ascii?q?IYnWIdI15fdxKHiJbpN0nUIP/kFfe/n0iskDBzyvDdILLhBpTNLn7ekLbuZr?=
 =?us-ascii?q?t99UFcxxQpzdxF5JJbFKsBIPTtVU/1rtDYCQU5MwPni9rgXc5w0oIYRHKnHK?=
 =?us-ascii?q?CUKuXRvEWO6+ZpJPODN6EPvzOoEOQo//7jizcCnFYZeaS4lc8MZGuQAuVtI0?=
 =?us-ascii?q?LfZ2HlxNgGDzFZ7UIFUOX2hQjaAnZobHGoUvd5vWA2?=
X-IPAS-Result: =?us-ascii?q?A2B6BQBAs4xd/wHyM5BmHgEGEoFcC4F0Km1TMiqTfAEBA?=
 =?us-ascii?q?QEBAQaLK48tgXsJAQEBAQEBAQEBGxAJAQIBAYN6RYMzIzQJDgIMAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFLQyCOimDIAFGgVGCYz8BgXYUD7AkhUyDO4FIgTSHM4RZGHiBB?=
 =?us-ascii?q?4RhgmECgSqBBIUWBK0QgiyCLoRXjXkMG4MolgIBli6SfDiBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?wlHEBSFQIVlhQokAzCBBgEBiyCCVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Sep 2019 12:52:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QCqLaQ003871;
        Thu, 26 Sep 2019 08:52:21 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] python/sepolicy: call segenxml.py with python3
Date:   Thu, 26 Sep 2019 08:52:18 -0400
Message-Id: <20190926125218.22958-1-sds@tycho.nsa.gov>
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
 python/sepolicy/sepolicy/interface.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 583091ae18aa..b1b39a492d73 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -196,7 +196,7 @@ def get_xml_file(if_file):
         from subprocess import getstatusoutput
     basedir = os.path.dirname(if_file) + "/"
     filename = os.path.basename(if_file).split(".")[0]
-    rc, output = getstatusoutput("python /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
+    rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % basedir + filename)
     if rc != 0:
         sys.stderr.write("\n Could not proceed selected interface file.\n")
         sys.stderr.write("\n%s" % output)
-- 
2.21.0

