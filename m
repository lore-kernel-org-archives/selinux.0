Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263AFC433FE
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E6E60F36
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhJNOza (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231875AbhJNOza (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634223205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z8pxsvvOFRcT+HyiQJ39ItHbml7GQ6KvffUlxLrbMo=;
        b=NOy6x8z6OFNq84yQoEhp0A+HYBB29NqUNifZgLFCs5n8LdnXY6iTF21vYT/dOJ8NSAG7y3
        EpGLk8fP1oGF/5TWQrAXufSqfyJ/5mTzu/FnhFEJ2fD90KaQH8aKlslJ3OaSRw1/u+RO6l
        vigAwusppbsJxa4GnhpxhMUiXXLsGaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-TCzQf6sPOYagFCnUhiTYCw-1; Thu, 14 Oct 2021 10:53:24 -0400
X-MC-Unique: TCzQf6sPOYagFCnUhiTYCw-1
Received: by mail-wr1-f71.google.com with SMTP id j19-20020adfb313000000b00160a9de13b3so4768906wrd.8
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Z8pxsvvOFRcT+HyiQJ39ItHbml7GQ6KvffUlxLrbMo=;
        b=n/nnzWIH0W6nXVswkCIMldXxk5JzxwhCYsavLbLYFvmb6IKarFeL5hYFATvPPsVdPc
         xz8pKo+gbhEuwnzm/WXg2XV3SHSXkvE1sOH6PPmq/6kgOFJWe+gFkjDy3627Uz4WKdbH
         fFx5Ev9+kNvGOzzVD5eKJHs77nO6w6kll2h97SoIl4Bpcn75mvqRhxFNy7wpgSe48dKS
         Cc3QijZkKrApYIKXRE5lgYbvcG0fFh602h07Ah6m+/rXMS2gdm9HLWOgt8jMwoWakFvn
         KstaS6J5bp6CK9pCOzm4dfu1oYWzCEZulvzCvUd4N8FRKxU+JhXq/jjzU/YjMIheHFbY
         BA9A==
X-Gm-Message-State: AOAM530IWZz62Ejzwn6LAR0RIMFWOoHvHHpKyMKLWEwWmtk83aRPonUc
        TccPi4R+lJ9xiGWhYJcPD13ut7bTfgmjX+jLkNnl6K5jY3stMZmiNa69c9LXFyiE58ZyoFYV88a
        kx+C+n75onZE3IbcRbrb4vXlTeECSnk9Hg6VOM4dJF16Gc5DbeBU8ACs7pnfHcciSXleKbw==
X-Received: by 2002:adf:a347:: with SMTP id d7mr7380261wrb.139.1634223202440;
        Thu, 14 Oct 2021 07:53:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdaj6sZrVOLG3X0njKVWNkfXizEVhYJB90kCwQwPq0II1w3X6aSODJaCl0XNBZjiSxnUnAig==
X-Received: by 2002:adf:a347:: with SMTP id d7mr7380234wrb.139.1634223202191;
        Thu, 14 Oct 2021 07:53:22 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k17sm2485489wrc.93.2021.10.14.07.53.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:53:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 2/6] selinux_restorecon: protect file_spec list with a mutex
Date:   Thu, 14 Oct 2021 16:53:15 +0200
Message-Id: <20211014145319.798740-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014145319.798740-1-omosnace@redhat.com>
References: <20211014145319.798740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Not very useful on its own, but will allow to implement a parallel
version of selinux_restorecon() in subsequent patches.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 15129336..732f0ccc 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -411,6 +411,7 @@ typedef struct file_spec {
 } file_spec_t;
 
 static file_spec_t *fl_head;
+static pthread_mutex_t fl_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 /*
  * Try to add an association between an inode and a context. If there is a
@@ -424,6 +425,8 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 	int h, ret;
 	struct stat64 sb;
 
+	__pthread_mutex_lock(&fl_mutex);
+
 	if (!fl_head) {
 		fl_head = calloc(HASH_BUCKETS, sizeof(file_spec_t));
 		if (!fl_head)
@@ -444,11 +447,11 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 				fl->con = strdup(con);
 				if (!fl->con)
 					goto oom;
-				return 1;
+				goto unlock_1;
 			}
 
 			if (strcmp(fl->con, con) == 0)
-				return 1;
+				goto unlock_1;
 
 			selinux_log(SELINUX_ERROR,
 				"conflicting specifications for %s and %s, using %s.\n",
@@ -457,6 +460,9 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 			fl->file = strdup(file);
 			if (!fl->file)
 				goto oom;
+
+			__pthread_mutex_unlock(&fl_mutex);
+
 			if (flags->conflicterror) {
 				selinux_log(SELINUX_ERROR,
 				"treating conflicting specifications as an error.\n");
@@ -481,13 +487,19 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 		goto oom_freefl;
 	fl->next = prevfl->next;
 	prevfl->next = fl;
+
+	__pthread_mutex_unlock(&fl_mutex);
 	return 0;
 
 oom_freefl:
 	free(fl);
 oom:
+	__pthread_mutex_unlock(&fl_mutex);
 	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
 	return -1;
+unlock_1:
+	__pthread_mutex_unlock(&fl_mutex);
+	return 1;
 }
 
 /*
-- 
2.31.1

