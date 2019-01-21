Return-Path: <SRS0=obw9=P5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EE6C2F421
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FACA20880
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 15:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfAUPgU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:36:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36354 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbfAUPgN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jan 2019 10:36:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so23891313wrp.3
        for <selinux@vger.kernel.org>; Mon, 21 Jan 2019 07:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UbSMyo3FUiO6qwWh0ZpBYNpr9P7NsFPvythw40KthYo=;
        b=DgxQbQHb4anVENPeCbkzXkZtgQqCmwnZ3IBjowj1fiUizTLscGSnIIS6wwxZC+UPdk
         zS+O4jHaw6g0X4wQR96bM0rjXoGLB+T+FrfI5I4prJUFRTGGoQsh+LPmSqQ/OYxF8X4g
         ppmGJs2ySRis57fUbil0gMPtiunNVE/9Qj+f8SqaqJjjjjsVj+IJdJS6Pn/LuY7tV0j2
         FRPmeXlvCwAKU22oO5qxqZwerzKZ4aA4UgVkXHGj1vCNkOl9LzT6+eugmHppB5KEQRO0
         P+QwYQnYweVQKO8Gk/kkaryN9n+L+0IU7FF/8jufEVXUOIU7AvmbKxU0+m+o0kz1lw87
         tjww==
X-Gm-Message-State: AJcUukcrKA/rpQJx0uFch/saPRi3fOgQeJhwBSktsCF7BtCoILhyDJXC
        /MXLpbaw0knVijKWU5YSyJfyNgCL4VxHBw==
X-Google-Smtp-Source: ALg8bN4aS2InLvrE7xLvXiO/Frq2mOS/L1r4QCyvoMqCfiEgMrglrYF3ryz/kJefwFGGoUMtONUbDA==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr30193234wrx.221.1548084971061;
        Mon, 21 Jan 2019 07:36:11 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t66sm13229844wme.15.2019.01.21.07.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:36:10 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: [PATCH v2] selinux: log invalid contexts in AVCs
Date:   Mon, 21 Jan 2019 16:36:05 +0100
Message-Id: <20190121153605.26847-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case a file has an invalid context set, in an AVC record generated
upon access to such file, the target context is always reported as
unlabeled. This patch adds new optional fields to the AVC record
(srawcon and trawcon) that report the actual context string if it
differs from the one reported in scontext/tcontext. This is useful for
diagnosing SELinux denials involving invalid contexts.

To trigger an AVC that illustrates this situation:

    # setenforce 0
    # touch /tmp/testfile
    # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
    # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile

AVC before:

type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1

AVC after:

type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 trawcon=system_u:object_r:banana_t:s0 tclass=file permissive=1

Cc: Daniel Walsh <dwalsh@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: Rename fields to "(s|t)rawcon".

 security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9b63d8ee1687..df5490db575b 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 	audit_log_format(ab, " }");
 }
 
+static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
+			 u32 sid, char type)
+{
+	int rc;
+	char *context, *rcontext;
+	u32 context_len, rcontext_len;
+
+	rc = security_sid_to_context(state, sid, &context, &context_len);
+	if (rc) {
+		audit_log_format(ab, "%csid=%d ", type, sid);
+		return;
+	}
+
+	audit_log_format(ab, "%ccontext=%s ", type, context);
+
+	/* in case of invalid context report also the actual context string */
+	rc = security_sid_to_context_force(state, sid, &rcontext,
+					   &rcontext_len);
+	if (!rc) {
+		if (strcmp(context, rcontext))
+			audit_log_format(ab, "%crawcon=%s ", type, rcontext);
+		kfree(rcontext);
+	}
+	kfree(context);
+}
+
 /**
  * avc_dump_query - Display a SID pair and a class in human-readable form.
  * @ssid: source security identifier
@@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
 			   u32 ssid, u32 tsid, u16 tclass)
 {
-	int rc;
-	char *scontext;
-	u32 scontext_len;
-
-	rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
-	if (rc)
-		audit_log_format(ab, "ssid=%d", ssid);
-	else {
-		audit_log_format(ab, "scontext=%s", scontext);
-		kfree(scontext);
-	}
-
-	rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
-	if (rc)
-		audit_log_format(ab, " tsid=%d", tsid);
-	else {
-		audit_log_format(ab, " tcontext=%s", scontext);
-		kfree(scontext);
-	}
+	avc_dump_sid(ab, state, ssid, 's');
+	avc_dump_sid(ab, state, tsid, 't');
 
 	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
-	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
+	audit_log_format(ab, "tclass=%s", secclass_map[tclass-1].name);
 }
 
 /**
-- 
2.20.1

