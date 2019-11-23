Return-Path: <SRS0=YAEg=ZP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C75C43215
	for <selinux@archiver.kernel.org>; Sat, 23 Nov 2019 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8A42071C
	for <selinux@archiver.kernel.org>; Sat, 23 Nov 2019 14:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsebm6x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWOmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:42:55 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39138 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfKWOmz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 Nov 2019 09:42:55 -0500
Received: by mail-wm1-f50.google.com with SMTP id t26so10917152wmi.4
        for <selinux@vger.kernel.org>; Sat, 23 Nov 2019 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjBL22PN3sfJGRvlVEWYzFP2gOHzeBEKWnMBHLTV6xo=;
        b=Tsebm6x3p1GAedoCo7oNTQaHJJ8OsX9uKUD24BM1w/u3mloWXad/lewLXU+Cz4h86p
         7U3L3CQ3hgFKFBX6phdPdhSYe7e7E+bGldDQRan3WK1rT1iJhxTHW2ZTIxmr1ddab6zZ
         xpcooEPasjevSxzttRt6it50F8wb/NGiZdMSPciUA0oFR1XVKU5C7nUpEIW6vbI9ECMT
         nEg1mvjoCRCjqrgxuJ1Jn8BCi6sXWAe0/BIWUqQVWhNxl1lG/aFFVsGrHtlW83C71bts
         exmIJP3Famzsx57qUEFFp+/r0DxOQDIj4JWcYxp5VLu8n5fw5yHb2/+8jcN/dBryldUA
         xv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjBL22PN3sfJGRvlVEWYzFP2gOHzeBEKWnMBHLTV6xo=;
        b=jBCOpSc/BpJ8hIantD383X90q3p8jFhMkbRAmq6AG2/LA9rqR5t6BsCQr9mGcYpNUD
         m0CUuGT+LUXgxvj3qali086ut/gCCNNFbtdhMZSssccR+SVRWu9zYu18jVIrMm1L+Bm1
         RPc3G/H0OyriB3qn566o/YNXpjiOFXK/RFOyGM1rSd4iIPUzk3F1IQ3hOtSKSsk0ACpV
         apPpRg66Xul0FHjLnKBGQ1lcYe8Afx9af23tXPLLlvvjl/7N9H7SdTGExfyT7WNQnqSe
         aLnOwUmz+HBxybMa5xdzaEpalFLGIbZRibqm+8aJWXtyfMceP/b735Zj63mrDiF9sQBk
         vv2A==
X-Gm-Message-State: APjAAAW1JTF6JMbH5QaPxsigrbSmSvZ5VP/XJr2XxCZsiUdXn5gwJ5vg
        DknXgmOVFjhv0kWE8bKekc52RzLD
X-Google-Smtp-Source: APXvYqzDDdrmfcD+3umHEtSWMOboRbGWl3gQGUukzRoaJzXX0cKhOhsKG0/jA4DRRb9/hhgt6pUjTg==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr21143826wmc.121.1574520172970;
        Sat, 23 Nov 2019 06:42:52 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id o187sm2112090wmo.20.2019.11.23.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 06:42:52 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dac.override@gmail.com>
Subject: [RFC 2/3] semanage: do not default prefix to "user"
Date:   Sat, 23 Nov 2019 15:42:44 +0100
Message-Id: <20191123144245.3079306-3-dac.override@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191123144245.3079306-1-dac.override@gmail.com>
References: <20191123144245.3079306-1-dac.override@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

By default `semanage-user -m ...` resets the prefix to "user". We need it not to. Defaulting to '' results is no change to the current prefix.

Signed-off-by: Dominick Grift <dac.override@gmail.com>
---
 python/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index b2fabea6..e5abfdd2 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -425,7 +425,7 @@ def setupUserParser(subparsers):
                             help=_('''
 SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times.
 '''))
-    userParser.add_argument('-P', '--prefix', default="user", help=argparse.SUPPRESS)
+    userParser.add_argument('-P', '--prefix', default='', help=argparse.SUPPRESS)
     userParser.add_argument('selinux_name', nargs='?', default=None, help=_('selinux_name'))
     userParser.set_defaults(func=handleUser)
 
-- 
2.24.0

