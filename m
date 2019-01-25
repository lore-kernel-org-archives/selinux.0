Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9716EC282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B18218A2
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfAYKHz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:07:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44800 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfAYKHy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 05:07:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so9598882wrt.11
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 02:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahfiFzkzW3c7iFI8v5bmrruVllmd62YbhhBJcLq3gVA=;
        b=S03cCsPqLwqnY/ggAIUOAaWWLRCXbpfCwTRUckYJhmAFzdPETbuxhitpan8jmFMUy0
         /OkeJPkG82TqzbUbVuVFrclx8zoBrpXf0g4e/6hK88X0/3bcNk7NEJo388XuUGF/uxNr
         JznL89nF0S9LB31uqW9Y82Hzq47UNcQc4N+Fqw1XDbWoQGYYIP9i++HTyONXnC+Lg02F
         rqvVhsJwcpBXXw/psnSn05f/PS4DCbOO7QipoPHVc5Pc5PKK6GShDjz9jqtR0sflnswy
         5BjRoeGesmGdnLp4zDyf+EzEYWkSOD4Je3oSXN0WeNenxZ6LAZVogCEXK7MpwhUtA8Fq
         2tjQ==
X-Gm-Message-State: AJcUukdLhaBu6BiCKNOiXAHtJtPwUQIN20vVS9wrDtFSzjSwYwpuWWwn
        eGw9xy/5RuBdlsT9WsIdIo24nRyZYIM=
X-Google-Smtp-Source: ALg8bN4Tu3rqCq7YWEDiC6MFZj5P7QXxKt7GzkmkPPJYpEwhBl9MGtkwECvbS37dvh78tEmbX/qMzA==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr10317943wri.210.1548410871877;
        Fri, 25 Jan 2019 02:07:51 -0800 (PST)
Received: from p600.fit.wifi.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id v6sm89155089wro.57.2019.01.25.02.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:07:50 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: [PATCH v3 4/4] selinux: log invalid contexts in AVCs
Date:   Fri, 25 Jan 2019 11:06:51 +0100
Message-Id: <20190125100651.21753-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125100651.21753-1-omosnace@redhat.com>
References: <20190125100651.21753-1-omosnace@redhat.com>
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

type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1 trawcon=system_u:object_r:banana_t:s0

Note that it is also possible to encounter this situation with the
'scontext' field - e.g. when a new policy is loaded while a process is
running, whose context is not valid in the new policy.

Cc: Daniel Walsh <dwalsh@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/avc.c              | 15 ++++++++++++
 security/selinux/include/security.h |  3 +++
 security/selinux/ss/services.c      | 37 +++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 478fa4213c25..047de65589bd 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -734,6 +734,21 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 
 	if (sad->denied)
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
+
+	/* in case of invalid context report also the actual context string */
+	rc = security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
+					   &scontext_len);
+	if (!rc && scontext) {
+		audit_log_format(ab, " srawcon=%s", scontext);
+		kfree(scontext);
+	}
+
+	rc = security_sid_to_context_inval(sad->state, sad->tsid, &scontext,
+					   &scontext_len);
+	if (!rc && scontext) {
+		audit_log_format(ab, " trawcon=%s", scontext);
+		kfree(scontext);
+	}
 }
 
 /* This is the slow part of avc audit with big stack footprint */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ba8eedf42b90..f68fb25b5702 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -255,6 +255,9 @@ int security_sid_to_context(struct selinux_state *state, u32 sid,
 int security_sid_to_context_force(struct selinux_state *state,
 				  u32 sid, char **scontext, u32 *scontext_len);
 
+int security_sid_to_context_inval(struct selinux_state *state,
+				  u32 sid, char **scontext, u32 *scontext_len);
+
 int security_context_to_sid(struct selinux_state *state,
 			    const char *scontext, u32 scontext_len,
 			    u32 *out_sid, gfp_t gfp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index dd44126c8d14..9be05c3e99dc 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1281,7 +1281,8 @@ const char *security_get_initial_sid_context(u32 sid)
 
 static int security_sid_to_context_core(struct selinux_state *state,
 					u32 sid, char **scontext,
-					u32 *scontext_len, int force)
+					u32 *scontext_len, int force,
+					int only_invalid)
 {
 	struct policydb *policydb;
 	struct sidtab *sidtab;
@@ -1326,8 +1327,14 @@ static int security_sid_to_context_core(struct selinux_state *state,
 		rc = -EINVAL;
 		goto out_unlock;
 	}
-	rc = context_struct_to_string(policydb, context, scontext,
-				      scontext_len);
+	if (only_invalid && !context->len) {
+		scontext = NULL;
+		scontext_len = 0;
+		rc = 0;
+	} else {
+		rc = context_struct_to_string(policydb, context, scontext,
+					      scontext_len);
+	}
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
 out:
@@ -1349,14 +1356,34 @@ int security_sid_to_context(struct selinux_state *state,
 			    u32 sid, char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
-					    scontext_len, 0);
+					    scontext_len, 0, 0);
 }
 
 int security_sid_to_context_force(struct selinux_state *state, u32 sid,
 				  char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(state, sid, scontext,
-					    scontext_len, 1);
+					    scontext_len, 1, 0);
+}
+
+/**
+ * security_sid_to_context_inval - Obtain a context for a given SID if it
+ *                                 is invalid.
+ * @sid: security identifier, SID
+ * @scontext: security context
+ * @scontext_len: length in bytes
+ *
+ * Write the string representation of the context associated with @sid
+ * into a dynamically allocated string of the correct size, but only if the
+ * context is invalid in the current policy.  Set @scontext to point to
+ * this string (or NULL if the context is valid) and set @scontext_len to
+ * the length of the string (or 0 if the context is valid).
+ */
+int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
+				  char **scontext, u32 *scontext_len)
+{
+	return security_sid_to_context_core(state, sid, scontext,
+					    scontext_len, 1, 1);
 }
 
 /*
-- 
2.20.1

