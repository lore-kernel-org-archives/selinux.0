Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6CC001DE
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjHIULM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHIULK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:11:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B7C10C4
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:11:07 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-76ad842d12fso17793785a.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611866; x=1692216666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlcZzgMBDJjl6Hwl3/KhLbWoBBs3o9K1/HYSek/QaKg=;
        b=Wiaczeod+Hc1wS5J+uYGIoM05/j99oR/rs21DV4fQ2r7IFe8uGRahiTGDjc77ILqgv
         b7jCa+0GIVrLbbepzkNEkrnmA7kmmaND2B9TkPBvM2FAdZGc0OMBVc4JeRBTaCHiZu65
         YEvdMkX5boKBhPNPHDTkfNMuoI7DX0DX+dmCZZdrjiFeE4XIpzuXKnOm0EmzXqP8/FWp
         Q1IJ7fPI/64IwtGt88mezjZj0Omv5BwnnO+1kI+Dl10LG3ep6QNWV7Tp7FoMC5IqK4HA
         q1xHNET+/HSCv74E3WmYU/jKlq/CtsruZkJBpZlkXJHrp2rCjo9fqiI9DZVEUcHYgDSy
         EE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611866; x=1692216666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlcZzgMBDJjl6Hwl3/KhLbWoBBs3o9K1/HYSek/QaKg=;
        b=S+ytaieRABjaDY0/qNInbetmQtxE9xy6HEApWZ+VPK2OG/+ABYT6wqJXPXrVt/lmiw
         WuUCsdtZSxCM1vcuFrOJQ/QUcgo9UQRvSAIOYmJTE9laPgSMd3Q16D23628ylJ4fnALW
         JWVvtUmb9YfqZGILrdaTrZohwaYL/Kd60PZDsKZMOrAB68kPFq3WshnL8TBBNPX9wjBF
         hZZXOdelCDjQX39Aluur4ZYmAOfHykmCFR0Su64OvWdOIwqFHUXkNBgQ+rsdQ1Eds07R
         pYKz19PWCT6ddmXjRu5TWKtFOoSLJe7SYvLq+RFQqPKH0/Qt61UYgEoQhERh0+iXYpiz
         nUww==
X-Gm-Message-State: AOJu0YxYCH84YafeelgHjDFGVxV3h/7ZW9ND7luYg+BtITZc+BrXYCMn
        orWeOyUUeJNa1T2HSqtVyvR/cmDsafU=
X-Google-Smtp-Source: AGHT+IGKU/F3gs2q3zvjpFKX5dOZG16ZQuLFifYBWY7dbU/6e2nKYC0yZS6ezXITx3Uk9kx3I+FxQQ==
X-Received: by 2002:a05:620a:4453:b0:76c:b718:2946 with SMTP id w19-20020a05620a445300b0076cb7182946mr72816qkp.55.1691611865410;
        Wed, 09 Aug 2023 13:11:05 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:11:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/13 v2] python: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:46 -0400
Message-ID: <20230809201051.108944-11-jwcart2@gmail.com>
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
date, so remove them. This removes the translations from sepolicy.

Suggested-by: Petr Lautrbach <plautrba@redhat.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 python/sepolicy/ru/sepolgen.8             |   1 -
 python/sepolicy/ru/sepolicy-booleans.8    |  29 ----
 python/sepolicy/ru/sepolicy-communicate.8 |  40 -----
 python/sepolicy/ru/sepolicy-generate.8    | 173 ----------------------
 python/sepolicy/ru/sepolicy-gui.8         |  29 ----
 python/sepolicy/ru/sepolicy-interface.8   |  41 -----
 python/sepolicy/ru/sepolicy-manpage.8     |  38 -----
 python/sepolicy/ru/sepolicy-network.8     |  90 -----------
 python/sepolicy/ru/sepolicy-transition.8  |  34 -----
 python/sepolicy/ru/sepolicy.8             |  77 ----------
 10 files changed, 552 deletions(-)
 delete mode 100644 python/sepolicy/ru/sepolgen.8
 delete mode 100644 python/sepolicy/ru/sepolicy-booleans.8
 delete mode 100644 python/sepolicy/ru/sepolicy-communicate.8
 delete mode 100644 python/sepolicy/ru/sepolicy-generate.8
 delete mode 100644 python/sepolicy/ru/sepolicy-gui.8
 delete mode 100644 python/sepolicy/ru/sepolicy-interface.8
 delete mode 100644 python/sepolicy/ru/sepolicy-manpage.8
 delete mode 100644 python/sepolicy/ru/sepolicy-network.8
 delete mode 100644 python/sepolicy/ru/sepolicy-transition.8
 delete mode 100644 python/sepolicy/ru/sepolicy.8

diff --git a/python/sepolicy/ru/sepolgen.8 b/python/sepolicy/ru/sepolgen.8
deleted file mode 100644
index 3ecf3eb2..00000000
--- a/python/sepolicy/ru/sepolgen.8
+++ /dev/null
@@ -1 +0,0 @@
-.so man8/sepolicy-generate.8
diff --git a/python/sepolicy/ru/sepolicy-booleans.8 b/python/sepolicy/ru/sepolicy-booleans.8
deleted file mode 100644
index 0f8f8ef6..00000000
--- a/python/sepolicy/ru/sepolicy-booleans.8
+++ /dev/null
@@ -1,29 +0,0 @@
-.TH "sepolicy-booleans" "8" "20121112" "" ""
-.SH "ИМЯ"
-sepolicy-booleans \- запросить описание логических переключателей из политики SELinux
-
-.SH "ОБЗОР"
-
-.br
-.B sepolicy booleans [\-h] [ \-a | \-b booleanname ... ]
-
-.SH "ОПИСАНИЕ"
-Утилита sepolicy booleans показывает все логические переключатели и их описание (либо можно вывести описание для отдельных логических переключателей)
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-h, \-\-help       
-показать справочное сообщение
-.TP
-.I                \-a, \-\-all
-показать все описания логических переключателей
-.TP
-.I                \-b, \-\-boolean
-логический переключатель, для которого следует получить описание
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8), getsebool(8), setsebool(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy-communicate.8 b/python/sepolicy/ru/sepolicy-communicate.8
deleted file mode 100644
index 3a8c535c..00000000
--- a/python/sepolicy/ru/sepolicy-communicate.8
+++ /dev/null
@@ -1,40 +0,0 @@
-.TH "sepolicy-communicate" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy-communicate \- создать отчёт, который покажет, могут ли связываться два домена политики SELinux
-
-.SH "ОБЗОР"
-
-.br
-.B sepolicy communicate [\-h] \-s SOURCE \-t TARGET [\-c TCLASS] [\-S SOURCEACCESS] [\-T TARGETACCESS]
-
-.SH "ОПИСАНИЕ"
-Команда sepolicy communicate позволяет проанализировать политику SELinux, чтобы узнать, может ли исходный домен SELinux связываться с целевым доменом SELinux.
-Команда по умолчанию проверяет, имеются ли какие-либо типы файлов, которые может записывать исходный домен и читать целевой домен.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-c, \-\-class
-Указать класс SELinux, который исходный домен попытается использовать для связи с целевым доменом. По умолчанию: file.
-.TP
-.I                \-h, \-\-help       
-Показать справочное сообщение
-.TP
-.I                \-s, \-\-source
-Указать тип исходного домена SELinux
-.TP
-.I                \-S, \-\-sourceaccess
-Указать список доступов, используемых типом исходного домена SELinux для связи с целевым доменом. По умолчанию: Open, Write.
-.TP
-.I                \-t, \-\-target
-Указать тип целевого домена SELinux
-.TP
-.I                \-T, \-\-targetaccess
-Указать список доступов, используемых типом целевого домена SELinux для получения обращений от исходного домена. По умолчанию: Open, Read.
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-
diff --git a/python/sepolicy/ru/sepolicy-generate.8 b/python/sepolicy/ru/sepolicy-generate.8
deleted file mode 100644
index d2e98861..00000000
--- a/python/sepolicy/ru/sepolicy-generate.8
+++ /dev/null
@@ -1,173 +0,0 @@
-.TH "sepolicy-generate" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy-generate \- создать исходный шаблон модуля политики SELinux.
-
-.SH "ОБЗОР"
-
-Общие параметры
-
-.B sepolicy generate [\-h ] [\-p PATH]
-
-.br
-
-Ограниченные приложения
-
-.br
-.B sepolicy generate \-\-application [\-n NAME] [\-u USER ]command [\-w WRITE_PATH ]
-.br
-.B sepolicy generate \-\-cgi [\-n NAME] command [\-w WRITE_PATH ]
-.br
-.B sepolicy generate \-\-dbus [\-n NAME] command [\-w WRITE_PATH ]
-.br
-.B sepolicy generate \-\-inetd [\-n NAME] command [\-w WRITE_PATH ]
-.br
-.B sepolicy generate \-\-init [\-n NAME] command [\-w WRITE_PATH ]
-
-Ограниченные пользователи
-
-.br
-.B sepolicy generate \-\-admin_user [\-r TRANSITION_ROLE] \-n NAME
-.br
-.B sepolicy generate \-\-confined_admin \-n NAME [\-a ADMIN_DOMAIN] [\-u USER] [\-n NAME] [\-w WRITE_PATH]
-.br
-.B sepolicy generate \-\-desktop_user \-n NAME [\-w WRITE_PATH]
-.br
-.B sepolicy generate \-\-term_user \-n NAME [\-w WRITE_PATH]
-.br
-.B sepolicy generate \-\-x_user \-n NAME [\-w WRITE_PATH]
-.br
-
-Разное
-
-.br
-.B sepolicy generate \-\-customize \-d DOMAIN \-n NAME [\-a ADMIN_DOMAIN]
-.br
-.B sepolicy generate \-\-newtype \-t type \-n NAME
-.br
-.B sepolicy generate \-\-sandbox \-n NAME
-
-.SH "ОПИСАНИЕ"
-Используйте команду \fBsepolicy generate\fP для создания модуля политики SELinux.
-
-.br
-\fBsepolicy generate\fP создаст 5 файлов.
-
-При указании \fBconfined application\fP необходимо указать путь. Команда \fBsepolicy generate\fP будет использовать полезную нагрузку rpm-пакета приложения вместе с \fBnm \-D APPLICATION\fP, чтобы создать типы и правила политики для ваших файлов политики.
-
-.B Файл принудительного назначения типов NAME.te
-.br
-Этот файл можно использовать, чтобы определить для конкретного домена все правила типов.
-
-.I Примечание:
-Политика, созданная с помощью команды \fBsepolicy generate\fP, автоматически добавит разрешительный домен (DOMAIN) в ваш файл .te. Когда вы закончите настройку политики, из файла .te будет необходимо удалить разрешительную строку, чтобы запустить домен в принудительном режиме.
-
-.B Файл интерфейсов NAME.if
-.br
-Этот файл определяет интерфейсы для созданных в файле .te типов, которые могут использоваться другими доменами политики.
-
-.B Контексты файлов NAME.fc
-.br
-Этот файл определяет контексты файлов по умолчанию для системы; он берёт типы файлов, созданные в файле .te, и связывает пути файлов с этими типами. Такие утилиты, как restorecon и RPM, будут использовать эти пути для проставления меток.
-
-.B Файл спецификации RPM NAME_selinux.spec
-.br
-Этот файл - файл СПЕЦИФИКАЦИИ, который можно использовать для установки политики SELinux на компьютеры и настройки проставления меток. Файл спецификации также устанавливает файл интерфейсов и man-страницу с описанием политики. Для создания man-страницы можно использовать команду \fBsepolicy manpage \-d NAME\fP.
-
-.B Файл оболочки NAME.sh
-.br
-Это вспомогательный сценарий оболочки для компиляции, установки и исправления меток в тестовой системе. Он также создаёт man-страницу на основе установленной политики, компилирует и собирает RPM, который подходит для установки на других компьютерах.
-
-Если создание возможно, эта утилита выведет на экран все пути создания из исходного домена в целевой домен
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-h, \-\-help
-Показать справочное сообщение
-.TP
-.I                \-d, \-\-domain
-Ввести тип домена, который будет расширен
-.TP
-.I                \-n, \-\-name
-Указать альтернативное имя политики. По умолчанию: указанный исполняемый файл или имя.
-.TP
-.I                \-p, \-\-path
-Указать каталог для сохранения созданных файлов политики. По умолчанию: текущий рабочий каталог.
-Необязательные аргументы:
-.TP
-.I                \-r, \-\-role
-Ввести роль (роли), в которую перейдёт этот администратор
-.TP
-.I                \-t, \-\-type
-Ввести тип (типы), для которого создаётся новое определение и правило (правила)
-.TP
-.I                \-u, \-\-user
-Пользователь (пользователи) SELinux, который перейдёт в этот домен
-.TP
-.I                \-w, \-\-writepath
-Путь (пути), который требуется для записи ограниченным процессам
-.TP
-.I                \-a, \-\-admin
-Домен (домены), который будет администрировать ограниченный администратор 
-.TP
-.I  \-\-admin_user 
-Создать политику для роли авторизации администратора
-.TP
-.I  \-\-application
-Создать политику для приложения пользователя
-.TP
-.I  \-\-cgi
-Создать политику для веб-приложения/сценария (CGI)
-.TP
-.I  \-\-confined_admin
-Создать политику для роли ограниченного администратора root
-.TP
-.I  \-\-customize
-Создать политику для типа существующего домена
-.TP
-.I  \-\-dbus
-Создать политику для системной внутренней службы DBUS
-.TP
-.I  \-\-desktop_user
-Создать политику для роли авторизации на рабочем столе
-.TP
-.I  \-\-inetd
-Создать политику для внутренней службы Интернет-служб
-.TP
-.I  \-\-init
-Создать политику для стандартной внутренней службы init (по умолчанию)
-.TP
-.I  \-\-newtype
-Создать политику для новых типов, которые будут добавлены в существующую политику.
-.TP
-.I  \-\-sandbox
-Создать политику для изолированной среды
-.TP
-.I  \-\-term_user
-Создать политику для минимальной роли авторизации пользователя терминала
-.TP
-.I  \-\-x_user
-Создать политику для минимальной роли авторизации пользователя X Windows
-
-.SH "ПРИМЕР"
-.B > sepolicy generate --init /usr/sbin/rwhod
-.br
-Создание политики для /usr/sbin/rwhod с именем rwhod
-.br
-Созданы следующие файлы:
-.br
-rwhod.te # файл принудительного присвоения типов
-.br
-rwhod.if # файл интерфейсов
-.br
-rwhod.fc # файл контекстов файлов
-.br
-rwhod_selinux.spec # файл спецификации
-.br
-rwhod.sh # сценарий настройки
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy-gui.8 b/python/sepolicy/ru/sepolicy-gui.8
deleted file mode 100644
index 1912c58b..00000000
--- a/python/sepolicy/ru/sepolicy-gui.8
+++ /dev/null
@@ -1,29 +0,0 @@
-.TH "sepolicy-gui" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy-gui \- графический интерфейс пользователя политики SELinux
-
-.SH "ОБЗОР"
-
-Общие параметры
-
-.B sepolicy gui [\-h ] [ \-d DOMAIN ]
-
-.br
-
-.SH "ОПИСАНИЕ"
-Используйте утилиту \fBsepolicy gui\fP для запуска графического интерфейса пользователя, с помощью которого можно посмотреть, как SELinux ограничивает различные домены процессов.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-h, \-\-help
-Показать справочное сообщение
-.TP
-.I                \-d, \-\-domain
-Инициализировать для выбранного домена графический интерфейс пользователя 
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy-interface.8 b/python/sepolicy/ru/sepolicy-interface.8
deleted file mode 100644
index b78a7925..00000000
--- a/python/sepolicy/ru/sepolicy-interface.8
+++ /dev/null
@@ -1,41 +0,0 @@
-.TH "sepolicy-interface" "8" "20121222" "" ""
-.SH "ИМЯ"
-sepolicy-interface \- вывести сведения об интерфейсах на основе установленной политики SELinux
-
-.SH "ОБЗОР"
-
-.br
-.B sepolicy interface  [\-h] [\-c] [\-v] [\-a | \-u | \-l | \-i INTERFACE [INTERFACE ... ]]
-
-.SH "ОПИСАНИЕ"
-Используйте утилиту sepolicy interface для вывода сведений об интерфейсах на основе политики SELinux.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-a, \-\-list_admin
-Вывести список всех доменов с интерфейсом администратора
-.TP
-.I                \-c, \-\-compile
-Проверить сборку интерфейсов
-.TP
-.I                \-h, \-\-help       
-Показать справочное сообщение
-.TP
-.I                \-i, \-\-interface
-Интерфейс (интерфейсы), которые следует показать
-.TP
-.I                \-l, \-\-list
-Вывести список всех интерфейсов
-.TP
-.I                \-u, \-\-list_user
-Вывести список всех доменов с интерфейсом роли пользователя SELinux
-.TP
-.I                \-v, \-\-verbose
-Показать расширенные сведения об интерфейсе, включая параметры и описание (если доступно).
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy-manpage.8 b/python/sepolicy/ru/sepolicy-manpage.8
deleted file mode 100644
index 35d7c683..00000000
--- a/python/sepolicy/ru/sepolicy-manpage.8
+++ /dev/null
@@ -1,38 +0,0 @@
-.TH "sepolicy-manpage" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy-manpage \- создать man-страницу на основе установленной политики SELinux
-
-.SH "ОБЗОР"
-
-.br
-.B sepolicy manpage [\-w] [\-h] [\-p PATH ] [\-r ROOTDIR ] [\-a | \-d ]
-
-.SH "ОПИСАНИЕ"
-Используйте утилиту sepolicy manpage для создания man-страниц на основе политики SELinux.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-a, \-\-all        
-Создать man-страницы для всех доменов
-.TP
-.I                \-d, \-\-domain     
-Создать man-страницу для указанного домена. (Поддерживает несколько команд)
-.TP
-.I                \-h, \-\-help       
-Показать справочное сообщение
-.TP
-.I                \-p, \-\-path
-Указать каталог для сохранения созданных man-страниц. (По умолчанию: /tmp)
-.TP
-.I                \-r, \-\-root
-Указать альтернативный корневой каталог для создания man-страниц. (По умолчанию: /)
-.TP
-.I                \-w, \-\-web
-Создать дополнительные man-страницы в формате HTML для указанного домена (доменов).
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy-network.8 b/python/sepolicy/ru/sepolicy-network.8
deleted file mode 100644
index ba78eced..00000000
--- a/python/sepolicy/ru/sepolicy-network.8
+++ /dev/null
@@ -1,90 +0,0 @@
-.TH "sepolicy-network" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy-network \- проанализировать политику SELinux и создать отчёт о сети
-
-.SH "ОБЗОР"
-
-.br
-.B sepolicy network [\-h] (\-l | \-a application [application ...] | \-p PORT [PORT ...] | \-t TYPE [TYPE ...] | \-d DOMAIN [DOMAIN ...])
-
-.SH "ОПИСАНИЕ"
-Используйте команду sepolicy network для анализа политики SELinux и создания отчётов о сети.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-a, \-\-application
-Создать отчёт с перечнем портов, к которым разрешено подключение и/или привязка указанного приложения инициализации.
-.TP
-.I                \-d, \-\-domain     
-Создать отчёт с перечнем портов, к которым разрешено подключение и/или привязка указанного домена.
-.TP
-.I                \-l, \-\-list        
-Вывести список всех типов сетевых портов, определённых в политике SELinux
-.TP
-.I                \-h, \-\-help       
-Показать справочное сообщение
-.TP
-.I                \-t, \-\-type
-Создать отчёт с перечнем номеров портов, связанных с указанным типом портов SELinux.
-.TP
-.I                \-p, \-\-port
-Создать отчёт с перечнем типов портов SELinux, связанных с указанным номером порта.
-
-.SH "ПРИМЕРЫ"
-
-.B sepolicy network -p 22
-.br
-22: tcp ssh_port_t 22
-.br
-22: udp reserved_port_t 1-511
-.br
-22: tcp reserved_port_t 1-511
-
-.B sepolicy network -a /usr/sbin/sshd
-.br
-sshd_t: tcp name_connect
-.br
-	111 (portmap_port_t)
-.br
-	53 (dns_port_t)
-.br
-	88, 750, 4444 (kerberos_port_t)
-.br
-	9080 (ocsp_port_t)
-.br
-	9180, 9701, 9443-9447 (pki_ca_port_t)
-.br
-	32768-61000 (ephemeral_port_t)
-.br
-	all ports < 1024 (reserved_port_type)
-.br
-	all ports with out defined types (port_t)
-.br
-sshd_t: tcp name_bind
-.br
-	22 (ssh_port_t)
-.br
-	5900-5983, 5985-5999 (vnc_port_t)
-.br
-	6000-6020 (xserver_port_t)
-.br
-	32768-61000 (ephemeral_port_t)
-.br
-	all ports > 500 and  < 1024 (rpc_port_type)
-.br
-	all ports with out defined types (port_t)
-.br
-sshd_t: udp name_bind
-.br
-	32768-61000 (ephemeral_port_t)
-.br
-	all ports > 500 and  < 1024 (rpc_port_type)
-.br
-	all ports with out defined types (port_t)
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8), semanage(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy-transition.8 b/python/sepolicy/ru/sepolicy-transition.8
deleted file mode 100644
index 77c25203..00000000
--- a/python/sepolicy/ru/sepolicy-transition.8
+++ /dev/null
@@ -1,34 +0,0 @@
-.TH "sepolicy-transition" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy-transition \- проанализировать политику SELinux и создать отчёт о переходах процессов
-
-.SH "ОБЗОР"
-
-.br
-.B sepolicy transition [\-h] \-s SOURCE
-
-.br
-.B sepolicy transition [\-h] \-s SOURCE \-t TARGET
-
-.SH "ОПИСАНИЕ"
-Утилита sepolicy transition покажет все домены, в которые может перейти указанный исходный домен SELinux, включая точку входа.
-
-Если указан целевой домен, команда sepolicy transition проанализирует политику на предмет наличия путей перехода из исходного домена в целевой домен и выведет список этих путей. Если переход возможен, эта утилита выведет все пути перехода из исходного домена в целевой домен.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-h, \-\-help       
-Показать справочное сообщение
-.TP
-.I                \-s, \-\-source
-Указать тип исходного домена SELinux
-.TP
-.I                \-t, \-\-target
-Указать тип целевого домена SELinux
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-sepolicy(8), selinux(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/python/sepolicy/ru/sepolicy.8 b/python/sepolicy/ru/sepolicy.8
deleted file mode 100644
index 1d8d3911..00000000
--- a/python/sepolicy/ru/sepolicy.8
+++ /dev/null
@@ -1,77 +0,0 @@
-.TH "sepolicy" "8" "20121005" "" ""
-.SH "ИМЯ"
-sepolicy \- утилита анализа политики SELinux
-
-.SH "ОБЗОР"
-.B sepolicy [-h] [-P policy_path ] {booleans,communicate,generate,interface,manpage,network,transition} OPTIONS
-
-.br
-Аргументы:
-.br
-
-.B    booleans
-.br
-Отправить запрос к политике SELinux, чтобы просмотреть описание логических переключателей
-.B sepolicy-boolean(8)
-.br
-
-.B    communicate
-.br
-Отправить запрос к политике SELinux, чтобы узнать, могут ли домены связываться друг с другом
-.B sepolicy-communicate(8)
-.br
-
-.B    generate
-.br
-Создать шаблон модуля политики SELinux
-.B sepolicy-generate(8)
-.br
-
-.B    gui
-.br
-Запустить графический интерфейс пользователя политики SELinux (требуется пакет policycoreutils-gui)
-.B sepolicy-gui(8)
-.br
-
-.B    interface
-.br 
-.br
-Вывести сведения интерфейса политики SELinux
-.B sepolicy-interface(8)
-.br
-
-.B    manpage
-.br
-Создать man-страницы SELinux 
-.B sepolicy-manpage(8)
-.br
-
-.B    network
-.br
-Запросить сведения о сети политики SELinux
-.B sepolicy-network(8)
-.br
-
-.B    transition 
-.br
-Отправить запрос к политике SELinux, чтобы узнать, как исходный домен процесса может перейти в целевой домен процесса 
-.B sepolicy-transition(8)
-
-.SH "ОПИСАНИЕ"
-sepolicy - это набор средств, опрашивающих установленную политику SELinux и создающих полезные отчёты,  man-страницы или даже новые модули политики.
-Параметры и их описание доступны на man-страницах соответствующих аргументов.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.I                \-P, \-\-policy
-Альтернативная политика для анализа. (По умолчанию: текущая установленная политика /sys/fs/selinux/policy)
-.TP
-.I                \-h, \-\-help       
-Показать справочное сообщение
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-selinux(8), sepolicy-booleans(8), sepolicy-communicate(8), sepolicy-generate(8),sepolicy-gui(8), sepolicy-interface(8),  sepolicy-network(8), sepolicy-manpage(8), sepolicy-transition(8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Daniel Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

