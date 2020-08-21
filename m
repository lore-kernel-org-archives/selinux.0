Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED0CC433E3
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14A622B40
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Mf3mggQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHUOJc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUOJa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 10:09:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCD9C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 07:09:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r12so1266695qvx.20
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=mzo3bIF9byNcf8Gl3Pbcb+/Bpb29k89cyN2k9ceMpns=;
        b=Mf3mggQSdrKDPQsBOH3gtsZfBGpO7r2dOWChft5esXAiYIk71TfGMpcC1TCoQ5kdL3
         Op+SYLRW/DYec87S/OfuzthKqPSbHbwkY7/xX35cdw5NicfZxX3W420OYz1Yl6GsQ/Hi
         uznY+jbWpq2gism8plh7pyaNm1UqnVcXHiw6bjHSE8rZel2fT7qtKMxM0o1N8S71IF3E
         N/NkbOEw4JszPGNpDW7b4pXxT4PfifBYPhDRFo5wAzf1tJWAxkiZrrsfQ3pR5WFkwuzL
         TpFQNtzg8OAlcxUkLtgxq2eJVWAoz+zVRNDBXHe8HE8ajCLbqIpHcH8N/cEtP6djOe+s
         S3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=mzo3bIF9byNcf8Gl3Pbcb+/Bpb29k89cyN2k9ceMpns=;
        b=OtuovXdCJ5HCg9Y8N61ug44RQNy/pc4qbZZK0mbt/8i9DTMREmQibLL8kPWby/R+wo
         9V7LP6vUpYbHrQuEGWgLik1uD5VnrkgvLVjZdDDS+zCGkhXYb/fAEGKdVQb1jkWDoGgN
         cOK/oz6J3U/WNqaPKVEL7NZahiwJGmxPCBxRS+ph+29uo37GPwuprm+rSQTkI3F42YR1
         0c8+wQS8t/XwYUMqlcQqpr/ZZYOm6PQ7GwrIROeYsSX5JNy0rDC3kndBLFnyr2tdPzHV
         yowBJB3d6PC9i79oqXKvFGQuLdtj6m8mpUjgjML66pinh8tlO/Y/9DWKtKLCcodvEZ/l
         m6Bg==
X-Gm-Message-State: AOAM531/gYTM54jDeamluvULeXqkcE4TnJnsFhke7MKG0fxU7mHjGmjK
        H1kKZit68YQl5GE1piqO8we37g2ZUA==
X-Google-Smtp-Source: ABdhPJw2BTayen9+uqtI4lTYdHFA2WP7YfwhIqjiHGCx2TASLNaM9o/7BLXGvmdngOMXzaMdSDzpjIdVzA==
X-Received: from tweek1.zrh.corp.google.com ([2a00:79e0:61:100:f693:9fff:fef4:a93d])
 (user=tweek job=sendgmr) by 2002:ad4:414b:: with SMTP id z11mr2433320qvp.116.1598018969628;
 Fri, 21 Aug 2020 07:09:29 -0700 (PDT)
Date:   Fri, 21 Aug 2020 16:08:22 +0200
In-Reply-To: <20200821140836.3707282-1-tweek@google.com>
Message-Id: <20200821140836.3707282-3-tweek@google.com>
Mime-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 2/2] selinux: add basic filtering for audit trace events
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Peter Enderborg <peter.enderborg@sony.com>

This patch adds further attributes to the event. These attributes are
helpful to understand the context of the message and can be used
to filter the events.

There are three common items. Source context, target context and tclass.
There are also items from the outcome of operation performed.

An event is similar to:
           <...>-1309  [002] ....  6346.691689: selinux_audited:
       requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
       result=3D-13
       scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
       tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile

With systems where many denials are occurring, it is useful to apply a
filter. The filtering is a set of logic that is inserted with
the filter file. Example:
 echo "tclass=3D=3D\"file\" " > events/avc/selinux_audited/filter

This adds that we only get tclass=3Dfile.

The trace can also have extra properties. Adding the user stack
can be done with
   echo 1 > options/userstacktrace

Now the output will be
         runcon-1365  [003] ....  6960.955530: selinux_audited:
     requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
     result=3D-13
     scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
     tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
          runcon-1365  [003] ....  6960.955560: <user stack trace>
 =3D>  <00007f325b4ce45b>
 =3D>  <00005607093efa57>

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 include/trace/events/avc.h | 36 ++++++++++++++++++++++++++----------
 security/selinux/avc.c     | 28 +++++++++++++++-------------
 2 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index 07c058a9bbcd..b55fda2e0773 100644
--- a/include/trace/events/avc.h
+++ b/include/trace/events/avc.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Author: Thi=C3=A9baud Weksteen <tweek@google.com>
+ * Authors:	Thi=C3=A9baud Weksteen <tweek@google.com>
+ *		Peter Enderborg <Peter.Enderborg@sony.com>
  */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM avc
@@ -12,23 +13,38 @@
=20
 TRACE_EVENT(selinux_audited,
=20
-	TP_PROTO(struct selinux_audit_data *sad),
+	TP_PROTO(struct selinux_audit_data *sad,
+		char *scontext,
+		char *tcontext,
+		const char *tclass
+	),
=20
-	TP_ARGS(sad),
+	TP_ARGS(sad, scontext, tcontext, tclass),
=20
 	TP_STRUCT__entry(
-		__field(unsigned int, tclass)
-		__field(unsigned int, audited)
+		__field(u32, requested)
+		__field(u32, denied)
+		__field(u32, audited)
+		__field(int, result)
+		__string(scontext, scontext)
+		__string(tcontext, tcontext)
+		__string(tclass, tclass)
 	),
=20
 	TP_fast_assign(
-		__entry->tclass =3D sad->tclass;
-		__entry->audited =3D sad->audited;
+		__entry->requested	=3D sad->requested;
+		__entry->denied		=3D sad->denied;
+		__entry->audited	=3D sad->audited;
+		__entry->result		=3D sad->result;
+		__assign_str(tcontext, tcontext);
+		__assign_str(scontext, scontext);
+		__assign_str(tclass, tclass);
 	),
=20
-	TP_printk("tclass=3D%u audited=3D%x",
-		__entry->tclass,
-		__entry->audited)
+	TP_printk("requested=3D0x%x denied=3D0x%x audited=3D0x%x result=3D%d scon=
text=3D%s tcontext=3D%s tclass=3D%s",
+		__entry->requested, __entry->denied, __entry->audited, __entry->result,
+		__get_str(scontext), __get_str(tcontext), __get_str(tclass)
+	)
 );
=20
 #endif
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b0a0af778b70..3c05827608b6 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -705,35 +705,37 @@ static void avc_audit_post_callback(struct audit_buff=
er *ab, void *a)
 {
 	struct common_audit_data *ad =3D a;
 	struct selinux_audit_data *sad =3D ad->selinux_audit_data;
-	char *scontext;
+	char *scontext =3D NULL;
+	char *tcontext =3D NULL;
+	const char *tclass =3D NULL;
 	u32 scontext_len;
+	u32 tcontext_len;
 	int rc;
=20
-	trace_selinux_audited(sad);
-
 	rc =3D security_sid_to_context(sad->state, sad->ssid, &scontext,
 				     &scontext_len);
 	if (rc)
 		audit_log_format(ab, " ssid=3D%d", sad->ssid);
-	else {
+	else
 		audit_log_format(ab, " scontext=3D%s", scontext);
-		kfree(scontext);
-	}
=20
-	rc =3D security_sid_to_context(sad->state, sad->tsid, &scontext,
-				     &scontext_len);
+	rc =3D security_sid_to_context(sad->state, sad->tsid, &tcontext,
+				     &tcontext_len);
 	if (rc)
 		audit_log_format(ab, " tsid=3D%d", sad->tsid);
-	else {
-		audit_log_format(ab, " tcontext=3D%s", scontext);
-		kfree(scontext);
-	}
+	else
+		audit_log_format(ab, " tcontext=3D%s", tcontext);
=20
-	audit_log_format(ab, " tclass=3D%s", secclass_map[sad->tclass-1].name);
+	tclass =3D secclass_map[sad->tclass-1].name;
+	audit_log_format(ab, " tclass=3D%s", tclass);
=20
 	if (sad->denied)
 		audit_log_format(ab, " permissive=3D%u", sad->result ? 0 : 1);
=20
+	trace_selinux_audited(sad, scontext, tcontext, tclass);
+	kfree(tcontext);
+	kfree(scontext);
+
 	/* in case of invalid context report also the actual context string */
 	rc =3D security_sid_to_context_inval(sad->state, sad->ssid, &scontext,
 					   &scontext_len);
--=20
2.28.0.297.g1956fa8f8d-goog

