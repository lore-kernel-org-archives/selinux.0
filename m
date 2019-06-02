Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88558C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6134E2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LVo5p4TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFBQx1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:27 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:40402
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbfFBQx0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494405; bh=K172cq+NB5Z0YjmWFKPzhzudN0HRFKrT7HKe6u3/BmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LVo5p4TN1N2ORA84bDvRKV4uU7w90WE8lBTggB2/TnHkVuOt3PJKWGR19QMa6JPzTYv9uvQXA0blNCjy4EYp+fRCf20+JVUs4Hgx+UJAfP4R/2wKyuCpZICV3I2DqVpL1hFumeWctc+7gdI7mF+RiOnhrlMPLKa7De5QepEnSPnW2bWle/YI0H+S7aEIxNCgkoN48AKwxzm7hH3Eg4KNLHvBRE1pBbhEdYMqGppvACiZW4QRT8fvnDKCEntUZ0eWbuJJ0wgbvogcoRRSXIO6rvaSh5OTEscgPM5c9/2OlffsE8C0w2JrQ5KE3Y/CvjSOwmRxS7k1WQadPWk24pQaqA==
X-YMail-OSG: y9JupqQVM1lcoiwfRXcZhtOXqOX0lYs_su_lc8vG9XsbUo.UDGLUo8ow0yWE4PI
 m65dwKAsO2kGLXZKY2Q4qXBG629zcljCjY26cSpOKRFU0IOx.ePBYlZBmdzE7cUTXvCN8VbY23xH
 GfxwKYJPqN.s5exHbwQqcRUK8gfl8wEpYMXHPwMCoETSv8yumq83b0whhoQRDFdkYnTdYykIZkIC
 GJ_m02QuehoMN5CBxcNVs2z8MrGDyJQ.e7LFIhcqwIvgvyTOkuFPfCMZztq7bNeYNG.pR3qfWvet
 fcl5.Sf0v_U7foBPh5SjwufqRPs6VI4aDhZlibxmLbTmgWlXxf2wis3EWVlZqoALvLv1bpSdSmWF
 QgwUE6dCAoaRhKPwIpDA1k2PfoE1A27goblVB04PHlqFoiIfcbXgTqpaVLvHA832Uw8QSk1vfZ.q
 NOjLsUg3lZmFuiM4BBUpY_hJ.iSBPAa3YebnWs8U44U0K26nqOmGFnTWdsQF7mBbWgDf5PC_5dKi
 .OPRqgTexgGO3l2fTbAaEpvsYpfsh18DbKt0fr7dkKiDGdru8DjlbI1Fp7w8qAj7efIPSytc.aLj
 OJ2J.n2SBex6CoTxIUr0HGMVeSWTJf9E_ugeRJ75uMpllqWHuRDT2rfBZtEwBL9ZIH89IjXCsWVf
 sxc9h6ofuM3K_psm6ZDER5LhmRBy1ji2aN6q8iwDtXkutF3OhmoksNniXY5pDvzdBqvVEQ7L0oIR
 qMN90oRlc2rCV.xhutppc3qPN_3n9jqsZNuQAtQ_gPpnktTUJa6IsLS2gTuaKUbT0hYmyA0Hx3E9
 Ksb_B0WnNVzmvmV3eVRwEyKziHsZsrBsgM_XUjTanqTlDi7myOfKECnhAgi8G9HJlnD3e.W0JsW6
 sX1jFF2ZfBigKaHGJFaG95T7Jo5Zua5sVPqwkQCFJBmqOlbvIe0iRbkUfgHjgZv8raG8g5VIacVU
 nmTcBAWlNUU00cvOGQvcljSvUaHaoOT4eBwPe5URpxeo98St2D8V63LJPA7udNANBsg11_VwPrcz
 0n_RRMFYtT9WN4CgB889FkWovWLgCNBSAaSiRuarTTewudgicRcVvj9wrCHRJnZ5zOm39hJpsP4i
 zNIoHuHtWj1KNge6iP_7A2WBLLldEdBF1WBWrKOzZMBbHINwdPUsw.KBRFgcV8zsqAavGLPrZkxU
 U8wwWyzU.0xL.0l8flY5dsx8ERkf3HXfQgXEmji_misf7GzQY7FGy7bFnIqNwgn5VQ7kY4TXPYFu
 qVEtygVslk2dNWzakj1d6bDpbp9vOYq6B5pNx0bWBP8fvyV_jBMYA6g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 037f0ce5b74e0a8af50a9035f5845b74;
          Sun, 02 Jun 2019 16:53:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 36/58] LSM: Create a data structure for a security context
Date:   Sun,  2 Jun 2019 09:50:39 -0700
Message-Id: <20190602165101.25079-37-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A "security context" is the text representation of
the information used by LSMs. This provides a structure
so that the use can be made consistant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index dde36e850cf0..e12b169deed6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,17 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
+/* Text representation of LSM specific security information - a "context" */
+struct lsm_context {
+	char	*context;
+	u32	len;
+};
+
+static inline void lsm_context_init(struct lsm_context *cp)
+{
+	memset(cp, 0, sizeof(*cp));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

