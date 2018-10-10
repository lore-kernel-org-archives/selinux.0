Return-Path: <SRS0=0uKS=MW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B2C43441
	for <selinux@archiver.kernel.org>; Wed, 10 Oct 2018 18:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D948D2087A
	for <selinux@archiver.kernel.org>; Wed, 10 Oct 2018 18:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D948D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJKBjo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:39:44 -0400
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:32246 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbeJKBjo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Oct 2018 21:39:44 -0400
X-EEMSG-check-008: 88352464|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Oct 2018 18:16:17 +0000
X-IronPort-AV: E=Sophos;i="5.54,365,1534809600"; 
   d="scan'208";a="19260497"
IronPort-PHdr: =?us-ascii?q?9a23=3AgAkuah/0JGwGv/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B41uwcTK2v8tzYMVDF4r011RmVBdqds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+55/ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMsPsTbAwRD?=
 =?us-ascii?q?+s8aFlRhH1gysDLjI17n3bhsl2galGohyuugZ/zpbUbo+LKfRwcKDTc9QBSG?=
 =?us-ascii?q?ZdQspcTTBND5mgY4cTCecKIOZWr5P6p1sLtRawGBWsC/33yj9ImHD227Ax3f?=
 =?us-ascii?q?kkEQ7c2AwgG8wBsXTJp9jyL6cdTPu1wbLUzTTDc/xW2TD95JLOchA6u/6AR7?=
 =?us-ascii?q?1wcc3PyUQ2EQ7Ok1aeqZT9Mj+I2ekAvHKX4up9We61lWIqpB99riKyysoql4?=
 =?us-ascii?q?LHnJgaykre+iV82Is1INq4R1NlbtO8C5tQsj2aN5NxQsM/X2FkoCY6xaMCuZ?=
 =?us-ascii?q?68ZCUK1I4oxwTea/yaaIiE+A7jVeaNLjd4g3JpYrS/iAqp8Ue80OH8U8i00F?=
 =?us-ascii?q?JSoipElNnDqGwN2gTO5sWIRfZx5Ees1SuV2wzN5exIP1o4mbfDJ54k2LEwl5?=
 =?us-ascii?q?4TsUrZHi/xnUX7lLSWeVg/+uWz9+TmYqnppp+bN4NujAH+Kb4hltawAeQ/LA?=
 =?us-ascii?q?gCR3Kb9vik1L3/4U35R61HjuYonandsZDaI9kbp6GiDg9L3YYs9Qy/Ay2l0N?=
 =?us-ascii?q?sGh3kHKkxKeBadg4juIVHOL6OwMfDqmFmokTF219jaL7bhBdPLNXGFn7D/Of?=
 =?us-ascii?q?5m5kpdzhcj5c5Q6ogSCbwbJv/3HEjru4/2FBg8Zjeozv7nBdM17YYXXWaCE+?=
 =?us-ascii?q?fNK6/JmUOZ7eIoZe+XbckavyireKtt3OLnkXJswQxVRqKux5ZCLSrgEw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2AEAwBGQb5b/wHyM5BlHAEBAQQBAQcEAQGBZYFVBSqBZ?=
 =?us-ascii?q?SiYPk0BAQEBAQaKNI4TgWYgGAGEQIRSITgWAQMBAQEBAQECAWwogjYkg1QLP?=
 =?us-ascii?q?4EAEoJiPykBgUsNpw2Ed4RkhxyEHxd5gQeDdoR5ARIBhXcCngYJkEYLF4FPh?=
 =?us-ascii?q?GmJUgGJE45SIWRxKwgCGAghDzuCbJBxIzB7AQGJI4I+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Oct 2018 18:16:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9AIGGbp003952;
        Wed, 10 Oct 2018 14:16:16 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@tycho.nsa.gov, selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] README: Update the SELinux mailing list location
Date:   Wed, 10 Oct 2018 14:17:54 -0400
Message-Id: <20181010181754.19044-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.14.4
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 174551a1..1c009b01 100644
--- a/README
+++ b/README
@@ -1,5 +1,6 @@
-Please submit all bug reports and patches to selinux@tycho.nsa.gov.
-Subscribe via selinux-join@tycho.nsa.gov.
+Please submit all bug reports and patches to selinux@vger.kernel.org.
+Subscribe by sending "subscribe selinux" in the body of an email
+to majordomo@vger.kernel.org.
 
 Build dependencies on Fedora:
 yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig xmlto redhat-rpm-config
-- 
2.14.4

