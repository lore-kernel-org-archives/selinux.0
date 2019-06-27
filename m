Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7BC48BD9
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469F12054F
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 16:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0Qsl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfF0Qsl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 27 Jun 2019 12:48:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FF41C057F3B;
        Thu, 27 Jun 2019 16:48:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE67019C4F;
        Thu, 27 Jun 2019 16:48:34 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacec <omosnace@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak57 V2] selinux: format all invalid context as untrusted
Date:   Thu, 27 Jun 2019 12:48:01 -0400
Message-Id: <20b1e7b386ba06f013e5e4206cca1bb487d90a68.1561640731.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 27 Jun 2019 16:48:41 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The userspace tools expect all fields of the same name to be logged
consistently with the same encoding.  Since the invalid_context fields
contain untrusted strings in selinux_inode_setxattr()
and selinux_setprocattr(), encode all instances of this field the same
way as though they were untrusted even though
compute_sid_handle_invalid_context() and security_sid_mls_copy() are
trusted.

Please see github issue
https://github.com/linux-audit/audit-kernel/issues/57

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/selinux/ss/services.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cc043bc8fd4c..a1c89ac22f1d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1588,6 +1588,7 @@ static int compute_sid_handle_invalid_context(
 	struct policydb *policydb = &state->ss->policydb;
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
+	struct audit_buffer *ab;
 
 	if (context_struct_to_string(policydb, scontext, &s, &slen))
 		goto out;
@@ -1595,12 +1596,14 @@ static int compute_sid_handle_invalid_context(
 		goto out;
 	if (context_struct_to_string(policydb, newcontext, &n, &nlen))
 		goto out;
-	audit_log(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR,
-		  "op=security_compute_sid invalid_context=%s"
-		  " scontext=%s"
-		  " tcontext=%s"
-		  " tclass=%s",
-		  n, s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
+	ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
+	audit_log_format(ab,
+			 "op=security_compute_sid invalid_context=");
+	/* no need to record the NUL with untrusted strings */
+	audit_log_n_untrustedstring(ab, n, nlen - 1);
+	audit_log_format(ab, " scontext=%s tcontext=%s tclass=%s",
+			 s, t, sym_name(policydb, SYM_CLASSES, tclass-1));
+	audit_log_end(ab);
 out:
 	kfree(s);
 	kfree(t);
@@ -3007,10 +3010,16 @@ int security_sid_mls_copy(struct selinux_state *state,
 		if (rc) {
 			if (!context_struct_to_string(policydb, &newcon, &s,
 						      &len)) {
-				audit_log(audit_context(),
-					  GFP_ATOMIC, AUDIT_SELINUX_ERR,
-					  "op=security_sid_mls_copy "
-					  "invalid_context=%s", s);
+				struct audit_buffer *ab;
+
+				ab = audit_log_start(audit_context(),
+						     GFP_ATOMIC,
+						     AUDIT_SELINUX_ERR);
+				audit_log_format(ab,
+						 "op=security_sid_mls_copy invalid_context=");
+				/* don't record NUL with untrusted strings */
+				audit_log_n_untrustedstring(ab, s, len - 1);
+				audit_log_end(ab);
 				kfree(s);
 			}
 			goto out_unlock;
-- 
1.8.3.1

