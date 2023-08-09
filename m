Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B158C001E0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHIUK7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjHIUK7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:10:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005F10C4
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:10:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76754b9eac0so19132985a.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611857; x=1692216657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iku1RXLNdAH6XvnWbhdz6W+Elx5TBsR1cwvG0ARme6U=;
        b=PZvBt5zEClSlOCeRABqjAN4BleFRQwoVCCl5dZxLKqUSzPMXAg+Gf8uGioVSB/UGTI
         C5H/aIbcqfpL7oGMKMNixv85RU0fdbFuhPRgT90Kaovn77oJbz8DLceD52FS4StGdU9n
         QRUY5BDD5b9zJoL4Ixqp19OkDtwPqI+7a++a8/Wb7K3Md19G0OUrnMVr7ARIGleWYUy/
         +X0jEXJRQx1wISK2L0lLoQpZ2Sronwm2XaqWAGKrYc1QAyoX1KaTksvERPye2o6FrIhG
         76SfEYJY5/khBjiXeRIpxq6KYgzHafIcMZBXD7PryUOhBfa8935jEhV+0AjCbph+t2aN
         KEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611857; x=1692216657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iku1RXLNdAH6XvnWbhdz6W+Elx5TBsR1cwvG0ARme6U=;
        b=OzmGKLag5reMSbVW/FIhmCC8Ntcg+4Lfg6BjkibfmdgL8v9umvmCqNSKGZJGndyPhL
         q0vbVzYVhy3nVypM0knNLhcXez03TrgQGh0E0hTlzB24nf6TsdTe76Jrhh+FsEgyCEKK
         qRct/vvEVV+oVsBaTvrrRBGf346GFgh3xt/O9o9kFjdXD4EYJhgtUoYXc6YPxlvbFX7o
         sZsFoU4RveA3urHNifldWW0FzfletU5wr1w0xYnq0kETYGAAe9gJxQNvGns5CmTKVAjW
         iPjyTZvggay79FsHNK/qpnlEbFLbwHBrtnzYw9QSe2GLTITDobBwoEXHHldiaF+8GQQO
         fCcQ==
X-Gm-Message-State: AOJu0YxMigusEc7bZ0WnCzgAxYQWHkN0l/lyYHF6/eMPLku7sztVCR9B
        2kSlBWyulw857X6O+ubbLRH4/aG/FUw=
X-Google-Smtp-Source: AGHT+IHCmdZ8xkyfl1gpmsyLUEWb84ujze31llqQ+ehDskqOMHnqESZeHUekAqUtehe2TZ+GBP5zmw==
X-Received: by 2002:a05:620a:458b:b0:767:1938:93c7 with SMTP id bp11-20020a05620a458b00b00767193893c7mr109643qkb.43.1691611857602;
        Wed, 09 Aug 2023 13:10:57 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:10:56 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/13 v2] gui: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:38 -0400
Message-ID: <20230809201051.108944-3-jwcart2@gmail.com>
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
 gui/ru/selinux-polgengui.8     | 35 ---------------------------------
 gui/ru/system-config-selinux.8 | 36 ----------------------------------
 2 files changed, 71 deletions(-)
 delete mode 100644 gui/ru/selinux-polgengui.8
 delete mode 100644 gui/ru/system-config-selinux.8

diff --git a/gui/ru/selinux-polgengui.8 b/gui/ru/selinux-polgengui.8
deleted file mode 100644
index a8e692a6..00000000
--- a/gui/ru/selinux-polgengui.8
+++ /dev/null
@@ -1,35 +0,0 @@
-.TH "selinux-polgengui" "8" "8 апреля 2013" "Руководство по утилитам настройки системы"
-
-.SH ИМЯ
-selinux\-polgengui \- утилита для создания политики SELinux
-
-.SH ОБЗОР
-.B selinux-polgengui
-
-.SH ОПИСАНИЕ
-\fBselinux-polgengui\fP - графическая утилита, которую можно использовать, чтобы создать платформу для сборки политики SELinux.
-.SH ПАРАМЕТРЫ
-Нет
-
-.SH ФАЙЛЫ
-\fi/usr/bin/selinux-polgengui\fP
-
-.SH Примеры
-Чтобы запустить программу, введите:
-
-selinux-polgengui
-
-.PP
-.SH "СМОТРИТЕ ТАКЖЕ"
-.TP
-selinux(1), sepolicy(8), sepolicy-generate(8)
-.PP
-
-.SH СООБЩЕНИЯ ОБ ОШИБКАХ
-Отправляйте сообщения об ошибках по адресу <http://bugzilla.redhat.com>.
-
-.SH ЛИЦЕНЗИЯ И АВТОРЫ
-\fBselinux-polgengui\fP распространяется на условиях Стандартной Общественной Лицензии 
-GNU, авторские права принадлежат Red Hat, Inc.
-.br
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>. Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/gui/ru/system-config-selinux.8 b/gui/ru/system-config-selinux.8
deleted file mode 100644
index 0b91a3bd..00000000
--- a/gui/ru/system-config-selinux.8
+++ /dev/null
@@ -1,36 +0,0 @@
-.TH "system-config-selinux" "8" "8 апреля 2013" "Руководство по утилитам настройки системы"
-
-.SH ИМЯ
-system\-config\-selinux \- утилита для управления SELinux
-
-.SH ОБЗОР
-.B system-config-selinux
-
-.SH ОПИСАНИЕ
-Утилита \fBsystem-config-selinux\fP предоставляет графический интерфейс для управления конфигурацией SELinux.
-
-.SH ПАРАМЕТРЫ
-Нет
-
-.SH ФАЙЛЫ
-\fi/usr/bin/system-config-selinux\fP
-
-.SH Примеры
-Чтобы запустить программу, введите:
-
-system-config-selinux
-
-.PP
-.SH "СМОТРИТЕ ТАКЖЕ"
-.TP
-selinux(1), semanage(8)
-.PP
-
-.SH СООБЩЕНИЯ ОБ ОШИБКАХ
-Отправляйте сообщения об ошибках по адресу <http://bugzilla.redhat.com>.
-
-.SH ЛИЦЕНЗИЯ И АВТОРЫ
-\fBsystem-config-selinux\fP распространяется на условиях Стандартной Общественной Лицензии 
-GNU, авторские права принадлежат Red Hat, Inc.
-.br
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>. Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

