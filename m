Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6FAC05052
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjHIQbR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHIQbQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D310FE
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:15 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a7afae474aso1253051b6e.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598674; x=1692203474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONzAPoR2lf4LkTsVf50DNEPMYppLmWyIwIzltfe9Cps=;
        b=Iaf7tNI7G6zoIXs562j6g7U9ZNgaH97jTgpHKyDHUT3TxC5K9pnxK2L5b+yQjHSX4u
         ti139MC7Ff9xDi7WMWaNT9aln33IA8iblFLVyvs7sWyDh3FS6vxT+PKMRT8YmXTQPCvQ
         XMZYIzY5JA8Sz3R5EhkJzUoabgudJrklpI7qCbe1b17UgeWHAlrahsBllOPyPXvhnaN8
         VSuYypQ7HHMlg8y6JhAVR54GY2GPjFu3pGvIKRSSGYuA4vpdMgQfWnjaoiRsecwubb0x
         ZiCdewaVt8Cq6690vKkdP9Kfqe73M1uhfPTX444ELWGbUIAyhSWyoXwrwgQgkyA7/IWd
         oJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598674; x=1692203474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONzAPoR2lf4LkTsVf50DNEPMYppLmWyIwIzltfe9Cps=;
        b=M4C5KRToziirKQGzRLKkrUQBpU678IGWwTcAzedin7lokAQjw/ssYC1yKdAaYJH3Zb
         I/ZyNh8ubujYlOgZYC+fhMhR7LFdr/yPvn0diMnplN00qHtVbYQLfbcxYWM8nBWUI6aF
         Grax8A49OIcRIby3xc2UdEA1k1kpHR7fHBuauBurMAk6jYggr3mh+BgAP4+6uiWxWEdx
         M/N3OV1FiXLMeCbZkdE0Oh778aPLPeq+ljusEusPDpfvY1/nd+9WzK6NvsXrAxYdPC+Y
         EvQw3GFdxZnLSztSdpkJ9vpGd/NusReDf/GG0Cf/XMhKq74vsi3Ygv1dHaLxPLUONmOo
         kbLQ==
X-Gm-Message-State: AOJu0YyAaoo5+LLuUp0GDtb7qLOVORAKq2TvTxVtRioTKdHG6+ImgpH+
        ZVb7JDKQet5vwTxEhG3tyK82/hijGfQ=
X-Google-Smtp-Source: AGHT+IFmjF5+WJjuMeWcha7oRvByel4V167qtfFff0y44P5z8wUNMneqdTaMvgpakNhsqrSwp3O1Ug==
X-Received: by 2002:a05:6808:1489:b0:3a7:62ff:24c1 with SMTP id e9-20020a056808148900b003a762ff24c1mr3714573oiw.46.1691598673901;
        Wed, 09 Aug 2023 09:31:13 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:13 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 12/12] semodule-utils: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:57 -0400
Message-ID: <20230809163059.97671-12-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809163059.97671-1-jwcart2@gmail.com>
References: <20230809163059.97671-1-jwcart2@gmail.com>
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

