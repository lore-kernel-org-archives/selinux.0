Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FF2C7EE25
	for <selinux@archiver.kernel.org>; Mon, 12 Jun 2023 09:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjFLJny (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjFLJnW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jun 2023 05:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C3D7ECD
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686562274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx9eCdvzRsZ33gJ5l73NjkTjESdf6DSYiX4yjqBuUTE=;
        b=TfDniNwGm0qJQyvlRo5l2QvYlqzgCOyHPqBwboOL9muzi4eHCdf2yHgv/NTRnymjc1si6L
        vRjvabK1YU6PBHISH4v+415mVKmDaeFD6i9Tbiplc20G1AARFjkCzm1HFxlpGECHBG4ozt
        QCWS6CyrKCjoyXbt8nGHObc6ADdcv+4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-4JBDibDKMPakV3EygLjN1Q-1; Mon, 12 Jun 2023 05:31:12 -0400
X-MC-Unique: 4JBDibDKMPakV3EygLjN1Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9750bb0695dso599109666b.0
        for <selinux@vger.kernel.org>; Mon, 12 Jun 2023 02:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562271; x=1689154271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx9eCdvzRsZ33gJ5l73NjkTjESdf6DSYiX4yjqBuUTE=;
        b=c2e2U9UVzRXmc8zX3U6ulUBr4oAGK5rD4wBlxSZ7sP3MPVFCu3wLiDU9GVO5R+AjWr
         DlNoD8dOd5ntdniu5BvFGkaToZ4IBZOqZ7L/tYOkHPNhb5ejPSg0qaNXTxFJWtRpvlLB
         GJr/DsvcIBLEFtkRF2omZVZx5aB1EKZlNHA266u0YNpjSv31CNgLmdoeFt24VwYE83l/
         nwZYRZNxpaha41a+8DETmoplFYf8M8O3gGY69os9ZZgfj5JnXvRop3V8L1EQQQuxRCz6
         3HDBDltCeOD3tzbjtepM7HxxLMlRgE0S7AbCCJ68NIyk2edXUt3b/J1u1puFTm/VGM5+
         rnug==
X-Gm-Message-State: AC+VfDwswmL+6+MmS5yDdbwobuXyfy22pftf+j7aIuXgro+ziEmwShrD
        /UvSG7YQMuT55KM53PwoGPMRw2ZkSs9AhXUkGJ8DHl5j/mhwdqfio2dGB6VuCHKjQSTR1h12TW/
        6e0jrvqSgT1EmjhrcTCvGQBFTzizSdJibU7GWDOj94E7fwcKUmFsrZiAzYyQGeLX1FCp+PFIrAj
        60kshr
X-Received: by 2002:a17:906:794b:b0:973:ddfe:e074 with SMTP id l11-20020a170906794b00b00973ddfee074mr9159961ejo.2.1686562271334;
        Mon, 12 Jun 2023 02:31:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75I4tmUUnNmc/VKXmn4TgbigYRpVKleVA8Zo+cLvNDnfRA2x9AJVGa0/7PcBvZ0WViil3MXA==
X-Received: by 2002:a17:906:794b:b0:973:ddfe:e074 with SMTP id l11-20020a170906794b00b00973ddfee074mr9159946ejo.2.1686562270982;
        Mon, 12 Jun 2023 02:31:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906a28800b009655eb8be26sm4958000ejz.73.2023.06.12.02.31.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:31:10 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 2/2] libsepol: add support for the new "init" initial SID
Date:   Mon, 12 Jun 2023 11:31:07 +0200
Message-Id: <20230612093107.1066410-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612093107.1066410-1-omosnace@redhat.com>
References: <20230612093107.1066410-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Resurrect the naming of the "init" initial SID, as it has been
reintroduced in the kernel. Also add the new "userspace_initial_context"
policy capability that is used to enable the new semantics for this
initial SID.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/kernel_to_common.h           | 2 +-
 libsepol/src/polcaps.c                    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index f5e32e60..14bcc6cb 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -15,6 +15,7 @@ enum {
 	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 6073ff3a..5d927a3d 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -20,7 +20,7 @@ static const char * const selinux_sid_to_str[] = {
 	NULL,
 	"file",
 	NULL,
-	NULL,
+	"init",
 	"any_socket",
 	"port",
 	"netif",
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 687e971c..be12580a 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -14,6 +14,7 @@ static const char * const polcap_names[] = {
 	"nnp_nosuid_transition",	/* POLICYDB_CAP_NNP_NOSUID_TRANSITION */
 	"genfs_seclabel_symlinks",	/* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
 	"ioctl_skip_cloexec",		/* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
+	"userspace_initial_context",	/* POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT */
 	NULL
 };
 
-- 
2.40.1

