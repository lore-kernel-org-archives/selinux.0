Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A900CC433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 01:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhKXBvQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:51:16 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:37166
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhKXBvQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 20:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718487; bh=Q3oYFxmyePXUZvb52LUnr5+7j9BYUgqBMyeLytsPrdM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=F4NAoxc88B11wa4uMaQyluzO/7S5f346tFZB+zthUcgfbS3WI76G5uDAOYnD5m6d1zpU800bSKPWgNk6FW6+6ZkAqxT4XU/JXnnh2Wg/fF9AkVSO2WGI/6nP68wZgTpSzeF6uk8KeC0PGE+rs4ar17pwI9toQzONJwavhlQ6MBR0R4kq0fcGK2ohBayPA+DIjZfPv9N+rqYhfMtoiZt8fhRgeTQC2JpWzr/y6rlHHQ/OmCFMLrXcdjqDcnVj2eLUgb17/sjtXB6+4UpCAnk4W7p5zOirXN3rgc7giQ19PrM3knhclawhDH1iLfzWTP71+MVOo4WQ4yV1F7V0qSOuow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718487; bh=3dH3FHQ1luPwj2Ok6BQ+Kx2XrL9SgD+Cr1EjxsCKGLW=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fup8DgpU9IkjVJ/xSAZbRpIKBUlV4pNsqj2wXj3UfO4mJyGmTm4DLc7eceTtpC+4yRGmWMQUJZ7zkhR2q8pP/NvYOlt34SpM0okv9TXUnRo3rI/zM8ZlvzAHs+3hi8O/TKWrI3wTMeLAJ8JbeOD7pgyNr//dh5eRy+CbzuPXRd5e+tWmtCQekzVgTgIGMSHqmn+P+1i2gVLIz//COB2Bn/NLKEiZwMychtENUORnnvBY/3Vl/rEMYV7dcyoKXEtH4I0FfJwEFYIrnMeeqzMhzZOt65NCBJ9NkPoOjVfgV//HOYeEGGtiU6j78MumPQ1fVUuwfxv9Q2G/SoXTjSbftg==
X-YMail-OSG: OY3jJx0VM1nybd4zNj0rZv_V722_ckQuZruKfZG_F9LJuiBkdt13vNCvkOaRUZE
 bd4PELqSISEY2CJL59LAvA3YWZbMPHvnjpJGr4WV2E1LtDyfMfqb8ukq8ybSXOL0s1gWyeO4fA1S
 SFRnOYszsnhiSRQhA926KHKz7rDoLPTfTh5uwe5L.a09.bux8HAjNi.DE1sUTlpoUBDtRhH56oNv
 9YVfRcVflPSua5cbxT5pFAi0jPgHIsVSXEaZQVwaVi3nx0rMf6aEYQXFRYSNEEOtiRdjY3opryty
 d5Y7vaIDuBJEav4zyD1vixVACnUuMKhIiw7qLIiHPu3ZRuC8tkh_7AgH9E1xkbNkIIXXlW_fQ9Jk
 o8HpIichPTsPfpWNJzVIPwDjNIAqdpam9M910OzUt_zqPlDCkEvz_dEGn09fOv6fwiCrIahNPXPi
 k2l2vxNMnLhInpQs7SCHiu3WPPFyuvU6712xhBvonkdGWW2WOJppSi_mAwBkAjLLLrorYrMO1mF6
 yN15MIe1Hgy8l3OrsuNPAMroFWNcFeQpQPlaqKDc8jSOJ4tO1PlnEIhFN701dbsTeNxbURX4XPa5
 8qUTBXfS4gCGPxSkF5O.XbYMsm5NEm8YTnuEC5CTK.Stuy3B_V74h.Kn3xC976hLHHJiV8Ccl0vl
 3x9bgIr1kitKIMANTdj3fFIa2tPU8DWwYaCzHsDix6mnCxpMQhHqHAYHXd_5XDl8_jomm_i7JXyE
 6PggWJ08kSRPWgSxr4lpIktF0GZIEPAWwcdT_DahtO_m8ggE1Y1mPGYutVtm4d_sUTkEE606dinR
 7XZvbYzJvZe3Sx3S1qK6e8fmjXlNND_XCRV2SbU6.Z7a2LJSV3wY7EWRffJ35po4qwrZdEUWe.Tz
 cl6g.R_XEYjodc4XoCxzrUhJnd00yO7x8K.ocUj4l0oVXU2lCzCUlVeerRCfEaVgKN96uQqhaLsl
 tVyccA2xhfesJ6p.pT2HWgX0HUoCZcmvQQk8zW2UAXqcB5iNgdwH5qDHGv2UVdWAPHJxUpe_unOf
 YCvUKCxf.bigL.AFZLriZrGQD6nst424Mxd6s7yy2chPIPHw00hWmYG9.2K0qeFjJ2agNkNVzq39
 tava71YU2ZHvdB8rrFn0hGYMOlZQmVXMYvhei8etbo96KuPO4Upoi3YmTLVQWWD.mw675hrlm0cN
 SYjW1vUlUiUXBtJH6a3zpZFkDFfjlScpjHLZ0FPg3tEttmtKo0pcnxTupICh55AvxCqT.VwuPvYV
 jNpt1ut3Nm9azrsTC8vCOPJACy3acLdKdjDjG8L9NNC8xT4HgxYBDiQxDgYAOHnmSH1QywoCi0J1
 RundcNtjZcCdWxHRKMj0Jr_ItX7WtgXG1wjhVfbotwpPaRXweteF0R.ki2aRMhsT.UCTSKYWWpyD
 tfDQyN3SdWAyJYb.oMgIIQqqt1zC_ha5rVYIpfth1A3j3ycdMCHeOCKuns.qXCU2oUdDcPFpI4eF
 giAnHJzalHeksfU3VBVND6wq2cgcwqr6WV9Ibi6YcWRZFcUgsjoIFyUDGx2i8rYtGnKTdx7F1hxt
 ZLubG4QI87itil6M7B_mzcCwf2BCObfkAnsN5_rgge3TizwdXiGiZN1fTcTUuLuokgDOlyXhn3yO
 V3l8kWCh1rMBFX8iJIRcXnWuJ19CqLhXO_T8fBJNgNv5Ao4HhDGvLpyepQwMz3QWZSG8aFQLX0Mm
 qTEd29JEIpU5xhC6IqTTEcqUTzUUKWJD.bA.Cet9Ryk2xS.wMnuwrbSc2.3Mqo_RXwnax0uXRS4b
 sKvwvNYEx.urtJTzriEwm2n.K5_5Y7b_fI9VhfdIVKwsQpd2llVj2eQisQqEVdAKYJcFc9eNE5EL
 XJ66I4pxdC3AN9D5lKeTU.uysiKBHie6bdUlARFD97PC8ps0Vhdp8SW1.JvzMy8tC_VGCLrahD9I
 gwdfPWjDvvlv7b7GQoHIvnYpd5AXk3IK7ym6BKoN_bvYhrN8ya3qHDxCL7jlFdpNUgnGEirY25gM
 oYFAvqYkQ8Wh1ZJInbE9rrqpCt_d16AdAHiuTCT_SCUFKqa7N0BS3CLbWQBIlch.uCajuIpM03Cl
 66vVjTA4kuH6KcJDd.67LSlt7eqYG92lJsl9ct24Vgfj2I2pm5QesYR4amz32t87zANnIjdpNmTY
 dRTnnKyB19aJVKEJ4EjMA6H_ylHHIWfBlzW9Bl402cnSSKwZ3beKtuMLk.J5K6oTkMhpr4ctLvtZ
 gKAwx3d1Q2JHnuot3nTkxEW18Pav7
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:48:07 +0000
Received: by kubenode536.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0bdf7b7fb47115a0eb0172a796184117;
          Wed, 24 Nov 2021 01:48:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 04/28] LSM: provide lsm name and id slot mappings
Date:   Tue, 23 Nov 2021 17:43:08 -0800
Message-Id: <20211124014332.36128-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide interfaces to map LSM slot numbers and LSM names.
Update the LSM registration code to save this information.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  4 ++++
 security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 36a8c2d95542..cd68b4199877 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -194,6 +194,10 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 	return !memcmp(bloba, blobb, sizeof(*bloba));
 }
 
+/* Map lsm names to blob slot numbers */
+extern int lsm_name_to_slot(char *name);
+extern const char *lsm_slot_to_name(int slot);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index 283671b6a5d7..bc169b9a6d77 100644
--- a/security/security.c
+++ b/security/security.c
@@ -477,6 +477,50 @@ static int lsm_append(const char *new, char **result)
  * Current index to use while initializing the lsmblob secid list.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
+
+/**
+ * lsm_name_to_slot - Report the slot number for a security module
+ * @name: name of the security module
+ *
+ * Look up the slot number for the named security module.
+ * Returns the slot number or LSMBLOB_INVALID if @name is not
+ * a registered security module name.
+ */
+int lsm_name_to_slot(char *name)
+{
+	int i;
+
+	for (i = 0; i < lsm_slot; i++)
+		if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
+			return i;
+
+	return LSMBLOB_INVALID;
+}
+
+/**
+ * lsm_slot_to_name - Get the name of the security module in a slot
+ * @slot: index into the interface LSM slot list.
+ *
+ * Provide the name of the security module associated with
+ * a interface LSM slot.
+ *
+ * If @slot is LSMBLOB_INVALID return the value
+ * for slot 0 if it has been set, otherwise NULL.
+ *
+ * Returns a pointer to the name string or NULL.
+ */
+const char *lsm_slot_to_name(int slot)
+{
+	if (slot == LSMBLOB_INVALID)
+		slot = 0;
+	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
+		return NULL;
+
+	if (lsm_slotlist[slot] == NULL)
+		return NULL;
+	return lsm_slotlist[slot]->lsm;
+}
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -498,6 +542,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.31.1

