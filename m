Return-Path: <SRS0=vu0J=6X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C813C28CBC
	for <selinux@archiver.kernel.org>; Sat,  9 May 2020 14:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FA52072F
	for <selinux@archiver.kernel.org>; Sat,  9 May 2020 14:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BbFmqZkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgEIOGF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 9 May 2020 10:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgEIOGE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 9 May 2020 10:06:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011AC061A0C
        for <selinux@vger.kernel.org>; Sat,  9 May 2020 07:06:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so13736716wmh.0
        for <selinux@vger.kernel.org>; Sat, 09 May 2020 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Q/S/o6hWNDjoxn9Xajgc9/KuxvE4dgtekrmnaiIIiRc=;
        b=BbFmqZkjKqCIhODmT1oyJU/4d7i2C4OjV6Dlkd9Xmrqsb3WgrsGKXHPoSAyc+yRwL9
         hocK56TP9GX+Bfd9HHoxwBrVmkcWHDbLo6xMpRsefN4KrtfnYJ5mLPSOGfhiY+q/hCvL
         tHpSJHAqlQvyx4x/jJ3hpjYP2rEar+eEM/o2Rh7xzQDxoSN4fcmxhxUMdk9RumnP8xU/
         u17xflkxAueYQlaWS5rjSImIiyz/nlqKkzsI+EnuOmHbRrSK3FEl0hNPd0Mw8EqU+r6M
         SgLmNUoke2q4PhjzI7PwUxuytxU1lpyBJuCjJB6/S4P6tZZmy5gmxkbZJ17ol/BucUmu
         bsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=Q/S/o6hWNDjoxn9Xajgc9/KuxvE4dgtekrmnaiIIiRc=;
        b=W3aHAhu9uXLObozNDPuPVR4sdUjSgOM+wmQj4zXzKsTmhbjY4qcdSoYcIxo34eyfYF
         hO+xRqAzf2jCkH2TjOMbYDloaJkaoNN0xBG02MIymPoxO+36sXW6P9g9eWBO/9S6EPhA
         iqi6zI6nX289t0sIEZOf2z7DoiBbY6ZKwrkREd8LLqef+CqGhatdt2CS78PATBit10ep
         H8AHlXxCmWtZVymqb/QX/zfA5s+ntcq6djIqB45zniMzCDXEF2Fd+xOfLaPHbtD4viLy
         VZLv8whYdHUpGaw5ka0BTVdPN0PZ0lUQTn26PJEoZLUyRr3pvhXoZDaVIWNQ6zbHA6HU
         j1Dw==
X-Gm-Message-State: AGi0PuYT1KMcpM6Tv7LZaCoBTm5e90betH089qMMwjf3p3CEalG9YK7H
        r/6Z3fwONTFnWLLwZOCCZ05jszc7
X-Google-Smtp-Source: APiQypLq2RBShiSta6mToACqNzP3vJt8YLHoamzmd+0KLvnvyVdKzE2cSkyEYGNjMWtK4d0Fm7wJcQ==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr18950748wmc.9.1589033161662;
        Sat, 09 May 2020 07:06:01 -0700 (PDT)
Received: from ?IPv6:2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a? ([2a02:810d:4bc0:8098:78d9:64c7:b7ab:1b3a])
        by smtp.gmail.com with ESMTPSA id l19sm18340585wmj.14.2020.05.09.07.06.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 07:06:00 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH] chcat: don't crash if access to binary policy is prohibited
To:     selinux@vger.kernel.org
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
 MzTZEAm15uwFxq66
Message-ID: <d204aaea-ca46-49c2-f7cd-6f20889cecbf@gmail.com>
Date:   Sat, 9 May 2020 16:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sobject will crash if access to the binary policy is prohibited by
selinux, e.g. refpolicy
this also breaks file operations that don't require seobject.

Signed-off-by: bauen1 <j2468h@gmail.com>
---
 python/chcat/chcat | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/python/chcat/chcat b/python/chcat/chcat
index fdd2e46e..55408577 100755
--- a/python/chcat/chcat
+++ b/python/chcat/chcat
@@ -28,7 +28,6 @@ import os
 import pwd
 import getopt
 import selinux
-import seobject
 
 PROGNAME = "policycoreutils"
 try:
@@ -65,6 +64,7 @@ def verify_users(users):
 
 
 def chcat_user_add(newcat, users):
+    import seobject
     errors = 0
     logins = seobject.loginRecords()
     seusers = logins.get_all()
@@ -144,6 +144,7 @@ def chcat_add(orig, newcat, objects, login_ind):
 
 
 def chcat_user_remove(newcat, users):
+    import seobject
     errors = 0
     logins = seobject.loginRecords()
     seusers = logins.get_all()
@@ -233,6 +234,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
 
 
 def chcat_user_replace(newcat, users):
+    import seobject
     errors = 0
     logins = seobject.loginRecords()
     seusers = logins.get_all()
@@ -376,6 +378,7 @@ def listcats():
 
 
 def listusercats(users):
+    import seobject
     if len(users) == 0:
         try:
             users.append(os.getlogin())
-- 
2.26.2

