Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ABCC43462
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CBE61376
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEKUEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 May 2021 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhEKUEW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 May 2021 16:04:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADBC06174A
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:14 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x8so20072303qkl.2
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7fqCYZsG61FPsk90V39010ZHwPFqE7pWXhqkZJPogU=;
        b=iTPH6Iz1+VwzOJCiM3wR+fbAmrgZuld23prxyDFzIBfPxMqj1vo9e4M7RddLM0mYmi
         PiaiL19+24PoKVEjL6kdeWheHAecfShG4e7A8Ne5EBrny0H1fad/s6ec7AvqBd//vmmm
         Du7bQW7vUwX13zjbR1Gft7HFhlLnIC8TXQT/3KhV1cVzfdUDAz96sWRHfGyfpsX7AAiV
         Aa1HkInF4PtTbEVBfF4WubyZ8qWwLCrrTh0Hx/DJkrRbgUOFM13tFKEmLC4+T4m58Ny1
         RJVKGAG1n0IPF82s7fNszsH8lNP/H1zpynrsLlhnJ/HgKvX2/lrJU4cLKeP4aIH9vz83
         ThlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7fqCYZsG61FPsk90V39010ZHwPFqE7pWXhqkZJPogU=;
        b=i54kAssg7krN7Z2K5GPQ6vIxOm3BDTv6tT+z+5O17GYTNyYHbw0/U6amcjZ8GIdBjl
         XCF/51YgCMjKBJ4aLEMmaf/ugVl9VgStmu3lGE2SmlAAnrSt7DiTJfdTYa/WHeSNMNt1
         9MTVVEenFRBE1MsBH9SZpH2LPhuB4Z1d1OnjNCUEmaR9rL3PnzQ7YBD1YVN4RHhqbEED
         LhPMjQSacQOLF/oSQGKwhMegsMD7dhwESdpxsjymOvpbTTGr3q08dlx0vAYCsT60Z2Si
         wTr60WK9AR/6U/QbsQszhgkrlxKDkw7up8iBSbRZWkwzmeW/zHJqfDRrbQ6lASVFi2Q5
         q2qQ==
X-Gm-Message-State: AOAM533vTz4GGWZLgNU0/VDyHXyVA4GM7ZqX30AbbZ6UjNNrXM45GfPl
        CZsAwXIKzOaelpA6IvSgxbbmOJfiCW3ErQ==
X-Google-Smtp-Source: ABdhPJzvtnNSoOLxJOqEYR+ryvKjXtc1Z4DxXm28aFqO8tdfsjPesWhginMRQRnq2+EWf6f5eWSVSQ==
X-Received: by 2002:ae9:e71a:: with SMTP id m26mr19980679qka.36.1620763394006;
        Tue, 11 May 2021 13:03:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z9sm4642533qtf.10.2021.05.11.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:13 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5 v2] libsepol/cil: Do not resolve arguments to declarations in the call
Date:   Tue, 11 May 2021 16:03:00 -0400
Message-Id: <20210511200301.407855-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511200301.407855-1-jwcart2@gmail.com>
References: <20210511200301.407855-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Lorenzo Ceragioli <lorenzo.ceragioli@phd.unipi.it> noted that the
following policy:
  (type a)
  (block A
    (macro m ((type x))
      (type a)
      (allow x x (file (read))))
  )
  (block B
    (call A.m(a))
  )
results in the allow rule (allow B.a B.a (file(read))). This makes
no sense because the "a" being passed as an argument has to be the
global "a" and not the "a" defined in the macro.

This behavior occurs because the call arguments are resolved AFTER
the macro body has been copied and the declaration of "a" in the
macro has been added to block B's namespace, so this is the "a"
that the call argument resolves to, rather than the one in the
global namespace.

When resolving call arguments, check if the datum found belongs to
a declaration in the call. If it does, then remove the datum from
the symbol table, re-resolve the argument, and add the datum back
into the symbol table.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index b96118ce..d416ce75 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3287,11 +3287,37 @@ int cil_resolve_call_args(struct cil_tree_node *current, void *extra_args)
 		}
 
 		if (sym_index != CIL_SYM_UNKNOWN) {
-			rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &(arg->arg));
+			struct cil_symtab_datum *datum;
+			struct cil_tree_node *n;
+			rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &datum);
 			if (rc != SEPOL_OK) {
 				cil_tree_log(current, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
 				goto exit;
 			}
+			arg->arg = datum;
+			n = NODE(datum);
+			while (n && n->flavor != CIL_ROOT) {
+				if (n == current) {
+					symtab_t *s = datum->symtab;
+					/* Call arg should not resolve to declaration in the call
+					 * Need to remove datum temporarily to resolve to a datum outside
+					 * the call.
+					 */
+					cil_symtab_remove_datum(datum);
+					rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &(arg->arg));
+					if (rc != SEPOL_OK) {
+						cil_tree_log(current, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
+						goto exit;
+					}
+					rc = cil_symtab_insert(s, datum->name, datum, NULL);
+					if (rc != SEPOL_OK) {
+						cil_tree_log(current, CIL_ERR, "Failed to re-insert datum while resolving %s in call argument list", arg->arg_str);
+						goto exit;
+					}
+					break;
+				}
+				n = n->parent;
+			}
 		}
 	}
 
-- 
2.26.3

