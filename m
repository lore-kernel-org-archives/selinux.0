Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCEC43381
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7BC20854
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RUPZm790"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfCSNVh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:21:37 -0400
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:34769 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfCSNVg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 09:21:36 -0400
X-EEMSG-check-017: 198289503|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Mar 2019 13:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1553001692; x=1584537692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=figF2tHzy7DP3pDHjBrC5b3pZF158cNinFRWDE0jZMo=;
  b=RUPZm790QM5TfWJS8BQC7IP1IHVfSmVbhUWxox+njLdPxyis6852PELE
   Ckobk8t91A+VHLS6fjiomUxtYFsFnr+KdXlHdAA00ROFrZOVGvmxdyVRe
   vH1cqRB09Ejo8O9VD5A0BGpUrsj2uw9jj6cZ9uIzyQAIv5KtsxocjcMp0
   4qym5IafQJXWS1S629FyXrV8/UYjlaI2ews+3pJhJGvq9et4wPVdDY21z
   4Y8+kq1tZZWFahbKj6yL+GC2Yb1X+5U7Emc4uZJehYJrRMH5J5oPt75XI
   SXL+u9bqL53dCut24+MY/sE1nsTgALzsUl9dy2ZMWcnv7Muxt5HCTLocN
   A==;
X-IronPort-AV: E=Sophos;i="5.58,498,1544486400"; 
   d="scan'208";a="25211971"
IronPort-PHdr: =?us-ascii?q?9a23=3A/4eqMxCwGLc8KkrZXhqcUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPT/pMbcNUDSrc9gkEXOFd2Cra4d06yO6ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVmDaxe69+IAirpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs7Vy?=
 =?us-ascii?q?6i76N2QxH2jikJOSMy/GXOhsF+iK9XpRSsrAF9zYHJeoGYLPpwcL3Ac90URm?=
 =?us-ascii?q?RPWcleWSNaD4+gbIYCFfYNMPxEo4XhoVYFsBuwBROrBOPq0jJGm2P20rMi0+?=
 =?us-ascii?q?QhDw7G2hErEc8LsHvOqNX1MLkdUOCox6TP1jXMcuhW1Czh6InIbh8hofaMUa?=
 =?us-ascii?q?h2ccrK00YjDQzFjlKOqYH8OT6ey+cDs3CD4uZ9Wu+ihHQrpgFsrjS12MshhZ?=
 =?us-ascii?q?fFipgIxl3C6C532pw6JceiR05+edOkFZxQuDyEOIZuWcMiRn1ouD49yr0bpZ?=
 =?us-ascii?q?63ZCgKx4ojxx7Yc/GHb5KH4gjiVOaMOjd0nm5lebKjiBay9kis0Ov8WdWv0F?=
 =?us-ascii?q?lWtCZFl9jMtnQV2xzS7MiIVOd981+81TuA2A3f8OFJLV0umabFJJMt3KQ8mo?=
 =?us-ascii?q?cLvUTGBCD2mUH2jKGMdkUj/+il8//nbaj9ppKHK491ih3xMqQpmsClB+Q4KR?=
 =?us-ascii?q?IBU3KU+eS7yr3v5Vf5T6lSjv0qjqnZt4jXJd8Vpq6jGAJazpws6xCkADu8yt?=
 =?us-ascii?q?sYgGQHLF1fdBKAlYjpNEvCL+rlDf2nmVSjjC9rx+zaPr3mGpjNNWbMkLPgfb?=
 =?us-ascii?q?Z79k5dxxE+zc5Q551KELENOvHzVVHrtNzeEBA5Nxa4w+H9CNVyzokeQ36AAr?=
 =?us-ascii?q?eFMKPOtl+F/vovLPORZI8Rozv9M+Iq5+PqjXMgnF8deq6p3YEJZ3yiAvtmJE?=
 =?us-ascii?q?CZMjLQhYIZGHoOlhI3UeivjVqFSzMVbHG3DIwm4TRuM56rFYfOQMiWhbWF2C?=
 =?us-ascii?q?qqVslNantuFkGHEXCucZ6NHfgLdnTBcYdajjUYWO35GMca3ha0uVq/kOtq?=
X-IPAS-Result: =?us-ascii?q?A2BFAAAq7JBc/wHyM5BjHQEBBQEHBQGBUQgBCwGBZiqBO?=
 =?us-ascii?q?DMnjCeLdgEBBAaKdo5xgXsgGAGEQIRtIjQJDQEBAwEBAQgBAwIBbCiCOimDI?=
 =?us-ascii?q?AFGgVGCYz+BaQ2rCoVGhHiBLwGGaIRIF3iBB4htgQSFFAOkaQmLZIc8DBmTX?=
 =?us-ascii?q?QGffjiBVisIAhgIIQ+DJ5BnIwMwgQUBAYZhgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Mar 2019 13:21:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2JDLRl1029532;
        Tue, 19 Mar 2019 09:21:27 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, sfr@canb.auug.org.au,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] scripts/selinux: fix build
Date:   Tue, 19 Mar 2019 09:21:06 -0400
Message-Id: <20190319132106.21127-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We need to add the object tree include directory to the include path
for building mdp in order to pick up generated/autoconf.h. Otherwise,
make O=/path/to/objtree breaks.

Fixes: e37c1877ba5b ("scripts/selinux: modernize mdp")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 scripts/selinux/mdp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/selinux/mdp/Makefile b/scripts/selinux/mdp/Makefile
index e9c92db7e2a3..8a1269a9d0ba 100644
--- a/scripts/selinux/mdp/Makefile
+++ b/scripts/selinux/mdp/Makefile
@@ -2,7 +2,7 @@
 hostprogs-y	:= mdp
 HOST_EXTRACFLAGS += \
 	-I$(srctree)/include/uapi -I$(srctree)/include \
-	-I$(srctree)/security/selinux/include
+	-I$(srctree)/security/selinux/include -I$(objtree)/include
 
 always		:= $(hostprogs-y)
 clean-files	:= policy.* file_contexts
-- 
2.20.1

