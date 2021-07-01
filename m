Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DCAC11F64
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC796140D
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 18:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhGASJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jul 2021 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhGASJq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jul 2021 14:09:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5738C061762
        for <selinux@vger.kernel.org>; Thu,  1 Jul 2021 11:07:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id df12so9674969edb.2
        for <selinux@vger.kernel.org>; Thu, 01 Jul 2021 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I86SQHF6nENov9OjccTTB4Vk+kfwrav3TJG11QHP5L8=;
        b=RuGNdIWI/PdUcRAzZVa6dJO8AFonnUFyCQmy/XJ46UUbMQFpev4/eaWzsjwTfadAX+
         /hG3g38WfKsgp7AO7qOs7FWLRRbUCSRKrLsmgcER1OMYgL2USsmD8IZH7WFJMYMgcLVg
         CFrsAM0iumHrhl/12xnfpCAi4wFkfdqKggb9hV5TDFGozsjyjJRThKnpP/sIcVj9xTcE
         xVdDx/OP4KAxsIEK+iM46Rb4mbQ9jlX0eSvx6eheTHDvhDyho8gfbryTeDXoymVKyCnN
         rdlgIbJh+g2McgYdUSrS6S3Fk6UmKSZkmGSbuib/cH1Wk1FiNSoRgu1V7ZkBZh/PaWNO
         dvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I86SQHF6nENov9OjccTTB4Vk+kfwrav3TJG11QHP5L8=;
        b=UejCwhsQ7Pz9lnBRSsmm3OrV9mracMbV7rMnIMyWqB9so3fVfS7V9mHuZPi/dF3QQY
         1C0YMKadLOqKN46jDBGPMuVWg2s0BT/yfjySn5rasrfSIslYZEUbC/1uYiaEcgM1YGbt
         pKakuBUub0gZfybS1quF7Eg+zoWaUi2qZ43URXoiroqPEfGDS/8k5JFp4bz+K3MEvCLz
         DP99Vafx4vAtqR2WfjUgwVpg2KjSMdjp8rwJ8RyB37TsxXJMePRloanb+Nc7dpLdGPj7
         zukHGL7NWwGi5E86OJHNnmqPGwv3oz7ZRdRJGOllNiEQlutqCTV5oAGxmlrnGyhDirgM
         2xCg==
X-Gm-Message-State: AOAM531WAAciQubpXU4LPO5zA4nGHLxdhKV0FJmIwhUKB5hUcYT3LhQO
        y2+K7c03iuR1mwn68yBicnj0p5t8XPk=
X-Google-Smtp-Source: ABdhPJxwIAYysK+QnApzVZvUZapmOLsuFpjmpPXmsnrTH24zYoL27Qro4XRNWtDkai6wAn+A+M1mQw==
X-Received: by 2002:a50:eb86:: with SMTP id y6mr1464535edr.111.1625162833391;
        Thu, 01 Jul 2021 11:07:13 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-223-136.77.6.pool.telefonica.de. [77.6.223.136])
        by smtp.gmail.com with ESMTPSA id j22sm208352ejt.11.2021.07.01.11.07.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:07:13 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 3/3] libsepol: assure string NUL-termination of ibdev_name
Date:   Thu,  1 Jul 2021 20:07:07 +0200
Message-Id: <20210701180707.120172-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-14-cgzones@googlemail.com>
References: <20210608155912.32047-14-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Clang complains:

    ibendport_record.c: In function ‘sepol_ibendport_get_ibdev_name’:
    ibendport_record.c:169:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
      169 |  strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ibendport_record.c: In function ‘sepol_ibendport_set_ibdev_name’:
    ibendport_record.c:189:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
      189 |  strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

strncpy(3) does not NUL-terminate the destination if the source is of
the same length or longer then the specified size.
The source of these copies are retrieved from
sepol_ibendport_alloc_ibdev_name(), which allocates a fixed amount of
IB_DEVICE_NAME_MAX bytes.
Reduce the size to copy by 1 of all memory regions allocated by
sepol_ibendport_alloc_ibdev_name().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - use at all affected places as pointed out by James Carter

 libsepol/src/ibendport_record.c | 8 ++++----
 libsepol/src/ibendports.c       | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
index adf67161..1eb50914 100644
--- a/libsepol/src/ibendport_record.c
+++ b/libsepol/src/ibendport_record.c
@@ -62,7 +62,7 @@ int sepol_ibendport_key_create(sepol_handle_t *handle,
 	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0)
 		goto err;
 
-	strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX - 1);
 	tmp_key->port = port;
 
 	*key_ptr = tmp_key;
@@ -166,7 +166,7 @@ int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
 	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_ibdev_name) < 0)
 		goto err;
 
-	strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
 	*ibdev_name = tmp_ibdev_name;
 	return STATUS_SUCCESS;
 
@@ -186,7 +186,7 @@ int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
 	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp) < 0)
 		goto err;
 
-	strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX - 1);
 	free(ibendport->ibdev_name);
 	ibendport->ibdev_name = tmp;
 	return STATUS_SUCCESS;
@@ -230,7 +230,7 @@ int sepol_ibendport_clone(sepol_handle_t *handle,
 	if (sepol_ibendport_alloc_ibdev_name(handle, &new_ibendport->ibdev_name) < 0)
 		goto omem;
 
-	strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(new_ibendport->ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
 	new_ibendport->port = ibendport->port;
 
 	if (ibendport->con &&
diff --git a/libsepol/src/ibendports.c b/libsepol/src/ibendports.c
index 6d56c9a1..ee5cb193 100644
--- a/libsepol/src/ibendports.c
+++ b/libsepol/src/ibendports.c
@@ -34,7 +34,7 @@ static int ibendport_from_record(sepol_handle_t *handle,
 					   &ibdev_name) < 0)
 		goto err;
 
-	strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(tmp_ibendport->u.ibendport.dev_name, ibdev_name, IB_DEVICE_NAME_MAX - 1);
 
 	free(ibdev_name);
 	ibdev_name = NULL;
-- 
2.32.0

