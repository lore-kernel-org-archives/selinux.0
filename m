Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658F2C25B0C
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiHHRhH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiHHRhE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:37:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D8913F7E
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:37:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gk3so17857133ejb.8
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=PMplhifgaOttKG7Qk7foOBtpQFhet1VGhNnwTKtfZV4=;
        b=apz/eogb6ql5DyhDtLqj5HXLeRvlW7PmEQmXWrTm0NLpPRW+I6EbqTWe3ydXB51+oc
         LucvWNVR/dDPJxFZiP4GSmI3k825pBxwHEKFK6j2rawJsXOaMKkUpxdUxk5d/pv93AsH
         BwkxMBzM7/R6L/GXwoiXzd43YTXuQlrY6g8kdCVOMNZRcd6tjyGJavpWBo4tVEhmHN//
         nMwfVajMNexBTbAVj8Wt5jqxxtWf073aymqIBQA8omzZeE4nlMxYC1b0i061nlWO+Glq
         grT73e2sSRzuWl5VfqlKjGdqWUzXroXrhI2XlrRv7j1WBD6SZbokZvYcyb3xW7hBHJbI
         b4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=PMplhifgaOttKG7Qk7foOBtpQFhet1VGhNnwTKtfZV4=;
        b=NzRCNjQir81pAi2f15zrX3QRm94gleIUbLObeaLiNtPX5/+redx2qPXDHH6aZvFsUx
         ReSLcdh4l6hNcTlFKdegC6I8WIhE81/vz4JeJ85LHpkArELaJHYJEhQrDQCFdkFerVwl
         fE+x1E0McZ9xuxoAcO9EC0gbs1rwcQX7LoalM5vdIMsCemd7pix0KDYqqVuSvG6aC8TD
         9F8tpTgurtBuODNYNO3bTW5/u3EXRF13aFDf0lmIX1iltJlvgRtGZAPXv+EEhHRqH4kH
         5BuXouudFgm/4I0XWhJiNbsUZhwVld/llijCAnRN/3vvC8s9vE30s6m5zOI6BwHO4AdZ
         Hnog==
X-Gm-Message-State: ACgBeo0NgQ09BRHIR2YVqr5wNolxBVgvvyv3HdQoHryTMFu0JshIKw0e
        8GTUJHabByG9/TWFEAG0+NZIhbEySqw=
X-Google-Smtp-Source: AA6agR4a0klH0J12GosaTcovOZ58Gdv+wnw3PQuszlMxIYD+ChZLVsnbviMD0wYnxweO44wS/xrFdw==
X-Received: by 2002:a17:907:968e:b0:730:bc30:da2f with SMTP id hd14-20020a170907968e00b00730bc30da2fmr14724264ejc.484.1659980220373;
        Mon, 08 Aug 2022 10:37:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a61f6c389sm4851900edb.4.2022.08.08.10.36.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:36:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] scripts/ci: use F36 image instead of F34
Date:   Mon,  8 Aug 2022 19:36:53 +0200
Message-Id: <20220808173655.16867-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808173655.16867-1-cgzones@googlemail.com>
References: <20220808173655.16867-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/ci/Vagrantfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ci/Vagrantfile b/scripts/ci/Vagrantfile
index 20c523a0..b6023367 100644
--- a/scripts/ci/Vagrantfile
+++ b/scripts/ci/Vagrantfile
@@ -34,7 +34,7 @@ SCRIPT
 # backwards compatibility). Please don't change it unless you know what
 # you're doing.
 Vagrant.configure("2") do |config|
-  config.vm.box = "fedora/34-cloud-base"
+  config.vm.box = "fedora/36-cloud-base"
   config.vm.synced_folder "../..", "/root/selinux"
 
   config.vm.provider "virtualbox" do |v|
-- 
2.36.1

