Return-Path: <SRS0=U9Ad=R3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4281DC43381
	for <selinux@archiver.kernel.org>; Sun, 24 Mar 2019 10:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4CF222D0
	for <selinux@archiver.kernel.org>; Sun, 24 Mar 2019 10:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl3xv5lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfCXKKN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:10:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36993 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfCXKKL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Mar 2019 06:10:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so4443539pgq.4;
        Sun, 24 Mar 2019 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jlGGEIV7cZHoWp38KFQeNPFLLCHH4bB7kg91XEBsuhQ=;
        b=Pl3xv5lgs+4aWoosnaKgbkh0cHNwFK0zuoxdcddlvwr4iRq9uEyewuKf7QSFfmSHTP
         +SSh4EURx1Ezi57QwhvDflbqM0j3+ZOmIZviSIV1NBfn6mu6qLUYbInmaj1dIX2e/m3Y
         8uBBNDRscOPS16/C0xnjt8YQSFj0busqeBALSgqmyiaNVS0zMdCzxc3tvemTOn4ff8BB
         8uPlQ3lLCEAUHSlkN6su5gLRgReLnuYLt5NYFaEIZNivrxQljlV0t0R+1YoupyWTjucR
         D6L0hGODvl0bN/M5l6ly/wP6PeqdFm+w/bpty58MTtsLKe76IdBkRmYGk+d3oGOEeSEf
         mzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jlGGEIV7cZHoWp38KFQeNPFLLCHH4bB7kg91XEBsuhQ=;
        b=kvgjTri94/y/naj+kTyQfzzEWuSEBaz99ZAAEUfn45Wce1u1CMfOT7RU39KS12J/FD
         ahPf8oRZaBZROKMdC/3r6TxRwhBJFlVCidNmqhqqZNkZ9oOc/7UjrISOh8ixoEXthHEX
         QK2oTkyMpyabGENWawHlE7GTAxKjZ4yLc3/q7SYx06ny+Z18BQ/m03JsG+TcIMAUNKkO
         2+qoZfZ6uk1if9JPmF5aFsQGKyVuQ7npSRP3DRyY7s8U3W9r/pQ5EN5GUk0jX2h23DnG
         ogvtUaWFZupMKKZCk5Rf0ctcZL7hzGIKnagdNrESdWU/VM6YGRQN5QhaeKnq+6dzphWx
         TVCw==
X-Gm-Message-State: APjAAAXhZYXBBZidxhyZ5/A/mXAMbPTBquqpJgC/bHtdmQflShhngoom
        HHSH8O7V9uvYHe68jh0bZ1M=
X-Google-Smtp-Source: APXvYqzySx8d4ZXQXvcELyfkMjrqwW9wpL6V4vDw9kUNwViYji8lEtKQoYKjxE+DxEDxwTWy5G2YqA==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr1473904pld.58.1553422210805;
        Sun, 24 Mar 2019 03:10:10 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id m25sm2754188pfa.175.2019.03.24.03.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 03:10:10 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:40:03 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
        omosnace@redhat.com, keescook@chromium.org, rgb@redhat.com,
        jannh@google.com, adobriyan@gmail.com, sgrover@codeaurora.org,
        peter.enderborg@sony.com, kent.overstreet@gmail.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: fixed parse warning Using plain integer as NULL
 pointer
Message-ID: <20190324101003.GA17131@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Changed  0 --> NULL to avoid sparse warning

Sparse warning below:

sudo make C=2 CF=-D__CHECK_ENDIAN__ M=security

 CHECK   security/selinux/ss/services.c
security/selinux/ss/services.c:1323:32: warning: Using plain integer as
NULL pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ec62918..30cea59 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1320,7 +1320,7 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	}
 	if (only_invalid && !context->len) {
 		scontext = NULL;
-		scontext_len = 0;
+		scontext_len = NULL;
 		rc = 0;
 	} else {
 		rc = context_struct_to_string(policydb, context, scontext,
-- 
2.7.4

