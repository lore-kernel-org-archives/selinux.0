Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F02C04E69
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjHNNVP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjHNNU4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E5510DD
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bc512526cso570389966b.1
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019246; x=1692624046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfrxVDE9VstbWj4fn7sebiRQEdVJJz4CbC0Rg1wJlB8=;
        b=ddS8uRXQMS/0i4xbF2X28t3MSNGAJvJmn16Yn7+YXKiJRLqllELCZDoaBxwY2VRocS
         jzy/YnVbqlScZMoBt0j/8++m57LCteVHh/nw0VRFQSF/3QsY7phpBAJ0FzILc1/WX1D/
         tE540K18LEhlM7LibknfxDPHrP23L9K0XBqUZAPGl1h+1H3mmzf5SMyGyLrITM7SQDnf
         /2oyIvhlCs5bZwODUIk6nQphwydtneDwtTGH+sHuq6LKR6knzq2dRmE+TQKihVJMdSn9
         /STaRypMk3X/TzqxuTN58KQU94RfxL4lvBGkMlVPHnjacXHaFvKC4+zUNsE1h7MDgbdM
         8H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019246; x=1692624046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfrxVDE9VstbWj4fn7sebiRQEdVJJz4CbC0Rg1wJlB8=;
        b=EnvlSmwT6lYeh6iBDqDR7tvyEiJYKKquNjkVEIhQZYM5Qxb/TrenXW9aGySa1gDI8B
         jsRryUaiwYbt4ULRdbg9Thrb4L7vjOKBCSs/t6NbeMMj3YFEXWHWZVfiX3T/ASBU2ZbZ
         2dIxTvLlX0PC2RuEWwTq8vD//9hUE87oKYqbb+XKHfRHVW6FGtu4H9bC1CHgMrMcPs8x
         t6VY9gCcI+LJaHxd0ug73S4lLrE8oOYccTCh4a53RAsgI/Bh39UYYSmhig8M8xxxwFp8
         xeNohyFM9ZvK2jPUvCzAldA6v7fSdxOSLPxe8CPaH978LSQUHMvWPI39PnRjUYdRLz/T
         0U0Q==
X-Gm-Message-State: AOJu0YzX9AYgwcaj/2T4l0v+TqF8kX+VkVsPLFE4Ne9kj3v0PeZZFBsE
        J25b9nDyrUM0zk9+28poq6BRjXfQAs0800StQ1U=
X-Google-Smtp-Source: AGHT+IFG5zB+wsdXPOf4JOyb4AJT14lsVia6KJpNmG0OjrFmnzni8IOyu5l1j0j33Wh+HQDiQ8Hn/A==
X-Received: by 2002:a17:906:73d5:b0:99b:4bab:2838 with SMTP id n21-20020a17090673d500b0099b4bab2838mr7844631ejl.0.1692019246355;
        Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 11/27] libselinux/utils: use type safe union assignment
Date:   Mon, 14 Aug 2023 15:20:09 +0200
Message-Id: <20230814132025.45364-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    selinux_check_access.c:43:10: warning: cast to union type is a GNU extension [-Wgnu-union-cast]
       43 |                                      (union selinux_callback)cb_auditinfo);
          |                                      ^                       ~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selinux_check_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/selinux_check_access.c b/libselinux/utils/selinux_check_access.c
index 6cea40e9..f7b27a85 100644
--- a/libselinux/utils/selinux_check_access.c
+++ b/libselinux/utils/selinux_check_access.c
@@ -40,7 +40,7 @@ int main(int argc, char **argv)
 
 	if (audit_msg)
 		selinux_set_callback(SELINUX_CB_AUDIT,
-				     (union selinux_callback)cb_auditinfo);
+				     (union selinux_callback) { .func_audit = cb_auditinfo });
 
 	rc = selinux_check_access(argv[optind], argv[optind + 1],
 				  argv[optind + 2], argv[optind + 3],
-- 
2.40.1

