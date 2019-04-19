Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4213C282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B92217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fOeqevvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDSArq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:46 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:39558 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfDSArq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634864; bh=VEDYIM3R1NMqedNbn6scDMcxUUfpt0y9Ccbwl5mHx6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fOeqevvMPv7pjLmpfcQal/at3X86AUsA5xAZZ1njeXPE1wlW9pyIB9/9paJhQTlpo/NURJkXYEZ9qLQnyJNkL4vtsW8gMFXmPjXJJhK9KdHoo2Pg/mXmXUykmAEEq5q/iZzYtij4zucR0MyS82JjgqybxwnkV5mhX1psiFzqD/CP7bh2331E7srFWN1VdJJdouEKgThEzFzsOawEuuBthpVcSs2ZtusNIFz9NkJffBHzADoSxZHE6BhVNaFLF1TPzRA57LMQ79oIQqi+mcB+CnQ13ZPrpGmTu7rTxrVa26DZEpj7ob1lZd9G2keFO0O2r+IrxvqHRAwdfdXcmFi3WA==
X-YMail-OSG: RpaJTzgVM1n3Q4v9gZHV17NdXQaVX195ckS6GfPsG8FdcldaAC5aQhjKve_1BPF
 ieX9KtTJXO3wrlVy55iWGcM_0.3jy8V5QcCAFXXrUfsMArjsy_dYrJ868wY4KxfZ_rTP989n9gbA
 EaOv9PPjfh7XLqsvFInBeJNClPgYYhKvGHC6MqRqo.5n6PB6owJluZilpachmIkwQU5MNT_wm5Vz
 jM_5.kwGZWpARfVa2R.wmz5WjzDjJhlRuetPU06BCuxo6zv7iXgIluNeIsMKAloIgTCRVNn_rvLC
 1SP6Ht9rTbcGfQ5.POjDqZRe7o6InsRe5x4nmrkhONUIDvc_bxng9F9FvkwQP6qJ0UOmlgf_N.5t
 Y5K6u1tSe2x6_qtAjYLzFuK.EfSi_vAtuSB16UdOSsHDWm7p_qeyyRgHrzM0ZgNivs.XFTeYKJRf
 n.Hy_RJCZmvTymtFDEC02cd6UZFoFJXlX2JuG8Rylxca7EllcrTMEY_BPzyOQg3d7A4hifY1RjTM
 EBvQLVtjp8fVtzR6kow_EGWUNtszDqWC6nEbBn6EFfX8I3L7N_zVLcQjGHh9DDBqENYC3F6tTjku
 .Fg1Zv7QgWCT1GMzNnTGX3qPbor968hDiuDEMtlJNhqtJOz4FA9WnOD8UhzGSNJC4ecc1_K5r1Ek
 HRoca4kYGpnWNWCe2IV8Ao5Ylph77P0ikPXDOhboBR96ylp4T4OM2TLJ5QFCoeJVVPgCo0SdamQt
 5uvZqdj.26iW7tp8.qPZ6adaLqsRwbpQD1FFjcl6WnsmcgjCDE0vBmtLba0YDwbj9_UE20GqstP.
 dfRKcML6uIW1JwgC6Wc3ylKF.sVMssLA2qVc7wu45oTtSaRoCCAro.orngcPtehSRlqHHmtqCuBi
 5fsqhlmCnFW4wIIPyKiBshbaXFxe_E4MNnoIdnDKaUpOd1uKK3mF3Faw70c5L.1QyD7x.Q4rj5k0
 PSkmIWsPznSK3hFfZ7l5WZgzV_LBQD.wS.UKjkSSJq4m8rdXS9VgisUSPfJWJMFcOo8ooyZEWDvQ
 gFFHUE6lSK2pZhOd8zoadjzbMnbyzds4PUNJRvleA.mwifJiqGymfCtryLu6AVztsiWwOeQIZpeV
 xJ8LFn6QuxETIH9zjnmr7XUgxnNwDwiS6vwfTfxNebejaHvGSYM3j3G9o7W7SHKi4Awr_SzNrZif
 Iry.kfj36Gfrs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be9fa3e2c75d2b77c1de47e4a712b0c9;
          Fri, 19 Apr 2019 00:47:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 35/90] AppArmor: Remove unnecessary hook stub
Date:   Thu, 18 Apr 2019 17:45:22 -0700
Message-Id: <20190419004617.64627-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

