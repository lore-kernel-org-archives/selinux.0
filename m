Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F28C04FE0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjHIULM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjHIULL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:11:11 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CB10CF
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:11:10 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635f293884cso1317266d6.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611869; x=1692216669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONzAPoR2lf4LkTsVf50DNEPMYppLmWyIwIzltfe9Cps=;
        b=VutWqg5RDHIQ9z8J0zkChO7DtiFoZ3E0k3mCJKYnmV9dqt3rxIZe+ARUT55wPeTL5t
         t8Pv1w2ymWwLXlSHfEUeavYuFi+JEdoKsAFOiANTy1yORFLpKBFqYrNGa4cjo71xXxya
         nP2vta7FHTOov25Ngq2KMMH/Vg25hTLOn8r44PmrBqXXQLrRxfYLj3+R5ZlwCoIH8Zcz
         wBbRRgSG/TjtBdnIj+V5KkTVXbz/9rovfJzTEiceJFSw7fz/0MA4VGOCDj4RGmEQo/YB
         j0gDyzOE2VcYxrghz+nQ3q9C9BHoKXNyrtJuy+lREj9pKxdCH0UJDUaJuveWeIokMjnw
         uiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611869; x=1692216669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONzAPoR2lf4LkTsVf50DNEPMYppLmWyIwIzltfe9Cps=;
        b=DvaortpuRnGbNtv/VCF71I10tgu9yLw8k0n/kLcgVPcJq0wzBLlZOcIycPv1G30jeo
         ACkvofBm4D110yrTK3FTApVfed0zi3QButO2gKg3x3J02RHpGmIoXLZeMwUM8UG/rF0i
         J533M8CoHMYEbO5oVtGtmYd603NcSDrDuSu0SdzAMtZFk3IYUhraqhTxndi6FisGmz7/
         aOG/U/JGXBGSGkhWGZe//m/xInCZBXGuKyYv42VfScJVUL5mK07mj1/oQgzoWVA3HOhB
         RQAC0ebtGHzBV9e66+SUZG+NgZz3SDlaYNdVu2pnrOcae5OB937ZiJKotTENhZpnyDRI
         5XWw==
X-Gm-Message-State: AOJu0YzKQOg02TDVULMu6XthKtyV+D4okPdsE2HitANIRBk7sG0RJtl6
        cnm/0XBtXgcBZj9nyVgFP52ymiu/rms=
X-Google-Smtp-Source: AGHT+IHMlMNEV5uSIaEcYr1nsgOhJaKvtanIRU0VijmG3RHHEq15oZ2iEuPdvvb2oEKYswy9m7onvg==
X-Received: by 2002:a0c:f353:0:b0:63d:c37:bf86 with SMTP id e19-20020a0cf353000000b0063d0c37bf86mr295346qvm.41.1691611868662;
        Wed, 09 Aug 2023 13:11:08 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:11:07 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 13/13 v2] semodule-utils: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:49 -0400
Message-ID: <20230809201051.108944-14-jwcart2@gmail.com>
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
 .../semodule_expand/ru/semodule_expand.8      | 31 ------------
 .../semodule_link/ru/semodule_link.8          | 32 -------------
 .../semodule_package/ru/semodule_package.8    | 48 -------------------
 .../semodule_package/ru/semodule_unpackage.8  | 24 ----------
 4 files changed, 135 deletions(-)
 delete mode 100644 semodule-utils/semodule_expand/ru/semodule_expand.8
 delete mode 100644 semodule-utils/semodule_link/ru/semodule_link.8
 delete mode 100644 semodule-utils/semodule_package/ru/semodule_package.8
 delete mode 100644 semodule-utils/semodule_package/ru/semodule_unpackage.8

diff --git a/semodule-utils/semodule_expand/ru/semodule_expand.8 b/semodule-utils/semodule_expand/ru/semodule_expand.8
deleted file mode 100644
index 28b381af..00000000
--- a/semodule-utils/semodule_expand/ru/semodule_expand.8
+++ /dev/null
@@ -1,31 +0,0 @@
-.TH SEMODULE_EXPAND "8" "ноябрь 2005" "Security Enhanced Linux"
-.SH ИМЯ 
-semodule_expand \- расширить пакет модуля политики SELinux
-
-.SH ОБЗОР
-.B semodule_expand [-V ] [ -a ] [ -c [version]] basemodpkg outputfile
-.br
-.SH ОПИСАНИЕ
-.PP
-semodule_expand - утилита разработки для ручного расширения пакета базового модуля политики в двоичный файл политики ядра.
-Это средство не является необходимым для нормальной работы SELinux. Обычно такое расширение выполняется libsemanage внутренним образом в ответ на команды semodule. Пакеты базовых модулей политики можно создавать непосредственно с помощью semodule_package или semodule_link (при связывании набора пакетов в один пакет).
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.B \-V
-Показать версию
-.TP
-.B \-c [version]
-Версия политики, которую следует создать
-.TP
-.B \-a
-Не проверять утверждения. При использовании этого параметра политика не будет проверять запрещающие правила (neverallow).
-
-.SH СМОТРИТЕ ТАКЖЕ
-.B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
-(8),
-.SH АВТОРЫ
-.nf
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Karl MacMillan <kmacmillan@tresys.com>, Joshua Brindle <jbrindle@tresys.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/semodule-utils/semodule_link/ru/semodule_link.8 b/semodule-utils/semodule_link/ru/semodule_link.8
deleted file mode 100644
index 4a8f414e..00000000
--- a/semodule-utils/semodule_link/ru/semodule_link.8
+++ /dev/null
@@ -1,32 +0,0 @@
-.TH SEMODULE_LINK "8" "Ноябрь 2005" "Security Enhanced Linux"
-.SH ИМЯ 
-semodule_link \- связать вместе пакеты модулей политики SELinux
-
-.SH ОБЗОР
-.B semodule_link [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...
-.br
-.SH ОПИСАНИЕ
-.PP
-semodule_link - утилита разработки для ручного связывания набора пакетов модулей политики SELinux в один пакет модулей политики. 
-Это средство не является необходимым для нормальной работы SELinux. Обычно такое связывание выполняется libsemanage внутренним образом в ответ на команды semodule. Пакеты модулей создаются с помощью semodule_package.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.B \-V
-Показать версию
-.TP
-.B \-v
-Подробный режим
-.TP
-.B \-o <output file> 
-Связанный пакет модулей политики, созданный с помощью этого средства
-
-
-.SH СМОТРИТЕ ТАКЖЕ
-.B checkmodule(8), semodule_package(8), semodule(8), semodule_expand(8)
-(8),
-.SH АВТОРЫ
-.nf
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Karl MacMillan <kmacmillan@tresys.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/semodule-utils/semodule_package/ru/semodule_package.8 b/semodule-utils/semodule_package/ru/semodule_package.8
deleted file mode 100644
index 3f4b16a9..00000000
--- a/semodule-utils/semodule_package/ru/semodule_package.8
+++ /dev/null
@@ -1,48 +0,0 @@
-.TH SEMODULE_PACKAGE "8" "Ноябрь 2005" "Security Enhanced Linux"
-.SH ИМЯ 
-semodule_package \- создать пакет модуля политики SELinux
-
-.SH ОБЗОР
-.B semodule_package \-o <output file> \-m <module> [\-f <file contexts>]
-.br
-.SH ОПИСАНИЕ
-.PP
-semodule_package - утилита, которая используется для создания пакета модуля политики SELinux из двоичного модуля политики и (необязательно) других данных, таких как контексты файлов. Команда semodule_package упаковывает двоичные модули политики, созданные с помощью checkmodule. Пакет политики, созданный с помощью semodule_package, затем можно установить через semodule. 
-
-.SH ПРИМЕР
-.nf
-# Собрать пакет политики для базового модуля.
-$ semodule_package \-o base.pp \-m base.mod \-f file_contexts
-# Собрать пакет политики для модуля httpd.
-$ semodule_package \-o httpd.pp \-m httpd.mod \-f httpd.fc
-# Собрать пакет политики для локальных правил принудительного присвоения типов, не включая контексты файлов.
-$ semodule_package \-o local.pp \-m local.mod
-.fi
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.B \-o \-\-outfile <output file> 
-Файл пакета модуля политики, созданный этим средством.
-.TP
-.B  \-s \-\-seuser <seuser file>
-Файл seuser, который следует включить в пакет.
-.TP
-.B  \-u \-\-user_extra <user extra file>
-Файл user_extra, который следует включить в пакет.
-.TP
-.B  \-m \-\-module <Module file>
-Файл модуля политики, который следует включить в пакет.
-.TP
-.B  \-f \-\-fc <File context file>
-Файл контекстов файлов для модуля (необязательно).
-.TP
-.B  \-n \-\-nc <netfilter context file>
-Файл контекста netfilter, который следует включить в пакет.
-
-.SH СМОТРИТЕ ТАКЖЕ
-.B checkmodule(8), semodule(8), semodule_unpackage(8)
-.SH АВТОРЫ
-.nf
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Karl MacMillan <kmacmillan@tresys.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8 b/semodule-utils/semodule_package/ru/semodule_unpackage.8
deleted file mode 100644
index 057ae3d7..00000000
--- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
+++ /dev/null
@@ -1,24 +0,0 @@
-.TH SEMODULE_PACKAGE "8" "Ноябрь 2005" "Security Enhanced Linux"
-.SH ИМЯ
-semodule_unpackage \- извлечь модуль политики и файл контекстов файлов из пакета модуля политики SELinux
-
-.SH ОБЗОР
-.B semodule_unpackage ppfile modfile [fcfile]
-.br
-.SH ОПИСАНИЕ
-.PP
-semodule_unpackage - утилита, которая используется для извлечения файла модуля политики SELinux и файла контекстов файлов из пакета политики SELinux.
-
-.SH ПРИМЕР
-.nf
-# Извлечь файл модуля httpd из пакета политики httpd.
-$ semodule_unpackage httpd.pp httpd.mod httpd.fc
-.fi
-
-.SH СМОТРИТЕ ТАКЖЕ
-.B semodule_package(8)
-.SH АВТОРЫ
-.nf
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Stephen Smalley <stephen.smalley.work@gmail.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

