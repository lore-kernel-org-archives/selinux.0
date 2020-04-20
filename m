Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391E3C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A32078E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqwmahBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgDTPqB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BCAC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b8so5115157pfp.8
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LiSqBGVfe5hAcik2WCFSuq49veVlaqUwalAvJGlQXvg=;
        b=pqwmahBYJDnYfq2IQe4nMH8LA97sJgYk2CnwRhtEARC/SEP7Yjk5Duw9KNP+gaSVLg
         d9H/k7JkuUOLtleO9A6hCsRAyqgIsraiTJ8B7pZnBdQ73ykDqF6ICQVueE2Jet65kdQx
         jvEGvv5FefR5i7i+FrxhDlFDUmvN+k+dE7VUYMc+yZ/Ywmy9kQ5xPNH+tO5slA7CFQ4c
         7d1P/DMwvdDfVpRi9P160b8qIx+l7eNpqKhkpHzxoLheis2RxdfHnguMfVMRoaFOBBcz
         z/CaudXvwoIhhr1iPS0AuzhuwL/MPo89u+aFoHUY8fKL4EkDfw6GMff3+V6eRoXyoqDc
         WIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LiSqBGVfe5hAcik2WCFSuq49veVlaqUwalAvJGlQXvg=;
        b=W6pVpqY1KaE1dy3xH1v5XgTOpMUrkgmft16UciRYoYtYdsYO/bPILRbrkuXtEXz3rY
         Y+TiBlYBhKuuE+IaFld6aZ5BqZO/3GGbYURGdsZ/s3MC9FlAgAQe94cL7fIHyQumgknN
         j4+OHnK4iojpNehMa1D7s0cPQ5MLpaYufbXNY8/3HrtgTW45Y6ak4ZSJWAPOJzZDb5z1
         5ycDopdNqZh0m/9MPnnPxO5KgC2F6zqh81lEsOvip0GxCo5NMeYkJjAtSuHSwAZsg9ES
         5ejgNZaAs3xlaYSD+bJBul9P9LbL8lrpRZcm+CAh2js9v53ynE7zFCO62/QIK+BP2NKN
         A+xw==
X-Gm-Message-State: AGi0PuaAHMewKHOR/GQyDE9uX7vOnnB3BCBjFHUjYpd6bk1xOl1OdpVv
        iIrRyLFpC1Y/6Vj4m0UYNtOdnvau/JQ=
X-Google-Smtp-Source: APiQypIeXzAYM4LqSXB5tam8ordJ7ikOAK2938YK3iYD8n/4Su289IgXwMZrmIbA6QvH7IVJOM11TQ==
X-Received: by 2002:a63:5d5c:: with SMTP id o28mr17691777pgm.322.1587397560934;
        Mon, 20 Apr 2020 08:46:00 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:00 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 08/19] checkPasswdAccess: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:26 -0500
Message-Id: <20200420154537.30879-9-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index deaa3f172586..9dcb3220264a 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -619,7 +619,11 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 extern int selinux_check_passwd_access(access_vector_t requested);
-extern int checkPasswdAccess(access_vector_t requested);
+extern int checkPasswdAccess(access_vector_t requested)
+#ifdef __GNUC__
+   __attribute__ ((deprecated("Use selinux_check_access")))
+#endif
+;
 
 /* Check if the tty_context is defined as a securetty
    Return 0 if secure, < 0 otherwise. */
-- 
2.17.1

