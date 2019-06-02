Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D87AC282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636FE2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Yqh2EJdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfFBQyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:45 -0400
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:39473 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbfFBQyo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494483; bh=nBnBMo6nnWk5nN0YxdI8fLfbN2dvJh7eXD4R2+pTog8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Yqh2EJdBY95QgBtZ8J245JijgiSYlswEnvRWw+Y83cshnhUHFniAyaD6DJ1WihNERDxyOqLt0lW0GlNMAiMXOsB61+rMt0lmwLFny89G5G0a5orXc792IPbOgrXUWBfcGfQyREvyspl4PSIr3cM6HOouarJuGgnugh4xqeKqNBLqzJyeNB1ZENOE1R+noeS1R4Ub7KYP46eo2xsW4QsX2sAEsV3dy4U5StrFW5ud31yXdr7zt0Fkk1qC+2x8zOWDMZ9VUhkhfUb4grBOoBO+3sFPopZe/u2mRzCuEfpwcli6gllCc0C0lAniIn1L73CVxmYB4RpqXCUJaGMXRFA6PA==
X-YMail-OSG: 7MoqQh4VM1lySqFqzTdsraUhdqEw8uAZ.g3..UeaWp37EOMmqZ6m0C.Kl0E9Lzo
 Iio6Uj.rN6iJMxo2EV.7nesdJhxCX4aA.c6_hft1QAufeYjrYOik_LCkoGg9mRPkdJxFs8rAkqkx
 .4THs1tDG4tXqgHHhUUPrz1QWYVTTpUua6wp1Whny6OtZe5q4SzNYis3ts5Qu8IhtDYJ68tWdynT
 vnSTsRA8Tq1hrLsjA8pZaBME1e4Q9JdmGfX.TUicTsKYF9HRgZSKeqeKs.hGCE2WaYKSHJ3lJ2hT
 TSDJDq2P2PTKhn9maWXBrUtIrnOcUN1o_dsZ53l_jzFGGuE3K3.z4ErkbAuoCa.b0tjphN1snqKM
 RKL8.X89J0JObJJoiSVIgx3IKMQQv.vX5eHp8qvwjGlL2UBSQ3MG.7bRcEyn16ujbw47cQRR3a6k
 dhIu2XYJ8T3r7Cjaeuje1p_CnU_fk5bGFSHcsAHNxJjmQBe1Kbcdx6hWiZXzAmd0kjRhhF_7hpfw
 LjnkfuGpmWtLXNVMujGQCvxBucHILZYS7A4ef4kxALMyFA0xmrET2.KsLGiw5G78iuLpjWkXG1xc
 n2qNqdnueGyADQd8ezXw587hKWvRd2IKlU7R7eYg12pe_6t6ESNg4TigxsW_kzFpNFS6DV9kaHoz
 azJy9buK3bh.v9k8.5D9mVEu8IX2QutKZXiWJKlHvMGNTIenOKwzeR38eY1YP84yBbj5EwYYtjGc
 g_Juv4atn9tqE7ElaoHvfNIfVFw4b_8oBXxvq5jqX09ctx9hAWlc.MApitSFBpsgJURBCUpP3N5S
 xbGJiIGwPhHiKbIi9meAGUj2UD7DYa2etcxHz_x9ioDDosikztQSN8wF10vLyNfpcTopQWo3izHi
 GsOynrj0ubO1zyct3R5rj5Bmpsac_.0XTh8vBVOtk6uJMhjXzajO7B9mWmn0_2PL0H4oBke0h_Tk
 p5ZindJPm1XkCPr2WYq1wa3kx9Jv5VZeOIQ2rJmjhfO_IDe0fVbTUseDh7qVKB65LybaoxKqgakB
 Oy_V0z3GiCRWn_YY6Y1LTuuPkcHhRqtrG6BayIZYWr7g.XA01lsbJ5ifhLj8QkjKqEA2TGBrKQlS
 7Uuur6PWGrC2XRX7.F0wfq_6TszfJaY052X1UmffsDfcInl5Yn4Yr4tqUNUn21T5.slQx75lgMSR
 .0wSlpTMLwO7WkdWh_Zj7J_0BABpYKEzkmbNC1eyF_2bWu1XkSbCXL_Ymu4y_ReWdKgC2Hhekf7L
 B2pg_oQxugfkeGW1Lx8O5cJtb_Es7yue8pATj_QXwKfHXiQwPpU8zy06v
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:43 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4f202846722f9a871dab498da8fe7ef4;
          Sun, 02 Jun 2019 16:54:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 56/58] SELinux: Use blob offset in current_sid
Date:   Sun,  2 Jun 2019 09:50:59 -0700
Message-Id: <20190602165101.25079-57-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the use of current_security() with a call to current_cred()
so that the blob offset can be correctly applied.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/include/objsec.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 59a3b1cd5ba9..c9a88b7a96a7 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -31,6 +31,8 @@
 #include "flask.h"
 #include "avc.h"
 
+extern struct lsm_blob_sizes selinux_blob_sizes;
+
 struct task_security_struct {
 	u32 osid;		/* SID prior to last execve */
 	u32 sid;		/* current SID */
@@ -45,7 +47,9 @@ struct task_security_struct {
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec;
+
+	tsec = current_cred()->security + selinux_blob_sizes.lbs_cred;
 
 	return tsec->sid;
 }
@@ -174,7 +178,6 @@ struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
 };
 
-extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 {
 	return cred->security + selinux_blob_sizes.lbs_cred;
-- 
2.19.1

