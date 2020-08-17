Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEFC433E8
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 17:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FC92067C
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 17:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gy44oW7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbgHQRLE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389388AbgHQRKT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 13:10:19 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F52C061349
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 10:08:46 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id g18so5840483ejm.4
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=EPrw5RnVluwXxcHuirD84lbrde8q2sR6O2SJbUiYZDY=;
        b=Gy44oW7fKCqNOu7gPn6b5s9Hw32Xq4yvq7Q8/WI+rSdRN/RrnCMqHlZokwohf6GGkz
         ypoB6AUHgyfz+bJDXMWm8Blt0UBD6/dGaIuQIvfl7bOt3jN4vxXJTDu2jOpZ4ewyPhrG
         YfljJu3kjA2wyvHtPaCjKBwl0przKWbYzsWQsdGdnLc4hfFX787wguDrmO4kprYWkhbv
         9kmWDpjQzVkL2fxSU9KyBkHzj+rX/3HVxRRYRvYLEYt0N4IA1YunVE4CE5wFA26dT5Sn
         rUrfV1QDNrPwEPvMO5NDiStCmjaz0+nUPq4iRWwIJvzH0bytnrQlfiDS2GHAcmp5HOLN
         S45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=EPrw5RnVluwXxcHuirD84lbrde8q2sR6O2SJbUiYZDY=;
        b=rb0a2rpYmM3wCqj88MiIgHMsmHatl79hBaBSy0j5O7bkT60WvPm7Ubudi9Wa3XClvU
         n3tpPh9Dg9oDOcY8nhDskMAIGM7at148QgVcBGNVwk/MCNIitriO8vwK7TUdJ3JdaB+2
         5lLEoCrOZzpeDmGQnJyWwdM6cevmB3sxrQxK/IqhcMb5GGY5Qqc7P562W/PVDWnO3Jz+
         DvjHnFSDPCNOGAGY/aqX+BtCX/ESjMRHOdbsafKB7rdR0yecoHIon8pze24oJGnKWGPi
         F6AzfddUcIJD4cR6qXdQJbJ4Ew12GLsVY60xYkY5yfHlDeiW6djBJX6mi0cKf1RjLLNe
         JMbw==
X-Gm-Message-State: AOAM53308CgiCkYrs1R8tbgPAFaHEzGYqYK8qOd9ml3WD0z/LY2R1OBj
        Kwb4ydZxWt73ACZFdOyrDCugzCDffQ==
X-Google-Smtp-Source: ABdhPJybsAInpFNA74sYWytsOjuXY3Qmc09wmwcrpFe5e0ysRNhDs7qvPGChjMLprINFNMZKElFXgEgVXg==
X-Received: by 2002:aa7:da46:: with SMTP id w6mr16086222eds.7.1597684122851;
 Mon, 17 Aug 2020 10:08:42 -0700 (PDT)
Date:   Mon, 17 Aug 2020 19:07:13 +0200
In-Reply-To: <20200817170729.2605279-1-tweek@google.com>
Message-Id: <20200817170729.2605279-3-tweek@google.com>
Mime-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 2/3] selinux: add basic filtering for audit trace events
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
 security/selinux/avc.c     | 22 +++++++++++++---------
 2 files changed, 39 insertions(+), 19 deletions(-)

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
2.28.0.220.ged08abb693-goog

