Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE6FC433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 21:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57FF20693
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 21:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM3I7P2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEMVPU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgEMVPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 17:15:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5086C061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 14:15:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y22so926413qki.3
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/jR/gmdr1dEwmznV9jcJ2FGFyDZqZIBHulyPg2p7LY=;
        b=XM3I7P2blqqxUTS9t1AaUSApswfVLnHs2OmCA/QfgLqB0mxHkkh+h4ssfnzQYKKwCr
         HcBhXUDRREgeyGGHZRuamPuJPEd/gfAS4np5a/DhdYkdKpQ0RWhJtR8oPtLUhtM1vgDw
         z4ihJCfe+vywGndd7PTvAEytZPFjukBYt7obu0CuEQo3o870PsanaNwvHRFmuAyhWHpT
         VEfZ4wFj/RtQ9mhxnR1x9CCFAYpBMzvIdiliLZkr/hlpU511Ojjhr8oj4+flEsUP8t9l
         N1wXx5ilThsR362LE3sSVhhoH/M+KUNQUNfkRL2Wa3GLv1SrIpSd//2IAsGLeVa9SXF1
         ot6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/jR/gmdr1dEwmznV9jcJ2FGFyDZqZIBHulyPg2p7LY=;
        b=IcWE3OQShuoI65qDIPgJ06R2M8V+4TAFL9iXwS31mbM5Un4iSuNIE3e/6Ckln1zpnY
         ki8y4qJb1nSuhgrN6R2u8Q3jXDZnvpyJ3BB4vtMVz2LG65K9apO68FDVcFxAmCpzECgy
         M0IE/EdITwlL49mOmSdr8MVknWKnlq3KbraSHwAg7546gvgN0RHzA3yZV7qt9D2FQE4j
         xrsq3WpF5NQwvxC3rKQUnx8j5kAymzcrw3qVHi4MgG8D6LQduuzzXe7AtG7IPQRz0hdV
         WF7uDXb7NrT0qzAcatV9f9xyQ/f872tbRv5N1VOTrzciG0CVaSmoMOwyZRgLeblxN9xT
         A0Tg==
X-Gm-Message-State: AOAM530CjpWqfE38nA1dUVw7YKufPbtuHM7s12u2Oj6H3BCnejfwQF23
        X1bU0R3qck6WqOdVC89+bTbl6Q8m
X-Google-Smtp-Source: ABdhPJyHYNVq+vwD9rMmb/rGyA8a68FqwmduUKWULG916v+bUhz2IgkEJFh7qU2Kks/jMMLwmIILqQ==
X-Received: by 2002:a37:d0a:: with SMTP id 10mr1737059qkn.288.1589404518805;
        Wed, 13 May 2020 14:15:18 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id m7sm778368qti.6.2020.05.13.14.15.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 14:15:18 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: drop broken warning on duplicate filename transitions
Date:   Wed, 13 May 2020 17:15:08 -0400
Message-Id: <20200513211508.4477-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As per the issue below, libsepol segfaults on loading old kernel policies
that contain duplicate filename transition rules.  The segfault is due to
the fact that the val_to_name arrays have not yet been populated at this
point in the policydb_read() processing.  Since this warning apparently
never worked since it was first introduced, drop it and just silently
discard the duplicate like the kernel does.  I was not able to produce a
policy with such duplicates using the current policy toolchain, either
via CIL or via binary modules with manual semodule_link/expand.

Fixes: https://github.com/SELinuxProject/selinux/issues/239
Fixes: 8fdb2255215a1f14 ("libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/policydb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 5b289a52..3992ea56 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2655,15 +2655,8 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
 			 * Some old policies were wrongly generated with
 			 * duplicate filename transition rules.  For backward
 			 * compatibility, do not reject such policies, just
-			 * issue a warning and ignore the duplicate.
+			 * ignore the duplicate.
 			 */
-			WARN(fp->handle,
-			     "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
-			     p->p_type_val_to_name[ft->stype - 1],
-			     p->p_type_val_to_name[ft->ttype - 1],
-			     p->p_class_val_to_name[ft->tclass - 1],
-			     ft->name,
-			     p->p_type_val_to_name[otype->otype - 1]);
 			free(ft);
 			free(name);
 			free(otype);
-- 
2.23.3

