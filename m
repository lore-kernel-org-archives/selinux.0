Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434BAC433F5
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287D460F21
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhJZLzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235594AbhJZLzO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFcaS2mw+N0nTSlkVptXG9WuCQnOex3N9UZzUdj4Q7k=;
        b=W83XD2yo1RFrRK4XFgV+u0WWDUsIMyLFEvruDXqxBGIWMfUV+nhtTolbhpqymakXWHL5J3
        XlQrK4Gcp+ra4uJm3glHWZYofRobDQhEb1HOAWvS68XkW/Gw2tbxmSNTy9w/rf+hkVVz5+
        TZjTnaspNaryronnvhNaooxJ6fYLCT0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-yXwLPS55PKSra9Hfd4nXxA-1; Tue, 26 Oct 2021 07:52:49 -0400
X-MC-Unique: yXwLPS55PKSra9Hfd4nXxA-1
Received: by mail-ed1-f69.google.com with SMTP id o22-20020a056402439600b003dd4f228451so6311658edc.16
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFcaS2mw+N0nTSlkVptXG9WuCQnOex3N9UZzUdj4Q7k=;
        b=hQ6zliDo8bUMlXEq/qsljzwIcV8aOYFYawu/hDqh+gRruk18R++iFvz7fCP4ooRFOP
         4D9nu8andPiJQlmCF5HmwR6aG/1ohUdzEJxu6J0OtsCDDcUK/cD0eZnXVMIP+0PC9H0l
         tZc9kKsVFv+Aoulq6v0w4lPymXoP07N6eIaWHrzgQEf+ND9GE2vQXKj5Fladb57ygkeZ
         EjBwpEUuNLT8Wp4Q7F6uWOvCNSTuk2LQL86+qJG0Nu/xVj0YbMsgMmShT8qQB3Bgi5FI
         bW4XlabXoMcoUnbdd5k7N7kihUpy5OAKgFANMHxDFU0SpIpMfbi+D4gc60Lvx9onyeIe
         GFoA==
X-Gm-Message-State: AOAM5306tndscCgHXGdP5EYr0QptImGzXN+b2vtJECcfVX+6QH5Yiu7e
        8G0NDNnE885y4AbNaL8fXSfw2Hh1hiELIOz/m9lHs4rDyUBsLtAxZi+se86KKTAwK2xBFyycCcy
        WqkwdVENK2L+oKjrFoBpofi5zJRy1GymkIQNrsZFJaKXTllg8qm0QMIxRKNetIwMzDQlEkg==
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr30653484ejb.558.1635249168261;
        Tue, 26 Oct 2021 04:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJFj/Dvyj23TY4FBWPqYJ+nuOBrbglM23XbYfWVyEa7gpsv8fIS6pd8PvNsULRizomrmoipQ==
X-Received: by 2002:a17:906:a1da:: with SMTP id bx26mr30653469ejb.558.1635249168027;
        Tue, 26 Oct 2021 04:52:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:47 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 6/8] selinux_restorecon: add a global mutex to synchronize progress output
Date:   Tue, 26 Oct 2021 13:52:37 +0200
Message-Id: <20211026115239.267449-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
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

