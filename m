Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7BBC43217
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1550960F36
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhJNOzc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231903AbhJNOzc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634223206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFcaS2mw+N0nTSlkVptXG9WuCQnOex3N9UZzUdj4Q7k=;
        b=A/WOnPXp+QNOBbZ9ZEIfGm8YGqjFd18mY+4t3K6jZWM1ZC0aXkhZ5B3gIG3R/CeajlqSoZ
        nQGU/UpK6ej9bgm5p030xjkXowYi0iOjfcQ7xn7dZcYsEh3MRD5lbt65FvQfl7x+tvVwCR
        JQj89nRjO6Fl1vTxudg1yfIrXXhl+C8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-0BYDXQPvOCGSx3RfU5AXeQ-1; Thu, 14 Oct 2021 10:53:25 -0400
X-MC-Unique: 0BYDXQPvOCGSx3RfU5AXeQ-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so4746124wrb.14
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFcaS2mw+N0nTSlkVptXG9WuCQnOex3N9UZzUdj4Q7k=;
        b=iaLpQnIemhOdTlImXpsgRACiiIpPH4Sn2vAuYpGlYYgaapUmxLU9dPNuQ5mI8l1wlA
         2YPC+MnWSUXKcWSKwu/ph2czTlZwUNBt/YE7gZTOmBI7hQ+1HpxOahC+O9ImT7D+h/do
         A5Gp6ggWBuACstoI5Tba5c/19GSFYclQhDK0o1CSpkjj5qiVX9m/JYKhG8tG4mAgqb9z
         aIGTu3PqiNqduJ+Kh06IkFC3cGOPoctE50DSZSMdK/8HBJIwvjPaQUFDDpjKdrFhEtDJ
         mRMjAeHNAoODhEpLEC1wpP6pnorJ54C4zA+UVRvhDU0Avnxtv+jM3hoR/0FEuWh9ViDu
         6ovg==
X-Gm-Message-State: AOAM531nPW9SNGdxnbkF9emZaGuWnysft/LJgd15KzGdnpcBifZHAXXa
        mI5ph41bMSXOeUDjjMtmi1Cstdgk3TgUFAymXZ4ddkzLH6DwTBbQiB+c+NspjpqBrdIN0SdvmuX
        rvmaYW/pABlK8R2+x0aglEvEr0+JxgtSC4fRWGO8cN65UMTACRUJ98ItnPbu6pG6PEfbNDA==
X-Received: by 2002:adf:aadc:: with SMTP id i28mr7181192wrc.320.1634223203974;
        Thu, 14 Oct 2021 07:53:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/7oDA5GdQIrs4s7MY5tqd1zJ55dcH4j2KjgNTJ1NKDhFYzpHLSkvu/0jt4v3+nQ9WIevWYw==
X-Received: by 2002:adf:aadc:: with SMTP id i28mr7181156wrc.320.1634223203678;
        Thu, 14 Oct 2021 07:53:23 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k17sm2485489wrc.93.2021.10.14.07.53.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:53:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 4/6] selinux_restorecon: add a global mutex to synchronize progress output
Date:   Thu, 14 Oct 2021 16:53:17 +0200
Message-Id: <20211014145319.798740-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014145319.798740-1-omosnace@redhat.com>
References: <20211014145319.798740-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Another small incremental change to pave the way for a parallel
selinux_restorecon() function.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 732f0ccc..252b775f 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -60,6 +60,7 @@ static int exclude_count = 0;
 static struct edir *exclude_lst = NULL;
 static uint64_t fc_count = 0;	/* Number of files processed so far */
 static uint64_t efile_count;	/* Estimated total number of files */
+static pthread_mutex_t progress_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 /* Store information on directories with xattr's. */
 static struct dir_xattr *dir_xattr_list;
@@ -647,6 +648,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (flags->progress) {
+		__pthread_mutex_lock(&progress_mutex);
 		fc_count++;
 		if (fc_count % STAR_COUNT == 0) {
 			if (flags->mass_relabel && efile_count > 0) {
@@ -658,6 +660,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			}
 			fflush(stdout);
 		}
+		__pthread_mutex_unlock(&progress_mutex);
 	}
 
 	if (flags->add_assoc) {
-- 
2.31.1

