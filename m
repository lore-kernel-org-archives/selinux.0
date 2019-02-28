Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F43EC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B698206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OsepPYFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfB1Wo0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:26 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:44725 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728946AbfB1Wo0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393864; bh=HtMHoChzx596drToVKA+SEbhFoEB1xjjcsaTIP+e+fs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OsepPYFRW8eV4/GP6YRK8ZtOrgX0OUHnBXsVsGlsVBBGE5S9N/5lNcAcyAcPd6EavYNrTEvK3Yeqc32m+WVnheHPyC+xqgNsYboihoUWKVs/sby7EUdJrj/zlv8RQjFBP+f9tFsr2MR1E71jDAg5OKG2PTCxUwjMKf25uflfC4QtkioGRn9RYjhccDtG3v29jU0jvF+Jvxx2AqZcRPT0cnD7tocVFuXkhnrARNNlwT/TjCEmuIV82a4+0NT3b3ONSeMKzIUvselNmTXp1YyL+a1M5jBCazqwdaO7/4gl/GWWvW01qkVa91meoNl+XyxozFLDd3AgKrINWCfEZ3ixBQ==
X-YMail-OSG: 6Q7VBNYVM1mz8WdDv..HddDemXEIJOPoTXDSHzdE2DAGqJkvhvxwTurtB3ZWbri
 20foMEB2gEViARjPYV5v.JeLO8sCKgRIelWGXPYObAPQhOSGYmUCjkIK6ANLfsrbNypstIM2.l5P
 bQF7wC_4eg_UYnSvWofsfrajCblewq4gEDpptQZtyLU9To2j3rLmO6lLm9A8dvVxHzQoXKpFoAA9
 .RBZA5KTsJ4oCZhIUZfflZydEaBqdIFt0rFw5aiyqZWzBD31AwUxH235_mfgCHTj9QIMkN.u8UIb
 edHD19m5bIoLm.mEhnl47LTPyo1efYQJbpGt9l8ODJ_i0t3qstbHZViAbpnUZNH5XtKJSNYfwx.Q
 ra9K7.c1Sm_vlL9GSQ5_.NNglffrmzfFUUoiti.lw0gwvg_7WYYuPvQRTJyDcnxCiNSipvuqXzLV
 OgVfzwiSh90G3GsnKYOTkOLQMbzYD6LynPOoFpDCq8KRI0gouLbyyNsQ0flko3iO1d2SeTCD19JU
 zwZlLcQJKohTpICKX33KmnAd2MqmJW_mHyxtAv2nYd6UuwLU1Y_pGemRuZM1iaA4t7q7z3Y_M_H9
 8kD.HojZOAsobd_f_wzf5DqYrGn7okqQXxYSK8ciDC9rxXyT_MqzCn8JdTNvU7vdEOAviUBoLQAS
 MlVhtUPN4Gd.RgKRhwIyYGNNyo4w8Lc.Qw.2dqZnyNi.daOibL9zziNDTa.fDj4o_rzFqM7101kA
 NpuvFlctp0rTO_Z7mnRZTYZHzOmueHl8N_ES9tokbtGrb4pmFd7miDareHE6MT3cMAf7zsqyKEIw
 acbSMFCjwBRUab9RTAU2QHx4R4ps5bPTeT7RRXAjroOasclUTG2m31P2nazLVU0yhmJxV3Djp7Er
 lSu4MpXPqKM9upHJvX5Px3IcLmuMNXmeQ36IiZJa7KQ1cQW8Gq2PwVv33czU5bbRlPNwu0GOFW_0
 HIN0GBfAKGHpm7k5idlNT_jQGugsxbog7gsrITa8ERFAKkOEhVCLqlPNLCodCh._KdznqCdEUjQ8
 lIQsas2ShDYZAMvMdf2v.5nOI.MrskRBCDokgCbv2hYAdX9Nsx5kA8u5vQMaQM0i_ESY2_CtTOp1
 IM.FVgZlxPgAXKxrS_lyeLbiMVLdgIJbQmuQ6b_g43LaOOEsZcqms9gc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 82/97] Smack: Fix setting of the CIPSO MLS_CAT flags
Date:   Thu, 28 Feb 2019 14:43:41 -0800
Message-Id: <20190228224356.2608-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't tell CIPSO that a netlabel created by Smack has
categories set whenit doesn't.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_access.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 0764bb85daee..5fe5c6799b27 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -494,8 +494,8 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 	int cat;
 	int rc;
 	int byte;
+	bool has = false;
 
-	sap->flags |= NETLBL_SECATTR_MLS_CAT;
 	sap->attr.mls.lvl = level;
 	sap->attr.mls.cat = NULL;
 
@@ -503,6 +503,7 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 		for (m = 0x80; m != 0; m >>= 1, cat++) {
 			if ((m & *cp) == 0)
 				continue;
+			has = true;
 			rc = netlbl_catmap_setbit(&sap->attr.mls.cat,
 						  cat, GFP_KERNEL);
 			if (rc < 0) {
@@ -511,6 +512,9 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 			}
 		}
 
+	if (has)
+		sap->flags |= NETLBL_SECATTR_MLS_CAT;
+
 	return 0;
 }
 
-- 
2.17.0

