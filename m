Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8055C28CC5
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1126FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gljSPrUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaXQW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:16:22 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:36596 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfEaXQW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344580; bh=VEDYIM3R1NMqedNbn6scDMcxUUfpt0y9Ccbwl5mHx6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gljSPrUGuoc5Uoa+EjQ9SGNP078uC1/mEdxfv8Idwy767vinA+jtn9lxB5J+BYn15BvUHsjAp21yvbxbbWr7S/YHVEfF6Dwqz5jDt8mavuXgNqUxxh7zAbUKk29vCQbzNiHwTYqWlPUT7iznXxs06pP7Jt7JQO/kVj26IFaKmaCPUx+bmcG79ZpdV8+//wuAlTE4jaNwZiyMsg603n498RiSgSCTC7GRw/FYbkpWQj7WtWIPQJFTeLHS9GS8WHjimDYYz1Doj+/PHHtqVIB0gqKD//YrXLcJxRpC4vF/hQQa0qkpMDpIRzYFLTH+ZryLUs9U31nRNhzZghyNez2jRg==
X-YMail-OSG: ffznJWYVM1kwo58gjwpWmI7u97q5GplhGG9NzWyH_dIVRuy2o21J.s6VIGQvafO
 U3PkNqAd9AjKcOTKt3fJfn40D13YLdFlDOC.uAlgST6bKTXDGT5XQXSKtSN4tP5I2pNqGGmq3lAD
 LH57FhtuGm1jFVaqwUrU3tz5Dok_BiidnTGTVK_RyWlnQyCZMtf_Kzg8elBGg4LdwO3YXA4RCjtF
 a3VKq2fXv76po4eekjfIJni5dQoiLVo8NP3D0gYyUzwfkeAALr5JEVopUBdIo.Ao8hcRPQXM4G.1
 iH2FMVXLwgjJBFSnnaVG1TSX9Ote87hbrKDrernweBGezDoB68x3Ap48uzdQZTktHlWxg3OQDqO7
 yqKvIa_gIKZr5UozKxD7zgkvJasK81ApjNtxhckW9YFdWHuLc95LUNvZskkCDrW2D9MX5D7TY23t
 TCfgUqpRba2JQwcH8fs013x5hUhLZAQXcc7nPR1lQv03vMy1vAqIEwg3k_OHEZHbXuFNyo1KEvgX
 BqymwdNE5_51MgmAZO2XUSfZ5_TFfw4fRZTdtAplWQRxUyDqEJdWSk0sU4wj8kom2HTdHv5YydbP
 UrfYP80RF6qsFBks8EoS4As02QNy7WiNpfkPY8LdtGuymg4wknssr0KaSbPkmV6aJYLnfdkC3il7
 FesPvFxVorDO4um.iBYr4.zuekvYQ8Rsk1cjBXw3OIkZlnT00_XoX7GsxYBpDKmr4Re5F_0L3AzO
 fxHuq1bIEZUobJ8RxeYnxvHEfYxdS7NWV6gywPW6f_xPS6tQLbLZn7wwhiayYx.Epc7vcepC4zYy
 QuGyO7radBenlw7pvFVoZRs_VyLE2_3UxyefcILDOO8z4cW2oLxsB2tsXQtbaUbR_YnpnlT3azGd
 NewbF1dyxakjudr9M7jVSi8SazOt9yazb9dTmc1mSkqK.3lMZpLW0Zg64eKcCANezbJoDJa1aNu0
 KnCs56Is7czs4anc.Uhqhpujs0kTkBRl5eQbHSICvSxShDr0i1umQg5s873p4OWDENgS9eG1OyZE
 3WsTTsNRJ1koEp0gxiddNDzFPAv0WmwEqE7KNC16mPp9qdlCf3_Kf13NoQkd1OupwJLLSMjXyPf8
 1JksBdeYf594ZMSciqa_VmZfvWb3xLHOUUnOU7hp4eGRUUcEEyT9qhAuxOWw8HfJyv47qoZiyoDf
 aFi5yZj4VkldgoKAti3T1zW70P6dNE6duLox2jJ.xyRvyBjeX__ieuZu.Ss7rtbXfkriO7PFUZS9
 2RWRcGaNElr7rzE0JFgCctxULunt6.vZ6zM5LTMPREweGxHS19BGh0vzS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:16:20 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 871cbbaf11ff5bc468f07126785c4e7b;
          Fri, 31 May 2019 23:16:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 34/58] AppArmor: Remove unnecessary hook stub
Date:   Fri, 31 May 2019 16:09:56 -0700
Message-Id: <20190531231020.628-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the getpeersec_dgram hook stub. It's unnecessary
and disrupts stacking.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 24b638bd4305..76c409737370 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1094,15 +1094,9 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * @secid: pointer to where to put the secid of the packet
  *
  * Sets the netlabel socket state on sk from parent
+ *
+ * The TODO stub interfered with stacking and was removed - Casey
  */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb,
-					    struct lsm_export *l)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
 
 /**
  * apparmor_sock_graft - Initialize newly created socket
@@ -1202,8 +1196,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
-- 
2.19.1

