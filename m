Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DB0C433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 21:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0622664E58
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 21:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBQVQr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhBQVQq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Feb 2021 16:16:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0247C061756
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 13:16:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o15so3470405wmq.5
        for <selinux@vger.kernel.org>; Wed, 17 Feb 2021 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rE/nK/xgS5dIgmaWncP8/S/EbO20vDeHrEJ++s3lXvc=;
        b=Iz0NK0jSzt6n1Mt+oQ7ute1XWhn/YxWtXhI7KaE5rmCxmWnbjOVDaPMiyNbK4Cl9mK
         jHIFFLZz5gKdHObkduOQIpa8vAzc28qPgT1kU5um1/TWbSMzugJj98H7tpvQ0Kw6T/fs
         CaEqIMv2qKvJIdJOnHmoQoNUqO/RmdDf1Ku9mqAmDDS7xfv3LbEOhMODRQcLG89Qus7D
         DdKT9UbTV2z4sM8QTafP9djzgKHErDLKeyRhBdQG3OMy8ssQA5kRLjMvccBrVD+89gJa
         Q4PBPusW9Ebsvnkjv5PGDvZUs673nz7UaWb8jbvbFV82me5fZQ2FHodU2OHJ4oEUWBe0
         SnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rE/nK/xgS5dIgmaWncP8/S/EbO20vDeHrEJ++s3lXvc=;
        b=ptl9QydbCHcBFY3LNfR7P0t7nfpl28TeLoqtXxwXCk8T6Fho4ZihFsKr+MiyLRbiDA
         tofCBcMTpPkUl3e6ULnXVb93Hw7EGfKzGAWXvK81x8J9FLYEx6N/EKy0T/ZnBbg4Kb9r
         vsGXOVAN0zEMbMFzWKgm5Dtr3NpEANFL/nOS7FGPEwIaBmLgajtLGmx1+me4vfdZIWFk
         CsU2qafpU2bnKGaFgrXVw+pFqKfOxUl1sncGXaueixArXGDD4LzUuF/+x82PZ/DXAjUI
         KRC3tVNhBmHGP8A1f27hyiVHBOY4U8zErziHCmRkfWYOAmUGxcKCkZ71xEsTpaNWCM9F
         Iy8A==
X-Gm-Message-State: AOAM532ysdtwbOe1bLBpqWDBQm/kJGuRKAxOeAUQlsqOn706fr0Fl8hQ
        QeEQplH45qWSOpQQTeEWswg=
X-Google-Smtp-Source: ABdhPJz8prDuS6iuonQ/xNTBu8roIWVtMqHymgu3Xyufjtqm8N4SzeAxggwgJuK4XewZDNYB2i2NJw==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr630053wmj.124.1613596564502;
        Wed, 17 Feb 2021 13:16:04 -0800 (PST)
Received: from ?IPv6:2001:a61:1143:1:6a3:b28d:bcc4:1981? ([2001:a61:1143:1:6a3:b28d:bcc4:1981])
        by smtp.gmail.com with ESMTPSA id d20sm6201377wrc.12.2021.02.17.13.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 13:16:04 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Subject: [PATCH v2] chcat: allow usage if binary policy is inaccessible
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>
References: <CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com>
Message-ID: <6b298117-2dd0-322a-4de2-b8886731265a@gmail.com>
Date:   Wed, 17 Feb 2021 22:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, chcat will crash when run as regular user, because import
sepolicy throws an Exception when failing to access the binary policy
under /etc/selinux/${POLICYNAME}/policy/ which is inaccessible to
regular users.

Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
---

v2:
 Fix signed-off-by, improve commit message, but otherwise unchanged

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
2.30.1

