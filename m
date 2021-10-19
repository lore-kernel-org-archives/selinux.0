Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9BC433FE
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6384060FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhJSPDt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233176AbhJSPDq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFcaS2mw+N0nTSlkVptXG9WuCQnOex3N9UZzUdj4Q7k=;
        b=EVvowgF9bGdHst7Q93ThYCUv/tOsawmMW7xEe9T2E0zxe0uQhaEteiJ+m6l+/YQ4o7LKUg
        SuWT+T9KMoQwujmgeL3B3t8jag6M4DyDaCtJnCSaaSosLYJLNblXKwLvsqvoRB7u7lVJM3
        /gQsDdFOwmCP2cT3lsus7f9YSdmK0QQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-d8ppuAq6MCy8tUrvATwz0Q-1; Tue, 19 Oct 2021 11:01:30 -0400
X-MC-Unique: d8ppuAq6MCy8tUrvATwz0Q-1
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso2606234wmc.1
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFcaS2mw+N0nTSlkVptXG9WuCQnOex3N9UZzUdj4Q7k=;
        b=KtYLc75dyhlpXxg8cWNgvxEAEjqCdzBm+Kw21JjhnX+ZETpwnIiRCAxehALvosIkpK
         p2D/0ijcYtPGyvMyqvK/XCGoGUsh/3r5u+EJjdMJOmxzFSnjr3KNI5EZcMinMgkVWc49
         inwMNTh8A4c5rC9LEaY+xUSvY4vtgqUMb70SBQY+nPc0MUNahSe5sM7tW5g1v1epSd0F
         4byzFhwx08zu2wS3El7kJ3FNZgMlPUEwxhufv7ZeVsoXV78EY+WgUXvHT8x2D/Xbt2lW
         kSrFUyB99ZN7v+PGII8PSh06Y6YeklHE734C4Fhf49iD8pvdNQ59YXH8K2EOI6ZN7zGM
         kjTw==
X-Gm-Message-State: AOAM5335JxF0VYBmf/ckxWh6XdHOtij7rQyNuuOONWcEsabf0ypJQAhw
        xY+0GEWpTIRNJHwuafeY5uDQxu8KzzXeYZq15zAgdBlL+wOOtauozVex78K1r7/i3w6d0GuKHpm
        jXyaJ16wLWHXvZRb2ZW0Mx6ZfF70G7K3X1ujrqPfCB18hECvrL13D/qy1b2KVbDSGN5aocg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6682887wmi.2.1634655688773;
        Tue, 19 Oct 2021 08:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1/bWiED3mA4UC2DCAjG3KxMTsOvkNT0hs0v3juW2RPnOkDC8jCtiz7xmO6hWJT3qlN7AGrw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6682847wmi.2.1634655688487;
        Tue, 19 Oct 2021 08:01:28 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:28 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 5/7] selinux_restorecon: add a global mutex to synchronize progress output
Date:   Tue, 19 Oct 2021 17:01:20 +0200
Message-Id: <20211019150122.459722-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
References: <20211019150122.459722-1-omosnace@redhat.com>
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

