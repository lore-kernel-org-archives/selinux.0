Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1447AC33CA3
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF93206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 10:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="CHKE/Ajc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAJKOn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:14:43 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25889 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgAJKOn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 05:14:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578650363; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LPNKhYD8VGGM3LlOvpkvz4S9ACqCUh4yp3mupX2mqzgp9x1omeg/7mvIiTsDpsTHyVVqJS+QUCZmei1q/tvXFTyeUkp8Q37erGa7Gm4qHuDlyeIoA2FeF3hZSAdqA0tgbh/Bvs16pKErfTS9RoBW04HRg8xdPGTHW+JtM8MBYcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1578650363; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=6k+ob4mND5uhGYNS0aLLe9mkja1bcLdOMMO7jcUWhUo=; 
        b=ZSVBhOl6iI8eQVqe5qm70vgMz6PZeU7tH/5ECA9xpWgXCGBlClXJUoBqOytQor0TMXHqbSjT/Dc4ecK/upGfLUhvzrW+KOtbr9AGn7FHutzjmNDkiovzS6out02Z2Jc0vy0DPwP+1CT8z80f2nLCdgcCzhrRIaLCym1wl+U0+Dw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=ejW7ZWQ5OyE9/795JUKXZ6EzmelpS/1GJpbI1mGTt6CO4wZHYu0QoblwEPkYIaERRiuRU91QqmlJ
    U9DjHv4BALJHW7XObKvsXgjcjNLKGF2c56dOG/a5M8a7ymfizR8F  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1578650363;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=6k+ob4mND5uhGYNS0aLLe9mkja1bcLdOMMO7jcUWhUo=;
        b=CHKE/Ajc7XKpwGamfC/RhaTQUAM0SXRRovodAMD+cT/cQc+EpZSnQK3V4zmnz1Oz
        9QCTpc85rLAuLPFJ0xGWClaRLX03T+/F7TA+bZu8Th+JqlsSwZ2qS8dmFglxo2rGJJg
        MFQZiJfdx6ohi553PqJk/5uviWRdunUqJ/ttm+QY=
Received: from YEHS1XPF1D05WL.lenovo.com (221.219.123.16 [221.219.123.16]) by mx.zohomail.com
        with SMTPS id 1578650359384351.6084037024035; Fri, 10 Jan 2020 01:59:19 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        jmorris@namei.org, serge@hallyn.com
Cc:     tyu1@lenovo.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] selinux: remove redundant msg_msg_alloc_security
Date:   Fri, 10 Jan 2020 17:58:56 +0800
Message-Id: <20200110095856.76612-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
do nothing else. And also msg_msg_alloc_security is just used by the
former.

Remove the redundant function to simplify the code.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 security/selinux/hooks.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99..fb1b9da 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5882,16 +5882,6 @@ static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
 	isec->sid = current_sid();
 }
 
-static int msg_msg_alloc_security(struct msg_msg *msg)
-{
-	struct msg_security_struct *msec;
-
-	msec = selinux_msg_msg(msg);
-	msec->sid = SECINITSID_UNLABELED;
-
-	return 0;
-}
-
 static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 			u32 perms)
 {
@@ -5910,7 +5900,12 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
 {
-	return msg_msg_alloc_security(msg);
+	struct msg_security_struct *msec;
+
+	msec = selinux_msg_msg(msg);
+	msec->sid = SECINITSID_UNLABELED;
+
+	return 0;
 }
 
 /* message queue security operations */
-- 
1.8.3.1


