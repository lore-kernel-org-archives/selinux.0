Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C33C433E1
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D9A6188B
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWRIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhCWRIi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Mar 2021 13:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjQ7iJahwyEc5OLEV3uVX6G8Ao8xq7GsiItKh1IgUJI=;
        b=LNounjUYqatodSjvOMnuLfeS/U19u7w0ZpuiRIOiItiCiec7F4JuQT50ZAZjRN+JGoJM4u
        q38xxaMo1lpdBFVNrVZeGtu6dl/uLkZI1EHXzg+MGz2evR8xRaSlGUamA4pLDsuiIumk44
        IjSezM/iomim99hK7YUggHvxHjx6Oak=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-aa4o6I_DPZyWNgbv0my3VA-1; Tue, 23 Mar 2021 13:08:36 -0400
X-MC-Unique: aa4o6I_DPZyWNgbv0my3VA-1
Received: by mail-ed1-f70.google.com with SMTP id q25so1257313eds.16
        for <selinux@vger.kernel.org>; Tue, 23 Mar 2021 10:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjQ7iJahwyEc5OLEV3uVX6G8Ao8xq7GsiItKh1IgUJI=;
        b=ad23xGz1a22kGxrAVfIpfJ/AueT3lQqox9wC8q5SbaimlxEcnJf0ieUdR9lRGpnCNb
         CNugYrK1vSQRxOO2r6Qrr0EEX/rB4Yz3BQ+sQ6CL4pPIEIZL2VcH8jr4jaATc6DNzBba
         IU5HfT8bVYcHw4jtB2dtKagE400n3t2qiQkukCzyqfRj9QnRGS58J2Bb0xiWE/JdrMh4
         7Om0DUjqUvtBQGrvLUTBToZjyUN9grurFhnLQI6ytuVYWomiokeJBX2eo7iYMmqaQDUp
         pwbh9HNBVmyUXNytLThePpff6+rpw9gpf7AuZDDVAx9RzIMf1pvZ+x67ZZNaSGekomI/
         /DDQ==
X-Gm-Message-State: AOAM531Xf6MPSANVFDj+y13jTbDzd9qRCrOPQb2QW85mREAEYMGLxgyz
        KmmsqIzZ500o5fyf+LhjEmp47q14mwZGEtsqNHPtBLup5+a7Ntbqk7K2RTOqO+VUinyPNPoFgj8
        RkqSdsiEoHkvCMVll06vn3GYPR1TBLlUZK4SmnUXK/FHPuY7EyRSt9h2VTbDZko8EcBCFZA==
X-Received: by 2002:a17:906:1155:: with SMTP id i21mr5862309eja.218.1616519314615;
        Tue, 23 Mar 2021 10:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq9k0CU6ZloMLxdG+NanocNayd+Xez8QsTyWuaWwnlQ/sYGsKqvEVaL77burZRDSwCBbX05g==
X-Received: by 2002:a17:906:1155:: with SMTP id i21mr5862284eja.218.1616519314363;
        Tue, 23 Mar 2021 10:08:34 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k9sm13337948edn.68.2021.03.23.10.08.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:08:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 2/6] selinux_restorecon: protect file_spec list with a mutex
Date:   Tue, 23 Mar 2021 18:08:26 +0100
Message-Id: <20210323170830.182553-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170830.182553-1-omosnace@redhat.com>
References: <20210323170830.182553-1-omosnace@redhat.com>
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
index 62b54079..f4a973eb 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -413,6 +413,7 @@ typedef struct file_spec {
 } file_spec_t;
 
 static file_spec_t *fl_head;
+static pthread_mutex_t fl_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 /*
  * Try to add an association between an inode and a context. If there is a
@@ -426,6 +427,8 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 	int h, ret;
 	struct stat64 sb;
 
+	__pthread_mutex_lock(&fl_mutex);
+
 	if (!fl_head) {
 		fl_head = calloc(HASH_BUCKETS, sizeof(file_spec_t));
 		if (!fl_head)
@@ -446,11 +449,11 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
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
@@ -459,6 +462,9 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 			fl->file = strdup(file);
 			if (!fl->file)
 				goto oom;
+
+			__pthread_mutex_unlock(&fl_mutex);
+
 			if (flags->conflicterror) {
 				selinux_log(SELINUX_ERROR,
 				"treating conflicting specifications as an error.\n");
@@ -483,13 +489,19 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
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
2.30.2

