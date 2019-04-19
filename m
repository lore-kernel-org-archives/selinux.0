Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0EC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1019A21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="royU8HOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfDSAqa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:30 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:45945
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfDSAqa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634789; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=royU8HOBj1RogF08UJmD7RTmxVn1sxkSpUNfj6Sc7KqEq9zLVW7kElntGqvRbdYl1JMrkbTQuLwr4aguOu6yi1RmiXDkMzTvaxr0/d5vwK8fIM6SAOMiWupH8QqjjG1V8vyLLH6AVq3UcDsv0KfpPNwnJIkyDMAG9XsP12viBHX9ILKBhtTGkXAu+Mta2xTxf2NFiykCE1mSSL/kgmjo5SloiMw3oATRrPeiUC/IXverNe1jsBG61+2IBacy0LOvaCao8P0t3z53KT7Of/nbnbszMQQjKzu6+mKpFdy8PwXVKQgCFZh9B5w3Nd+gQdKVS74ykIQtSpUGK++duwabhQ==
X-YMail-OSG: GsJJH54VM1lQvmCcBjisXnYJEsEzLp5MYCDxIz9y4VDvE0BFjeDajr8NQHJIYgX
 Ok0rmL1lqHNzgax5r0UEKt.9ywPw_FGc4HFkSqGSuU482mdDQiksAoLBvJCUCGHRUqH4Dl.hKZOR
 ynKyT6iQNrQtbGhQMzxMRHhNRCnJo0bs.aHESI5pGECR3LVELmh5yHeXdyA3gF6eAvJpePcKJyWW
 ky9eYydpL.DqxSvTChqJYEgE61pgObMCcZYhwDAx9CKb.BXObw_AIZuIXBFtjDnaS2CZcfvPTWE3
 _7.BH7_fcy56a6pf9x0QWi1Nb6Z96s_WpR5X6z73ae0EjgakOIn_u4Qyq72sNyagDY47IaPI2_ei
 DzYCX2f6weCaVlprmDJzvNDzujSoVoXNv0kwOt3nN9xwmpBp5esoo64jbSSXn22a4W1Hy3Jvcupr
 bhtIoKOi5P3msYOK967eszgvBdCOrtiVrza_4IbtXMmjS42ZvqjPeSoMoJbHsxutE9ghh5eX7ghM
 O3gCnTXpmm84Ux.mq.wta4xBR6K0eZeTEDwuwGTP.b8v9pYYUKYNgFYHhdvB0D9AeTCCgRzPe7Kl
 A7dYMYz78KDx_PJet.BIktSMz450VU_ubdevHT4Xz639DoP2ZxMUUiZHMd94hAIDhtxZZDaUBtZm
 agaxAqysyuRhfwASqXSY_6TePs3rceUvk08UMzEXJ_mbXoMoTMO0xm71YHuyun1gEWHzcaue2MBh
 m6VRiUlkqR9OV1QLfEkMazX9B8ZtPOHN9KR.JtoTK7ijr5Ub1Njg8EC81QC4HiOuIdEDYU3lYjkD
 A6DzWAaDOUmpMAs60A5brb44WdSVw._tLwoRFCmC9dqZS2yWxgSTzQkZV1vcvwSziHVYunPTT3QW
 nNBWhVuKtCrmr3gh9viN5Sbix5x2hZlJ9qRjuj7iueTP_369wyb8t5.CNnQmKlnNj4Po91kvy05n
 I_thAbdE26k1YZV2clJlYxM3slQJjtk8D8lMu0nzxjfWAnToBbattZJPpuZtdEQbeUgFzoChBZbC
 7h1Y38feou9eQduofR_gJ7fVtdadRWHt80rJDXjbGq06liTkBGqADbJ2hr7qPnUtg60MVsI4g8NL
 rs7wH7FU.o6HwDw_nAa1iSxMetbcGy6bXjUWUCe_zz4v_Q_h_QGRD.Kuie4.G93dxiAPleFaCHgm
 7jOKNkp3n
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:29 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cf1bd369acc816a9d15b1740f4265439;
          Fri, 19 Apr 2019 00:46:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 04/90] LSM: Create an lsm_export data structure.
Date:   Thu, 18 Apr 2019 17:44:51 -0700
Message-Id: <20190419004617.64627-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..81f9f79f9a1e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/* Data exported by the security modules */
+struct lsm_export {
+	u32	selinux;
+	u32	smack;
+	u32	apparmor;
+	u32	flags;
+};
+#define LSM_EXPORT_NONE		0x00
+#define LSM_EXPORT_SELINUX	0x01
+#define LSM_EXPORT_SMACK	0x02
+#define LSM_EXPORT_APPARMOR	0x04
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

