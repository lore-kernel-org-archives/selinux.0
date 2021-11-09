Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EAC433F5
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B52561104
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhKIPmw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 10:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbhKIPmw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 10:42:52 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943BC061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 07:40:05 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 13so19177380ljj.11
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 07:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2j5e9vRCU/b7xIT+KnhQyEhAUur/DD7crjSvxZh2Yk=;
        b=k04IZvPj6waI82CbaOfaB8TQsnzWfkMHVM6ZfXvYVnKSH44jWBRJdWexNoeopDcZyw
         rA+3GP204miedHiF7ZuaJNS7mzejbpmUi2wjLriF6piJ1/C7hjf0hs/w4LeVkb8LnGqa
         vJhr0yv1qvReEBRCdH+vrS7QbUncXx032sZ/vVjp5Q2uzvL1Qg4u4owy5VPBDkKl8sKl
         1q/YbmhiGYpwawoKKYVySa9h6KBCamOLa2hQ3kY+4gdO6vaufBE/3FimYXPyR26ac1Ky
         /acyixzghpEzWnwrdbrHY/ZJiYP4p2oyWqgVni859y4J3Vmrd6tgXYHmLSwp7o6Zd+zD
         9dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2j5e9vRCU/b7xIT+KnhQyEhAUur/DD7crjSvxZh2Yk=;
        b=ekhGlZK5iqeNdMG+RyrF2kojI3LCbcKbCowfrqXCrxSsXxzl3ikeUZBEgH9JKpiB2m
         IC5QkaiHiXzwoJy1pVuFA60c2PWB5XdNV9qo1GZIXZj08VBA6j5JC+Quq+BCxKWh7Ld/
         nF2EeonoKsDrAViMmRs6zcTMRkmRdfbWLvbFevyQcPHps7l6igMlfqzwS2JQUVGru92M
         o15RPGmCuo0bEH5TZYdJgL50a4ohKP6RsyEHRII4AYkdDTwTsXHMkkU+evidFbj0tsSL
         CBENQHyMf8nBprzwQRvmad91X4YdpbLOV+8xoe6FDdVEqJUR+v1wz4Pk4RrITJt0tz62
         75cQ==
X-Gm-Message-State: AOAM533s5xnX/NsfeWcTsmvtQL44bdkegKZQ+T8O1aoc46Vlr+eHymQB
        GXFBvRLMLJKXcgc9sRJf56+kSsJIwLo=
X-Google-Smtp-Source: ABdhPJzXuCUOx5yzacJrAAc7TIYIpCmkf+vHD/5pN5+9Mb9UPXpCoplqjQ6NRTDN9Z68Qz15ae8HlA==
X-Received: by 2002:a2e:2e19:: with SMTP id u25mr8812213lju.41.1636472404029;
        Tue, 09 Nov 2021 07:40:04 -0800 (PST)
Received: from maage-hp-eb.global.ad (gurus.cybercom.com. [185.93.49.66])
        by smtp.gmail.com with ESMTPSA id b43sm295434ljr.64.2021.11.09.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:40:03 -0800 (PST)
From:   markus.linnala@gmail.com
To:     selinux@vger.kernel.org
Cc:     Markus Linnala <Markus.Linnala@knowit.fi>
Subject: [PATCH] Use IANA-managed domain example.com in examples
Date:   Tue,  9 Nov 2021 17:39:56 +0200
Message-Id: <20211109153956.472188-1-markus.linnala@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Markus Linnala <Markus.Linnala@knowit.fi>

See: RFC 2606

foo.com seems to be privately owned.

Signed-off-by: Markus Linnala <Markus.Linnala@knowit.fi>
---
 libsemanage/man/man5/semanage.conf.5    | 2 +-
 libsemanage/man/ru/man5/semanage.conf.5 | 2 +-
 libsemanage/src/semanage.conf           | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 7d6f2fef..380b58be 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -23,7 +23,7 @@ Management library writes to the SELinux policy module store directly (this is t
 Otherwise a socket path or a server name can be used for the argument.
 If the argument begins with "/" (as in "/foo/bar"), it represents the path to a named socket that should be used to connect the policy management
 server.
-If the argument does not begin with a "/" (as in "foo.com:4242"), it should be interpreted as the name of a remote policy management server
+If the argument does not begin with a "/" (as in "example.com:4242"), it should be interpreted as the name of a remote policy management server
 to be used through a TCP connection (default port is 4242 unless a different one is specified after the server name using the colon to separate
 the two fields).
 
diff --git a/libsemanage/man/ru/man5/semanage.conf.5 b/libsemanage/man/ru/man5/semanage.conf.5
index cf65b3e6..548aa58d 100644
--- a/libsemanage/man/ru/man5/semanage.conf.5
+++ b/libsemanage/man/ru/man5/semanage.conf.5
@@ -19,7 +19,7 @@ semanage.conf \- глобальный файл конфигурации для 
 Указать, как библиотека управления SELinux должна взаимодействовать с хранилищем политики SELinux. Если установлено "direct", библиотека управления SELinux выполняет запись напрямую в хранилище модулей политики SELinux (это значение по умолчанию).
 В ином случае в качестве аргумента может использоваться путь к сокету или имя сервера.
 Если аргумент начинается с "/" (как в "/foo/bar"), он представляет собой путь к именованному сокету, который следует использовать для подключения сервера управления политикой.
-Если аргумент не начинается с "/" (как в "foo.com:4242"), он должен интерпретироваться как имя удалённого сервера управления политикой, который следует использовать через TCP-подключение (порт по умолчанию 4242, если только после имени сервера через двоеточие, разделяющее два поля, не указан другой порт).
+Если аргумент не начинается с "/" (как в "example.com:4242"), он должен интерпретироваться как имя удалённого сервера управления политикой, который следует использовать через TCP-подключение (порт по умолчанию 4242, если только после имени сервера через двоеточие, разделяющее два поля, не указан другой порт).
 
 .TP
 .B root
diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.conf
index dc8d46b8..98d769b5 100644
--- a/libsemanage/src/semanage.conf
+++ b/libsemanage/src/semanage.conf
@@ -24,8 +24,9 @@
 #  /foo/bar     - Write by way of a policy management server, whose
 #                 named socket is at /foo/bar.  The path must begin
 #                 with a '/'.
-#  foo.com:4242 - Establish a TCP connection to a remote policy
-#                 management server at foo.com.  If there is a colon
+#  example.com:4242
+#               - Establish a TCP connection to a remote policy
+#                 management server at example.com.  If there is a colon
 #                 then the remainder is interpreted as a port number;
 #                 otherwise default to port 4242.
 module-store = direct
-- 
2.33.1

