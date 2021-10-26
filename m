Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0A8C433F5
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E7460F0F
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhJZLzN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235575AbhJZLzM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Z8pxsvvOFRcT+HyiQJ39ItHbml7GQ6KvffUlxLrbMo=;
        b=iqBLz9mM+vgu+6N+dNzD3GRWO36J7jd3DvOFtp+myKnfdp5VKj6mu2+1Q1+zvOLGOi1Yx+
        Tzidnemv/g/iQMGelZy//SVEm3JUDj0AzHv+QUNIhlID6x08OurU6egCHgcPFm5nrUwU6l
        jreXZl+XKIRGGZ0RcKtVMfLuk4QHlkk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-pW75Ps98MRqZ_n9XoWzTVg-1; Tue, 26 Oct 2021 07:52:47 -0400
X-MC-Unique: pW75Ps98MRqZ_n9XoWzTVg-1
Received: by mail-ed1-f70.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so12750592edj.21
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Z8pxsvvOFRcT+HyiQJ39ItHbml7GQ6KvffUlxLrbMo=;
        b=sJoEJOCs5njcWouJei0nMAocBesIH9ZIkIOesMak12/Q4wVHe3Vo/FKxv7yMWPmPzU
         jtnD1DOcZDaV/X/BGbGss4hQVrhXU1qX5fBbdFbWg8C4pzu+7NhfW4DaIG0EeFQ5G/wL
         pgbkm99s5JelPDRodXYTKDdLLd3gOuogtK0HYPuTWmBxNNXxHcoNUfL3xrxJo0SjwKM7
         4K7MylSsgESJHUF8C4atSpUgQ1os8oOXjYFlvWPKrZMsXAgnGJ5d04mdWX7PNIVsay34
         CHkSCzlrvRwCH5YI/hDTx3T4qvCor49seXHqMlAch4KTQYQQKRpb9OKjO4cGOlcNfn9v
         YxZA==
X-Gm-Message-State: AOAM533+TedVxYpgvJVA/RD28n+WYWwKSdKCEqgyC84KfYfnUhu0EXz5
        f+bdtpvjVIh12Lz5i+dFbIGOQLsmSZ1gIELhOj5iQdV/zWJWP3jP9UxcS5JNhlP7k2YA8QYHZE3
        omqY1lAGq2Uft08N/8CeHMwfvgkYzyb+6vXrUNr68OgI2mXW1MuHUZkiu+iFdHSWkJOAznw==
X-Received: by 2002:a17:906:5a62:: with SMTP id my34mr7038699ejc.348.1635249165320;
        Tue, 26 Oct 2021 04:52:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyl9+3y9qUVbxyK06Dv+jUlrGUHxcgkkv0p8QP2sDbL/maoPGMaL4q1qRlg5t+9ISrMokFw5A==
X-Received: by 2002:a17:906:5a62:: with SMTP id my34mr7038678ejc.348.1635249165018;
        Tue, 26 Oct 2021 04:52:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:44 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 3/8] selinux_restorecon: protect file_spec list with a mutex
Date:   Tue, 26 Oct 2021 13:52:34 +0200
Message-Id: <20211026115239.267449-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
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

