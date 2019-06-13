Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC36C31E45
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 18:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319D921473
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 18:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfFMSnx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfFMSnx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Jun 2019 14:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0771081F22;
        Thu, 13 Jun 2019 18:43:53 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 929FE2B465;
        Thu, 13 Jun 2019 18:43:46 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacec <omosnace@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak57 V1] selinux: format all invalid context as untrusted
Date:   Thu, 13 Jun 2019 14:43:21 -0400
Message-Id: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Jun 2019 18:43:53 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

All instances of one field type should be encoded in the same way.
Since some invalid_context fields can contain untrusted strings, encode
all instances of this field the same way.

Please see github issue
https://github.com/linux-audit/audit-kernel/issues/57

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Passes audit-testsuite.

 security/selinux/ss/services.c | 48 +++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cc043bc8fd4c..817576802f7d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1588,6 +1588,8 @@ static int compute_sid_handle_invalid_context(
 	struct policydb *policydb = &state->ss->policydb;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
+	struct audit_buffer *ab;
+	size_t audit_size;
 
 	if (context_struct_to_string(policydb, scontext, &s, &slen))
 		goto out;
@@ -1595,12 +1597,22 @@ static int compute_sid_handle_invalid_context(
 		goto out;
 	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
 		goto out;
-	audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
-		  "op=security_compute_sid invalid_context=%s"
-		  " scontext=%s"
-		  " tcontext=%s"
-		  " tclass=%s",
-		  n, s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
+	/* We strip a nul only if it is at the end, otherwise the
+	 * context contains a nul and we should audit that */
+	if (n) {
+		if (n[nlen - 1] == '\0')
+			audit_size = nlen - 1;
+		else
+			audit_size = nlen;
+	} else {
+		audit_size = 0;
+	}
+	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
+	audit_log_format(ab, "op=security_compute_sid invalid_context=");
+	audit_log_n_untrustedstring(ab, n, audit_size);
+	audit_log_format(ab, " scontext=%s tcontext=%s tclass=%s",
+		  	 s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
+	audit_log_end(ab);
 out:
 	kfree(s);
 	kfree(t);
@@ -3007,10 +3019,26 @@ int security_sid_mls_copy(struct selinux_state *state,
 		if (rc) {
 			if (!context_struct_to_string(policydb, &newcon, &s,
 						      &len)) {
-				audit_log(audit_context(),
-					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
-					  "op=security_sid_mls_copy "
-					  "invalid_context=%s", s);
+				struct audit_buffer *ab;
+				size_t audit_size;
+
+				/* We strip a nul only if it is at the
+				 * end, otherwise the context contains a
+				 * nul and we should audit that */
+				if (s) {
+					if (s[len - 1] == '\0')
+						audit_size = len - 1;
+					else
+						audit_size = len;
+				} else {
+					audit_size = 0;
+				}
+				ab = audit_log_start(audit_context(),
+						     GFP_ATOMIC,
+						     AUDIT_SELINUX_ERR);
+				audit_log_format(ab, "op=security_sid_mls_copy invalid_context=");
+				audit_log_n_untrustedstring(ab, s, audit_size);
+				audit_log_end(ab);
 				kfree(s);
 			}
 			goto out_unlock;
-- 
1.8.3.1

