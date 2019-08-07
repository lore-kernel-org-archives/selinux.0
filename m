Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076DDC32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BE82229C
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Wqe0z2Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfHGTpJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:45:09 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:45717 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389264AbfHGTpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207108; bh=briZ1G0thI3HOOe1UjduGGB1KgPYPpIvi+URLNky8xE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Wqe0z2Wa3Eg1su/ky16rhEAxpTTOd7xEnGc1mXc8mHdzqmRBLJ379sy2DUL5VeORHUAMQL4sOtxcVGlJIWiW99wL0dAc+LnpdyYXrzC3NCArKJ+3EKDpVfiM9s0z8SiIapmcyU5u3PZGZ6mimt1+SQ3WFYBZGRIuvtuPR7JVzNWyY8BTwNxk79qo/hlhunzMyVYiUuB4T62vDrFrL3eXCCedr/91+aJGzSwU0f9KN6x23hWfu9wEbreq22SM5HnSZEPRQ38K3I4TYNUW0v1PXghlKUsAPGOOVRPSWBC4XRyQTEifti65fptCVKfYjn1L4oyPgphsJ97k8goJsLouAQ==
X-YMail-OSG: QJBj8DQVM1mHRsdQ97IP6mQjSrMrqhQ4DHZlm7f0sig1xPd_bcSAdp_xiGWrlgm
 cRny3ZK9.SvAPjmmyodJOaaVfH9yLL82YWaWagkVNK2j2p8HT0NE5OCVnz_M5BsAlWb0y8iXxlsU
 L8ljKg0Am2qmiPuMpVDsTHsAea4D0qS.y0aHWEiWV_VweTr4JL6xqQ.myd_jgfiksz6NG8maTVBn
 nIuZAAr_mWg6Gk.GOMFaW6JqUYLcqY96oTOVKsO4bR_5937kjApevNUliHBntWQydrg7Q_k9cr2V
 MfsVcrkFXy0SmsvoRri56jP3xwILzzHYuXFglaCKHBRzHWFX80EB08xBKQGZaM2Ng.eWJlKfcoG8
 IupD2xDg4deY31fwZNWRv1ga6aMXU_cZziAxox.hg32KTplN9HBhhGgOZLhU0KiLko8Reaa4alpk
 h8R2ZhIm6H_82W4F._Hgsk0GFIv7mFDD7HR9XoknInSprMIqZu_OZ7lnBHSr9blKr0EW4pvsTOnf
 hOlbAS1s12VtL_thBHRVvRMrekru.iYEXKdLON1VmnytuNUCxZldU9iny6akRRJ0LpT0AWiSUEjv
 hVm1l60F6sTxpoV_6BxFzBuphB6QT.HkgMPMgquWAyciXbnCfQ4f553ubQlO_AmYb9NaMAhMDtHA
 zdujueeekSdEjIs3gccW9e9cTnHxeTzAiszTonMpsx.nNWTMhF2GeX60ylc9Xmdb6hSTaSnzFavV
 ofRfz4GorOOyJjSV2xMi3NPYTVrGl6OQOjTzoRnc_BQXalB0jsOnQrZ0mGAVGeQk5Deypk8d8c48
 oo5nDxBnGyR2cRxr26zN7dYvj8HRL331W4TtXHi1O8hW05s9BeSDMWAA1koIhlMg2wEPc1QicVwq
 Oag49y_hxAKefTlCmGBrs1VC1p1Fk4NzODn9BcsDo8X9QSFp9k44rtifrUAgpXZGIoLSNl._b6Gz
 yAeJpxc1iyEy6PTe59YcOymT2vfEPUJZWtdiyhc4CPNwlS6AQrSu5CepKaEY5QgvhANpvRnBb7c3
 eLaRU_r.Vyyu5nKQf.hlnuNRvIlqyE2kvyMvbmI4QxM7ufHeeHtGwP_gexuL3M0PYw7wDAJiBddz
 WLpdWsbRhrxQ8LVCVyNGkCO13OTWg_w8Xk1xlNyogr_73eLKD3JVihY2G.xkKskNEXz8IUOWm9lv
 mI9BkOoY1s5jG_tvbiGKRyg3WQCHC8SJVSqMFyKMq.b6Y5DbVLIS4WD.ztRyY676_qL6wYXCCJ09
 l89n8ty.yqsjoDowIJRgH_Pd6kPbAIALvQ45e9eS93kaLZPTHrFErYbVH.bp86TykoplPJBEtJ04
 YZlvqzYsawTh6obE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:45:08 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 47b71907c10558f94678ade4ae66d1b7;
          Wed, 07 Aug 2019 19:45:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 27/28] LSM: Add /proc attr entry for full LSM context
Date:   Wed,  7 Aug 2019 12:44:09 -0700
Message-Id: <20190807194410.9762-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:'
	lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c      |  1 +
 security/security.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7bf70e041315..79600df5f7a2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2619,6 +2619,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index 0ea7ee27e331..e9f579483d12 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2046,6 +2046,14 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	char *tp;
+	int rc = 0;
+	int finallen = 0;
+	int llen;
+	int clen;
+	int tlen;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2063,6 +2071,43 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "current", &cp);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			llen = strlen(hp->lsmid->lsm) + 1;
+			clen = strlen(cp) + 1;
+			tlen = llen + clen;
+			if (final)
+				tlen += finallen;
+			tp = kzalloc(tlen, GFP_KERNEL);
+			if (tp == NULL) {
+				kfree(cp);
+				kfree(final);
+				return -ENOMEM;
+			}
+			if (final)
+				memcpy(tp, final, finallen);
+			memcpy(tp + finallen, hp->lsmid->lsm, llen);
+			memcpy(tp + finallen + llen, cp, clen);
+			kfree(cp);
+			if (final)
+				kfree(final);
+			final = tp;
+			finallen = tlen;
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
-- 
2.20.1

