Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E40C433EF
	for <selinux@archiver.kernel.org>; Wed, 16 Feb 2022 00:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbiBPAyO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:54:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbiBPAyN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Feb 2022 19:54:13 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB52DB4BA
        for <selinux@vger.kernel.org>; Tue, 15 Feb 2022 16:54:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f24-20020aa782d8000000b004bc00caa4c0so484765pfn.3
        for <selinux@vger.kernel.org>; Tue, 15 Feb 2022 16:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=mZG2zfA6mccfujY5Y41tgjG+ducgUvlhNThpZe8uEGk=;
        b=gZvvdfmkpRDHUT02h0bUWALV4lUF6y4RIJgo8FiKMqUTKv2A+59t4iu34IQzEOGfEz
         tMiVckbUSiHRVcOJjqc9M4+PoytGGRDRJP4ccJT3jkRAa5RLH48bmoyXH9tsX/U6bb6g
         bLQpziNdTKYZ3PHK9Sd9Zf3oZJJqSgVQ25Xd55Gf2ledS0djSdxXtizeXYNpIjl+HJxr
         odBxN/iCxGgRtotutab4nezfvn2m4qEycadf+QydHDyTyQG+GLfE5SBDe7ybKsMqFaeS
         cdf7uVybWRxTPGcUQTdko7+YzJmvO0Zt1tLVI6yDJnyVmSKBlqkve+l5+gqQ0t/4ifa4
         13IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=mZG2zfA6mccfujY5Y41tgjG+ducgUvlhNThpZe8uEGk=;
        b=k7Xlbda598/XgsJhmGeHGLnZ60z/JtUGR+sQBxJWDomG6GvUhJK/PmEaqZ8THjSgl+
         nXIG5SdzTYEbq9+2pke7ILH+JomIUC36yBVBl/8ebb4Wrf3UtCBXdiYDDw2T57J+FmHf
         +LSkRoXLjfxVaacyRB+ovNKcH0nhFya2F434XxOHY/ulBo16l5HGz9JXVJx8F0hPIB21
         dxTS4OuLixckCjlJeiZM89IkDYKzqECvXtvMhutMdYbl5nCnu2TLWG17OGNh2FiKAgAn
         OFnb6Fx0jMM7banXohnXCZJKLdvlpc5cjSPPOlv1qqbv6KrLzRaLNQop8HE1DmdzLrFV
         Bhuw==
X-Gm-Message-State: AOAM532Z/g8dbbrT6hsP0hS9AOzqzhOWcTfC7lfsId6Ty5C8SfWxbZ1T
        lMH9quauxVqPJQAkExkcjlcM9ovG4DtjDNzQ67fYpLkIvYJUxrP1zXAHb64ckzJCMFRpWEzTMyv
        /kqmBrQNKCkufd0HLlUfW+HIO6ankHYen1mOND3hl92PWrf1mzCIShZgwCY2M
X-Google-Smtp-Source: ABdhPJzRlEjCngLPD1hCdCzaUMwiHxAckWE/RKnzOi3eat0VaGr1Hvgv84FvocgYKAkTHRuRQc6/2xflew==
X-Received: from tweek.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:280])
 (user=tweek job=sendgmr) by 2002:a62:7554:0:b0:4e1:5898:4fbb with SMTP id
 q81-20020a627554000000b004e158984fbbmr528735pfc.2.1644972842092; Tue, 15 Feb
 2022 16:54:02 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:53:26 +1100
Message-Id: <20220216005326.1899481-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2] libsepol: Populate and use policy name
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     selinux@vger.kernel.org,
        "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>
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
v1 -> v2: Fix leak reported by Christian G=C3=B6ttsche

 checkpolicy/module_compiler.c |  1 +
 checkpolicy/parse_util.c      |  1 +
 libsepol/src/assertion.c      | 20 ++++++++++++++------
 libsepol/src/expand.c         |  3 +++
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 5f5b0b19..129650fa 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -99,6 +99,7 @@ int define_policy(int pass, int module_header_given)
 				yyerror("no module name");
 				return -1;
 			}
+			free(policydbp->name);
 			policydbp->name =3D id;
 			if ((policydbp->version =3D
 			     queue_remove(id_queue)) =3D=3D NULL) {
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
2.35.1.265.g69c8d7142f-goog

