Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC4C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9194D2078D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgHXNX6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:23:58 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14657 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgHXNX5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:23:57 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [RFC PATCH] selinux: Add denied trace with permssion filter
Date:   Mon, 24 Aug 2020 15:22:52 +0200
Message-ID: <20200824132252.31261-2-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824132252.31261-1-peter.enderborg@sony.com>
References: <CAHC9VhRuvK55JVyHOxckThbRQ7sCwkeZsudwCaBo2f5G4g11VA@mail.gmail.com>
 <20200824132252.31261-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=dtal9Go4 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=y4yBn9ojGxQA:10 a=z6gsHLkEAAAA:8 a=9Lnft3qYOPM9H8Q3WhUA:9 a=d-OLMTCWyvARjPbQ-enb:22
X-SEG-SpamProfiler-Score: 0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This adds tracing of all denies. They are grouped with trace_seq for
each audit.

A filter can be inserted with a write to it's filter section.

echo "permission==\"entrypoint\"" > events/avc/selinux_denied/filter

A output will be like:
          runcon-1046  [002] .N..   156.351738: selinux_denied:
	  trace_seq=2 result=-13
	  scontext=system_u:system_r:cupsd_t:s0-s0:c0.
	  c1023 tcontext=system_u:object_r:bin_t:s0
	  tclass=file permission=entrypoint

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 include/trace/events/avc.h | 37 +++++++++++++++++++++++++++++++++++++
 security/selinux/avc.c     | 27 +++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index 94bca8bef8d2..9a28559956de 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -54,6 +54,43 @@ TRACE_EVENT(selinux_audited,
 	)
 );
 
+TRACE_EVENT(selinux_denied,
+
+	TP_PROTO(struct selinux_audit_data *sad,
+		char *scontext,
+		char *tcontext,
+		const char *tclass,
+		const char *permission,
+		int64_t seq
+	),
+
+	TP_ARGS(sad, scontext, tcontext, tclass, permission, seq),
+
+	TP_STRUCT__entry(
+		__field(int, result)
+		__string(scontext, scontext)
+		__string(tcontext, tcontext)
+		__string(permission, permission)
+		__string(tclass, tclass)
+		__field(u64, seq)
+	),
+
+	TP_fast_assign(
+		__entry->result	= sad->result;
+		__entry->seq	= seq;
+		__assign_str(tcontext, tcontext);
+		__assign_str(scontext, scontext);
+		__assign_str(permission, permission);
+		__assign_str(tclass, tclass);
+	),
+
+	TP_printk("trace_seq=%lld result=%d scontext=%s tcontext=%s tclass=%s permission=%s",
+		 __entry->seq, __entry->result, __get_str(scontext), __get_str(tcontext),
+		 __get_str(tclass), __get_str(permission)
+
+	)
+);
+
 #endif
 
 /* This part must be outside protection */
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 1debddfb5af9..ca53baca15e1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -92,6 +92,7 @@ struct selinux_avc {
 };
 
 static struct selinux_avc selinux_avc;
+static atomic64_t trace_seqno;
 
 void selinux_avc_init(struct selinux_avc **avc)
 {
@@ -731,9 +732,31 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 	tclass = secclass_map[sad->tclass-1].name;
 	audit_log_format(ab, " tclass=%s", tclass);
 
-	if (sad->denied)
+	if (sad->denied) {
 		audit_log_format(ab, " permissive=%u", sad->result ? 0 : 1);
-
+		if (trace_selinux_denied_enabled()) {
+			int i, perm;
+			const char **perms;
+			u32 denied = sad->denied;
+			int64_t seq;
+
+			seq = atomic_long_inc_return(&trace_seqno);
+			perms = secclass_map[sad->tclass-1].perms;
+			i = 0;
+			perm = 1;
+			while (i < (sizeof(denied) * 8)) {
+				if ((perm & denied & sad->requested) && perms[i]) {
+					trace_selinux_denied(sad, scontext, tcontext,
+							     tclass, perms[i], seq);
+					denied &= ~perm;
+					if (!denied)
+						break;
+				}
+				i++;
+				perm <<= 1;
+			}
+		}
+	}
 	trace_selinux_audited(sad, scontext, tcontext, tclass);
 	kfree(tcontext);
 	kfree(scontext);
-- 
2.17.1

