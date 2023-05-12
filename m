Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1344BC77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 09:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbjELJXY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjELJXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 05:23:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47976100D2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so14936378a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 02:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883400; x=1686475400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoMrW3V/A9N7wPCXJJGIbTzi79/73RaSfdPxcPy3rCc=;
        b=rALDDYIdW92Kx1brJwGeGf69M5BpKy8pnfFd/K+OhOoilAWpiv1l9vu5RgfTW7WySG
         PiNPNxxeDsScWOKNKRoCq93NJr/PITLKNPAE2fswsyO4ro28N2o+X0O15qZrNMOHjLXk
         mGFqfcZH+t8zvc8GKweF9KNGFCYT1ERZicWcVQIpXg/yhYA/FwCZu3RiqWn65N8uwFSa
         VoacHHUTzyrBplfzIOLNDDR0n5L2P+/o+eBU7FBJNkqP+LVvOcSLJnhZPiq/zy5EpCI0
         iJjq8SeFPBkP5GkdX7tmz6tThuqiku7gevDQ3Pw40hrPRWWJzbUqrDi/p7OpbZKIvrWm
         I3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883400; x=1686475400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoMrW3V/A9N7wPCXJJGIbTzi79/73RaSfdPxcPy3rCc=;
        b=BzI+mk9XwnEm158Tx06uSktjmUemYFROH9iNKQmiS8fVsD/pxoqa4dndNx/z6eHaUa
         akxmmrXYvYQWOPAjCs6aV/G4E15O8VWhjTnvjODuSu903gXkPZSk/gurac74vxn/bpa4
         3oe3anbzYUikmiHwU1nr2gJdaE/a2CAt/WC2d9E9TvtH68IGCzH+7lhLRvaLUgSCadCO
         PGPVnqXTSo0v0PiwzPJAEsi9T39dFV7vA6sYMUOguWvOM9acnPLFgv0l/OK1xF8K3bnn
         yNmtgi2VP5j3HLrpQImGs5biO7s8rVpflq4VR2uprbo0/F6eS3YNMnymGzI34D7S7EvP
         Nv6g==
X-Gm-Message-State: AC+VfDzw5EIzsFTgB/LVPF0PoFoJpLwcvBoqIFS5FLfbCNgwK9ruPPlE
        zU+3ewDZ3ra/5NFVaEGwfS7XNK14YwU58A==
X-Google-Smtp-Source: ACHHUZ5X7xBj+5Ozo5y2oOCfDEjZ1eG5F5tJaRg0bm2fO83/RPqLOxNW4eCQIxS8rhAytulrkGc7JQ==
X-Received: by 2002:a17:906:ee8e:b0:95e:c549:9ace with SMTP id wt14-20020a170906ee8e00b0095ec5499acemr20711828ejb.62.1683883399607;
        Fri, 12 May 2023 02:23:19 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id de25-20020a1709069bd900b0096664376ec9sm5186040ejc.55.2023.05.12.02.23.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:23:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] checkpolicy: only set declared permission bits for wildcards
Date:   Fri, 12 May 2023 11:23:10 +0200
Message-Id: <20230512092311.42583-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512092311.42583-1-cgzones@googlemail.com>
References: <20230512092311.42583-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When setting permission bits from a wildcard or complement only set the
bits for permissions actually declared for the associated class.  This
helps optimizing the policy later, since only rules are dropped with a
complete empty permission bitset.  Example policy:

    class CLASS1
    sid kernel
    class CLASS1 { PERM1 }
    type TYPE1;
    bool BOOL1 true;
    allow TYPE1 self : CLASS1 { PERM1 };
    role ROLE1;
    role ROLE1 types { TYPE1 };
    if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
    user USER1 roles ROLE1;
    sid kernel USER1:ROLE1:TYPE1

Also emit a warning if a rule will have an empty permission bitset due
to an exhausting complement.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 95cd5c85..cef8f3c4 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2511,6 +2511,8 @@ int define_te_avtab_extended_perms(int which)
 	return rc;
 }
 
+#define PERMISSION_MASK(nprim) ((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
+
 static int define_te_avtab_helper(int which, avrule_t ** rule)
 {
 	char *id;
@@ -2616,8 +2618,8 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 			cladatum = policydbp->class_val_to_struct[i];
 
 			if (strcmp(id, "*") == 0) {
-				/* set all permissions in the class */
-				cur_perms->data = ~0U;
+				/* set all declared permissions in the class */
+				cur_perms->data = PERMISSION_MASK(cladatum->permissions.nprim);
 				goto next;
 			}
 
@@ -2625,7 +2627,16 @@ static int define_te_avtab_helper(int which, avrule_t ** rule)
 				/* complement the set */
 				if (which == AVRULE_DONTAUDIT)
 					yywarn("dontaudit rule with a ~?");
-				cur_perms->data = ~cur_perms->data;
+				cur_perms->data = ~cur_perms->data & PERMISSION_MASK(cladatum->permissions.nprim);
+				if (cur_perms->data == 0) {
+					class_perm_node_t *tmp = cur_perms;
+					yywarn("omitting avrule with no permission set");
+					if (perms == cur_perms)
+						perms = cur_perms->next;
+					cur_perms = cur_perms->next;
+					free(tmp);
+					continue;
+				}
 				goto next;
 			}
 
@@ -3549,8 +3560,6 @@ static constraint_expr_t *constraint_expr_clone(const constraint_expr_t * expr)
 	return NULL;
 }
 
-#define PERMISSION_MASK(nprim) ((nprim) == PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
-
 int define_constraint(constraint_expr_t * expr)
 {
 	struct constraint_node *node;
-- 
2.40.1

