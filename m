Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB5C41513
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjHIULK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjHIULJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:11:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9920210CF
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:11:07 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5607cdb0959so169604eaf.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611866; x=1692216666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWcFYaGSuqSygNA1A5+mhzKgV/pHHX0wPaj4dypTDFM=;
        b=kBF56GLbI6gBZuSHadScmKAPbX9k0gXnOxIvlh4xODeLsINKJCarhiwMCNLtX22K/7
         mQuNOlM3NlfpDsFyDexXiooGjshwSo4OFhAVadqEFqjlZaQfADcSFnQPLBsoLEnicmGI
         fnmB7aXHqrXJOItB69InIuansD/oF0fck7F76KH321/eCqKtCCgT7JbwN4MRJAf3xck2
         vrWfP/vNZI7ibeehVg664F0GCp/9nuxUznyF0cXEsFoVrjkCZKs3lR3ctgw5zgh2HkSQ
         /oZQMTVN2DOstF0fDl5OAo6lZeJnNNqFFccDct3Q/bpdGD9CEU0U7HV4dxnUQwgA0xdt
         dY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611866; x=1692216666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWcFYaGSuqSygNA1A5+mhzKgV/pHHX0wPaj4dypTDFM=;
        b=fpSux8wpWUZA3cEx0jZEt3HuIxIW7oliOJX6rr2bo4yCeOOxlOzlOma1NJADGdpvW/
         O0ed1DHSje9Cfdn+yX4orcINWP5hgCBv6fJodsmO1t1XX8AbQpesb2NMuCPotNaafa1V
         hpwiQTZyfd1pJyuZSo7KhZiWTW5cy3XLwg+OIsltNDfjZSoyy71U6L7EMMHnjI10fjDD
         GQAO6RWKKgeflsugnsAkDK8gHffg9Oh0zZTWeft240leQ391ecu9COUR4NxxPU1nYDXl
         slU1jK0j2Dm/FkRgbTWL7F1DHSypSblO3CLqpPxFD1Eh9oqqsIhcSqpxYYnP7OUg9T/6
         xLTA==
X-Gm-Message-State: AOJu0YzSXS/HwM3FJIA/bZ17jnxLXRrHkSvpZpgW13ww3vBVvtV7IG3o
        ybDe07muzHbGg4eNiB7BR+vkLJQD1Nw=
X-Google-Smtp-Source: AGHT+IE1bf2UHdgc449htPctYsijQJBMOkKmZOOSIIN0GLCPjCLWR4pCE3phvJfGNSNkTSdnEZZwhA==
X-Received: by 2002:a05:6808:1b20:b0:39c:93e7:d5b0 with SMTP id bx32-20020a0568081b2000b0039c93e7d5b0mr436267oib.21.1691611866348;
        Wed, 09 Aug 2023 13:11:06 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:11:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 11/13 v2] restorecond: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:47 -0400
Message-ID: <20230809201051.108944-12-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809201051.108944-1-jwcart2@gmail.com>
References: <20230809201051.108944-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The Russian translations have not been maintained and are out of
date, so remove them.

Suggested-by: Petr Lautrbach <plautrba@redhat.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 restorecond/ru/restorecond.8 | 41 ------------------------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 restorecond/ru/restorecond.8

diff --git a/restorecond/ru/restorecond.8 b/restorecond/ru/restorecond.8
deleted file mode 100644
index 72d91199..00000000
--- a/restorecond/ru/restorecond.8
+++ /dev/null
@@ -1,41 +0,0 @@
-.TH "restorecond" "8" "2002031409" "" ""
-.SH "ИМЯ"
-restorecond \- внутренняя служба, которая отслеживает создание файлов и затем задаёт для них SELinux-контекст по умолчанию
-
-.SH "ОБЗОР"
-.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-u] [\-v]
-.P
-
-.SH "ОПИСАНИЕ"
-Эта страница руководства содержит описание программы
-.BR restorecond.
-.P
-Эта внутренняя служба использует inotify для отслеживания файлов, перечисленных в /etc/selinux/restorecond.conf. После создания этих файлов эта служба обеспечивает присвоение им правильного контекста, связанного с политикой.
-
-.SH "ПАРАМЕТРЫ"
-.TP 
-.B \-d
-Включить режим отладки. Приложение останется на переднем плане, будет показано много отладочных сообщений.
-.TP
-. B \-h
-Вывести сведения об использовании.
-.TP
-.B \-f restorecond_file
-Использовать альтернативный файл restorecond.conf.
-.TP
-.B \-u
-Включить пользовательский режим. Запускает restorecond в сеансе пользователя и выполняет чтение /etc/selinux/restorecond_user.conf. Использует dbus, чтобы удостовериться, что в одном сеансе пользователя запущен только один экземпляр restorecond.
-.TP
-.B \-v
-Включить отладку с подробным выводом. (Сообщать об отсутствующих файлах)
-
-.SH "ФАЙЛЫ"
-/etc/selinux/restorecond.conf
-/etc/selinux/restorecond_user.conf
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR restorecon (8)
-
-.SH "АВТОРЫ"
-Эта man-страница и программа были написаны Dan Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

