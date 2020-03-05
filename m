Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C5AC3F2CD
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524E2073B
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyC8pJlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCENxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:53:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbgCENxo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583416423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AAhmDKFKy5El4RC6OpkftZKgdbcbmiqXVp8yAOXv4rw=;
        b=PyC8pJlNdbSmxHAcs6ITxnktPm+fCkumsjAZtm0f8ZY4pjroyXDnvFUDX3h/jHbxjtWvUP
        kbVWAeeizXxbMxIqsD13EnnQ8Ceyt4ITiObP0pHnWcdfNZfregkjnMa5kQIlSzVh9YD1og
        lpOJ1QCGOvPAFF2njnHL1r8/YOO5nRc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280--68vJRKxP9y6JeKcKL8JhQ-1; Thu, 05 Mar 2020 08:53:41 -0500
X-MC-Unique: -68vJRKxP9y6JeKcKL8JhQ-1
Received: by mail-wr1-f71.google.com with SMTP id p11so2333479wrn.10
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 05:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AAhmDKFKy5El4RC6OpkftZKgdbcbmiqXVp8yAOXv4rw=;
        b=UQPt3k84JtXvOsDxyef+REexTR5+zSDMMtjLl58w+iYehrMmR6l9vdBGFhopJ38Za8
         PV+lx4K/f3ZuaMTMk9dGOVPGiSOYLtLQneYo+LzAqAE6Z5nfgohlPXBgsKVK6uyqf1y7
         8fFIgsBLUgv5d7VLZNKRcPJt8Z7WFxFgCoS/XFn6U9z4/OUmHp5qJL7KninWZH02Eb+9
         0VPmkCJq6LGyt0+S6Ekr+2mMMqHNGIZiJXvBe/pwF6HYqMwi/D1VDCjNbOp/7LzO3CxZ
         CzCR4C+gNiH1R8WidkakMfk9WNyNYNbvS6i48Vdm5GsPvYlbCJgqK3zIrkxfC5z2jOzk
         PoFw==
X-Gm-Message-State: ANhLgQ3QX0GIv7hUrhPYfV3Vbb4gSTyQ2fU9UQ/ajNXAo4lwY7gDBtlb
        UxB3ha1wbk4eeb15mwCk2WbSAnAdbVHD8XrEMyzLxF6criqK1JTVbquL/QsWdZ2n5tJnXpdQ/Th
        aNfOGGe4xK4V7FnqFEA==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr9444140wmi.94.1583416420316;
        Thu, 05 Mar 2020 05:53:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuQnwVi3XtawWgK+QraHmBUvX7UKXOUvtv9YljKV+W2OfyOiKzZ2P1RJ4fFGvoVsraLAooxqw==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr9444066wmi.94.1583416419199;
        Thu, 05 Mar 2020 05:53:39 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u20sm8679061wmj.14.2020.03.05.05.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 05:53:38 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
Date:   Thu,  5 Mar 2020 14:53:37 +0100
Message-Id: <20200305135337.113248-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The value attrs_expand_size == 1 removes all empty attributes, but it
also makes sense to expand all attributes that have only one type. This
removes some redundant rules (there is sometimes the same rule for the
type and the attribute) and reduces the number of attributes that the
kernel has to go through when looking up rules.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: fix typos (Tne -> The; cointains -> contains)

 libsepol/cil/src/cil.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index d222ad3a..c010ca2a 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
 	(*db)->disable_dontaudit = CIL_FALSE;
 	(*db)->disable_neverallow = CIL_FALSE;
 	(*db)->attrs_expand_generated = CIL_FALSE;
-	(*db)->attrs_expand_size = 1;
+	/* 2 == remove attributes that contain none or just 1 type */
+	(*db)->attrs_expand_size = 2;
 	(*db)->preserve_tunables = CIL_FALSE;
 	(*db)->handle_unknown = -1;
 	(*db)->mls = -1;
-- 
2.24.1

