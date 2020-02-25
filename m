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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE09C35E01
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FDE218AC
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovd4AKhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbgBYUCq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36958 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbgBYUCp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so122465pfn.4
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W23xTt7ttGIK1C1HvZAN92fOe86sF7EeKTsLn8aQd+o=;
        b=Ovd4AKhT32F8m4v2MqyiOaLKmD3hhWHg02Q2vXM5WJ93CKKo5llFhtoK2nl6N4LF2R
         ZtUGJQUGqpL2gAfoKrTtkR8t4oaEeQ3k8vnyC1k60ytuFT6HPkA8+arLxHSnmZ7NKsIh
         M/J3u/bqo4attnvccyvl8oKz7lJDdzJE4LljUHsk6nDH8bdOttQpCWWKysaQmz8umH/5
         6CRfPdX8Hs4DmJXcZHgiMFNRVAlA13a9XUb2uFXWjPZcroS7A6WwVOiX8YPeVRNz3x7S
         c3Rg8ahk+dZU19/A6O8bujbTV3DcNM4Z4kMdJms5BS+z31Pamqu7VSMIE8depfQNOOPs
         wE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W23xTt7ttGIK1C1HvZAN92fOe86sF7EeKTsLn8aQd+o=;
        b=ikjZxJ1IviCp92Jcokc+bqwTiV76Zsst5N4cOr6ySUp8R4+IrOu+uYSoKn4Id6rUkt
         M/fTEF2iq9/vGUf6bKGxv26x1d0ODzuD7xLmfVaYupc4zSZO1xak+o1tyNRU6uT2xIVX
         yxQjfVWOxwofiUWvO83QiNu3SEyheDR5/FoHPVQpHgy0asxAWHexGmxrhMbUdh6zX1sI
         +lDZnmaq0VI2Ip45LE8I9Xge+HLRsiTnfYt+KB7RctP5CphVrAqVlyBJrX1U00sXh5+S
         ct1Ex6KvKF31fH+Jv9+qgM/yaIHwWzm46yz0sVeWejGEu2JfCbGsX9x/qtsEP3kwdDGu
         wB6g==
X-Gm-Message-State: APjAAAVhPAtQUaI+75Ud2cqvunWQYCyZmccsDQZdNW9ZQJI8h7zKvXWS
        O7zEJg8f1qJ5b1gaoWc9MOs=
X-Google-Smtp-Source: APXvYqyGIGyjHY/P99Oh2kPFIcXLinmYtZXLb7JKqPhsKn9ah61a/czkNW9Q5MwhMpUsETYd0p7V7A==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr434862pfl.32.1582660965158;
        Tue, 25 Feb 2020 12:02:45 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:44 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 04/17] selinux_users_path: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:06 -0600
Message-Id: <20200225200219.6163-5-william.c.roberts@intel.com>
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
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 0f77debaa06c..e5c8fdf3e4fb 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -574,7 +574,7 @@ extern const char *selinux_booleans_subs_path(void);
 extern const char *selinux_booleans_path(void) __attribute__ ((deprecated));
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
-extern const char *selinux_users_path(void);
+extern const char *selinux_users_path(void) __attribute__ ((deprecated));
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
 extern const char *selinux_colors_path(void);
-- 
2.17.1

