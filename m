Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C18C001E0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjHIULL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjHIULK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:11:10 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F330A2100
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:11:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76ca8921c6cso10017985a.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611867; x=1692216667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//TQINjJX2PICywLpObgoGGAix8Mp5Lz3WYe+ZbbLJI=;
        b=qGJG0hsyERXzfrZoDKFVmh7pDfbKXKk435aG7sNfEdOQjd+f1l3TJgmFKbZcGLM1G5
         gn6KLASopDvTXjYIfpCnmJyiCJIHO8j3Kq6QoJSssoczE0W0lmn2E8B7XpVTL6Vypuvs
         qh18oM3TkRu+LjP8OttPB9wbTG2I7LlclAm6QWy9t9QbZ2kxhwq9qH4/WNr708GyWlXv
         qScG8vnG4zo3QLCpUTHZlVNatXDtCmDb3ITDDshuCJSmeZcbpWJrjZ1C1C3+XgET4P/R
         /VKfG68jZAQnONQFb3ZL83um6+iGJ9brBESmExBnseAuwEyTKJh024MCTsv9hGGt32TT
         XhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611867; x=1692216667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//TQINjJX2PICywLpObgoGGAix8Mp5Lz3WYe+ZbbLJI=;
        b=cI5uwez3dzV36yfkdLvX0Plgtn6xe2v5mY4t+nDmeK+zgQxfPG5HbJy15uhPl0DY5T
         g9uaJUcRxMB3Jm984lirt4yLHhgSAhD8HnQ4i2yOKEOAxGhKOQ2h/fI3D670NusKgzBr
         a2y2RTM39Sk9BAWrC0+T9kjbQ3r5vcMcUNJWyFoKizNC1O2fZ2vkaQi7hqBXJKuo1SoI
         QynwG6WyNkGWUmqyXouOkhovJoRnALZcENQGvM9HSZp2An9yBASLKPneYZa3NdEoEUHM
         3Nc28Vp6eHBqk4ePzSWTR2Tqjn6B5d+n+kzLh291G5fNjisxLm9VItDzUyYwTBH9t4jU
         3gyA==
X-Gm-Message-State: AOJu0YxgB+tUg54Aw0Doue+Xyr26YH6o3tyzTCpfjgRbYaoKT3i4kTBh
        1ZsCLMMVzYnJny25j7ircRQHW79sDEo=
X-Google-Smtp-Source: AGHT+IFBYSGRClH60Va916DJ6jY77wryg+6YY7LE5cN/qPcOvP4XlMBJhf2ElRf5Ngm8TJZBtwI7sA==
X-Received: by 2002:a05:620a:170b:b0:767:dc9f:5141 with SMTP id az11-20020a05620a170b00b00767dc9f5141mr865157qkb.19.1691611867590;
        Wed, 09 Aug 2023 13:11:07 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:11:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 12/13 v2] sandbox: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:48 -0400
Message-ID: <20230809201051.108944-13-jwcart2@gmail.com>
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
 sandbox/ru/sandbox.5   |  42 -----------------
 sandbox/ru/sandbox.8   | 100 -----------------------------------------
 sandbox/ru/seunshare.8 |  42 -----------------
 3 files changed, 184 deletions(-)
 delete mode 100644 sandbox/ru/sandbox.5
 delete mode 100644 sandbox/ru/sandbox.8
 delete mode 100644 sandbox/ru/seunshare.8

diff --git a/sandbox/ru/sandbox.5 b/sandbox/ru/sandbox.5
deleted file mode 100644
index 69e822d8..00000000
--- a/sandbox/ru/sandbox.5
+++ /dev/null
@@ -1,42 +0,0 @@
-.TH sandbox.conf "5" "Июнь 2010" "sandbox.conf" "Администрирование системы Linux"
-.SH ИМЯ
-sandbox.conf \- файл конфигурации пользователей для изолированной среды SELinux
-.SH ОПИСАНИЕ
-.PP
-Если изолированная среда запускается с аргументом -C, она будет ограничена с помощью групп управления. Системный администратор может указать, как именно ограничить изолированную среду.
-
-.PP
-Весь текст после "#" игнорируется, как и пустые строки. Все аргументы должны быть разделены пробелами и иметь знаки равенства ("=").
-
-.PP
-Эти ключевые слова разрешены.
-
-.RS
-.TP
-.B NAME
-Имя группы управления изолированной средой.  По умолчанию: "sandbox".
-
-.TP
-.B CPUAFFINITY
-Определяет, каким процессорам назначить изолированную среду. По умолчанию она назначается всем процессорам (ALL), но пользователи могут указать разделённый запятыми список с дефисами ("-"), чтобы представить диапазоны. Пример: 0-2,5
-
-.TP
-.B MEMUSAGE
-Определяет, сколько памяти разрешается использовать изолированной среде. Значение по умолчанию: 80%. Пользователи могут указать либо процентное значение, либо значение в виде числа, за которым следует суффикс  K, M, G, для соответствующего обозначения килобайтов, мегабайтов или гигабайтов. Пример: 50% или 100M
-
-.TP
-.B CPUUSAGE
-Процент использования ЦП, разрешённый для изолированной среды. По умолчанию: 80%. Укажите значение, за которым следует знак процента ("%"). Пример: 50%
-
-
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.TP
-sandbox(8)
-.PP
-
-.SH АВТОРЫ
-Эта страница руководства была написана
-.I Thomas Liu <tliu@fedoraproject.org>.
-Перевод на русский язык выполнила
-.I Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/sandbox/ru/sandbox.8 b/sandbox/ru/sandbox.8
deleted file mode 100644
index 5e6e0aad..00000000
--- a/sandbox/ru/sandbox.8
+++ /dev/null
@@ -1,100 +0,0 @@
-.TH SANDBOX "8" "Май 2010" "sandbox" "Команды пользователя"
-.SH ИМЯ
-sandbox \- выполнить приложение cmd в изолированной среде SELinux
-.SH ОБЗОР
-.B sandbox
-[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] cmd
-
-.br
-.B sandbox
-[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] \-S
-.br
-.SH ОПИСАНИЕ
-.PP
-Выполнить приложение
-.I cmd 
-в строго ограниченном домене SELinux. По умолчанию в домене изолированной среды приложения могут только читать и записывать stdin, stdout и любые другие передаваемые дескрипторы файлов. Открывать другие файлы нельзя. Параметр \-M позволяет смонтировать альтернативные домашний каталог и временный каталог, которые будут использоваться изолированной средой.
-
-Если установлен пакет 
-.I policycoreutils-sandbox, 
-можно использовать параметр \-X и параметр \-M.
-.B sandbox \-X
-позволяет запускать приложения X в изолированной среде. Эти приложения запускаются на своём собственном X-сервере и создают временные домашний каталог и каталог /tmp. Политика SELinux по умолчанию не разрешает использовать какие-либо средства для управления привилегиями или осуществлять доступ к сети. Она также предотвращает доступ к другим процессам и файлам пользователей. Указанные в команде файлы, которые находятся в домашнем каталоге или каталоге /tmp, будут скопированы в каталоги изолированной среды.
-
-Если каталоги указаны с параметром \-H или \-T, их контекст будет изменён chcon(1) (если только с помощью параметра \-l не указан уровень). Если уровень безопасности MLS/MCS указан, пользователь должен установить правильные метки.
-.PP
-.TP
-\fB\-h\ \fB\-\-help\fR
-Показать сведения об использовании
-.TP
-\fB\-H\ \fB\-\-homedir\fR
-Указать альтернативный домашний каталог для монтирования вместо вашего домашнего каталога. По умолчанию используется временный каталог. Требуется \-X или \-M.
-.TP
-\fB\-i\fR \fB\-\-include\fR
-Копировать этот файл в соответствующий временный каталог изолированной среды. Команду можно повторять.
-.TP
-\fB\-I\fR \fB\-\-includefile\fR
-Копировать все файлы, перечисленные во входном файле (inputfile), в соответствующие временные каталоги изолированной среды.
-.TP
-\fB\-l\fR \fB\-\-level\fR
-Указать уровень безопасности MLS/MCS, с которым следует запускать изолированную среду. По умолчанию используется случайное значение.
-.TP
-\fB\-M\fR \fB\-\-mount\fR
-Создать изолированную среду с временными файлами для $HOME и /tmp.
-.TP
-\fB\-s\fR \fB\-\-shred\fR
-Уничтожить временные файлы, созданные в $HOME в /tmp, перед удалением.
-.TP
-\fB\-t\fR \fB\-\-type\fR
-Использовать альтернативный тип изолированной среды. По умолчанию: sandbox_t или sandbox_x_t для \-X.
-
-\fBПримеры:\fR
-.br
-sandbox_t	\-	без X, без доступа к сети, без открытия, чтение/запись передаются в дескрипторах файлов.
-.br
-sandbox_min_t	\-	без доступа к сети
-.br
-sandbox_x_t	\-	порты для X-приложений, которые следует запустить локально
-.br
-sandbox_web_t	\-	порты, необходимые для работы в Интернете
-.br
-sandbox_net_t	\-		сетевые порты (для серверного ПО)
-.br
-sandbox_net_client_t	\-	все сетевые порты
-
-.TP
-\fB\-T\fR \fB\-\-tmpdir\fR
-Использовать альтернативный временный каталог для монтирования в /tmp. По умолчанию: tmpfs. Требуется \-X или \-M.
-.TP
-\fB\-S\fR \fB\-\-session\fR
-Запустить полный сеанс рабочего стола. Требуется уровень, домашний каталог и временный каталог.
-.TP
-\fB\-w\fR \fB\-\-windowsize\fR
-Указать размер окна при создании изолированной среды на основе X. По умолчанию: 1000x700.
-.TP
-\fB\-W\fR \fB\-\-windowmanager\fR
-Выбрать альтернативный диспетчер окон для запуска в 
-.B sandbox \-X.
-По умолчанию: /usr/bin/openbox.
-.TP
-\fB\-X\fR 
-Создать изолированную среду на основе X для приложений графического интерфейса пользователя, временные файлы для $HOME и /tmp, дополнительный X-сервер. По умолчанию: sandbox_x_t
-.TP
-\fB\-d\fR \fB\-\-dpi\fR
-Указать значение разрешения (DPI) для X-сервера изолированной среды. По умолчанию используется значение разрешения текущего X-сервера.
-.TP
-\fB\-C\fR \fB\-\-capabilities\fR
-Использовать средства для управления привилегиями внутри изолированной среды. По умолчанию приложениям, которые выполняются в изолированной среде, запрещено использовать средства для управления привилегиями (setuid apps), но с флагом \-C можно использовать программы, которым необходимы средства для управления привилегиями.
-.PP
-.SH "СМОТРИТЕ ТАКЖЕ"
-.TP
-runcon(1), seunshare(8), selinux(8)
-.PP
-
-.SH АВТОРЫ
-Эта страница руководства была написана
-.I Dan Walsh <dwalsh@redhat.com>
-и
-.I Thomas Liu <tliu@fedoraproject.org>.
-Перевод на русский язык выполнила 
-.I Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/sandbox/ru/seunshare.8 b/sandbox/ru/seunshare.8
deleted file mode 100644
index f604b9eb..00000000
--- a/sandbox/ru/seunshare.8
+++ /dev/null
@@ -1,42 +0,0 @@
-.TH SEUNSHARE "8" "Май 2010" "seunshare" "Команды пользователя"
-.SH ИМЯ
-seunshare \- выполнить cmd с другим домашним каталогом (homedir), временным каталогом (tmpdir) и/или контекстом SELinux 
-.SH ОБЗОР
-.B seunshare
-[ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -Z context ] -- executable [args]
-.br
-.SH ОПИСАНИЕ
-.PP
-Запустите исполняемый файл
-.I executable
-в указанном контексте, используя альтернативный домашний каталог и каталог /tmp. Команда seunshare отменяет общий доступ из пространства имён по умолчанию, затем монтирует указанные домашний каталог и временный каталог вместо домашнего каталога и временного каталога по умолчанию. После этого команда сообщает ядру, что следует выполнить приложение в указанном контексте SELinux.
-
-.TP
-\fB\-h homedir\fR
-Альтернативный домашний каталог для использования приложением. Пользователь должен быть владельцем домашнего каталога.
-.TP
-\fB\-t\ tmpdir
-Использовать альтернативный временный каталог для монтирования в /tmp. Пользователь должен быть владельцем временного каталога.
-.TP
-\fB\-C --capabilities\fR
-Разрешить приложениям, исполняемым в пространстве имён, использовать средства для управления привилегиям. По умолчанию использование средств для управления привилегиями запрещено.
-.TP
-\fB\-k --kill\fR
-Завершить все процессы с соответствующим уровнем MCS.
-.TP
-\fB\-Z\ context
-Использовать альтернативный контекст SELinux при запуске исполняемого файла.
-.TP
-\fB\-v\fR
-Подробный вывод
-.SH "СМОТРИТЕ ТАКЖЕ"
-.TP
-runcon(1), sandbox(8), selinux(8)
-.PP
-.SH АВТОРЫ
-Эта страница руководства была написана
-.I Dan Walsh <dwalsh@redhat.com>
-и
-.I Thomas Liu <tliu@fedoraproject.org>.
-Перевод на русский язык выполнила
-.I Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

