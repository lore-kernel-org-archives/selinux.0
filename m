Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE344C4167B
	for <selinux@archiver.kernel.org>; Fri, 25 Nov 2022 15:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKYPuG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 10:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKYPuF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Nov 2022 10:50:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1547336
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e13so6908701edj.7
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4vy3eFLQqP4wvv1ZE71PHa7+htMdMw/1aLRojabWOE=;
        b=l8msLN/++udlBmuxkrcDP63FS+dSb9B8t1A2YJYwvqIUOD79C1boy/YLbyLYMJS2Uo
         i/TTH4Tv7MCTq/OjMDqymGEtVOY92DhR/88/ir+kPBouOM0odzmj0qpu6hKcNNTkOEWK
         E4Mwif0mX31zs8f4LNy2J054SV/t1Yg1X0GsRoN1FH5HoIJo/gJyEfZ9DN5CGSxxPErY
         A1F0Tl1PxUaXn6nSwgd6nAorVp5o2oxCZIQW7wu5dUem2SGvDrTxY9QL5Y2tjuwfwNns
         g79m8j3peTvU5Fw57kIfiU+L8VgAhHgu/iBPGkcqJk/r+lM3Q5XM9kb//aon/CNp+KXI
         9UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4vy3eFLQqP4wvv1ZE71PHa7+htMdMw/1aLRojabWOE=;
        b=7OyN0jyaECn+sYcB5N+BfHRc128kazllytuOJFqDAQ2QAP4GAH4f0EF/y69eMut0QR
         d6+bonZ/HUF8oOfjNXMyq4ofz4QSXAKIRS6zAJgTMkDfOG4F7GsWi4mJZbyE8eKNxX10
         jzm+oEhcipVv4nVa0NdbG7G0fHmvoVpWTSck6KqGpdVpKxsHLf9icN0Bx0FmfpqPRqw+
         HGXo1JGSSp7/V538tKviI3hoJh6PsO5QY90N7Os+48n8SG2tyrG2p6lcDgUKUeDJdXCw
         44PsNmV9HHw7WqXyWhb83md/LFsQDX6UvZFDZbVYnJFHLfCyfUoPjUuY0KGq/F3kd06O
         G1sA==
X-Gm-Message-State: ANoB5plsa9OOO0kEc/lxKtLqvVXzxHyKl3fU76ddwLt4oQXth0mp5+5d
        TyUZUVb5Q5XGB8eofCxpmJDO3OCCROk=
X-Google-Smtp-Source: AA0mqf7WTS51myGF7RSB9gFd6mDlGcTYIy7YQ2d1ziqNZTDSeo2Sr6mgp1uV2Ihu029nJ2BTvXEEjA==
X-Received: by 2002:aa7:d816:0:b0:458:4868:814 with SMTP id v22-20020aa7d816000000b0045848680814mr36027727edq.190.1669391402309;
        Fri, 25 Nov 2022 07:50:02 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-154-194.77.3.pool.telefonica.de. [77.3.154.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090630ce00b0078df26efb7dsm1677136ejb.107.2022.11.25.07.50.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:50:01 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v4 6/6] libsepol: update CIL generation for trivial not-self rules
Date:   Fri, 25 Nov 2022 16:49:52 +0100
Message-Id: <20221125154952.20910-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125154952.20910-1-cgzones@googlemail.com>
References: <20221125154952.20910-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert trivial not-self neverallow rules to CIL, e.g.

    neverallow TYPE1 ~self:CLASS1 PERM1;

into

    (neverallow TYPE1 notself (CLASS1 (PERM1)))

More complex targets are not yet supported in CIL and will fail to
convert, e.g.:

    neverallow TYPE1 ~{ self ATTR1 } : CLASS1 PERM1;
    neverallow TYPE2 { ATTR2 -self } : CLASS2 PERM2;

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b900290a..2d5d1d6d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1201,10 +1201,23 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 			goto exit;
 		}
 
-		ts = &avrule->ttypes;
-		rc = process_typeset(pdb, ts, attr_list, &tnames, &num_tnames);
-		if (rc != 0) {
-			goto exit;
+		if (avrule->flags & RULE_NOTSELF) {
+			if (!ebitmap_is_empty(&avrule->ttypes.types) || !ebitmap_is_empty(&avrule->ttypes.negset)) {
+				if (avrule->source_filename) {
+					log_err("%s:%lu: Non-trivial neverallow rules with targets containing not or minus self not yet supported",
+						avrule->source_filename, avrule->source_line);
+				} else {
+					log_err("Non-trivial neverallow rules with targets containing not or minus self not yet supported");
+				}
+				rc = -1;
+				goto exit;
+			}
+		} else {
+			ts = &avrule->ttypes;
+			rc = process_typeset(pdb, ts, attr_list, &tnames, &num_tnames);
+			if (rc != 0) {
+				goto exit;
+			}
 		}
 
 		for (s = 0; s < num_snames; s++) {
@@ -1228,6 +1241,15 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				if (rc != 0) {
 					goto exit;
 				}
+			} else if (avrule->flags & RULE_NOTSELF) {
+				if (avrule->specified & AVRULE_XPERMS) {
+					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "notself", avrule->perms, avrule->xperms);
+				} else {
+					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "notself", avrule->perms);
+				}
+				if (rc != 0) {
+					goto exit;
+				}
 			}
 		}
 
-- 
2.38.1

