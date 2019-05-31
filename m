Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEE7C46460
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A3524BA8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EEpmjSKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEaXc3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:32:29 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:40000
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbfEaXc3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345548; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EEpmjSKB8THVqnvfyOYqgXuFYH5S1V/HGrGay8rva1h/m/kG0nJ3BcjC5tJSYOg9Le9hfCsZoHo7bFlYlX1tRGWcAtuJNWUGYBqZ/KrWHMTOTWv3RvuQlXfEsDuls3MnrZHMNWCA4BF8nIGJDKUhtrLl5ISmW/d8maQohwprN5jgQSmd7tENnrEaFq3SGvMZHG8/SwiDLkXTm9N8eLOP77Ul62ZBPE+lhqK5XD45eIA74vCi/9DUDPu3V4f9hZWtJ7+LubPZhd+sOfLYDAblr5IExD2Kl1b3ltT0MWYIyFc3J3VSblCpfMmRsdM14NKABTJz/SwB0rzpXErWMJ1RCA==
X-YMail-OSG: YEC9SAoVM1n0kcWiITUDKJSmhkYWyHHl.2lZA7g3C7X6F5xpTPGiHeeQZW_vF0f
 qJdZJ2Af94ZrQp7SGNCFeD2Rfc3cpQoQ0iSnngMAthVnGGAo9CB_eOLhCE5o02DiNwUxU.cn.6R_
 C1Iw9YmsYQYXdHfL6MlWfTiE4cS5LMcL21t.yEQXhXr8XlMSThXYQvcCIwk7AKZfXZvxiA_dlEnn
 chixy4SAfG1r0DGJ13GH6__grIQSzMhh.R28PXiWk4TQRp5Y7jGxD7c8rV0sXTAPRKHrNzQxgZMW
 NjDVzjUE9BJ1vOnkrMI3jvymXqvOQZMkAuBcq7iBHebJ3SxxzqxPSiq4WEoXIlDc6guPV0MF6Bl6
 Rhux1NpozdRn9t.9HH_OYlF6zIVLN0m0M0KzaZnf8sD8oTUDo1brgj5MbcTp5FtPNo_e0fsD5__z
 loP8_V7EJRaHBqxsqmyiBUI168DqsXoNA5B5F1AFos3GVjOC9f0hI866P_i70Il3fsCLx1GFKSne
 NkYwG2JMDQ3XtORJMib9qmFYKVTqrGJ3WTg8LBZkrhI3FFyfmGVH8tdytW9ygGJulwk17v95u5n1
 L1viL.a6pzaoFxnTa97D0Flq.0IniNH.LqwPPkR1d6QbIn9Kxbq..j_LijlrxbIPV6uDeinoFyOQ
 Lnblnk2FEoXq47iKR7A1pq5kB_Otkj_VZE54Y9lIx4q1VzmYJEGeg35UIpTrPpvjRij5AiCvF4Xu
 eX6yhc9SCxLcKRkz6Dc9rM2u1ftzTJ.AHngpyUWvaufH1qmC6yvYWpyZ2UhDBDlweCnyjBu_NX4R
 ceTFNCq.Gu6Tv5mxmI1icw9Hc3P1dxadVgm.mF6AAjX77Aun0bBRFjswsG98rgAVTNoBwDLAikHr
 GDHKnulbuQunhdsMcZt6oJymPu86OqVsNQfEhNH2uWwdCus_AEJJtjGDfB7lRfgpa0lwqpqKklg6
 lpKWEET6lU7KsYKeTi1OGjxzCUXxjRuPzTs2FnjesxpPCCfgLiw.j4B6esIqQgXP5HjzKcxuToxx
 4DCLpN9JhtemDYOvwvWlRIQ2_1aJDxLIEFitUOn.pFAUQyWSR12m_0dzNjTUhmruo4rM35p8TghO
 i6EPTvdf2EtGamFHAcDbR_qg6pcFPYoAGOXip9WlOXS0aY9_rjVY2j66cqlpwshZAioYlYJfJWd5
 RDtooMyFYOyiz4f7VidNBy2gW0jrxoIUR759QdNHmh3C3SnwtmOrEOpsl9AC5RxDwsO7tXv5RpBS
 N3uuGn3NsA7EXuVU7_HNwODe_AWVHU35lCdBulXdXqLJbHKxV00LuZA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:32:28 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac816fe950c45c4dd9654cd9287f8d35;
          Fri, 31 May 2019 23:32:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 04/58] LSM: Create an lsm_export data structure.
Date:   Fri, 31 May 2019 16:30:55 -0700
Message-Id: <20190531233149.715-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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

