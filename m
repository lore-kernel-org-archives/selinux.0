Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552AC43334
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiFHRWH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiFHRV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 13:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE59477111
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654708200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMrJ6VeTuLRTvpxP1c3lGep9mWv5DtHALsuJT7lSfyQ=;
        b=J391lPwvnsn0vfauQK3qFpjFibfCUqoTTd7iBoZd2uR78hAbGgGZZ9u+7ogvoasKS/NttE
        U/+mnecQMQncpRJmOK4opMy/d8arO0+OtxlYzhmIJuFdU5reOvacLNycN9dQYJKlYaXAb6
        aya8TYbq+UUTfX5n254VALI9nbHMt3M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-p6j2Y9D5OlSO8DZ1--AOtA-1; Wed, 08 Jun 2022 13:09:59 -0400
X-MC-Unique: p6j2Y9D5OlSO8DZ1--AOtA-1
Received: by mail-wr1-f70.google.com with SMTP id v4-20020adfebc4000000b002102c69be5eso5010229wrn.13
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 10:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMrJ6VeTuLRTvpxP1c3lGep9mWv5DtHALsuJT7lSfyQ=;
        b=1qDQcvzBTuqnGqJLDnMKUWmmul02aiwxMMu/g1zkvPUzGvMoCKx0OMvtSf99uA0EDr
         Ybky3o16SeYkKSzXb6ERpSUNTK7ltB9zoCPAqMIvXfQO83sX08GdNKRPkv0ZM193z10a
         /SrCTQvOhOWuFu1zOtp1PSQFlnKMXjdsQ0W6nQuQRIKkKXxttQc758rJ1P2PYIgWZAi9
         nbeI4GYCGDqVkMtafhHKgnLL5884JvH95M4cutsUkJBLYgNHTl/IeFGa2pvgXtwkE+XR
         Mlsvqz/MTdjlcfVU3wzw2S+9tgXc7dWhoIC8sMwS79pn6z2sSy4dKiVYHIdOcsUbDM//
         Gmvw==
X-Gm-Message-State: AOAM531UQKIyLgg2yLRo7sF6oWVaSwh2VcK09yZAHpZDuueeJpSnhZWp
        gJv9b8aPbx0MGEtARFLV1Nf08JPDCG4YmKJV2jBiZqxAKQYHyXSb+jBZZQ4448Vm6HqEPNJhG/s
        wXadGgU+owrAO/8SfV9APR9JK07YtFj87bfgcx+DcyotXKFwn7Zg/uiahCko7R46qTw7D/Q==
X-Received: by 2002:a5d:6510:0:b0:216:f04d:3c50 with SMTP id x16-20020a5d6510000000b00216f04d3c50mr21536960wru.628.1654708197579;
        Wed, 08 Jun 2022 10:09:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxM9WrfjefKbDZ9LIH0pSZPF4qaO1x8/BKvfJmcgtCJE1bHOxfcNGhJn4vZkv0Vjk/Ugbhb6w==
X-Received: by 2002:a5d:6510:0:b0:216:f04d:3c50 with SMTP id x16-20020a5d6510000000b00216f04d3c50mr21536940wru.628.1654708197223;
        Wed, 08 Jun 2022 10:09:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe942000000b0020fcaba73bcsm22176194wrn.104.2022.06.08.10.09.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 10:09:56 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 2/2] semodule: rename --rebuild-if-modules-changed to --refresh
Date:   Wed,  8 Jun 2022 19:09:54 +0200
Message-Id: <20220608170954.114668-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608170954.114668-1-omosnace@redhat.com>
References: <20220608170954.114668-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

After the last commit this option's name and description no longer
matches the semantic, so give it a new one and update the descriptions.
The old name is still recognized and aliased to the new one for
backwards compatibility.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/semodule/semodule.8 | 12 ++++++------
 policycoreutils/semodule/semodule.c | 13 ++++++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index d1735d21..c56e580f 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -23,12 +23,12 @@ force a reload of policy
 .B \-B, \-\-build
 force a rebuild of policy (also reloads unless \-n is used)
 .TP
-.B \-\-rebuild-if-modules-changed
-Force a rebuild of the policy if any changes to module content are detected
-(by comparing with checksum from the last transaction).  One can use this
-instead of \-B to ensure that any changes to the module store done by an
-external tool (e.g. a package manager) are applied, while automatically
-skipping the rebuild if there are no new changes.
+.B \-\-refresh
+Like \-\-build, but reuses existing linked policy if no changes to module
+files are detected (by comparing with checksum from the last transaction).
+One can use this instead of \-B to ensure that any changes to the module
+store done by an external tool (e.g. a package manager) are applied, while
+automatically skipping the module re-linking if there are no module changes.
 .TP
 .B \-D, \-\-disable_dontaudit
 Temporarily remove dontaudits from policy.  Reverts whenever policy is rebuilt
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 1ed8e690..ec079486 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -150,9 +150,12 @@ static void usage(char *progname)
 	printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
 	printf("  -H, --hll extract module as hll. This only affects module extraction.\n");
 	printf("  -m, --checksum   print module checksum (SHA256).\n");
-	printf("      --rebuild-if-modules-changed\n"
-	       "                   force policy rebuild if module content changed since\n"
-	       "                   last rebuild (based on checksum)\n");
+	printf("      --refresh    like --build, but reuses existing linked policy if no\n"
+	       "                   changes to module files are detected (via checksum)\n");
+	printf("Deprecated options:\n");
+	printf("  -b,--base	   same as --install\n");
+	printf("  --rebuild-if-modules-changed\n"
+	       "                   same as --refresh\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -185,6 +188,7 @@ static void parse_command_line(int argc, char **argv)
 {
 	static struct option opts[] = {
 		{"rebuild-if-modules-changed", 0, NULL, '\0'},
+		{"refresh", 0, NULL, '\0'},
 		{"store", required_argument, NULL, 's'},
 		{"base", required_argument, NULL, 'b'},
 		{"help", 0, NULL, 'h'},
@@ -225,6 +229,9 @@ static void parse_command_line(int argc, char **argv)
 		case '\0':
 			switch(longind) {
 			case 0: /* --rebuild-if-modules-changed */
+				fprintf(stderr, "The --rebuild-if-modules-changed option is deprecated. Use --refresh instead.\n");
+				/* fallthrough */
+			case 1: /* --refresh */
 				check_ext_changes = 1;
 				break;
 			default:
-- 
2.36.1

