Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E3CC4332F
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiDMP7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDMP7G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 11:59:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2063513
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:56:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bh17so4852809ejb.8
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ryh964fKJzkKAaybIRW9AOPBL3f1aks+3tTIdY+JCbA=;
        b=GbyifrDS6osZ93cJ5cffNun4SJS/J3WKltGTc1qohKGdxBBLTIptkWrI1bGro6Ks0U
         VxWSSopzl1MWj+U05RgvURVNyQXzvprCasOXjOuU1fUzJ7Fwl7bFfkqypWcnWeYB8KoJ
         X9410MpjSAugkFfQrWrp6vf3LcpTl5pJg+oLukSY5q4Xv3UNjJpoGay3Wx1tLOn/PbWL
         tvGGiGLuK78dkthBIE7XFBmv7NYRXpPuZWxv3rptDYOIGIShyjPLTxV+t0gn4rmhzQqQ
         IEkXqrl0Xic3bZAOqCxJYFVXrOqPWxtBBR0Rpc/GckDSt4lb/V8fc3lcj+kDJiCQKLRo
         hVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ryh964fKJzkKAaybIRW9AOPBL3f1aks+3tTIdY+JCbA=;
        b=ByftRZoj+V7EXUKUcpO4cvkx0bBts0DtZR7TsH7aCJhsio+I0OtoeDe+7oM4F1mI2a
         q1jevt+yRtlHiqhhS0DzQlir7Mq03OxHVRvPLGJoa8rxuLllzrTMPZEi3BtdmTxf+uHC
         +qmvITyKfi1pxPuwLQ4kKXsWhoq7IT6DDq8SW1Eza1vbozvGna9ZjJZhyywGCZs3huH6
         rPAJ+AnB38Li3SjJvAOqJe0EdvddLombkS4MobMX9gDpHnafqoTlr9VTmHYz1hkEYJbq
         T2wkV45GKg7l2bkkwh17/csGegCZX0hnoVJ1Irc5CmNpu4/nDrmc2GLd4WkqfiKiUSWd
         Jplg==
X-Gm-Message-State: AOAM532clCUdv/Uraox3XpTB1Dey7EU734nAWmcf1pcakuUTSyaBMYUX
        MKq9wnMLZLhjRR/VbXITWH1M6ov6GoQ=
X-Google-Smtp-Source: ABdhPJzK2Vtd7zwa3vzt+wRTyN0v5dJvAF8Qyd5mz5iajfXLbdGkugzWc5NfZ4tEbLplzl3L+7YwTg==
X-Received: by 2002:a17:906:6a15:b0:6e8:aa5a:f386 with SMTP id qw21-20020a1709066a1500b006e8aa5af386mr10400985ejc.649.1649865402827;
        Wed, 13 Apr 2022 08:56:42 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-215-252.77.0.pool.telefonica.de. [77.0.215.252])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm121296ejc.42.2022.04.13.08.56.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:56:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libselinux: correctly hash specfiles larger than 4G
Date:   Wed, 13 Apr 2022 17:56:33 +0200
Message-Id: <20220413155633.62677-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220413155633.62677-1-cgzones@googlemail.com>
References: <20220413155633.62677-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The internal Sha1Update() functions only handles buffers up to a size of
UINT32_MAX, due to its usage of the type uint32_t.  This causes issues
when processing more than UINT32_MAX bytes, e.g. with a specfile larger
than 4G.  0aa974a4 ("libselinux: limit has buffer size") tried to
address this issue, but failed since the overflow check

    if (digest->hashbuf_size + buf_len < digest->hashbuf_size) {

will be done in the widest common type, which is size_t, the type of
`buf_len`.

Revert the type of `hashbuf_size` to size_t and instead process the data
in blocks of supported size.

Reverts: 0aa974a4 ("libselinux: limit has buffer size")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
UBSAN reports without block processing:

hashbuf_size of uint32_t

    label_support.c:158:23: runtime error: implicit conversion from type 'unsigned long' of value 4294968207 (64-bit, unsigned) to type 'uint32_t' (aka 'unsigned int') changed the value to 911 (32-bit, unsigned)
        #0 0x4ecdbd in digest_add_specfile /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_support.c:158:23
        #1 0x4e0d83 in selabel_subs_init /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_file.c:666:6
        #2 0x4d5c48 in init /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_file.c:738:12
        #3 0x4d5c48 in selabel_file_init /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_file.c:1304:9
        #4 0x4cfdde in selabel_open /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label.c:228:6
        #5 0x4ce76c in main /home/christian/Coding/workspaces/selinux_userland/libselinux/utils/selabel_digest.c:130:8
        #6 0x77b65848a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
        #7 0x77b65848a277 in __libc_start_main csu/../csu/libc-start.c:409:3
        #8 0x41f4c0 in _start (/home/christian/Coding/workspaces/selinux_userland/libselinux/utils/selabel_digest+0x41f4c0)

hashbuf_size of size_t

label_support.c:125:40: runtime error: implicit conversion from type 'size_t' (aka 'unsigned long') of value 4298262406 (64-bit, unsigned) to type 'uint32_t' (aka 'unsigned int') changed the value to 3295110 (32-bit, unsigned)
        #0 0x4ec468 in digest_gen_hash /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_support.c:125:40
        #1 0x4d6dd3 in init /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_file.c:793:2
        #2 0x4d6dd3 in selabel_file_init /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label_file.c:1304:9
        #3 0x4cfdde in selabel_open /home/christian/Coding/workspaces/selinux_userland/libselinux/src/label.c:228:6
        #4 0x4ce76c in main /home/christian/Coding/workspaces/selinux_userland/libselinux/utils/selabel_digest.c:130:8
        #5 0x749229c371c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
        #6 0x749229c37277 in __libc_start_main csu/../csu/libc-start.c:409:3
        #7 0x41f4c0 in _start (/home/christian/Coding/workspaces/selinux_userland/libselinux/utils/selabel_digest+0x41f4c0)
---
 libselinux/src/label_internal.h |  2 +-
 libselinux/src/label_support.c  | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 82a762f7..782c6aa8 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -57,7 +57,7 @@ int selabel_service_init(struct selabel_handle *rec,
 struct selabel_digest {
 	unsigned char *digest;	/* SHA1 digest of specfiles */
 	unsigned char *hashbuf;	/* buffer to hold specfiles */
-	uint32_t hashbuf_size;	/* buffer size */
+	size_t hashbuf_size;	/* buffer size */
 	size_t specfile_cnt;	/* how many specfiles processed */
 	char **specfile_list;	/* and their names */
 };
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 94ed6e42..54fd49a5 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -116,13 +116,25 @@ int  read_spec_entries(char *line_buf, const char **errbuf, int num_args, ...)
 void  digest_gen_hash(struct selabel_digest *digest)
 {
 	Sha1Context context;
+	size_t remaining_size;
+	const unsigned char *ptr;
 
 	/* If SELABEL_OPT_DIGEST not set then just return */
 	if (!digest)
 		return;
 
 	Sha1Initialise(&context);
-	Sha1Update(&context, digest->hashbuf, digest->hashbuf_size);
+
+	/* Process in blocks of UINT32_MAX bytes */
+	remaining_size = digest->hashbuf_size;
+	ptr = digest->hashbuf;
+	while (remaining_size > UINT32_MAX) {
+		Sha1Update(&context, ptr, UINT32_MAX);
+		remaining_size -= UINT32_MAX;
+		ptr += UINT32_MAX;
+	}
+	Sha1Update(&context, ptr, remaining_size);
+
 	Sha1Finalise(&context, (SHA1_HASH *)digest->digest);
 	free(digest->hashbuf);
 	digest->hashbuf = NULL;
-- 
2.35.2

