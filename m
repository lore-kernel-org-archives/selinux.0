Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25ABC433F5
	for <selinux@archiver.kernel.org>; Mon, 31 Jan 2022 01:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357274AbiAaBEv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 30 Jan 2022 20:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiAaBEv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 30 Jan 2022 20:04:51 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E745C061714
        for <selinux@vger.kernel.org>; Sun, 30 Jan 2022 17:04:51 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ga20-20020a17090b039400b001b536800e04so6250526pjb.7
        for <selinux@vger.kernel.org>; Sun, 30 Jan 2022 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bf17KGmlD9d+sx3unmulkrmFFqs3m9h4FKvJ2ZKfrxI=;
        b=QRf1klHG5rUNZEkTtuHKebkAyIz6e3w45N2DXDDmvbtonLXx58JHng0pyyOcjZNpjg
         5b9zcR3j1pvW9Hz7+y76DTKIKyDvDu1y13u/rezH2u1goDgjdw3h6O7qUeZTKASpiiTU
         kxPhTvT3SnWB4zuSyVJud+3ShaelT8B6UAcYj590cCiVbPohYh6oBPG4sxIQBwlG6gj2
         KFOeIpPw+T/cUXCYcUMzW41bbeKoJNmCbxzcG0nzbAObef7yEP5A8f9B+VExtBLOzk0m
         QozuVmXzPxNI4qgZG/z8avjIsYEakKZq3mkc4rW6smKQFfZo6ykZLrgc/cJOjGFC13vz
         9aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bf17KGmlD9d+sx3unmulkrmFFqs3m9h4FKvJ2ZKfrxI=;
        b=DB0T3pf0sTIGWA3lw58MwdwC+1HLIO9Et945yQzhtk4qKsrUTpILgVZxUQvu0Zleo0
         3sxJbO9vDDRk/RsNyHUyNpXIlOHbvFp+QSxYKwh1JDY4aHz+ivbsWb5vB+IIHrlo8LgV
         C/HGoXDgBYvp8WgNdxEvc8G0WlSRRX5YyrbsbaxsEquPXeqML0gpjiZVUTbAPpHKxNpa
         s/71zxezxrkZYBdRJ5hXSVnu6VaJIIWNJeAFPenBkfU7E76y4TZ5ChgS9JXdWuQHS5V7
         WbhguiQiQ316uwgLzkWS1D7bVop6W9yFAx6QTigNWoxD+AhIByNEqp02s2xL68SLU3x8
         Fk3Q==
X-Gm-Message-State: AOAM530iSWDmRZ6oSPqIh/h0xUk6DCNNXkHcy7HWm+s91qNAQm8Aczw7
        sAgDDRNvf5WSZw8lvJo7Z8P1pwibJti3gjsGeX01VoKH9h9dATQ6snqZrNu1badhMyLnAY3n8XK
        3CL69iRbOr3GOkCFTdXmca2eHwRckYF0F4XgCaNB7wSwN20eDMCOUWXXpCik1
X-Google-Smtp-Source: ABdhPJx7AA2L5zHA0U8355DyrDiL30KFUs4JDsa1H3RYn+obO81vv5XYdgwhxzCste0wske6u6K8aEYtNA==
X-Received: from tweek.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:280])
 (user=tweek job=sendgmr) by 2002:a17:90b:118d:: with SMTP id
 gk13mr22142595pjb.119.1643591090652; Sun, 30 Jan 2022 17:04:50 -0800 (PST)
Date:   Mon, 31 Jan 2022 12:04:21 +1100
Message-Id: <20220131010421.1960196-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] libsepol: Populate and use policy name
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     selinux@vger.kernel.org
Cc:     jeffv@google.com, alanstokes@google.com,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When an assertion fails, the error message refers to a generic
"policy.conf" file. When parsing a policy in checkpolicy, populate its
name using the original filename (source_filename is still build using
the #line directives within the policy).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 checkpolicy/parse_util.c |  1 +
 libsepol/src/assertion.c | 20 ++++++++++++++------
 libsepol/src/expand.c    |  3 +++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
index 8c1f393c..f2d1e04d 100644
--- a/checkpolicy/parse_util.c
+++ b/checkpolicy/parse_util.c
@@ -47,6 +47,7 @@ int read_source_policy(policydb_t * p, const char *file, =
const char *progname)
 	}
=20
 	policydbp =3D p;
+	policydbp->name =3D strdup(file);
 	mlspol =3D p->mls;
=20
 	init_parser(1);
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..74f6d9c0 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -36,13 +36,21 @@ struct avtab_match_args {
 	unsigned long errors;
 };
=20
+static const char* policy_name(policydb_t *p) {
+	const char *policy_file =3D "policy.conf";
+	if (p->name) {
+		policy_file =3D p->name;
+	}
+	return policy_file;
+}
+
 static void report_failure(sepol_handle_t *handle, policydb_t *p, const av=
rule_t *avrule,
 			   unsigned int stype, unsigned int ttype,
 			   const class_perm_node_t *curperm, uint32_t perms)
 {
 	if (avrule->source_filename) {
-		ERR(handle, "neverallow on line %lu of %s (or line %lu of policy.conf) v=
iolated by allow %s %s:%s {%s };",
-		    avrule->source_line, avrule->source_filename, avrule->line,
+		ERR(handle, "neverallow on line %lu of %s (or line %lu of %s) violated b=
y allow %s %s:%s {%s };",
+		    avrule->source_line, avrule->source_filename, avrule->line, policy_n=
ame(p),
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
@@ -173,9 +181,9 @@ static int report_assertion_extended_permissions(sepol_=
handle_t *handle,
 				/* failure on the extended permission check_extended_permissions */
 				if (rc) {
 					extended_permissions_violated(&error, avrule->xperms, xperms);
-					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy=
.conf) violated by\n"
+					ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) vi=
olated by\n"
 							"allowxperm %s %s:%s %s;",
-							avrule->source_line, avrule->source_filename, avrule->line,
+							avrule->source_line, avrule->source_filename, avrule->line, policy_=
name(p),
 							p->p_type_val_to_name[i],
 							p->p_type_val_to_name[j],
 							p->p_class_val_to_name[curperm->tclass - 1],
@@ -190,9 +198,9 @@ static int report_assertion_extended_permissions(sepol_=
handle_t *handle,
=20
 	/* failure on the regular permissions */
 	if (rc) {
-		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of policy.co=
nf) violated by\n"
+		ERR(handle, "neverallowxperm on line %lu of %s (or line %lu of %s) viola=
ted by\n"
 				"allow %s %s:%s {%s };",
-				avrule->source_line, avrule->source_filename, avrule->line,
+				avrule->source_line, avrule->source_filename, avrule->line, policy_nam=
e(p),
 				p->p_type_val_to_name[stype],
 				p->p_type_val_to_name[ttype],
 				p->p_class_val_to_name[curperm->tclass - 1],
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 8667f2ed..7da51a40 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2970,6 +2970,9 @@ int expand_module(sepol_handle_t * handle,
=20
 	state.out->policy_type =3D POLICY_KERN;
 	state.out->policyvers =3D POLICYDB_VERSION_MAX;
+	if (state.base->name) {
+		state.out->name =3D strdup(state.base->name);
+	}
=20
 	/* Copy mls state from base to out */
 	out->mls =3D base->mls;
--=20
2.35.0.rc2.247.g8bbb082509-goog

