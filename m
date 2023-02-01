Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8188C636CD
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 13:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBANP1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBANP0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 08:15:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A2AD3F
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 05:15:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q19so7700166edd.2
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2YRXDG1nLI53BAb//uhPYdYYjP9McWPjxD80d2UbYI=;
        b=iN+f9LM9/evWQSKtQxVYslHT2ivLsDB93dnV13alIZwVJnru1yg6qup6WTf1BnMePC
         wfQ6Cf7K7a5eg3NAr8tCzCq5RsUq5waTE67/6gxkWqxrGwEtBVNnEGwZU2vVP6rmQT6T
         g4dH9khESlFQQKBM/kg5XHv9jK9HV/muTkEjId+whbEWVe0JuAktDWQoupdr3n1bzYUH
         XU8o/Un4Rs1KM9RNNDohgSbhwaEjooO0V7/7uwBOr4N0Tu8ikFx4flaAu7+w2Ao0nZzd
         yY8/udjXYUrZya83Qte839T4B+74Z1HjzX9VWcf+oUOjM6y2d447FEozQvHDozE6LGu8
         8ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2YRXDG1nLI53BAb//uhPYdYYjP9McWPjxD80d2UbYI=;
        b=wFwS8OhxQrX6pQKBEgwWl0gR0Q7bYbURpCuFmCdIyQ/QpRWZIfPGIChFkB/sIgipbS
         cwe8h8Fpdcl2Rl3s2CsLqBBtlgDrvroevBbM3Mo4vkWGDCipjW9MwWGzK2mwoLU0yotj
         dRyhiwSyaKbBiEdzYrEGmnEloAliuzcjECccK7NnwQ3xpg4u7u/TjFhUcYUgwGn2lK/j
         /+NDYHZi/7EawJ1681qRUU5dCkFYtiBwrtf+Bs4XYPHDiS7vXaBIkJmeKfrLZdHVn/pN
         570Yy5cEDPcZbmUzT9ixJU/wewDxupqmmo9TmUa6xxiKcHpycqSvhIns/Q9sQMJxK5Ks
         puEA==
X-Gm-Message-State: AO0yUKUOCwh46bCgue118iF0Fd37VbMyTgwATJU5psFslJQJYz3sMFcM
        Tabf+ZayDBt5dra0Z/D6q9nTizJUOH2Ldg==
X-Google-Smtp-Source: AK7set9Jz12krvb2P4JHZsKl1NV3P9L4d6sF/Dmef+1xPH6W3c5G1wAajYINSDhal9bkCaNA24Tl/g==
X-Received: by 2002:a05:6402:401a:b0:499:bffb:7e58 with SMTP id d26-20020a056402401a00b00499bffb7e58mr6495759eda.20.1675257323780;
        Wed, 01 Feb 2023 05:15:23 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-178-099.77.8.pool.telefonica.de. [77.8.178.99])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7c40f000000b0049f88f00f70sm8431978edq.7.2023.02.01.05.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:15:23 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] libselinux: getcon.3: add note about PID races
Date:   Wed,  1 Feb 2023 14:15:16 +0100
Message-Id: <20230201131516.19967-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201131516.19967-1-cgzones@googlemail.com>
References: <20230109170912.57887-1-cgzones@googlemail.com>
 <20230201131516.19967-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a note that querying a foreign process via its PID is inherently
racy.

Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/getcon.3 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index 1b4fe4b7..be60341b 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -149,5 +149,9 @@ The retrieval functions might return success and set
 .I *context
 to NULL if and only if SELinux is not enabled.
 
+Querying a foreign process via its PID, e.g. \fBgetpidcon\fR() or
+\fBgetpidprevcon\fR(), is inherently racy and therefore should never be relied
+upon for security purposes.
+
 .SH "SEE ALSO"
 .BR selinux "(8), " setexeccon "(3)"
-- 
2.39.1

