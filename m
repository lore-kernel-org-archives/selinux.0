Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A877C05051
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHIQbQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjHIQbP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF2610F3
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:12 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7659cb9c42aso1786485a.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598671; x=1692203471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faJIFKAefw6sl8+vfNyP+M9hWy7F5/xahKbivvf0ALU=;
        b=lytErh1icVPlUMAKMdhuU1T3+CGmPGkC+nSE9n83bDqIR6rw61oxRjgugHBdzJcbg0
         Zp3y03Q4sFDJkMofooAyWQVA2zSn1xSayPOQKZqytuivm8wgeHdUJBU7HYy/JmqFVZaa
         ROb5dKIVnB6ki+kGBVepazBQvtjXODa+PwdzZktu17miJaFGrnzBs/bNq6rJJfwBRBtR
         Erx19hwDCbjC4I78iC8mpK8a/mMsdTyRnce5cm73hDDkIMSQ6EWydWCAr7F6B86bQVcI
         iKWpccHavXftPJP7GParAP94TcvOUB3Hy7fgpYUhEJe7AzOr3lT74/NOd76wNa9836Wj
         9y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598671; x=1692203471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faJIFKAefw6sl8+vfNyP+M9hWy7F5/xahKbivvf0ALU=;
        b=hdHwEVXQpSd98hAv2yeu3U/F6fFJxjrlhybiTI3tF5ahhhKEZu3C+Fsto/60OnDJWy
         xfOxeTWwXEJ1oyUWX3J7IwePjjpQZsLBOoreNd9w7M79ZaiEjKrrWBB3c1GfQ4svPG86
         0jUNBQZSk1mpS8QU4P3QnDfHnQcH2MQ88X0hRUKUh3rZXj5/Wl/iU1dDjNDNJvmT4uUk
         l2Hz9eA/RBsjCE7GGpXyEfi2TIYmzyOLrYvX+f+9xCEaVYLQjj6by+vtRkDA3MzskWR6
         n39CDDjMaTsmsxcBFYYd6wXVyWvASyxqQvnFy4L1J3lGHt/ZbUQi8Dv6oN6Bw370Vama
         jmPg==
X-Gm-Message-State: AOJu0Yz4S1lboPThjfnS+OywPg3gOkr58wyPCzB0gSq9o6gjuMeuhNjQ
        o8Zl27YoD2Bwt/ymlyvBFQZ4wD+n7mQ=
X-Google-Smtp-Source: AGHT+IFt3A4bj0OwLHyEQLLuLqA+7CISnvt8LXVvWOp50NdBXpUxfQJ2xGgeON8xYg8jnhwFWZXe3A==
X-Received: by 2002:a0c:ea8d:0:b0:63f:89ef:556a with SMTP id d13-20020a0cea8d000000b0063f89ef556amr2839980qvp.27.1691598669912;
        Wed, 09 Aug 2023 09:31:09 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:09 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 08/12] policycoreutils: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:53 -0400
Message-ID: <20230809163059.97671-8-jwcart2@gmail.com>
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
 policycoreutils/load_policy/ru/load_policy.8  |  41 ----
 policycoreutils/man/ru/man5/selinux_config.5  | 136 -----------
 policycoreutils/newrole/ru/newrole.1          | 109 ---------
 policycoreutils/run_init/ru/open_init_pty.8   |  42 ----
 policycoreutils/run_init/ru/run_init.8        |  26 ---
 policycoreutils/scripts/ru/fixfiles.8         |  94 --------
 policycoreutils/secon/ru/secon.1              | 120 ----------
 policycoreutils/semodule/ru/genhomedircon.8   |  25 --
 policycoreutils/semodule/ru/semodule.8        | 133 -----------
 policycoreutils/sestatus/ru/sestatus.8        |  79 -------
 policycoreutils/sestatus/ru/sestatus.conf.5   |  97 --------
 policycoreutils/setfiles/ru/restorecon.8      | 193 ---------------
 .../setfiles/ru/restorecon_xattr.8            | 115 ---------
 policycoreutils/setfiles/ru/setfiles.8        | 221 ------------------
 policycoreutils/setsebool/ru/setsebool.8      |  27 ---
 15 files changed, 1458 deletions(-)
 delete mode 100644 policycoreutils/load_policy/ru/load_policy.8
 delete mode 100644 policycoreutils/man/ru/man5/selinux_config.5
 delete mode 100644 policycoreutils/newrole/ru/newrole.1
 delete mode 100644 policycoreutils/run_init/ru/open_init_pty.8
 delete mode 100644 policycoreutils/run_init/ru/run_init.8
 delete mode 100644 policycoreutils/scripts/ru/fixfiles.8
 delete mode 100644 policycoreutils/secon/ru/secon.1
 delete mode 100644 policycoreutils/semodule/ru/genhomedircon.8
 delete mode 100644 policycoreutils/semodule/ru/semodule.8
 delete mode 100644 policycoreutils/sestatus/ru/sestatus.8
 delete mode 100644 policycoreutils/sestatus/ru/sestatus.conf.5
 delete mode 100644 policycoreutils/setfiles/ru/restorecon.8
 delete mode 100644 policycoreutils/setfiles/ru/restorecon_xattr.8
 delete mode 100644 policycoreutils/setfiles/ru/setfiles.8
 delete mode 100644 policycoreutils/setsebool/ru/setsebool.8

diff --git a/policycoreutils/load_policy/ru/load_policy.8 b/policycoreutils/load_policy/ru/load_policy.8
deleted file mode 100644
index 6c29e30a..00000000
--- a/policycoreutils/load_policy/ru/load_policy.8
+++ /dev/null
@@ -1,41 +0,0 @@
-.TH LOAD_POLICY "8" "Май 2003" "Security Enhanced Linux"
-.SH ИМЯ
-load_policy \- загрузить новую политику SELinux в ядро
-
-.SH ОБЗОР
-.B load_policy 
-[\-qi]
-.br
-.SH ОПИСАНИЕ
-.PP
-load_policy загружает установленный файл политики в ядро.
-Существующие значения логических переключателей политики автоматически сохраняются при перезагрузках политики, а не сбрасываются на установленные в файле политики значения по умолчанию.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.B \-q
-Отменить предупредительные сообщения.
-.TP
-.B \-i
-Начальная загрузка политики. Следует использовать, только если политика загружается впервые с момента запуска (обычно вызывается из initramfs).
-
-.SH "СОСТОЯНИЕ ВЫХОДА"
-.TP
-.B 0
-Успешно
-.TP
-.B 1
-Недействительный параметр
-.TP
-.B 2
-Не удалось загрузить политику
-.TP
-.B 3
-Не удалось выполнить начальную загрузку политики, запрошен принудительный режим
-.SH СМОТРИТЕ ТАКЖЕ
-.BR booleans (8)
-.SH АВТОРЫ
-.nf
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Stephen Smalley <stephen.smalley.work@gmail.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/man/ru/man5/selinux_config.5 b/policycoreutils/man/ru/man5/selinux_config.5
deleted file mode 100644
index 8c0db9ae..00000000
--- a/policycoreutils/man/ru/man5/selinux_config.5
+++ /dev/null
@@ -1,136 +0,0 @@
-.TH "selinux_config" "5" "18 ноября 2011" "Security Enhanced Linux" "Файл конфигурации SELinux"
-
-.SH "ИМЯ"
-config \- файл конфигурации подсистемы SELinux.
-
-.SH "ОПИСАНИЕ"
-Файл \fIconfig\fR SELinux управляет состоянием SELinux, определяя:
-.RS
-.IP "1." 4
-Состояние применения политики \- \fIenforcing\fR (принудительный режим), \fIpermissive\fR (разрешительный режим) или \fIdisabled\fR (отключена).
-.IP "2." 4
-Имя политики или тип, формирующий путь к политике, которую следует загрузить, и её вспомогательным файлам конфигурации.
-.IP "3." 4
-Способ управления локальными пользователями и логическими переключателями после загрузки политики (обратите внимание, что эта возможность использовалась в предыдущих версиях SELinux, сейчас она устарела).
-.IP "4." 4
-Поведение поддерживающих SELinux приложений при отсутствии настроенных действительных пользователей SELinux.
-.IP "5." 4
-Следует ли повторно проставлять метки в системе.
-.RE
-
-Описание записей, которые управляют этими возможностями, приводится в разделе \fBФОРМАТ ФАЙЛА\fR.
-.sp
-Полный путь к файлу конфигурации SELinux: \fI/etc/selinux/config\fR.
-.sp
-Если файл \fIconfig\fR отсутствует или повреждён, политика SELinux не будет загружена (то есть SELinux будет отключён).
-.sp
-Команда \fBsestatus\fR (8) и функция libselinux \fBselinux_path\fR (3) возвращают расположение файла \fIconfig\fR.
-
-.SH "ФОРМАТ ФАЙЛА"
-Файл \fIconfig\fR поддерживает следующие параметры:
-.sp
-.RS
-\fBSELINUX = \fIenforcing\fR | \fIpermissive\fR | \fIdisabled\fR
-.br
-\fBSELINUXTYPE = \fIpolicy_name\fR
-.br
-\fBREQUIRESEUSERS = \fI0\fR | \fI1\fR
-.br
-\fBAUTORELABEL = \fI0\fR | \fI1\fR
-.RE
-.sp
-Где:
-.br
-.B SELINUX
-.RS
-Эта запись может содержать одно из трёх значений:
-.RS
-.IP \fIenforcing\fR 4
-Политика безопасности SELinux применяется.
-.IP \fIpermissive\fR 4
-Политика безопасности SELinux не применяется, но ведётся журналирование предупреждений (то есть действиям разрешено продолжать выполняться).
-.IP \fIdisabled\fR
-SELinux отключён, политика не загружена.
-.RE
-.sp
-Значение записи можно узнать с помощью команды \fBsestatus\fR(8) или \fBselinux_getenforcemode\fR(3).
-.RE
-.sp
-.B SELINUXTYPE
-.RS
-Запись \fIpolicy_name\fR используется для идентификации типа политики и становится именем каталога, в котором располагаются политика и её файлы конфигурации.
-.sp
-Значение записи можно узнать с помощью команды \fBsestatus\fR(8) или \fBselinux_getpolicytype\fR(3).
-.sp
-\fIpolicy_name\fR относится к пути, который определён внутри подсистемы SELinux и может быть получен с помощью \fBselinux_path\fR(3). Пример записи, полученной с помощью \fBselinux_path\fR(3):
-.br
-.RS
-.I /etc/selinux/
-.RE
-.sp
-Затем к концу этой записи добавляется \fIpolicy_name\fR, и она становится корневым расположением политики, которое может быть получено с помощью \fBselinux_policy_root_path\fR(3). Пример полученной записи:
-.RS
-.I /etc/selinux/targeted
-.RE
-.sp
-Фактическая двоичная политика расположена относительно этого каталога и также имеет предварительно выделенное имя политики. Эту информацию можно получить с помощью \fBselinux_binary_policy_path\fR(3). Пример записи, полученной с помощью \fBselinux_binary_policy_path\fR(3):
-.br
-.RS
-.I /etc/selinux/targeted/policy/policy
-.RE
-.sp
-По соглашению к концу имени двоичной политики добавляется версия политики SELinux, которую она поддерживает. Максимальную версию политики, поддерживаемую ядром, можно определить с помощью команды \fBsestatus\fR(8) или \fBsecurity_policyvers\fR(3). Пример файла двоичной политики с версией:
-.br
-.RS
-.I /etc/selinux/targeted/policy/policy.24
-.RE
-.RE
-.sp
-.B REQUIRESEUSERS
-.RS
-Эта необязательная запись позволяет сделать попытку входа неудачной, если в файле 
-.BR seusers "(5) нет соответствующей записи или записи по умолчанию или отсутствует сам файл " seusers ". "
-.sp
-Она проверяется функцией \fBgetseuserbyname\fR(3), которая вызывается поддерживающими SELinux приложениями для входа, например, \fBPAM\fR(8).
-.sp
-Если задано значение \fI0\fR или отсутствует запись:
-.RS
-.BR getseuserbyname "(3) вернёт имя пользователя GNU / Linux в качестве пользователя SELinux."
-.RE
-.sp
-Если задано значение \fI1\fR:
-.RS
-.BR getseuserbyname "(3) не удастся выполнить."
-.RE
-.sp
-Описание работы \fBgetseuserbyname\fR(3) содержится на соответствующей man-странице. Формат файла \fIseusers\fR показан в \fBseusers\fR(5).
-.sp
-.RE
-.sp
-.B AUTORELABEL
-.RS
-Эта необязательная запись позволяет повторно проставлять метки в файловой системе.
-.sp
-Если задано значение \fI0\fR и в корневом каталоге имеется файл с именем \fI.autorelabel\fR, при перезагрузке загрузчик перейдёт в оболочку, запрашивающую вход в качестве пользователя root. Затем администратор сможет вручную проставить метки в файловой системе.
-.sp
-Если задано значение \fI1\fR или запись отсутствует (состояние по умолчанию) и в корневом каталоге имеется файл \fI.autorelabel\fR, в файловой системе с помощью \fBfixfiles \-F restore\fR будут автоматически повторно проставлены метки.
-.sp
-В обоих случаях файл \fI/.autorelabel\fR будет удалён, чтобы предотвратить последующее повторное проставление меток.
-.RE
-.sp
-
-.SH "ПРИМЕР"
-В этом примере показано минимальное содержимое файла \fIconfig\fR, которое обеспечит запуск SELinux в системе в принудительном режиме, со значением \fIpolicy_name\fR 'targeted':
-.sp
-.RS
-SELINUX = enforcing
-.br
-SELINUXTYPE = targeted
-.RE
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR selinux "(8), " sestatus "(8), " selinux_path "(3), " selinux_policy_root_path "(3), " selinux_binary_policy_path "(3), " getseuserbyname "(3), " PAM "(8), " fixfiles "(8), " selinux_mkload_policy "(3), " selinux_getpolicytype "(3), " security_policyvers "(3), " selinux_getenforcemode "(3), " seusers "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/newrole/ru/newrole.1 b/policycoreutils/newrole/ru/newrole.1
deleted file mode 100644
index 6d9c6dd0..00000000
--- a/policycoreutils/newrole/ru/newrole.1
+++ /dev/null
@@ -1,109 +0,0 @@
-.TH NEWROLE "1" "Октябрь 2000" "Security Enhanced Linux"
-.SH ИМЯ
-newrole \- запустить оболочку с новой ролью SELinux
-.SH ОБЗОР
-.B newrole
-[\fB-r\fR|\fB--role\fR]
-\fIROLE\fR
-[\fB-t\fR|\fB--type\fR]
-\fITYPE\fR
-[\fB-l\fR|\fB--level\fR]
-[\fB-p\fR|\fB--preserve-environment\fR]
-\fILEVEL\fR [-- [\fIARGS\fR]...]
-.SH ОПИСАНИЕ
-.PP
-Запустить новую оболочку в новом контексте. Новый контекст берётся из старого контекста, в котором изначально исполнялась
-.B newrole.
-Если указан параметр
-.B -r
-или
-.B --role
-, новый контекст будет иметь роль, заданную 
-\fIROLE\fR.
-Если указан параметр 
-.B -t
-или
-.B --type
-, новый контекст будет иметь тип (домен), заданный
-\fITYPE\fR.
-Если указана роль, но не указан тип, тип по умолчанию берётся из указанной роли. Если указан параметр
-.B -l
-или
-.B --level
-, новый контекст будет иметь уровень конфиденциальности, заданный 
-\fILEVEL\fR.
-Если
-\fILEVEL\fR
-является диапазоном, новый контекст будет иметь уровень конфиденциальности и допуск, заданные этим диапазоном. Если указан параметр
-.B -p
-или
-.B --preserve-environment
-, оболочка с новым контекстом SELinux сохранит переменные среды, в ином случае будет создана новая минимальная среда.
-.PP
-Дополнительные аргументы
-.I ARGS
-могут присутствовать после параметра --,
-в этом случае они передаются в новую оболочку.
-В частности, при использовании аргумента \-\- \-c следующий аргумент будет обрабатываться как команда большинством интерпретаторов команд.
-.PP
-Если для newrole указан аргумент команды и имя команды найдено в /etc/selinux/newrole_pam.conf, будет использована служба pam, указанная в этом файле для команды, а не обычная конфигурация pam для newrole. Это позволяет устанавливать конфигурацию pam для каждой команды при вызове через newrole, например, чтобы пропустить этап интерактивной повторной аутентификации.
-.PP
-Новой оболочкой будет оболочка, указанная в записи пользователя в файле
-.I /etc/passwd.
-.PP
-.B -V
-или 
-.B --version
-показывает текущую версию newrole
-.PP
-.SH ПРИМЕР
-.br
-Смена роли:
-   # id \-Z
-   staff_u:staff_r:staff_t:SystemLow-SystemHigh
-   # newrole \-r sysadm_r
-   # id \-Z
-   staff_u:sysadm_r:sysadm_t:SystemLow-SystemHigh
-
-Смена только уровня конфиденциальности:
-   # id \-Z
-   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
-   # newrole \-l Secret
-   # id \-Z
-   staff_u:sysadm_r:sysadm_t:Secret-SystemHigh
-
-.PP
-Смена уровня конфиденциальности и допуска:
-   # id \-Z
-   staff_u:sysadm_r:sysadm_t:Unclassified-SystemHigh
-   # newrole \-l Secret-Secret
-   # id \-Z
-   staff_u:sysadm_r:sysadm_t:Secret
-
-.PP
-Запуск программы с указанной ролью или уровнем:
-   # newrole \-r sysadm_r \-\- \-c "/path/to/app arg1 arg2..."
-   # newrole \-l Secret \-\- \-c "/path/to/app arg1 arg2..."
-
-.SH ФАЙЛЫ
-/etc/passwd - информация об учётных записях пользователей
-.br
-/etc/shadow - зашифрованные пароли и информация об устаревании паролей
-.br
-/etc/selinux/<policy>/contexts/default_type - типы по умолчанию для ролей
-.br
-/etc/selinux/<policy>/contexts/securetty_types - типы securetty для изменений уровня
-.br
-/etc/selinux/newrole_pam.conf - необязательное сопоставление команд с отдельными службами pam 
-.br
-.SH СМОТРИТЕ ТАКЖЕ
-.BR runcon (1)
-.SH АВТОРЫ
-.nf
-Anthony Colatrella
-Tim Fraser
-Steve Grubb <sgrubb@redhat.com>
-Darrel Goeddel <DGoeddel@trustedcs.com>
-Michael Thompson <mcthomps@us.ibm.com>
-Dan Walsh <dwalsh@redhat.com>
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>
diff --git a/policycoreutils/run_init/ru/open_init_pty.8 b/policycoreutils/run_init/ru/open_init_pty.8
deleted file mode 100644
index 143941e1..00000000
--- a/policycoreutils/run_init/ru/open_init_pty.8
+++ /dev/null
@@ -1,42 +0,0 @@
-.\" Hey, Emacs! This is an -*- nroff -*- source file.
-.\" Copyright (c) 2005 Manoj Srivastava <srivasta@debian.org>
-.\"
-.\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License, or (at your option) any later version.
-.\"
-.\" The GNU General Public License's references to "object code"
-.\" and "executables" are to be interpreted as the output of any
-.\" document formatting or typesetting system, including
-.\" intermediate and printed output.
-.\"
-.\" This manual is distributed in the hope that it will be useful,
-.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\" GNU General Public License for more details.
-.\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
-.\"
-.\"
-.TH OPEN_INIT_PTY "8" "Январь 2005" "Security Enhanced Linux"
-.SH ИМЯ
-open_init_pty \- запустить программу под псевдотерминалом
-.SH ОБЗОР
-.B open_init_pty
-\fISCRIPT\fR [[\fIARGS\fR]...] 
-.br
-.SH ОПИСАНИЕ
-.PP
-Запуск программы под псевдотерминалом. Эта возможность используется 
-.B run_init
-для фактического запуска программы после настройки подходящего контекста. Эта программа получает новый псевдотерминал, ответвляет дочерний процесс, который привязывается к псевдотерминалу, а затем соединяет физический терминал, на котором она была вызвана, с псевдотерминалом, передавая ввод клавиатуры в дочерний процесс и передавая вывод дочернего процесса физическому терминалу.
-.PP
-Она надлежащим образом настраивает псевдотерминал на основе атрибутов физического терминала, а затем устанавливает терминал пользователя в режим RAW (при выходе этот режим сбрасывается).
-.SH АВТОРЫ
-Эта страница руководства была написана Manoj Srivastava <srivasta@debian.org>
-для системы Debian GNU/Linux.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/run_init/ru/run_init.8 b/policycoreutils/run_init/ru/run_init.8
deleted file mode 100644
index 26b767ce..00000000
--- a/policycoreutils/run_init/ru/run_init.8
+++ /dev/null
@@ -1,26 +0,0 @@
-.TH RUN_INIT "8" "Май 2003" "Security Enhanced Linux"
-.SH ИМЯ
-run_init \- запустить сценарий init в правильном контексте SELinux
-.SH ОБЗОР
-.B run_init 
-\fISCRIPT\fR [[\fIARGS\fR]...] 
-.br
-.SH ОПИСАНИЕ
-.PP
-Запуск сценария init в правильном контексте, который указан в 
-/etc/selinux/POLICYTYPE/contexts/initrc_context.
-Обычно эта возможность используется интерактивно, так как она требует аутентификации shadow или пользователя PAM (в зависимости от параметров при компиляции). PAM можно настроить таким образом, что интерактивный ввод не потребуется. Обратитесь к документации по PAM.
-.SH ФАЙЛЫ
-/etc/passwd - информация об учётных записях пользователей
-.br
-/etc/shadow - зашифрованные пароли и информация об устаревании паролей
-.br
-/etc/selinux/POLICYTYPE/contexts/initrc_context - содержит контекст для запуска сценариев init
-.SH СМОТРИТЕ ТАКЖЕ
-.BR newrole (1),
-.BR runcon (1)
-.SH АВТОРЫ
-.nf
-Wayne Salamon (wsalamon@tislabs.com) 
-Dan Walsh (dwalsh@redhat.com) 
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>
diff --git a/policycoreutils/scripts/ru/fixfiles.8 b/policycoreutils/scripts/ru/fixfiles.8
deleted file mode 100644
index 13829441..00000000
--- a/policycoreutils/scripts/ru/fixfiles.8
+++ /dev/null
@@ -1,94 +0,0 @@
-.TH "fixfiles" "8" "2002031409" "" ""
-.SH "ИМЯ"
-fixfiles \- исправить SELinux-контексты безопасности файлов.
-
-.SH "ОБЗОР"
-.na
-
-.B fixfiles
-.I [\-v] [\-F] [\-f] relabel
-
-.B fixfiles
-.I [\-v] [\-F] { check | restore | verify } dir/file ...
-
-.B fixfiles
-.I [\-v] [\-F] [\-B | \-N time ] { check | restore | verify }
-
-.B fixfiles 
-.I [\-v] [\-F] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
-
-.B fixfiles
-.I [\-v] [\-F] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }
-
-.B fixfiles
-.I [-F] [-B] onboot
-
-.ad
-
-.SH "ОПИСАНИЕ"
-На этой странице руководства приводится описание сценария
-.BR fixfiles.
-.P
-Этот сценарий в основном используется для исправления базы данных контекстов безопасности (расширенных атрибутов) в файловых системах.  
-.P
-Его также можно запустить в любой момент, чтобы повторно проставить метки при добавлении поддержки новой политики или просто проверить, соответствуют ли контексты файлов ожиданиям пользователя. По умолчанию он повторно проставит метки во всех смонтированных файловых системах ext2, ext3, xfs и 
-jfs, даже если у них нет параметра монтирования с контекстом безопасности. Флаг \-R позволяет использовать rpm-пакеты в качестве альтернативы.
-Файл etc/selinux/fixfiles_exclude_dirs может содержать список каталогов, исключённых из повторного проставления меток.
-.P
-.B fixfiles onboot 
-При следующей перезагрузке компьютера метки будет проставлены повторно.
-
-.SH "ПАРАМЕТРЫ"
-.TP 
-.B \-B
-При использовании с onboot сценарий fixfiles запишет текущую дату в файл /.autorelabel, чтобы потом её можно было использовать для ускорения проставления меток. При использовании с restore будут затронуты только те файлы, которые были изменены сегодня.
-.TP
-.B \-F
-Принудительно сбросить контекст, чтобы он соответствовал file_context для настраиваемых файлов.
-
-.TP 
-.B \-f
-Очистить каталог /tmp, не запрашивая подтверждение удаления у пользователя.
-
-.TP 
-.B \-R rpmpackagename[,rpmpackagename...]
-Использовать базу данных rpm, чтобы найти все файлы в указанных пакетах и восстановить их контексты.
-.TP
-.B \-C PREVIOUS_FILECONTEXT
-Выполнить diff, чтобы сравнить файл PREVIOUS_FILECONTEXT с текущим установленным файлом, и восстановить контекст всех затронутых файлов.
-
-.TP 
-.B \-N time
-Применять изменения только к файлам, созданным после указанной даты. Дата должна быть указана в формате "ГГГГ\-ММ\-ДД ЧЧ:ММ". Поле даты будет передано в команду find \-\-newermt.
-
-.TP
-.B -v
-Изменить уровень детализации с показа хода выполнения на показ подробных сведений. (Запуск restorecon с \-v вместо \-p.)
-
-.SH "АРГУМЕНТЫ"
-Одно из:
-.TP 
-.B check
-Вывести все некорректные метки контекста файлов, показывая старый и новый контекст, но не изменяя его.
-.TP 
-.B restore
-Изменить все некорректные метки контекста файлов.
-.TP 
-.B relabel
-Запросить у пользователя подтверждение удаления содержимого каталога /tmp и затем изменить все некорректные метки контекста файлов, чтобы привести их в соответствие с файлом file_contexts.
-.TP 
-.B verify
-Вывести список файлов с некорректными метками контекста, но не изменять их.
-.TP 
-.B [[dir/file] ... ] 
-Список файлов или каталогов, для которых следует проверить контекст.
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR setfiles (8),
-.BR restorecon (8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Richard Hally <rhally@mindspring.com>.
-Сценарий был написан Dan Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-
diff --git a/policycoreutils/secon/ru/secon.1 b/policycoreutils/secon/ru/secon.1
deleted file mode 100644
index 3c9aa535..00000000
--- a/policycoreutils/secon/ru/secon.1
+++ /dev/null
@@ -1,120 +0,0 @@
-.TH SECON "1" "Апрель 2006" "Security Enhanced Linux"
-.SH ИМЯ
-secon \- показать контекст SELinux для файла, программы или ввода пользователя.
-.SH ОБЗОР
-.B secon
-[\fB-hVurtscmPRfLp\fR]
-[\fICONTEXT\fR]
-.br
-[\fB--file\fR]
-\fIFILE\fR
-.br
-[\fB--link\fR]
-\fIFILE\fR
-.br
-[\fB--pid\fR]
-\fIPID\fR
-.SH ОПИСАНИЕ
-.PP
-Просмотр части контекста. Контекст берётся из файла, идентификатора процесса, ввода пользователя или контекста, в котором была изначально запущена команда
-.B secon.
-.TP
-\fB\-V\fR, \fB\-\-version\fR
-показать текущую версию secon
-.TP
-\fB\-h\fR, \fB\-\-help\fR
-показать сведения об использовании secon
-.TP
-\fB\-P\fR, \fB\-\-prompt\fR
-вывести данные в формате, подходящем для запроса
-.TP
-\fB\-C\fR, \fB\-\-color\fR
-вывести данные с назначенными цветовыми кодами ANSI (требуется \-P)
-.TP
-\fB\-u\fR, \fB\-\-user\fR
-показать пользователя контекста безопасности
-.TP
-\fB\-r\fR, \fB\-\-role\fR
-показать роль контекста безопасности
-.TP
-\fB\-t\fR, \fB\-\-type\fR
-показать тип контекста безопасности
-.TP
-\fB\-s\fR, \fB\-\-sensitivity\fR
-показать уровень конфиденциальности контекста безопасности
-.TP
-\fB\-c\fR, \fB\-\-clearance\fR
-показать уровень допуска контекста безопасности
-.TP
-\fB\-m\fR, \fB\-\-mls-range\fR
-показать для контекста безопасности в виде диапазона уровень конфиденциальности и уровень допуска
-.TP
-\fB\-R\fR, \fB\-\-raw\fR
-вывести уровень конфиденциальности и уровень допуска в непреобразованном формате
-.TP
-\fB\-f\fR, \fB\-\-file\fR
-получить контекст из указанного файла FILE
-.TP
-\fB\-L\fR, \fB\-\-link\fR
-получить контекст из указанного файла FILE (не выполнять переход по символическим ссылкам)
-.TP
-\fB\-p\fR, \fB\-\-pid\fR
-получить контекст из указанного идентификатора процесса PID
-.TP
-\fB\-\-pid\-exec\fR
-получить контекст exec из указанного идентификатора процесса PID
-.TP
-\fB\-\-pid\-fs\fR
-получить контекст fscreate из указанного идентификатора процесса PID
-.TP
-\fB\-\-pid\-key\fR
-получить контекст key из указанного идентификатора процесса PID
-.TP
-\fB\-\-current\fR, \fB\-\-self\fR
-получить контекст из текущего процесса
-.TP
-\fB\-\-current\-exec\fR, \fB\-\-self\-exec\fR
-получить контекст exec из текущего процесса
-.TP
-\fB\-\-current\-fs\fR, \fB\-\-self\-fs\fR
-получить контекст fscreate из текущего процесса
-.TP
-\fB\-\-current\-key\fR, \fB\-\-self\-key\fR
-получить контекст key из текущего процесса
-.TP
-\fB\-\-parent\fR
-получить контекст из родителя текущего процесса
-.TP
-\fB\-\-parent\-exec\fR
-получить контекст exec из родителя текущего процесса
-.TP
-\fB\-\-parent\-fs\fR
-получить контекст fscreate из родителя текущего процесса
-.TP
-\fB\-\-parent\-key\fR
-получить контекст key из родителя текущего процесса
-.PP
-Можно предоставить дополнительный аргумент
-.I CONTEXT
-- он будет использоваться, если не заданы параметры, согласно которым
-.B secon
-получает контекст из другого источника.
-Если этим аргументом является  
-.I -
-(знак дефиса), контекст будет прочтён из stdin.
-.br
-Если аргумент отсутствует,
-.B secon
-попытается прочитать контекст из stdin, если это не tty; в ином случае 
-.B secon
-будет действовать так, как если бы был передан параметр \fB\-\-self\fR.
-.PP
-Если не передан ни один из параметров \fB\-\-user\fR, \fB\-\-role\fR, \fB\-\-type\fR, \fB\-\-level\fR или
-\fB\-\-mls\-range\fR, будут выведены все они.
-.PP
-.SH СМОТРИТЕ ТАКЖЕ
-.BR chcon (1)
-.SH АВТОРЫ
-.nf
-James Antill (james.antill@redhat.com).
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/semodule/ru/genhomedircon.8 b/policycoreutils/semodule/ru/genhomedircon.8
deleted file mode 100644
index dbf27bcc..00000000
--- a/policycoreutils/semodule/ru/genhomedircon.8
+++ /dev/null
@@ -1,25 +0,0 @@
-.TH GENHOMEDIRCON "8" "Сентябрь 2011" "Security Enhanced Linux" "SELinux"
-.SH ИМЯ
-genhomedircon \- создать записи конфигурации контекста файлов SELinux для домашних каталогов пользователей
-.SH ОПИСАНИЕ
-.B genhomedircon
-- сценарий, который исполняет
-.B semodule
-для пересборки текущей активной политики SELinux (без её перезагрузки) и создания меток для домашних каталогов пользователей на основе путей к каталогам, возвращённых вызовами функции getpwent().
-
-Последняя возможность будет работать, если для параметра "usepasswd" установлено значение "true" (по умолчанию)
-в /etc/selinux/semanage.conf.
-
-Этот сценарий обычно исполняется
-.B semanage,
-хотя это поведение по умолчанию можно изменить, установив для "disable-genhomedircon" значение "true"
-в /etc/selinux/semanage.conf.
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-semanage.conf(5), semodule(8), semanage(8), getpwent(3), getpwent_r(3)
-
-.SH АВТОРЫ
-Эта страница руководства была написана 
-.I Dan Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила
-.I Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/semodule/ru/semodule.8 b/policycoreutils/semodule/ru/semodule.8
deleted file mode 100644
index d7ff9b56..00000000
--- a/policycoreutils/semodule/ru/semodule.8
+++ /dev/null
@@ -1,133 +0,0 @@
-.TH SEMODULE "8" "Ноябрь 2005" "Security Enhanced Linux"
-.SH ИМЯ 
-semodule \- управление модулями политики SELinux.
-
-.SH ОБЗОР
-.B semodule [option]... MODE...
-.br
-.SH ОПИСАНИЕ
-.PP
-semodule - это утилита, которая используется для управления модулями политики SELinux, включая установку, обновление, вывод списка и удаление модулей. semodule также можно использовать для принудительной пересборки политики из хранилища модулей и/или для принудительной перезагрузки политики без выполнения других транзакций. semodule применяется к пакетам модулей, созданным с помощью semodule_package. По соглашению эти файлы имеют суффикс .pp (пакет политики), хотя это никак не регламентируется.
-
-.SH "MODES"
-.TP
-.B \-R, \-\-reload
-принудительно перезагрузить политику
-.TP
-.B \-B, \-\-build
-принудительно пересобрать политику (также выполнит перезагрузку, если не используется \-n)
-.TP
-.B \-D, \-\-disable_dontaudit
-временно удалить правила dontaudit из политики (изменения отменяются при пересборке политики)
-.TP
-.B \-i,\-\-install=MODULE_PKG
-установить/заменить пакет модуля
-.TP
-.B  \-u,\-\-upgrade=MODULE_PKG
-устарел, псевдоним для --install
-.TP
-.B  \-b,\-\-base=MODULE_PKG   
-устарел, псевдоним для --install
-.TP
-.B  \-r,\-\-remove=MODULE_NAME
-удалить существующий модуль с указанным приоритетом (по умолчанию: -X 400)
-.TP
-.B  \-l[KIND],\-\-list-modules[=KIND]
-вывести список установленных модулей (отличных от базовых)
-.TP
-.B  KIND:
-.TP
-standard
-вывести модули с высшим приоритетом, включённые, небазовые
-.TP
-full
-вывести все модули
-.TP
-.B  \-X,\-\-priority=PRIORITY
-установить приоритет для следующих операций (1-999)
-.TP
-.B  \-e,\-\-enable=MODULE_NAME
-включить модуль
-.TP
-.B  \-d,\-\-disable=MODULE_NAME
-отключить модуль
-.TP
-.B  \-E,\-\-extract=MODULE_PKG
-извлечь модуль из хранилища в текущий каталог как файл HLL или CIL.
-По умолчанию модуль извлекается как файл HLL. Имя записываемого модуля - <module-name>.<lang_ext>
-.SH "ПАРАМЕТРЫ"
-.TP
-.B  \-s,\-\-store
-имя хранилища, над которым следует выполнить операцию
-.TP
-.B  \-n,\-\-noreload,\-N
-не перезагружать политику после фиксации
-.TP
-.B  \-h,\-\-help        
-вывести справочное сообщение и выйти
-.TP
-.B \-P,\-\-preserve_tunables
-сохранить настраиваемые параметры в политике
-.TP
-.B \-C,\-\-ignore-module-cache
-перекомпилировать модули CIL, собранные из файлов HLL
-.TP
-.B \-p,\-\-path
-использовать альтернативный путь для корневого расположения политики
-.TP
-.B \-S,\-\-store-path
-использовать альтернативный путь для корневого расположения хранилища политики
-.TP
-.B  \-v,\-\-verbose     
-подробно
-.TP
-.B  \-c,\-\-cil
-извлечь модуль как файл CIL. Это влияет только на параметр \-\-extract и модули, перечисленные в \-\-extract после этого параметра.
-.TP
-.B  \-H,\-\-hll
-извлечь модуль как файл HLL. Это влияет только на параметр \-\-extract и модули, перечисленные в \-\-extract после этого параметра.
-
-.SH ПРИМЕР
-.nf
-# Установить или заменить базовый пакет политики.
-$ semodule \-b base.pp
-# Установить или заменить небазовый пакет политики.
-$ semodule \-i httpd.pp
-# Установить или заменить все небазовые модули в текущем каталоге.
-# Этот синтаксис можно использовать с -i/u/r/E, но после имён модулей нельзя вводить какие-либо другие параметры.
-$ semodule \-i *.pp
-# Установить или заменить все модули в текущем каталоге.
-$ ls *.pp | grep \-Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule \-b base.pp \-i
-# Вывести список небазовых модулей.
-$ semodule \-l
-# Вывести список всех модулей, включая их приоритет.
-$ semodule \-lfull
-# Удалить модуль с приоритетом 100.
-$ semodule \-X 100 \-r wireshark
-# Включить все сообщения кэша вектора доступа (AVC), для которых SELinux сейчас использует правила "dontaudit".
-$ semodule \-DB
-# Включить правила "dontaudit" обратно.
-$ semodule \-B
-# Отключить модуль (будут отключены все экземпляры данного модуля независимо от их приоритета).
-$ semodule \-d alsa
-# Установить модуль с указанным приоритетом.
-$ semodule \-X 100 \-i alsa.pp
-# Вывести список всех модулей.
-$ semodule \-\-list=full
-# Установить альтернативный путь для корневого расположения политики.
-$ semodule \-B \-p "/tmp"
-# Установить альтернативный путь для корневого расположения хранилища политики.
-$ semodule \-B \-S "/tmp/var/lib/selinux"
-# Записать HLL-версию модуля puppet и CIL-версию модуля wireshark
-# с приоритетом 400 в текущий рабочий каталог
-$ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E wireshark
-.fi
-
-.SH СМОТРИТЕ ТАКЖЕ
-.BR checkmodule (8),
-.BR semodule_package (8)
-.SH АВТОРЫ
-.nf
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Karl MacMillan <kmacmillan@tresys.com>, Joshua Brindle <jbrindle@tresys.com>, Jason Tang <jtang@tresys.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>
diff --git a/policycoreutils/sestatus/ru/sestatus.8 b/policycoreutils/sestatus/ru/sestatus.8
deleted file mode 100644
index 56fcd23e..00000000
--- a/policycoreutils/sestatus/ru/sestatus.8
+++ /dev/null
@@ -1,79 +0,0 @@
-.TH "sestatus" "8" "26 ноября 2011" "Security Enhanced Linux" "Документация по командной строке SELinux"
-.SH "ИМЯ"
-sestatus \- утилита для просмотра состояния SELinux
-
-.SH "ОБЗОР"
-.B sestatus
-.I [\-v] [\-b]  
-.P
-Эта утилита используется для получения состояния системы, в которой работает SELinux.
-
-.SH "ОПИСАНИЕ"
-Эта страница руководства содержит описание программы
-.BR sestatus.
-.sp
-Эта утилита используется для получения состояния системы, в которой работает SELinux. Она показывает сведения о том, включён или отключён SELinux, расположение ключевых каталогов, а также загруженную политику и её состояние. Пример:
-.RS
-> sestatus
-.br
-SELinux status:              enabled
-.br
-SELinuxfs mount:             /selinux
-.br
-SELinux root directory:      /etc/selinux
-.br
-Loaded policy name:          targeted
-.br
-Current mode:                permissive
-.br
-Mode from config file:       enforcing
-.br
-Policy MLS status:           enabled
-.br
-Policy deny_unknown status:  allow
-.br
-Memory protection checking:  actual (secure)
-.br
-Max kernel policy version:   26
-.RE
-.sp
-\fBsestatus\fR также можно использовать, чтобы просмотреть:
-.RS
-.IP "-" 4
-Контексты безопасности файлов и процессов, перечисленные в файле \fI/etc/sestatus.conf\fR. Описание формата этого файла содержится в \fBsestatus.conf\fR(5).
-.IP "-" 4
-Состояние логических переключателей.
-.RE
-
-.SH "ПАРАМЕТРЫ"
-.B \-v
-.RS
-Показать контексты файлов и процессов, перечисленные в файле \fI/etc/sestatus.conf\fR. Также проверяет, является ли файл символической ссылкой (если является, то также будет показан контекст целевого файла).
-.sp
-Всегда будут показаны следующие контексты:
-.RS
-Контекст текущего процесса
-.br
-Контекст процесса init 
-.br
-Контекст файла управляющего терминала
-.RE
-.RE
-.sp
-.B \-b
-.RS
-Показать текущее состояние логических переключателей.
-.RE
-
-.SH "ФАЙЛЫ"
-.I /etc/sestatus.conf
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR selinux "(8), " sestatus.conf "(5)
-
-.SH "АВТОРЫ"
-Эта страница руководства была написана Daniel Walsh <dwalsh@redhat.com>.
-.br
-Программа была написана Chris PeBenito <pebenito@gentoo.org>.
-.br
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/sestatus/ru/sestatus.conf.5 b/policycoreutils/sestatus/ru/sestatus.conf.5
deleted file mode 100644
index 60ebeab9..00000000
--- a/policycoreutils/sestatus/ru/sestatus.conf.5
+++ /dev/null
@@ -1,97 +0,0 @@
-.TH "sestatus.conf" "5" "26 ноября 2011" "Security Enhanced Linux" "Файл конфигурации sestatus"
-
-.SH "ИМЯ"
-sestatus.conf \- файл конфигурации \fBsestatus\fR(8).
-
-.SH "ОПИСАНИЕ"
-Файл \fIsestatus.conf\fR используется командой \fBsestatus\fR(8) с параметром \fB\-v\fR, чтобы определить, какие контексты безопасности файлов и процессов следует показать.
-.sp
-Полный путь к файлу конфигурации:
-.RS
-\fI/etc/sestatus.conf\fR
-.RE
-.RE
-.sp
-Файл состоит из двух необязательных разделов (описание содержится в разделе \fBФОРМАТ ФАЙЛА\fR). Независимо от того, существуют ли эти разделы, всегда показывается следующее:
-.RS
-Контекст текущего процесса
-.br
-Контекст процесса init 
-.br
-Контекст файла управляющего терминала
-.RE
-
-.SH "ФОРМАТ ФАЙЛА"
-Формат состоит из двух необязательных разделов (пример далее):
-.RS
-.B [files]
-.br
-.I file_name
-.br
-.I [file_name]
-.br
-.I ...
-.sp
-.B [process]
-.br
-.I executable_file_name
-.br
-.I [executable_file_name]
-.br
-.I ...
-.RE
-.sp
-Где:
-.RS
-.B [files]
-.RS
-Начало блока списка файлов.
-.RE
-.I file_name
-.RS
-Одно или несколько полных имён файлов (каждое на новой строке), контекст которых будет показан. Если файл не существует, он игнорируется. Если файл является символической ссылкой, \fBsestatus \-v\fR также покажет контекст целевого файла.
-.RE
-.sp
-.B [process]
-.RS
-Начало блока списка процессов.
-.RE
-.I executable_file_name
-.RS
-Одно или несколько полных имён исполняемых файлов; будет показан контекст соответствующих активных процессов. Каждая запись находится на новой строке.
-.RE
-.RE
-
-.SH "ПРИМЕР"
-# /etc/sestatus.conf
-.br
-[files]
-.br
-/etc/passwd
-.br
-/etc/shadow
-.br
-/bin/bash
-.br
-/bin/login
-.br
-/lib/libc.so.6
-.br
-/lib/ld-linux.so.2
-.br
-/lib/ld.so.1
-.sp
-[process]
-.br
-/sbin/mingetty
-.br
-/sbin/agetty
-.br
-/usr/sbin/sshd
-.RE
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR selinux "(8), " sestatus "(8) "
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>
diff --git a/policycoreutils/setfiles/ru/restorecon.8 b/policycoreutils/setfiles/ru/restorecon.8
deleted file mode 100644
index 9be3a63d..00000000
--- a/policycoreutils/setfiles/ru/restorecon.8
+++ /dev/null
@@ -1,193 +0,0 @@
-.TH "restorecon" "8" "10 июня 2016" "" "Команда пользователя SELinux"
-.SH "ИМЯ"
-restorecon \- восстановить SELinux-контексты безопасности файлов по умолчанию.
-
-.SH "ОБЗОР"
-.B restorecon
-.RB [ \-r | \-R ]
-.RB [ \-m ]
-.RB [ \-n ]
-.RB [ \-p ]
-.RB [ \-v ]
-.RB [ \-i ]
-.RB [ \-F ]
-.RB [ \-W ]
-.RB [ \-I | \-D ]
-.RB [ \-e
-.IR directory ]
-.IR pathname \ ...
-.P
-.B restorecon
-.RB [ \-f
-.IR infilename ]
-.RB [ \-e
-.IR directory ]
-.RB [ \-r | \-R ]
-.RB [ \-m ]
-.RB [ \-n ]
-.RB [ \-p ]
-.RB [ \-v ]
-.RB [ \-i ]
-.RB [ \-F ]
-.RB [ \-W ]
-.RB [ \-I | \-D ]
-
-.SH "ОПИСАНИЕ"
-Эта страница руководства содержит описание программы
-.BR restorecon.
-.P
-Эта программа используется в основном для установки контекста безопасности (расширенных атрибутов) для одного или нескольких файлов.
-.P
-Также можно запустить её в любой момент, чтобы исправить некорректные метки, добавить поддержку недавно установленной политики или, используя параметр
-.B \-n
-, пассивно проверить, соответствуют ли установленные контексты файлов тем контекстам, которые указаны в активной политике (поведение по умолчанию).
-.P
-Если объект файла не имеет контекста,
-.B restorecon
-запишет контекст по умолчанию в расширенные атрибуты объекта файла. Если объект файла имеет контекст,
-.B restorecon
-изменит только ту часть контекста безопасности, которая относится к типу.
-Параметр
-.B \-F
-позволяет принудительно заменить контекст целиком.
-.P
-Если у файла имеется метка настраиваемого типа SELinux
-.BR customizable
-(список настраиваемых типов: /etc/selinux/{SELINUXTYPE}/contexts/customizable_types), restorecon
-выполнит сброс метки только при условии использования параметра \-F.
-.P
-Эта программа аналогична
-.BR setfiles,
-но действует немного другим образом в зависимости от значения argv[0].
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.BI \-e \ directory
-исключить каталог (чтобы исключить более одного каталога, этот параметр необходимо использовать соответствующее количество раз; необходимо указывать полный путь).
-.TP
-.BI \-f \ infilename
-.I infilename
-содержит список файлов для обработки. Используйте
-.RB \*(lq \- \*(rq
-для
-.BR stdin.
-.TP
-.B \-F
-принудительно сбросить контекст, чтобы обеспечить соответствие file_context для настраиваемых файлов и соответствие контексту файлов по умолчанию для остальных файлов (меняются части контекста, связанные с пользователем, ролью, диапазоном, а также тип). 
-.TP
-.B \-h, \-?
-показать сведения об использовании и выйти.
-.TP
-.B \-i
-игнорировать файлы, которые не существуют.
-.TP
-.B \-I
-игнорировать дайджест, чтобы принудительно проверить метки, даже если хранимый дайджест SHA1 соответствует дайджесту SHA1 файлов спецификации. Затем (при условии отсутствия ошибок) дайджест будет обновлён. Более подробные сведения доступны в разделе
-.B ПРИМЕЧАНИЯ.
-.TP
-.B \-D
-установить или обновить дайджесты SHA1 для любых каталогов. Используйте этот параметр, чтобы включить использование расширенного атрибута
-.IR security.restorecon_last.
-.TP
-.B \-m
-не выполнять чтение
-.B /proc/mounts
-для получения списка монтирований без seclabel, которые следует исключить из проверок с повторным проставлением меток. Установка этого параметра полезна при наличии смонтированной файловой системы без seclabel, в которой в расположенном ниже каталоге смонтирована файловая система с seclabel.
-.TP
-.B \-n
-не изменять метки файлов (пассивная проверка). Чтобы просмотреть файлы, метки которых были бы изменены, добавьте
-.BR \-v.
-.TP
-.BI \-o \ outfilename
-этот параметр устарел и больше не поддерживается.
-.TP
-.B \-p
-показывать ход выполнения, выводя количество обработанных файлов (единица измерения - блок размером 1 КБ (то есть 1000 файлов)). Если выполняется повторное проставление меток во всей ОС, будет показан примерный процент выполнения. Обратите внимание, что параметры
-.B \-p
-и
-.B \-v
-являются взаимоисключающими.
-.TP
-.B \-R, \-r
-рекурсивно изменить метки файлов для файлов и каталогов (спускаться по каталогам).
-.br
-.TP
-.B \-v
-показать изменения в метках файлов. Использование нескольких параметров -v увеличивает уровень детализации. Обратите внимание, что параметры
-.B \-v
-и
-.B \-p
-являются взаимоисключающими.
-.TP
-.B \-W
-показать предупреждения о записях, для которых не обнаружены соответствующие файлы, с помощью вывода результатов
-.BR selabel_stats (3).
-.TP
-.B \-0
-предполагается, что разделителем для элементов ввода является символ нуля
-(вместо пробела). Символы кавычек и обратной косой черты также считаются обычными символами, которые могут формировать допустимый ввод.
-Этот параметр также отключает строку конца файла (end-of-file string), она обрабатывается, как любой другой аргумент. Это полезно, если элементы ввода содержат пробелы, кавычки или обратные косые черты. Параметр 
-.B \-print0
-GNU
-.B find
-производит ввод, подходящий для этого режима.
-.TP
-.SH "АРГУМЕНТЫ"
-.IR pathname \ ...
-Путь к файлу (файлам), для которых следует повторно проставить метки.
-.SH "ПРИМЕЧАНИЯ"
-.IP "1." 4
-.B restorecon
-не переходит по символическим ссылкам и по умолчанию не работает с каталогами рекурсивно.
-.IP "2." 4
-Если в
-.I pathname
-указан корневой каталог, установлен параметр
-.B \-vR
-или
-.B \-vr,
-а также запущена система аудита, в журнал с меткой сообщения
-.BR FS_RELABEL
-автоматически записывается событие аудита, которое содержит сообщение о том, что произошло "массовое повторное проставление меток". 
-.IP "3." 4
-Для повышения производительности при рекурсивном повторном проставлении меток в файловых системах (то есть тогда, когда установлен параметр
-.B \-R
-или
-.B \-r
-),
-параметр
-.B \-D
-команды
-.B restorecon
-обеспечит сохранение дайджеста SHA1 файлов спецификации по умолчанию в расширенном атрибуте с именем
-.IR security.restorecon_last
-для каталогов, указанных в соответствующих путях
-.IR pathname \ ...
-, после успешного завершения повторного проставления меток. Этот дайджест будет проверен, если команда
-.B restorecon
-.B \-D
-будет перезапущена с теми же параметрами
-.I pathname.
-Подробные сведения доступны в
-.BR selinux_restorecon (3).
-.sp
-Параметр
-.B \-I
-позволяет игнорировать дайджест SHA1 из каждого каталога, указанного в 
-.IR pathname \ ...
-, и, при условии, что НЕ установлен параметр
-.B \-n
-и установлен рекурсивный режим, для файлов будут необходимым образом повторно проставлены метки, а дайджест затем будет обновлён (если не будет ошибок).
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR setfiles (8),
-.BR fixfiles (8),
-.BR load_policy (8),
-.BR checkpolicy (8),
-.BR customizable_types (5)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Dan Walsh <dwalsh@redhat.com>.
-Некоторая часть содержимого этой man-страницы была взята из man-страницы setfiles, написанной Russell Coker <russell@coker.com.au>.
-Программа была написана Dan Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/policycoreutils/setfiles/ru/restorecon_xattr.8 b/policycoreutils/setfiles/ru/restorecon_xattr.8
deleted file mode 100644
index 41c441b8..00000000
--- a/policycoreutils/setfiles/ru/restorecon_xattr.8
+++ /dev/null
@@ -1,115 +0,0 @@
-.TH "restorecon_xattr" "8" "24 сентября 2016" "" "Команда пользователя SELinux"
-.SH "ИМЯ"
-restorecon_xattr \- управление записями расширенных атрибутов
-.I security.restorecon_last,
-добавленными с помощью
-.BR setfiles (8)
-или
-.BR restorecon (8).
-
-.SH "ОБЗОР"
-.B restorecon_xattr
-.RB [ \-d ]
-.RB [ \-D ]
-.RB [ \-m ]
-.RB [ \-n ]
-.RB [ \-r ]
-.RB [ \-v ]
-.RB [ \-e
-.IR directory ]
-.RB [ \-f
-.IR specfile ]
-.I pathname
-
-.SH "ОПИСАНИЕ"
-.B restorecon_xattr
-покажет дайджесты SHA1, добавленные в расширенные атрибуты
-.I security.restorecon_last,
-или полностью удалит эти атрибуты. Эти атрибуты устанавливаются командой
-.BR restorecon (8)
-или
-.BR setfiles (8)
-для указанных каталогов при рекурсивном повторном проставлении меток.
-.sp
-.B restorecon_xattr
-полезно использовать для управления записями расширенных атрибутов, в частности, когда пользователи забывают, из каких каталогов они запускали
-.BR restorecon (8)
-или
-.BR setfiles (8).
-.sp
-Файловые системы
-.B RAMFS
-и
-.B TMPFS
-не поддерживают расширенные атрибуты
-.I security.restorecon_last
-и автоматически исключаются из поиска.
-.sp
-По умолчанию
-.B restorecon_xattr
-показывает дайджесты SHA1, добавляя в конце "Match", если они соответствуют установленному по умолчанию файлу спецификации или файлу спецификации
-.I specfile,
-который установлен с помощью параметра
-.B \-f.
-Несоответствующие дайджесты SHA1 будут показаны с добавлением "No Match" в конце.
-Эту возможность можно отключить с помощью параметра
-.B \-n.
-
-.SH "ПАРАМЕТРЫ"
-.TP
-.B \-d
-удалить все несоответствующие записи дайджеста каталога
-.I security.restorecon_last.
-.TP
-.B \-D
-удалить все записи дайджеста каталога
-.I security.restorecon_last.
-.TP
-.B \-m
-не выполнять чтение
-.B /proc/mounts
-для получения списка монтирований без seclabel, которые следует исключить из проверок с повторным проставлением меток.
-.br
-установка параметра
-.B \-m
-полезна при наличии смонтированной файловой системы без seclabel, в которой в расположенном ниже каталоге смонтирована файловая система с seclabel.
-.TP
-.B \-n
-не добавлять "Match" или "No Match" в конце отображаемых дайджестов.
-.TP
-.B \-r
-рекурсивно спускаться по каталогам.
-.TP
-.B \-v
-показать дайджест SHA1, созданный установленным файлом спецификации.
-.TP
-.B \-e
-.I directory
-.br
-каталог, который следует исключить (чтобы исключить более одного каталога, этот параметр необходимо использовать соответствующее количество раз).
-.TP
-.B \-f
-.I specfile
-.br
-необязательный файл спецификации
-.I specfile,
-который содержит записи контекстов файлов в соответствии с описанием в
-.BR file_contexts (5).
-Он будет использоваться
-.BR selabel_open (3)
-для получения набора записей меток; получение дайджеста SHA1 выполняется с помощью
-.BR selabel_digest (3).
-Если этот параметр не указан, будет использоваться файл file_contexts по умолчанию.
-
-.SH "АРГУМЕНТЫ"
-.TP
-.I pathname
-.br
-путь к дереву каталогов, в котором следует выполнить поиск.
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR restorecon (8),
-.BR setfiles (8)
-
-.SH "АВТОРЫ"
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>
diff --git a/policycoreutils/setfiles/ru/setfiles.8 b/policycoreutils/setfiles/ru/setfiles.8
deleted file mode 100644
index 730b634b..00000000
--- a/policycoreutils/setfiles/ru/setfiles.8
+++ /dev/null
@@ -1,221 +0,0 @@
-.TH "setfiles" "8" "10 июня 2016" "" "Команда пользователя SELinux"
-.SH "ИМЯ"
-setfiles \- установить SELinux-контексты безопасности файлов.
-
-.SH "ОБЗОР"
-.B setfiles
-.RB [ \-c
-.IR policy ]
-.RB [ \-d ]
-.RB [ \-l ]
-.RB [ \-m ]
-.RB [ \-n ]
-.RB [ \-e
-.IR directory ]
-.RB [ \-p ]
-.RB [ \-s ]
-.RB [ \-v ]
-.RB [ \-W ]
-.RB [ \-F ]
-.RB [ \-I | \-D ]
-.I spec_file
-.IR pathname \ ...
-
-.SH "ОПИСАНИЕ"
-На этой странице руководства приводится описание программы
-.BR setfiles.
-.P
-Эта программа используется в основном для инициализации полей контекста безопасности (расширенных атрибутов) в одной или нескольких файловых системах (или их частях). Обычно она впервые запускается как часть процесса установки SELinux (этап, который называется проставлением меток).
-.P
-Также можно запустить её в любой другой момент, чтобы исправить некорректные метки, добавить поддержку для недавно установленной политики или, используя параметр
-.B \-n
-, пассивно проверить, соответствуют ли установленные контексты файлов тем контекстам, которые указаны в активной политике (поведение по умолчанию) или в какой-либо другой политике (см. параметр
-.B \-c
-).
-.P
-Если объект файла не имеет контекста,
-.B setfiles
-запишет контекст по умолчанию в расширенные атрибуты объекта файла. Если объект файла имеет контекст,
-.B setfiles
-изменит только ту часть контекста безопасности, которая относится к типу.
-Параметр
-.B \-F
-позволяет принудительно заменить контекст целиком.
-.SH "ПАРАМЕТРЫ"
-.TP
-.B \-c
-проверить действительность контекстов относительно указанной двоичной политики.
-.TP
-.B \-d
-показать, какая спецификация соответствует каждому из файлов.
-.TP
-.BI \-e \ directory
-исключить каталог (чтобы исключить более одного каталога, этот параметр необходимо использовать соответствующее количество раз).
-.TP
-.BI \-f \ infilename
-.I infilename
-содержит список файлов для обработки. Используйте
-.RB \*(lq \- \*(rq
-для
-.BR stdin .
-.TP
-.B \-F
-принудительно сбросить контекст, чтобы обеспечить соответствие file_context для настраиваемых файлов и соответствие контексту файлов по умолчанию для остальных файлов (меняются части контекста, связанные с пользователем, ролью, диапазоном, а также тип).
-.TP
-.B \-h, \-?
-показать сведения об использовании и выйти.
-.TP
-.B \-i
-игнорировать файлы, которые не существуют.
-.TP
-.B \-I
-игнорировать дайджест, чтобы принудительно проверить метки, даже если хранимый дайджест SHA1 соответствует дайджесту SHA1 файлов спецификации. Затем (при условии отсутствия ошибок) дайджест будет обновлён. Более подробные сведения доступны в разделе
-.B ПРИМЕЧАНИЯ.
-.TP
-.B \-D
-установить или обновить дайджесты SHA1 для любых каталогов. Используйте этот параметр, чтобы включить использование расширенного атрибута
-.IR security.restorecon_last.
-.TP
-.B \-l
-записывать изменения меток файлов в системный журнал.
-.TP
-.B \-m
-не выполнять чтение
-.B /proc/mounts
-для получения списка монтирований без seclabel, которые следует исключить из проверок с повторным проставлением меток. Установка этого параметра полезна при наличии смонтированной файловой системы без seclabel, в которой в расположенном ниже каталоге смонтирована файловая система с seclabel.
-.TP
-.B \-n
-не изменять метки файлов (пассивная проверка).
-.TP
-.BI \-o \ outfilename
-этот параметр устарел и больше не поддерживается.
-.TP
-.B \-p
-показывать ход выполнения, выводя количество обработанных файлов (единица измерения - блок размером 1 КБ (то есть 1000 файлов)). Если выполняется повторное проставление меток во всей ОС, будет показан примерный процент выполнения. Обратите внимание, что параметры
-.B \-p
-и
-.B \-v
-являются взаимоисключающими.
-.TP 
-.B \-q
-этот параметр устарел, ранее использовался для прекращения вывода параметров ассоциаций индексных дескрипторов (inode).
-.TP 
-.BI \-r \ rootpath
-использовать альтернативный корневой путь. Используется в meta-selinux для сборок OpenEmbedded/Yocto, чтобы проставить метки для файлов в каталоге
-.I rootpath
-таким образом, как если бы они были в
-.B /
-.TP 
-.B \-s
-взять список файлов из стандартного ввода, а не использовать путь из командной строки (эквивалентно
-.RB \*(lq "\-f \-" \*(rq
-).
-.TP
-.B \-v
-показать изменения меток для файлов и вывести параметры ассоциаций индексных дескрипторов (inode).
-Обратите внимание, что параметры
-.B \-v
-и
-.B \-p
-являются взаимоисключающими.
-.TP 
-.B \-W
-показать предупреждения о записях, для которых не обнаружены соответствующие файлы, с помощью вывода результатов
-.BR selabel_stats (3).
-.TP 
-.B \-0
-предполагается, что разделителем для элементов ввода является символ нуля
-(вместо пробела). Символы кавычек и обратной косой черты также считаются обычными символами, которые могут формировать допустимый ввод.
-Этот параметр также отключает строку конца файла (end-of-file string), она обрабатывается, как любой другой аргумент. Это полезно, если элементы ввода содержат пробелы, кавычки или обратные косые черты. Параметр 
-.B -print0
-GNU
-.B find
-производит ввод, подходящий для этого режима.
-
-.SH "АРГУМЕНТЫ"
-.TP
-.I spec_file
-Файл спецификации, содержащий строки следующего вида:
-.sp
-.RS
-.I regexp
-.RI [ type ]
-.IR context \ |
-.B <<none>>
-.RS
-Регулярное выражение привязывается с обоих концов. Необязательное поле
-.I type
-указывает тип файла (показывается в поле режима по команде
-.BR ls (1)
-), например,
-.B \-\-
-для соответствия только обычным файлам или
-.B \-d
-для соответствия только каталогам. 
-.I context
-может быть обычным контекстом безопасности или строкой
-.B <<none>>
-(чтобы указать, что контекст файла не следует изменять).
-.br
-Используется последняя соответствующая спецификация. Если на файл имеется несколько жёстких ссылок, которые соответствуют разным спецификациям, и эти спецификации означают разные контексты безопасности, будет показано предупреждение, но для файла всё равно будет проставлена метка на основе последней соответствующей спецификации, отличной от
-.BR <<none>> \|.
-.RE
-.RE
-.TP 
-.IR pathname \ ...
-Путь к корневому каталогу каждой файловой системы, в которой следует повторно проставить метки, или конкретный каталог в файловой системе, по которому следует рекурсивно спуститься и повторно проставить метки, или путь к файлу, для которого следует повторно проставить метку.
-Не используется, если используется параметр
-.B \-f
-или
-.B \-s .
-
-.SH "ПРИМЕЧАНИЯ"
-.IP "1." 4
-.B setfiles
-следует по символическим ссылкам и рекурсивно применяется к каталогам.
-.IP "2." 4
-Если в
-.I pathname
-указан корневой каталог, установлен параметр
-.B \-v
-, а также запущена система аудита, в журнал с меткой сообщения
-.BR FS_RELABEL
-автоматически записывается событие аудита, которое содержит сообщение о том, что произошло "массовое повторное проставление меток".
-.IP "3." 4
-Для повышения производительности при рекурсивном повторном проставлении меток в файловых системах используется параметр
-.B \-D
-команды
-.B setfiles .
-Он обеспечивает сохранение дайджеста SHA1 файла спецификации
-.B spec_file 
-в расширенном атрибуте с именем
-.IR security.restorecon_last
-для каталога, указанного в соответствующем пути
-.IR pathname \ ...
-, после успешного завершения повторного проставления меток. Этот дайджест будет проверен, если команда
-.B setfiles
-.B \-D
-будет перезапущена с теми же параметрами
-.I spec_file
-и
-.I pathname
-Подробные сведения доступны в
-.BR selinux_restorecon (3).
-.sp
-Параметр
-.B \-I
-позволяет игнорировать дайджест SHA1 из каждого каталога, указанного в 
-.IR pathname \ ...
-, и, при условии, что НЕ установлен параметр
-.B \-n
-, для файлов будут необходимым образом повторно проставлены метки, а дайджест затем будет обновлён (если не будет ошибок).
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR restorecon (8),
-.BR load_policy (8),
-.BR checkpolicy (8)
-
-.SH "АВТОРЫ"
-Эта man-страница была написана Russell Coker <russell@coker.com.au>.
-Программа была написана Stephen Smalley <stephen.smalley.work@gmail.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>
diff --git a/policycoreutils/setsebool/ru/setsebool.8 b/policycoreutils/setsebool/ru/setsebool.8
deleted file mode 100644
index 8a97b8ab..00000000
--- a/policycoreutils/setsebool/ru/setsebool.8
+++ /dev/null
@@ -1,27 +0,0 @@
-.TH "setsebool" "8" "11 августа 2004" "dwalsh@redhat.com" "Документация по командной строке SELinux"
-.SH "ИМЯ"
-setsebool \- установить значение логического переключателя SELinux
-
-.SH "ОБЗОР"
-.B setsebool
-.I "[ \-PNV ] boolean value | bool1=val1 bool2=val2 ..."
-
-.SH "ОПИСАНИЕ"
-.B setsebool 
-устанавливает текущее состояние отдельного логического переключателя SELinux или списка логических переключателей в указанное значение. Это значение может быть либо 1, true или on (включает логический переключатель), либо 0, false или off (отключает логический переключатель). 
-
-Если параметр \-P не указан, будет изменено только текущее значение логического переключателя; параметры загрузки по умолчанию останутся без изменений. 
-
-Если параметр \-P указан, все ожидающие значения записываются в файл политики на диске. Поэтому они не будут сбрасываться после перезагрузок.
-
-Если параметр \-N указан, политика на диске не перезагружается в ядро.
-
-Если параметр \-V указан, показываются подробные сообщения об ошибках из библиотек semanage.
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-getsebool(8), booleans(8), togglesebool(8), semanage(8)
-
-.SH АВТОРЫ
-Эта страница руководства была написана Dan Walsh <dwalsh@redhat.com>.
-Программа была написана Tresys Technology.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

