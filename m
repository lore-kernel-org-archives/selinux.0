Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88406C35E04
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6047B21556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf8WKv70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbgBYUCx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33969 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731716AbgBYUCx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so128961pfc.1
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wwFhO9xEQoqdC2RxprqBabD5tnAZvcCgeKvB/jvXXqA=;
        b=pf8WKv70fl3pJEgH8aGccVFpXAFkbq0bEzLl40xLqJf51G5TjJEYBFfZst8HL+2+lm
         cy+5h1ktp17mcgqLawDxXMh5lIQJgo3U1W4cBuUOLqDCxyQCojL4v990BJYFqBsTs7IJ
         od4zNWK6KBml8EGPQugWsUQk8Pag5qxZXK+otpbkQLIao2zCD8L8gW3w65kdQXp6xWDd
         AnHG2+J/gdMjYElm7JURD1X18XbUsBYbUSbzQ6uwm1iyFulokdVFKU4A/KUMbBC6yuY7
         mpGmrKIclBPX7XWHmk0YzeRpLY/kGR3LJAnadH4GlKzhKMD5cYfLhOkDjoPQ0cGVHP9R
         2KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wwFhO9xEQoqdC2RxprqBabD5tnAZvcCgeKvB/jvXXqA=;
        b=Qv20fkBLxvYfY5Z4oI+3tc9k7qgcSmeF/DkknFMQ7SkO8ZiNoQPEF5rwHlhsZttr94
         0ZhucZwzKmrFC+qJK4QaYm1w2x1R/tqtgPpYlcqou56exkfcFnEw0ApGyFOR/024XSlv
         8W4hovLUEZ70XZ/pLbzSeui44Tq5qaIv1f+71uPivO+kbPB4IwCuxEMMaJfpISYpEFMt
         DfwaB58qlk3S7zBlVFcbPl2fHoEA/qMy1e2xK20hZ2HpzEv9M3t3MgA9wLTjHZ6yH3As
         HucPF0qVKJfWSfvQ7UAwgCiQ+i1eq+ArpwDE/xu1hFm0KHOZ7dkbFLCOoEGn2yoor/5W
         rDNw==
X-Gm-Message-State: APjAAAXK+B1l3HM2fCJ+1n5YnH/UOB451LgyEk6fe6xZEGCv1IFVyNf2
        fgIcjCqtXKkDc7+4GD3weZs=
X-Google-Smtp-Source: APXvYqyLu3tSsK7aqaMECko9Gn7LdqCtPsX/cqvnOH08kTC3qouhk0pn2rifrRrmOzQtCFka8lmQOg==
X-Received: by 2002:a63:a351:: with SMTP id v17mr164524pgn.319.1582660972528;
        Tue, 25 Feb 2020 12:02:52 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:52 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 08/17] checkPasswdAccess: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:10 -0600
Message-Id: <20200225200219.6163-9-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index e531f927be1e..3704eabc7545 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -603,7 +603,8 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 extern int selinux_check_passwd_access(access_vector_t requested);
-extern int checkPasswdAccess(access_vector_t requested);
+extern int checkPasswdAccess(access_vector_t requested)
+   __attribute__ ((deprecated("Use selinux_check_passwd_access")));
 
 /* Check if the tty_context is defined as a securetty
    Return 0 if secure, < 0 otherwise. */
-- 
2.17.1

