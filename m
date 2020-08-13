Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B5C433DF
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A60B20781
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPGwSU3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHMOty (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHMOtm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 10:49:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B0C061383
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 07:49:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q18so4053906qkq.11
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=fCGrFQfpfR4RJs5ZY7NRIygzu/+q9MlAoBreTUrZtKI=;
        b=aPGwSU3DH9pOxvTlq3Vws4aZ298GUILOkQMZa7HkaFW7bbJTqkoKkJdDwZOvXyfLCD
         WjttKGnSDKQuTC1kLTWwWqMTBI1ZC/bDZLtFG9RSer2bvKuAZn5jEnRuMjOj4r6Ulfap
         WUhkJRfcn3VqdCv6hUbALW+EyFpBFQmAJbqtUzpKSYKypkVGXwwmjX1BnrtwwWD+FMU5
         eL1WKBbm1M6vWDjHt54UOwQEex3jLh5y7x1L4MlyPsaiXESuJaS6q/Mt00dYpzsCtLCU
         8JYET0WCgV0cQCSmIMmVESEZN206LNEL8hAZAZ3dOdAq6vKM75+dnliVv9V5CxmTWOyl
         wTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=fCGrFQfpfR4RJs5ZY7NRIygzu/+q9MlAoBreTUrZtKI=;
        b=s3Bf9OR/RkywPIe5Yl4HCWROkCJGhtuWnPqD3Wuug+++TDWQUzxkkkd+hYYoLOJn33
         gFKzCpHgGMqUCJ/+SpMzNorO6GGC9epIv/wYiSpMQ3a/6a/7nx2HC39Fi3hzUO/oqm7R
         TGBrwDdrBIEKmmtXiuObqy6kTr6UhDhk9ez7Uhcv6KzphDrMmqp6Y4tRzhVNUa3Bjbos
         WgSptxf3dGO0GbtIatFMM7jiGD2/RxiHr5NF8ciURAk9mRffqTf/i8ubMOfUTgxPjVzH
         7Nw0e5kcIjS0dsXr6QUs4jcsJGFJvuN1mrxbge+q3ECGk3jqnZKex1ItOSKtiRLgYl30
         eDbg==
X-Gm-Message-State: AOAM533QjcicFT7U7bo+XnLXbgwY08ni0sip8pyM0+DcUxCOwDeFMqPC
        IJpQawHusz2PaiqbypHYVsQ1SJMGYw==
X-Google-Smtp-Source: ABdhPJwhDd55Hhnw1Df03C8Ckc1A5yrI74oFew+g5Iv+yieF4ooMZEPMYiaFMZYEMPON3RGCK0rWZJmfPg==
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr5037154qvx.126.1597330178932;
 Thu, 13 Aug 2020 07:49:38 -0700 (PDT)
Date:   Thu, 13 Aug 2020 16:48:59 +0200
In-Reply-To: <20200813144914.737306-1-tweek@google.com>
Message-Id: <20200813144914.737306-2-tweek@google.com>
Mime-Version: 1.0
References: <20200813144914.737306-1-tweek@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 2/2] selinux: add basic filtering for audit trace events
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
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
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
       result=3D-13 ssid=3D315 tsid=3D61
       scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
       tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile

With systems where many denials are occurring, it is useful to apply a
filter. The filtering is a set of logic that is inserted with
the filter file. Example:
 echo "tclass=3D=3D\"file\" && ssid!=3D42" > events/avc/selinux_audited/fil=
ter

This adds that we only get tclass=3Dfile but not for ssid 42.

The trace can also have extra properties. Adding the user stack
can be done with
   echo 1 > options/userstacktrace

Now the output will be
         runcon-1365  [003] ....  6960.955530: selinux_audited:
     requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
     result=3D-13 ssid=3D315 tsid=3D61
     scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
     tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
          runcon-1365  [003] ....  6960.955560: <user stack trace>
 =3D>  <00007f325b4ce45b>
 =3D>  <00005607093efa57>

Note that the ssid is the internal numeric representation of scontext
and tsid is numeric for tcontext. They are useful for filtering.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2 changes:
- update changelog to include usage examples

 include/trace/events/avc.h | 41 ++++++++++++++++++++++++++++----------
 security/selinux/avc.c     | 22 +++++++++++---------
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/avc.h b/include/trace/events/avc.h
index 07c058a9bbcd..ac5ef2e1c2c5 100644
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
@@ -12,23 +13,43 @@
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
+		__field(u32, ssid)
+		__field(u32, tsid)
 	),
=20
 	TP_fast_assign(
-		__entry->tclass =3D sad->tclass;
-		__entry->audited =3D sad->audited;
+		__entry->requested	=3D sad->requested;
+		__entry->denied		=3D sad->denied;
+		__entry->audited	=3D sad->audited;
+		__entry->result		=3D sad->result;
+		__entry->ssid		=3D sad->ssid;
+		__entry->tsid		=3D sad->tsid;
+		__assign_str(tcontext, tcontext);
+		__assign_str(scontext, scontext);
+		__assign_str(tclass, tclass);
 	),
=20
-	TP_printk("tclass=3D%u audited=3D%x",
-		__entry->tclass,
-		__entry->audited)
+	TP_printk("requested=3D0x%x denied=3D0x%x audited=3D0x%x result=3D%d ssid=
=3D%u tsid=3D%u scontext=3D%s tcontext=3D%s tclass=3D%s",
+		__entry->requested, __entry->denied, __entry->audited, __entry->result,
+		__entry->ssid, __entry->tsid, __get_str(scontext), __get_str(tcontext),
+		__get_str(tclass)
+	)
 );
=20
 #endif
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b0a0af778b70..7de5cc5169af 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -705,35 +705,39 @@ static void avc_audit_post_callback(struct audit_buff=
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
 	else {
 		audit_log_format(ab, " scontext=3D%s", scontext);
-		kfree(scontext);
 	}
=20
-	rc =3D security_sid_to_context(sad->state, sad->tsid, &scontext,
-				     &scontext_len);
+	rc =3D security_sid_to_context(sad->state, sad->tsid, &tcontext,
+				     &tcontext_len);
 	if (rc)
 		audit_log_format(ab, " tsid=3D%d", sad->tsid);
 	else {
-		audit_log_format(ab, " tcontext=3D%s", scontext);
-		kfree(scontext);
+		audit_log_format(ab, " tcontext=3D%s", tcontext);
 	}
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
2.28.0.236.gb10cc79966-goog

