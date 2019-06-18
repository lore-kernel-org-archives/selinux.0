Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167DBC31E5D
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAFE20873
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H2V1CgA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfFRXHc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:07:32 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34345
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730935AbfFRXHc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899251; bh=qYwgn0uPGgCDn+7D3Qi11nDs0rG6ExpEBAY79u1pJ8g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=H2V1CgA2jrL020NaF+Nmeyp0+u38nkj8lcSwrJRP9nX46ziop//yGFRn4nVHbAckczkZBaA5l5Zxos9D22mRm7Kf30eoDi5IlBQtoF/lpbM97fjqZG+iYZn8FrcSP94T4irKF4dkRjsBNK/O129X3KFNtufIwWHFX98dGDpt5ByrLTsuaeq9EfrT1uGGmloH6owPBJc0+H84a7o4rWdiw25R5xYXvTGkv/KLfWTHDTtuoPeyHHvxvLDvRvNxphByFs/rL9UF5cAYaznbk4/z8JXdK32yrydoKHoQj8JCJx1zEErOPEaflA+zjYazoxk+3+FYRFH7rt+uAWWrG4lhfA==
X-YMail-OSG: NoEfWXgVM1ncqO6Ari2YW17QHWYNOzZAiuYDqmZmZ0ieTJBpbFwAqFnZnSCSViJ
 WylUo24ZU.4uen8ZeqAb_GmxpRWndz3EGUiqJ8LM7MbpwL0BvmhnagpC9NiOe_djT9b253ncQpdI
 BkcXtBsosbiQdyJKicPSzOONfaVp9DvMbC9uTFC731kUckvuRUB6JeqUCiAn0QlUtpwAMjSAFDSH
 4UqOOecPJ3yyPWkzo6WFPDd1mJe4PLINZsu8gVXlI9pLyVBwcJGsaKnFJabHwc0YbtDcUCIoPXpk
 .FiAmThRvjrHrlJOtgL0J2S96e3BmhlS_ZsU.BDC1HVz8tzT8PvnN9K2_8n8vQ6dXH8SdjIC55d1
 hod6qRBhWnGR.tJD1h_.Iapx6zMT2dmwQ9vhag9QwYkTqyMNSL1wpSTy6mPyTfR6Kbb7Jwj7Zoz8
 uDU1tWHFN6y4jTT9u9UBNMmZXyU9._hUroCeEpsD_e_WicXPQjX_BJZVK7iiaNFdJts.65gn1URB
 TDfDrzovx3HwKHabsXPx1kYaMp37gboj1KkMTsiAUa4PQ9qCcPQhGdbhbgPD5zxMgpj69gMY_7I7
 i3kWd6pRnsMMRVcPwHlLgUSc.QSoKlFex1m_PjSsakyifrCPW7gu4UmkRHGpNrh0zzXdNyg4O86W
 SK86oxVdVkKPBkNadcDwyDfJZdKpnlh7vtsLhPUC4sIDVHsOiMqK_4pbDW0p0WT0cUzgaslmdXEA
 1bpmYhJ3MXHwIJ52BH5XZfAZ4lnXpbBw9FQ1y1C8m51pUEBXntkXH1MMZKvo7gEGVXXzoDNudV16
 q5O5Rp1UDbFPCS6ft3sAll4vrz_QqLTO5bgeSN3HjaM9WHYOBSTjhOwnuegSqZDkO8qwFco0ALdy
 Ry6NphjcIsg7mQjt6yEmPo4o223MdW3Br.EziE8yMcsTqeaNfAEBsBTVdSltY_uEW.vF6IPa7qMb
 dvDu9m6jhtSOrKYVHCwu.SmuE8h89Sprp14RphNlDqfcvF_CCmI2mREYXiecNOlwE5YRwmSithI7
 Gxnq54XggmTdGxpGjAaQ62mbzNZc66WAndNznb81p7xnvswmyGgZqMUuVtv6T7XMjW2GyN75xQKo
 9BX0IKcGg_Hp3UlYQyR3W_U46JEuIBKFdBHlWTZN8eGnwnj7ag0wcVvaNa2UX702RPXbjJCEa1LV
 5Gd2vsALdbukH9aNebhhxoWy1LrkIRnEcbZiszyFAFjd4vAQ0iK0DqBI1N7m5hBGfD0DxX7CUJN3
 9T7niF99qq4EhWR62X0Pt89ef1GkesVHsywkuPQCygfM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:07:31 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp418.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 32802204b4a4d598b4026998dc749035;
          Tue, 18 Jun 2019 23:07:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 24/25] Fix slotted list and getpeersec_d
Date:   Tue, 18 Jun 2019 16:05:50 -0700
Message-Id: <20190618230551.7475-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 5a23ccec7c7b..8aca43ab3e81 100644
--- a/security/security.c
+++ b/security/security.c
@@ -461,6 +461,8 @@ int __init security_add_hooks(struct security_hook_list *hooks, int count,
 		    hooks[i].head == &security_hook_heads.kernel_act_as ||
 		    hooks[i].head ==
 			&security_hook_heads.socket_getpeersec_dgram ||
+		    hooks[i].head == &security_hook_heads.getprocattr ||
+		    hooks[i].head == &security_hook_heads.setprocattr ||
 		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
 		    hooks[i].head == &security_hook_heads.release_secctx ||
 		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
@@ -2269,7 +2271,9 @@ int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 			     list) {
 		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
 						      &l->secid[hp->slot]);
-		if (rc != 0)
+		if (rc == -ENOPROTOOPT)
+			rc = 0;
+		else if (rc != 0)
 			break;
 	}
 	return rc;
-- 
2.20.1

