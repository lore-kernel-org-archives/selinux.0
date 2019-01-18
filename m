Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E9C43387
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 10:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C920855
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 10:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfARKGJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:06:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43316 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfARKGJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 05:06:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so14256795wrs.10
        for <selinux@vger.kernel.org>; Fri, 18 Jan 2019 02:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8hGEIFuim3oUqZ1U1zJcxU9heWtt3gj/Zx6V8CRlBE=;
        b=iqWGp0LN+iNOxuGmOO5bKaClae9ViQ3x0UktKQz3vBjspjY86Y6JOVOrh5UYC/uWYa
         nITrgdLGt8JL/1dpqtseBCp8+sJLUo1Nwx89XC1Y7dgm42oqc88QJ4oIelYhPt7/W+SC
         ervu8ylVelhpl7y46j4DcCuLxl6RQLlrCXzL2ru4SX4HqrHDLBY5CkjMPhLCpRX27y0+
         Xu4ZTNLMt0f0OZKsOnd8CXTa6mrUY+vDad9HY6mK14vT1MqO/bkqHvtNBama3gqbDSj2
         iRk9oSnSVoy2jB1IV7WtsoC0k6KWWY/TUNBAJo45foaFVho4OTUGRAYUs60sjOYz11Nz
         gHZw==
X-Gm-Message-State: AJcUukcp1w459anF3WnkPeXw8bdwF2T80my02zNgkDv6MPVFFmArQjK0
        KelKzcP0dUzsyjvAm71tJqKhpUzfXlM=
X-Google-Smtp-Source: ALg8bN7FooR9dq91QYgZS60e9CZwFp74B25vyYKBCjhLSrD4ir+LmC1cVaYr66lcxGG66Gor9CVV+A==
X-Received: by 2002:adf:83e7:: with SMTP id 94mr15918165wre.278.1547805966964;
        Fri, 18 Jan 2019 02:06:06 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v6sm44750601wrd.88.2019.01.18.02.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 02:06:06 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Steve Grubb <sgrubb@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: [RFC PATCH] selinux: log invalid contexts in AVCs
Date:   Fri, 18 Jan 2019 11:04:29 +0100
Message-Id: <20190118100429.11703-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case a file has an invalid context set, in an AVC record generated
upon access to such file, the target context is always reported as
unlabeled. This patch adds new optional fields to the AVC record (slcon
and tlcon) that report the actual context string if it differs from the
one reported in scontext/tcontext. This is useful for diagnosing SELinux
denials.

To trigger an AVC that illustrates this situation:

    # setenforce 0
    # touch /tmp/testfile
    # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
    # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile

AVC before:

type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1

AVC after:

type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tlcon=system_u:object_r:banana_t:s0 tclass=file permissive=1

Cc: Daniel Walsh <dwalsh@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

I'm not entirely sure about the record format here, so I'm Cc'ing
linux-audit and Steve for feedback. I went for optional fields to
minimize the size of the record, but maybe a different format is
preferred. If so, let me know and I'll do a respin.

Also, I accept suggestions for better field names than "slcon"/"tlcon"
("lcon" is meant as an acronym for "literal context", but I'm not sure
if that's a good name...).

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 9b63d8ee1687..4a181ed56e37 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 	audit_log_format(ab, " }");
 }
 
+static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
+			 u32 sid, char type)
+{
+	int rc;
+	char *context, *lcontext;
+	u32 context_len, lcontext_len;
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
+	rc = security_sid_to_context_force(state, sid, &lcontext,
+					   &lcontext_len);
+	if (!rc) {
+		if (strcmp(context, lcontext))
+			audit_log_format(ab, "%clcon=%s ", type, lcontext);
+		kfree(lcontext);
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

