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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DBC3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FB12078E
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU73WbIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgDTPqE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgDTPqE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E14C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u9so5111096pfm.10
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zfah9HSGQgGYpQi+daihMCdQ48cIJqxp2wzwkAq8SWQ=;
        b=eU73WbIq5uZ8wTHjtLhxU583MSSQwdklcgQjq2nDesXaWNAxYIr5B9LnH88+muqeZO
         QFnSnDHd2u7G6sl0pbB/C/8vD3xOtinSD4kb/UxLMARJ+V2RSpp2HFnCbCvJKAo6DOU5
         LjlC+PE85jUVSrjSUKUMTux3pD9XbsRjPepqX2TqQRJUhSdrYw5x9usDl+I0GUvkUkZv
         itmocHgzTbI/tLeUwnd089FZFbitH7Sj53tR+EENIO+/D2lZdF4xr0eP5+VN77jea8Z/
         73Ct5xWWVNDk8pw+JuU45/YqVYZUoS5p8hNEvuMemOT0UygF9s1bqRsT03QPRG/t2m2o
         M0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zfah9HSGQgGYpQi+daihMCdQ48cIJqxp2wzwkAq8SWQ=;
        b=ff34ZUPmte0Yz1mE4fUpDCHZuDtNCiDqXdRZvAdq93PTs5ndOJufQtq3Wdyly1QmUf
         tuk+MzQTdaWHU0NatQ4BgG9zR0qlmI2YjBYmyZUlLA5gyEWvxWzZQN6mD5I26RpgYv4k
         IQSBxAu+S8cMeRRKwSqDwd1HINJcfnRzztP12SKWJzyUGZc0t26yaZctBQnP4kgf49+L
         NCkr27EYKoMpHUMPttBKxNvb9xZJLPcEMSwi6YiD2v676OCbzxwqiCQpuVdT7nd2dkQE
         XTBNdA0Bt7ft5nZkn6Sac249Yl4X4jebwMW9GKgnpbUhcufiXhdalJTppz6PFItLuwhz
         v7Fg==
X-Gm-Message-State: AGi0Pub/eTmNW9NTN1OHgujYAZ0dT13Z+hKp9ZZDvUS3V89vLJqWhOZo
        0uVQV9OMNAhAe/UMpPHDEsc=
X-Google-Smtp-Source: APiQypKB/UfIJ5LtDQrkkbx8pZtlIsy/EQmqIeoq0ibRWSicJVmtW1NhxZwv+cc0tEiAfjZkwwxoJQ==
X-Received: by 2002:a63:4665:: with SMTP id v37mr16120736pgk.297.1587397563436;
        Mon, 20 Apr 2020 08:46:03 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:02 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 09/19] matchpathcon_init: annotate deprecated
Date:   Mon, 20 Apr 2020 10:45:27 -0500
Message-Id: <20200420154537.30879-10-william.c.roberts@intel.com>
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
index 9dcb3220264a..940c43eff8c9 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -465,7 +465,11 @@ extern void set_matchpathcon_flags(unsigned int flags);
    function also checks for a 'path'.homedirs file and 
    a 'path'.local file and loads additional specifications 
    from them if present. */
-extern int matchpathcon_init(const char *path);
+extern int matchpathcon_init(const char *path)
+#ifdef __GNUC__
+   __attribute__ ((deprecated("Use selabel_open with backend SELABEL_CTX_FILE")))
+#endif
+;
 
 /* Same as matchpathcon_init, but only load entries with
    regexes that have stems that are prefixes of 'prefix'. */
-- 
2.17.1

