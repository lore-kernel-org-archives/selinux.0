Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396FC001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjHIULE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjHIULD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:11:03 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E540510C4
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:11:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76754b9eac0so19135385a.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611860; x=1692216660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daThGXAG29BTE6FUtJdTiFrioyymCHxFk0KPQfEqRPE=;
        b=sWxWLYz32bnvMZhiVtlKBb46zyn8nbyL9c+/eQcwJwolnSFS7rVb9ui/iYS9Nbmlnk
         7lDTH6yaBnZp9n/LguxWJ2PpWNVADWwD+pDvP2RgXFGWRzrQ9cWAUgMw0bprR2LQ/Zgu
         JUpeHcL9H0sCkcb+vfdobeVYrhrnXMkmIxT+TL1/WoL7uGe73DGA8FAJ51V8XnH0WUVC
         gd7COs5hxkA4BAXiRwW6E1L1HwJY8peCQ+/kLA/VdmvGs+oQRf++pstpAfBfOiZLZIqh
         bjwIfx4db9G9CqoHkIn0MK5aH0ZpTzsrkh7eoPeLUcAscQ0jz3ZzVcD8P1IdKJZzTwkU
         Kl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611860; x=1692216660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daThGXAG29BTE6FUtJdTiFrioyymCHxFk0KPQfEqRPE=;
        b=DXN6ThzK2ws9/ajRa9AdOqphdbXNb1AlLd8IthDbrRO3IKocGNjD6GtyEl4KgALly7
         BQFNe7rY9prIWA8e/4mskZ1wjwR7miEXLo2ytt0/o9F27+RYwjZ6YhW5PiZ6i+OKV252
         jAZZB0DhGp+w+ekydWVk4PL5gfPZqSbd4JYs96aqr7V/w/GdxC/T+DlbG1SkwhzJAoba
         Q8KQJFwMasSs/+h+1hhwSdzSWQ+ypAwI4M4f3abjlB0ivXyx2BVTRKG3i7O8zecbhyJ7
         zR1ER9yNQW1Y78OdZ977tuLUBAnyIUzAZZAWVMt8yFsWvrYO4TwiXh7ToEaIb5ECNWJj
         pNCw==
X-Gm-Message-State: AOJu0Yz+jF443SLqMzLxttwP42iLANDXC0sZgVHl+k2XQTAITB9jORxv
        v6Xgx5PxRWJxlz8vAbSuh68Lx6ILqSI=
X-Google-Smtp-Source: AGHT+IGdcprpUtNsR+Rjzo1KfJCBupy4OzXZZDu0AoEfGrxrO2sjXEeW/fERbLg4T9SWMJXIdtYKSg==
X-Received: by 2002:a05:620a:28c8:b0:75b:23a0:e7a1 with SMTP id l8-20020a05620a28c800b0075b23a0e7a1mr129684qkp.2.1691611860311;
        Wed, 09 Aug 2023 13:11:00 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:10:59 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 05/13 v2] libsemanage: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:41 -0400
Message-ID: <20230809201051.108944-6-jwcart2@gmail.com>
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

