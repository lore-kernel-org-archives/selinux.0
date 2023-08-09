Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E5C04E69
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHIQbN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjHIQbM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D819A1
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:08 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a734b8a27fso4145015b6e.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598667; x=1692203467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daThGXAG29BTE6FUtJdTiFrioyymCHxFk0KPQfEqRPE=;
        b=hoJ/ZBOg6a9vGZZoujMh1gQh2xyZVunYvoNWnkI+vsV23EusGslxLqVsjUjYWp8sCr
         msia0hIJiQBA9eT3samrW2BtyXbsgiS0irMcygfanvRs+PdhB+xWcX4bUh8cXPtL5gSs
         pGo0VynGYpFXwFj8yCu7Esy2IIfweXfbx7Nsy1LJSYhSss68dZJkroizBsn2hye41Bbs
         4Og7Iwn8l1QGrF0Qh2LAJ8MC81pZU81+pHqvPRATsHKZMyxo42I1wauNbO/3OSR9eFE+
         42ypio1riNa5FDB6NKSHOnCf8O6EOwD1u+5JZSIiRocVVGDPLCXaYsxuN/U+XosBh4EZ
         t8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598667; x=1692203467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daThGXAG29BTE6FUtJdTiFrioyymCHxFk0KPQfEqRPE=;
        b=fZ5IyFlsv4n6vGJ5M7Rd8Wk9FP6Hrla9Mbv/pGSQMuXMBpMugCOVV/9KcKgQ8oemJF
         kq8UizgQvqxNP76376I8ujDTRbUPz7u/kpzoTNLGE1aHQr0lV07oJTKbkRyAdaQaf2y7
         JQls89nR1e1YkU7ob/E/C3whfkqv16+fbfEELue9bvwtAQs0jj4SABmoV58AmEjT+Htt
         5qg9qhPQzYCT3cUFwwd4NJmiYnmixR9cdtf0aTC69rADlYwTh4O24oIaY/uHEPuagvI1
         oiMOeq7ZB3X+cjYlWfQgFASP3klKMtM0yu30pwnvKVNdgkiWYKUvH+RYaq6T8rrmiR+l
         cWHQ==
X-Gm-Message-State: AOJu0YzoYgh3PDAV4k1kw2+k6UTjFFS/g6jbU1f7dl1eXjuDpsj1KfYf
        SORjwcSIZOXpNCciBWunIx5s7icmqvE=
X-Google-Smtp-Source: AGHT+IHfHhWNwSI/Z6E+JYpj9jmPhDR0tVl9c60qYz2QW5bdiBDuo10H5W07XZ/pZH40HjOP8fD7Uw==
X-Received: by 2002:a05:6808:1cd:b0:3a7:10e8:fbc2 with SMTP id x13-20020a05680801cd00b003a710e8fbc2mr2823461oic.30.1691598666615;
        Wed, 09 Aug 2023 09:31:06 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/12] libsemanage: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:50 -0400
Message-ID: <20230809163059.97671-5-jwcart2@gmail.com>
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
 libsemanage/man/ru/man5/semanage.conf.5 | 117 ------------------------
 1 file changed, 117 deletions(-)
 delete mode 100644 libsemanage/man/ru/man5/semanage.conf.5

diff --git a/libsemanage/man/ru/man5/semanage.conf.5 b/libsemanage/man/ru/man5/semanage.conf.5
deleted file mode 100644
index 548aa58d..00000000
--- a/libsemanage/man/ru/man5/semanage.conf.5
+++ /dev/null
@@ -1,117 +0,0 @@
-.TH semanage.conf "5" "Сентябрь 2011" "semanage.conf" "Администрирование системы Linux"
-.SH ИМЯ
-semanage.conf \- глобальный файл конфигурации для библиотеки управления SELinux 
-.SH ОПИСАНИЕ
-.PP
-Файл
-.BR semanage.conf
-обычно располагается в каталоге /etc/selinux и используется для конфигурации поведения библиотеки управления SELinux в среде выполнения.
-
-.PP
-Каждая строка должна содержать параметр конфигурации, за которым следует знак равенства ("=") и значение конфигурации этого параметра. Все символы, которые следуют за "#", игнорируются (аналогично пустым строкам).
-
-.PP
-Разрешены следующие параметры:
-
-.RS
-.TP
-.B module-store 
-Указать, как библиотека управления SELinux должна взаимодействовать с хранилищем политики SELinux. Если установлено "direct", библиотека управления SELinux выполняет запись напрямую в хранилище модулей политики SELinux (это значение по умолчанию).
-В ином случае в качестве аргумента может использоваться путь к сокету или имя сервера.
-Если аргумент начинается с "/" (как в "/foo/bar"), он представляет собой путь к именованному сокету, который следует использовать для подключения сервера управления политикой.
-Если аргумент не начинается с "/" (как в "example.com:4242"), он должен интерпретироваться как имя удалённого сервера управления политикой, который следует использовать через TCP-подключение (порт по умолчанию 4242, если только после имени сервера через двоеточие, разделяющее два поля, не указан другой порт).
-
-.TP
-.B root
-Указать альтернативный корневой путь к хранилищу. По умолчанию: "/"
-
-.TP
-.B store-root
-Указать альтернативный путь store_root. По умолчанию: "/var/lib/selinux"
-
-.TP
-.B compiler-directory
-Указать альтернативный каталог, который содержит компиляторы HLL в CIL. Значение по умолчанию: "/usr/libexec/selinux/hll".
-
-.TP
-.B ignore-module-cache
-Определяет, следует ли игнорировать кэш модулей CIL, скомпилированных из HLL. Можно установить либо значение "true", либо значение "false" (по умолчанию установлено "false").
-Если кэш игнорируется, все модули CIL перекомпилируются из соответствующих модулей HLL.
-
-.TP
-.B policy-version 
-При создании политики
-.BR semanage
-по умолчанию устанавливает версию политики POLICYDB_VERSION_MAX, как определено в <sepol/policydb/policydb.h>. Измените этот параметр, если для политики требуется установить другую версию.
-
-.TP
-.B target-platform
-Целевая платформа, для которой создаются политики. Действительными значениями являются "selinux" и "xen" (по умолчанию установлено "selinux").
-
-.TP
-.B expand-check
-Определяет, следует ли проверять правила "neverallow" при исполнении всех команд
-.BR semanage.
-Для этого параметра можно установить либо значение "0" (отключён), либо "1" (включён). По умолчанию параметр включён. Время выполнения может сильно возрасти, если этот параметр включён.
-
-.TP
-.B file-mode
-По умолчанию для разрешительного режима для файлов среды выполнения политики установлено значение 0644.
-
-.TP
-.B save-previous
-Определяет, следует ли сохранять прежний каталог модуля после успешной фиксации модуля в хранилище политики. Для параметра можно установить либо значение "true", либо значение "false". По умолчанию установлено "false" (прежняя версия удаляется).
-
-.TP
-.B save-linked
-Определяет, следует ли сохранять прежний связанный модуль (с именем "base.linked") после успешной фиксации модуля в хранилище политики.
-Для параметра можно установить либо значение "true", либо значение "false". По умолчанию установлено "false" (прежний модуль удаляется).
-
-.TP
-.B ignoredirs
-Разделённый ";" список каталогов, которые следует игнорировать при установке домашних каталогов пользователей. 
-В некоторых дистрибутивах этот параметр используется для того, чтобы /root не отмечался как домашний каталог. 
-
-.TP
-.B usepasswd 
-Определяет, использовать ли getpwent(), чтобы получить список домашних каталогов, для которых следует проставить метки. Для параметра можно установить либо значение "true", либо значение "false" (по умолчанию установлено "true").
-
-.TP
-.B disable-genhomedircon
-Определяет, следует ли исполнять функцию genhomedircon при использовании команды
-.BR semanage.
-Для параметра можно установить либо значение "true", либо значение "false". По умолчанию возможность genhomedircon включена (эквивалентно установке значения "false" для этого параметра).
-
-.TP
-.B handle-unknown
-Этот параметр управляет тем, как ядро обрабатывает разрешения, которые определены в ядре, но отсутствуют в фактической политике.
-Возможные значения: "deny", "reject" или "allow". 
-
-.TP
-.B bzip-blocksize
-Этот параметр должен находиться в диапазоне 0-9. Значение 0 означает отсутствие сжатия. По умолчанию значение размера блока bzip равняется 9 (фактическое значение размера блока получается путём умножения на 100000).
-
-.TP
-.B bzip-small
-Если для этого параметра установлено значение "true", алгоритм bzip попытается уменьшить использование системной памяти. Также для этого параметра можно установить значение "false" (по умолчанию установлено это значение).
-
-.TP
-.B remove-hll
-Если для этого параметра установлено значение "true", файлы HLL будут удалены после компиляции в CIL. Чтобы удалить уже cкомпилированные в CIL файлы HLL, необходимо перекомпилировать модули, установив для параметра
-.BR ignore-module-cache
-значение "true", или используя параметр
-.BR ignore-module-cache
-с semodule. Для параметра remove-hll можно установить либо значение "true", либо значение "false" (по умолчанию установлено "false").
-
-Обратите внимание: так как этот параметр удаляет все файлы HLL, обновлённый компилятор HLL не сможет перекомпилировать исходный файл HLL в CIL.
-Чтобы скомпилировать исходный файл HLL в CIL, необходимо переустановить этот файл HLL.
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.TP
-semanage(8)
-.PP
-
-.SH АВТОРЫ
-Эта страница руководства была написана Guido Trentalancia <guido@trentalancia.com>.
-Библиотека управления SELinux была написана Tresys Technology LLC и Red Hat Inc.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

