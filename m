Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05DEC04FE0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjHIQbP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHIQbM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:12 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878701986
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd0425ad4fso1800713a34.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598666; x=1692203466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNZJe5BcZdeIAmclBzZY2QTkBSbMr07Q7NGi421g0yY=;
        b=FC2H13TniB8gMEqYK+TenVsBd/8KhQFfR/Q0hEgdUTJnJkwL/kHD0ULFLZJhCQPY0c
         /csnHbNpEc0g9QEJiyuZRFquSyD8IENvWz/2hHyC4LHYQNlgYDleuCehv+TM2q+O1w7s
         VKmuIXn9dXhZAelvPsDUxDMhLH71zKO0jmpzQanGdoQTMq0goRDtko0jFSD95pUoreDP
         34+HpmocJJci80CbzjVlwklyx+IWw89ZDVvD1hKHWXe3vTYqqXavoQUpRUpgmYMgXUrK
         VVFwoBI4ZCisJOkn56q69JsfZNOy2u+JNVhP9Obmh8cx/z8YYHtLJHY33RAtmVBbOznk
         KVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598666; x=1692203466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNZJe5BcZdeIAmclBzZY2QTkBSbMr07Q7NGi421g0yY=;
        b=aBf3HEz9853m6795CZzR7e/4xinVVFO4aWQeWVPNbd0aQFbZ0nsghqebSYNQRzMjHl
         IrPPjqpvoxOE1zLhxliumuIvbR9Zc4YSMxKUGLPzIVL202Y5KKEL4u1I9J5K/Kbr5b/7
         XHtnRMKY7m/PGQlVM5PMUeTCWA5YVp1yvn66kUoAXs8/O+EExbp2KcmNHRPo9OakDPIL
         KEAX21yX/YD+ctewT3BsKO07Ywh/BHX8IH4tr6hn5CyPF8DUrjiAsGh0kTb4ic/OTgIr
         v+yf7JTm1AYgRxcuKP1vm3JoJAMHT7pqC0xT0iHkbsX0yhq0zGfbuFiji7AB67DFml0g
         1c+w==
X-Gm-Message-State: AOJu0Yy/XDuSrhg0QiDzwLQNWc6bpjnOvJapfD46sqVOvnsL+5bQmz7s
        Eh8vDTUuPa1x3edzaLjK9UEK/TXAzIU=
X-Google-Smtp-Source: AGHT+IHPKbJyIkAxpKWFcMlRwlyrEk2fVBysN8tSgrzNxBCH+FGvQS6c26RuZAVcVE9K2u+Pfg33mg==
X-Received: by 2002:a05:6808:8f2:b0:3a7:63e9:57af with SMTP id d18-20020a05680808f200b003a763e957afmr3427683oic.5.1691598665048;
        Wed, 09 Aug 2023 09:31:05 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:04 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 03/12] libselinux: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:48 -0400
Message-ID: <20230809163059.97671-3-jwcart2@gmail.com>
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
date, so remove them. Because of the size, this just removes the
man5 translations.

Suggested-by: Petr Lautrbach <plautrba@redhat.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/man/ru/man5/customizable_types.5   |  63 -----
 libselinux/man/ru/man5/default_contexts.5     |  75 ------
 libselinux/man/ru/man5/default_type.5         |  43 ----
 libselinux/man/ru/man5/failsafe_context.5     |  68 ------
 libselinux/man/ru/man5/file_contexts.5        |   1 -
 .../man/ru/man5/file_contexts.homedirs.5      |   1 -
 libselinux/man/ru/man5/file_contexts.local.5  |   1 -
 libselinux/man/ru/man5/file_contexts.subs.5   |   1 -
 .../man/ru/man5/file_contexts.subs_dist.5     |   1 -
 libselinux/man/ru/man5/media.5                |   1 -
 libselinux/man/ru/man5/removable_context.5    |  39 ----
 libselinux/man/ru/man5/secolor.conf.5         | 180 --------------
 libselinux/man/ru/man5/securetty_types.5      |  49 ----
 libselinux/man/ru/man5/selabel_db.5           | 219 ------------------
 libselinux/man/ru/man5/selabel_file.5         | 219 ------------------
 libselinux/man/ru/man5/selabel_media.5        |  92 --------
 libselinux/man/ru/man5/selabel_x.5            | 168 --------------
 libselinux/man/ru/man5/sepgsql_contexts.5     |   1 -
 libselinux/man/ru/man5/service_seusers.5      |  71 ------
 libselinux/man/ru/man5/seusers.5              |  67 ------
 libselinux/man/ru/man5/user_contexts.5        |  85 -------
 .../man/ru/man5/virtual_domain_context.5      |  44 ----
 .../man/ru/man5/virtual_image_context.5       |  46 ----
 libselinux/man/ru/man5/x_contexts.5           |   1 -
 24 files changed, 1536 deletions(-)
 delete mode 100644 libselinux/man/ru/man5/customizable_types.5
 delete mode 100644 libselinux/man/ru/man5/default_contexts.5
 delete mode 100644 libselinux/man/ru/man5/default_type.5
 delete mode 100644 libselinux/man/ru/man5/failsafe_context.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.homedirs.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.local.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.subs.5
 delete mode 100644 libselinux/man/ru/man5/file_contexts.subs_dist.5
 delete mode 100644 libselinux/man/ru/man5/media.5
 delete mode 100644 libselinux/man/ru/man5/removable_context.5
 delete mode 100644 libselinux/man/ru/man5/secolor.conf.5
 delete mode 100644 libselinux/man/ru/man5/securetty_types.5
 delete mode 100644 libselinux/man/ru/man5/selabel_db.5
 delete mode 100644 libselinux/man/ru/man5/selabel_file.5
 delete mode 100644 libselinux/man/ru/man5/selabel_media.5
 delete mode 100644 libselinux/man/ru/man5/selabel_x.5
 delete mode 100644 libselinux/man/ru/man5/sepgsql_contexts.5
 delete mode 100644 libselinux/man/ru/man5/service_seusers.5
 delete mode 100644 libselinux/man/ru/man5/seusers.5
 delete mode 100644 libselinux/man/ru/man5/user_contexts.5
 delete mode 100644 libselinux/man/ru/man5/virtual_domain_context.5
 delete mode 100644 libselinux/man/ru/man5/virtual_image_context.5
 delete mode 100644 libselinux/man/ru/man5/x_contexts.5

diff --git a/libselinux/man/ru/man5/customizable_types.5 b/libselinux/man/ru/man5/customizable_types.5
deleted file mode 100644
index e0015864..00000000
--- a/libselinux/man/ru/man5/customizable_types.5
+++ /dev/null
@@ -1,63 +0,0 @@
-.TH "customizable_types" "5" "28 ноября 2011" "Security Enhanced Linux" "SELinux configuration"
-.SH "ИМЯ"
-customizable_types \- файл конфигурации настраиваемых типов SELinux
-.
-.SH "ОПИСАНИЕ"
-Файл \fIcustomizable_types\fR содержит список типов, которые можно каким-либо образом настраивать с помощью поддерживающих SELinux приложений.
-.sp
-Обычно это тип контекста файла, который устанавливается для файлов, к которым требуется предоставить общий доступ для определённых доменов, и когда администратору необходимо управлять этим типом вручную.
-.sp
-Возможность использования настраиваемых типов устарела. Рекомендуется использовать
-.BR semanage (8)
-.BR fcontext (8)
-.BR ... (8).
-Тем не менее, поддерживающие SELinux приложения, например,
-.BR setfiles (8),
-будут использовать эту информацию для получения списка типов, относящихся к файлам, для которых не следует повторно проставлять метки.
-.sp
-.BR selinux_customizable_types_path (3)
-вернёт путь активной политики к этому файлу. Файл настраиваемых типов по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/customizable_types
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-.BR is_context_customizable (3)
-выполняет чтение этого файла, чтобы определить, является ли контекст настраиваемым для активной политики.
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка в файле состоит из следующих компонентов:
-.RS
-.I type
-.RE
-.sp
-Где:
-.RS
-.I type
-.RS
-Определённый в политике тип, который можно настроить.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/customizable_types
-.br
-mount_loopback_t
-.br
-public_content_rw_t
-.br
-public_content_t
-.br
-swapfile_t
-.br
-sysadm_untrusted_content_t
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selinux_customizable_types_path "(3), " is_context_customizable "(3), " semanage "(8), " setfiles "(8), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/default_contexts.5 b/libselinux/man/ru/man5/default_contexts.5
deleted file mode 100644
index ca1361d9..00000000
--- a/libselinux/man/ru/man5/default_contexts.5
+++ /dev/null
@@ -1,75 +0,0 @@
-.TH "default_contexts" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-default_contexts \- файл конфигурации контекстов SELinux по умолчанию
-.
-.SH "ОПИСАНИЕ"
-Файл конфигурации контекстов по умолчанию \fIdefault_contexts\fR содержит записи, которые позволяют поддерживающим SELinux приложениям для входа, например,
-.BR PAM "(8), настроить контекст пользователя. "
-.sp
-Поддерживающие SELinux приложения для входа обычно используют одну или несколько из следующих функций libselinux, которые выполняют чтение этих файлов по пути активной политики:
-.RS
-.BR get_default_context "(3) "
-.br
-.BR get_ordered_context_list "(3) "
-.br
-.BR get_ordered_context_list_with_level "(3) "
-.br
-.BR get_default_context_with_level "(3) "
-.br
-.BR get_default_context_with_role "(3) "
-.br
-.BR get_default_context_with_rolelevel "(3) "
-.br
-.BR query_user_context "(3) "
-.br
-.BR manual_user_enter_context "(3) "
-.RE
-.sp
-Путь к файлу конфигурации контекстов по умолчанию для активной политики возвращает \fBselinux_default_contexts_path\fR(3). По умолчанию файл контекстов по умолчанию находится по адресу:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/default_contexts
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка в файле конфигурации по умолчанию состоит из следующих компонентов:
-.RS
-.I login_process user_login_process [user_login_process] ...
-.RE
-.sp
-Где:
-.RS
-.I login_process
-.RS
-Состоит из записи \fIrole\fB:\fItype\fR[\fB:\fIrange\fR], которая представляет собой контекст процесса входа, определённый в политике.
-.RE
-.I user_login_process
-.RS
-Состоит из одной или нескольких записей \fIrole\fB:\fItype\fR[\fB:\fIrange\fR], которые представляют собой контекст процесса входа пользователя, определённый в политике.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/default_contexts
-.br
-system_r:crond_t:s0			 system_r:system_crond_t:s0
-.br
-system_r:local_login_t:s0	 user_r:user_t:s0 staff_r:staff_t:s0
-.br
-system_r:remote_login_t:s0	 user_r:user_t:s0
-.br
-system_r:sshd_t:s0			 user_r:user_t:s0
-.br
-system_r:sulogin_t:s0		 sysadm_r:sysadm_t:s0
-.br
-system_r:xdm_t:s0			 user_r:user_t:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selinux_default_contexts_path "(3), " PAM "(8), " selinux_default_type_path "(3), " get_default_context "(3), " get_ordered_context_list "(3), " get_ordered_context_list_with_level "(3), " get_default_context_with_level "(3), " get_default_context_with_role "(3), " get_default_context_with_rolelevel "(3), " query_user_context "(3), " manual_user_enter_context "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/default_type.5 b/libselinux/man/ru/man5/default_type.5
deleted file mode 100644
index 54e2c100..00000000
--- a/libselinux/man/ru/man5/default_type.5
+++ /dev/null
@@ -1,43 +0,0 @@
-.TH "default_type" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-default_type \- файл конфигурации типов SELinux по умолчанию
-.
-.SH "ОПИСАНИЕ"
-Файл \fIdefault_type\fR содержит записи, которые позволяют поддерживающим SELinux приложениям, таким как \fBnewrole\fR(1), выбирать для роли тип по умолчанию, если не предоставлен другой тип.
-.sp
-\fBselinux_default_type_path\fR(3) возвращает путь активной политики к этому файлу. По умолчанию файл типов по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/default_type
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-\fBget_default_type\fR(3) выполняет чтение этого файла, чтобы определить тип для активной политики.
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка внутри файла \fIdefault_type\fR форматируется записями \fIrole\fB:\fItype\fR, где:
-.RS
-.I role
-.RS
-Роль SELinux.
-.RE
-.I type
-.RS
-Тип домена, который возвращается для этой роли.
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/default_type
-.br
-auditadm_r:auditadm_t
-.br
-user_r:user_t
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " get_default_type "(3), " newrole "(1), " selinux_default_type_path "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/failsafe_context.5 b/libselinux/man/ru/man5/failsafe_context.5
deleted file mode 100644
index 54cecf39..00000000
--- a/libselinux/man/ru/man5/failsafe_context.5
+++ /dev/null
@@ -1,68 +0,0 @@
-.TH "failsafe_context" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-failsafe_context \- файл конфигурации резервного контекста SELinux
-.
-.SH "ОПИСАНИЕ"
-Файл
-.I failsafe_context
-позволяет поддерживающим SELinux приложениям, таким как
-.BR PAM "(8), "
-получать известный действительный контекст входа для администратора, если в других расположениях отсутствуют действительные записи по умолчанию.
-.sp
-.BR selinux_failsafe_context_path "(3) "
-возвращает путь активной политики к этому файлу. Файл резервного контекста по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/failsafe_context
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-Следующие функции выполняют чтение этого файла по пути активной политики, если им не удаётся получить контекст по умолчанию:
-.br
-.RS
-.BR get_default_context "(3) "
-.br
-.BR get_ordered_context_list "(3) "
-.br
-.BR get_ordered_context_list_with_level "(3) "
-.br
-.BR get_default_context_with_level "(3) "
-.br
-.BR get_default_context_with_role "(3) "
-.br
-.BR get_default_context_with_rolelevel "(3) "
-.br
-.BR query_user_context "(3) "
-.br
-.BR manual_user_enter_context "(3) "
-.RE
-.
-.SH "ФОРМАТ ФАЙЛА"
-Файл состоит из следующей однострочной записи:
-.RS
-\fIrole\fB:\fItype\fR[\fB:\fIrange\fR]
-.RE
-.sp
-Где:
-.RS
-.I role
-.I type
-.I range
-.RS
-Роль, тип и необязательный диапазон (для MCS/MLS), разделённые двоеточиями (:), которые формируют действительный контекст процесса входа для получения администратором доступа к системе.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/failsafe_context
-.br
-unconfined_r:unconfined_t:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selinux_failsafe_context_path "(3), " PAM "(8), " selinux_default_type_path "(3), " get_default_context "(3), " get_ordered_context_list "(3), " get_ordered_context_list_with_level "(3), " get_default_context_with_level "(3), " get_default_context_with_role "(3), " get_default_context_with_rolelevel "(3), " query_user_context "(3), " manual_user_enter_context "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/file_contexts.5 b/libselinux/man/ru/man5/file_contexts.5
deleted file mode 100644
index 9c022d8f..00000000
--- a/libselinux/man/ru/man5/file_contexts.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_file.5
diff --git a/libselinux/man/ru/man5/file_contexts.homedirs.5 b/libselinux/man/ru/man5/file_contexts.homedirs.5
deleted file mode 100644
index 9c022d8f..00000000
--- a/libselinux/man/ru/man5/file_contexts.homedirs.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_file.5
diff --git a/libselinux/man/ru/man5/file_contexts.local.5 b/libselinux/man/ru/man5/file_contexts.local.5
deleted file mode 100644
index 9c022d8f..00000000
--- a/libselinux/man/ru/man5/file_contexts.local.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_file.5
diff --git a/libselinux/man/ru/man5/file_contexts.subs.5 b/libselinux/man/ru/man5/file_contexts.subs.5
deleted file mode 100644
index 9c022d8f..00000000
--- a/libselinux/man/ru/man5/file_contexts.subs.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_file.5
diff --git a/libselinux/man/ru/man5/file_contexts.subs_dist.5 b/libselinux/man/ru/man5/file_contexts.subs_dist.5
deleted file mode 100644
index 9c022d8f..00000000
--- a/libselinux/man/ru/man5/file_contexts.subs_dist.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_file.5
diff --git a/libselinux/man/ru/man5/media.5 b/libselinux/man/ru/man5/media.5
deleted file mode 100644
index 14f00f28..00000000
--- a/libselinux/man/ru/man5/media.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_media.5
diff --git a/libselinux/man/ru/man5/removable_context.5 b/libselinux/man/ru/man5/removable_context.5
deleted file mode 100644
index 0d83ef26..00000000
--- a/libselinux/man/ru/man5/removable_context.5
+++ /dev/null
@@ -1,39 +0,0 @@
-.TH "removable_context" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-removable_context \- файл конфигурации SELinux-контекста съёмных устройств
-.
-.SH "ОПИСАНИЕ"
-Этот файл содержит метку по умолчанию, которую следует использовать для съёмных устройств.
-.sp
-.BR selinux_removable_context_path "(3) "
-вернёт путь активной политики к этому файлу. Файл контекста съёмных устройств по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/removable_context
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Файл состоит из следующей однострочной записи:
-.RS
-.IB user : role : type \fR[\fB:\fIrange\fR]
-.RE
-.sp
-Где:
-.RS
-.I user role type range
-.RS
-Пользователь, роль, тип и необязательный диапазон (для MCS/MLS), разделённые двоеточиями (:), которые будут применены к съёмным устройствам.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/removable_contexts
-.br
-system_u:object_r:removable_t:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR selinux "(8), " selinux_removable_context_path "(3), " selinux_config "(5) "
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/secolor.conf.5 b/libselinux/man/ru/man5/secolor.conf.5
deleted file mode 100644
index bcae80c1..00000000
--- a/libselinux/man/ru/man5/secolor.conf.5
+++ /dev/null
@@ -1,180 +0,0 @@
-.TH "secolor.conf" "5" "08 апреля 2011" "Документация API SELinux"
-.SH "ИМЯ"
-secolor.conf \- файл конфигурации цвета SELinux
-.
-.SH "ОПИСАНИЕ"
-Этот необязательный файл управляет цветом, который назначается компонентам контекста, связанным с контекстом 
-.I raw
-, который передаётся с помощью 
-.BR selinux_raw_context_to_color "(3),"
-когда поддерживающее SELinux приложение должно показать сведения о контексте в цвете. 
-.sp
-.BR selinux_raw_context_to_color "(3)"
-получает эту информацию о цвете из файла активной политики 
-.B secolor.conf
-, возвращённого 
-.BR selinux_colors_path "(3)."
-.
-.SH "ФОРМАТ ФАЙЛА"
-Формат файла:
-.RS
-.B color
-.I color_name
-.BI "= #"color_mask
-.br
-[...]
-.sp
-.I context_component string
-.B =
-.I fg_color_name bg_color_name
-.br
-[...]
-.sp 
-.RE
-
-Где:
-.br
-.B color
-.RS
-Ключевое слово цвета (color). Каждая запись цвета находится на новой строке.
-.RE
-.I color_name
-.RS
-Название цвета из одного слова (например, red (красный)).
-.RE
-.I color_mask
-.RS
-Маска цвета, начинающаяся с хэша (#), который описывает шестнадцатиричные RGB-цвета, где black (чёрный) #000000 и white (белый) #ffffff.
-.RE
-.I context_component
-.RS
-Имя компонента контекста, должно быть одним из следующих:
-.br
-.RS
-пользователь, роль, тип или диапазон 
-.RE
-Каждая запись
-.IR context_component " " string " ..."
-находится на новой строке.
-.RE
-.I string
-.RS
-Это строка 
-.I context_component
-, которая будет сопоставляться с компонентом контекста 
-.I raw
-, который передаётся
-.BR selinux_raw_context_to_color "(3)."
-.br
-Подстановочный знак '*' можно использовать для сопоставления какой-либо неопределённой строки только записям
-.I context_component
-пользователя, роли или типа.
-.RE
-
-.I fg_color_name
-.RS
-Строка color_name, которая будет использоваться как цвет переднего плана. Маска цвета
-.I color_mask
-также может использоваться.
-.RE
-.I bg_color_name
-.RS
-Строка color_name, которая будет использоваться как цвет фона. Маска цвета
-.I color_mask
-также может использоваться.
-.RE
-.
-.SH "ПРИМЕРЫ"
-Записи примера 1:
-.RS
-color black  = #000000
-.br
-color green  = #008000
-.br
-color yellow = #ffff00
-.br
-color blue   = #0000ff
-.br
-color white  = #ffffff
-.br
-color red    = #ff0000
-.br
-color orange = #ffa500
-.br
-color tan    = #D2B48C
-.sp
-user * = black white
-.br
-role * = white black
-.br
-type * = tan orange
-.br
-range s0\-s0:c0.c1023 = black green
-.br
-range s1\-s1:c0.c1023 = white green
-.br
-range s3\-s3:c0.c1023 = black tan
-.br
-range s5\-s5:c0.c1023 = white blue
-.br
-range s7\-s7:c0.c1023 = black red
-.br
-range s9\-s9:c0.c1023 = black orange
-.br
-range s15\-s15:c0.c1023   = black yellow
-.RE
-
-.sp
-Записи примера 2:
-.RS
-color black  = #000000
-.br
-color green  = #008000
-.br
-color yellow = #ffff00
-.br
-color blue   = #0000ff
-.br
-color white  = #ffffff
-.br
-color red    = #ff0000
-.br
-color orange = #ffa500
-.br
-color tan    = #d2b48c
-.sp
-user unconfined_u = #ff0000 green
-.br
-role unconfined_r = red #ffffff
-.br
-type unconfined_t = red orange
-.br
-user user_u       = black green
-.br
-role user_r       = white black
-.br
-type user_t       = tan red
-.br
-user xguest_u     = black yellow
-.br
-role xguest_r     = black red
-.br
-type xguest_t     = black green
-.br
-user sysadm_u     = white black
-.br
-range s0\-s0:c0.c1023 = black white
-.br
-user *            = black white
-.br
-role *            = black white
-.br
-type *            = black white
-.RE
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR selinux "(8), " selinux_raw_context_to_color "(3), " selinux_colors_path "(3)"
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/securetty_types.5 b/libselinux/man/ru/man5/securetty_types.5
deleted file mode 100644
index ce0aa324..00000000
--- a/libselinux/man/ru/man5/securetty_types.5
+++ /dev/null
@@ -1,49 +0,0 @@
-.TH "securetty_types" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-securetty_types \- файл конфигурации типа безопасного терминала (tty) SELinux
-.
-.SH "ОПИСАНИЕ"
-Файл
-.I securetty_types
-содержит список типов, связанных с типом безопасного tty, которые определены в политике для использования поддерживающими SELinux приложениями.
-.sp
-.BR selinux_securetty_types_path "(3) "
-вернёт путь активной политики к этому файлу. Файл типов securetty по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/securetty_types
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-.BR selinux_check_securetty_context "(3) выполняет чтение этого файла, чтобы определить, установлен ли в активной политике контекст для безопасного tty. "
-.sp
-Поддерживающие SELinux приложения, такие как
-.BR newrole "(1), используют эту информацию для проверки состояния tty. "
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка в файле состоит из следующей записи:
-.sp
-.RS
-.I type
-.RS
-Одна или несколько записей типов, которые определены в политике для безопасных устройств tty.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/securetty_types
-.br
-sysadm_tty_device_t
-.br
-user_tty_device_t
-.br
-staff_tty_device_t
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selinux_securetty_types_path "(3), " newrole "(1), " selinux_check_securetty_context "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/selabel_db.5 b/libselinux/man/ru/man5/selabel_db.5
deleted file mode 100644
index 1c667e83..00000000
--- a/libselinux/man/ru/man5/selabel_db.5
+++ /dev/null
@@ -1,219 +0,0 @@
-.\" Hey Emacs! This file is -*- nroff -*- source.
-.\"
-.\" Author: KaiGai Kohei <kaigai@ak.jp.nec.com> 2009
-.TH "selabel_db" "5" "01 декабря 2011" "Security Enhanced Linux" "Документация API SELinux"
-.SH "ИМЯ"
-selabel_db \- интерфейс проставления меток SELinux в пространстве пользователя и формат файла конфигурации для внутренней службы контекстов объектов RDBMS (реляционная СУБД)
-.
-.SH "ОБЗОР"
-.B #include <selinux/label.h>
-.sp
-.BI "int selabel_lookup(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" object_name ", int " object_type ");"
-.in
-.sp
-.BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" object_name ", int " object_type ");"
-.
-.SH "ОПИСАНИЕ"
-Внутренняя служба контекста базы данных сопоставляет имя и класс объекта с контекстами безопасности. Это действие позволяет найти правильный контекст для объектов базы данных при повторном проставлении меток для определённой базы данных. Необходимо освободить возвращённый \fIcontext\fR с помощью \fBfreecon\fR(3).
-.br
-\fBselabel_lookup\fR(3) описывает функцию с её возвращаемыми значениями и кодами ошибок.
-.sp
-\fIobject_name\fR должно быть полным именем, которое использует иерархию объектов базы данных. Например, таблица \fBpg_class\fR в базе данных \fBpostgres\fR и схема \fBpg_catalog\fR должны быть указаны следующим образом:
-.RS
-.B postgres.pg_catalog.pg_class
-.RE
-.sp
-В разделе \fBПРИМЕЧАНИЯ\fR доступны более подробные сведения о поддержке баз данных для иерархий пространства имён.
-.sp
-Для аргумента \fIobject_type\fR должно быть установлено одно из следующих значений:
-.RS
-.TP
-.B SELABEL_DB_DATABASE
-Аргумент
-.I object_name
-определяет имя самой базы данных, например, "postgres".
-.TP
-.B SELABEL_DB_SCHEMA
-Аргумент
-.I object_name
-определяет имя объекта схемы, например, "postgres.public".
-.TP
-.B SELABEL_DB_TABLE
-Аргумент
-.I object_name
-определяет имя объекта таблицы, например, "postgres.public.my_table"
-.TP
-.B SELABEL_DB_COLUMN
-Аргумент
-.I object_name
-определяет имя объекта столбца, например, "postgres.public.my_table.user_id"
-.TP
-.B SELABEL_DB_TUPLE
-Аргумент
-.I object_name
-определяет имя объекта таблицы, содержащей кортежи, для которых требуется повторно проставить метки, например, "postgresql.public.my_table". Следует учитывать, что нет способа идентифицировать отдельные объекты кортежа (за исключением условия WHERE для инструкций DML), потому что у них нет имён.
-.TP
-.B SELABEL_DB_PROCEDURE
-Аргумент
-.I object_name
-определяет имя объекта процедуры, например, "postgres.public.my_func". Следует учитывать, что поиск отдельных контекстов безопасности для процедур с одинаковыми именами, но разными аргументами не поддерживается.
-.TP
-.B SELABEL_DB_SEQUENCE
-Аргумент
-.I object_name
-определяет имя объекта последовательности, например, "postgres.public.my_seq".
-.TP
-.B SELABEL_DB_BLOB
-Аргумент
-.I object_name
-определяет имя большого объекта, например, "postgres.16308".
-Следует учитывать, что у большого объекта нет имени, поэтому он идентифицируется по значению соответствующего идентификатора.
-.TP
-.B SELABEL_DB_VIEW
-Аргумент
-.I object_name
-определяет имя объекта просмотра, например, "postgres.public.my_view".
-.TP
-.B SELABEL_DB_LANGUAGE
-Аргумент
-.I object_name
-определяет имя объекта языка, например, "postgres.public.tcl".
-.TP
-.B SELABEL_DB_EXCEPTION
-Аргумент
-.I object_name
-определяет имя объекта исключения.
-.TP
-.B SELABEL_DB_DATATYPE
-Аргумент
-.I object_name
-определяет имя объекта типа или домена, например, postgres.public.my_type.
-.RE
-.sp
-Все сообщения, созданные с помощью \fBselabel_lookup\fR(3), по умолчанию отправляются в \fIstderr\fR. Это поведение можно изменить с помощью \fBselinux_set_callback\fR(3).
-.sp
-.BR selabel_lookup_raw (3)
-работает аналогично \fBselabel_lookup\fR(3), но не выполняет преобразование контекста.
-.sp
-В разделе \fBФАЙЛЫ\fR приводится описание файлов конфигурации, которые используются для определения контекста объекта базы данных.
-.
-.SH "ПАРАМЕТРЫ"
-Помимо глобальных параметров, описание которых приведено в \fBselabel_open\fR(3), эта внутренняя служба распознаёт следующие параметры:
-.RS
-.TP
-.B SELABEL_OPT_PATH
-Значение этого параметра, отличное от null, определяет путь к файлу, который будет открыт вместо стандартного файла контекста базы данных.
-По умолчанию параметр пытается открыть файл спецификации, предназначенный для SE-PostgreSQL; если этот интерфейс используется другой реляционной СУБД, параметр должен явно объявить файл спецификации, предназначенный для такой реляционной СУБД (подробные сведения см. в разделе \fBФАЙЛЫ\fR).
-.RE
-.
-.SH "ФАЙЛЫ"
-То, какой файл контекстов базы данных будет использоваться для получения контекста, зависит от параметра \fBSELABEL_OPT_PATH\fR, переданного в \fBselabel_open\fR(3). Если \fINULL\fR, то значением \fBSELABEL_OPT_PATH\fR по умолчанию станет расположение контекстов базы данных активной политики (возвращённое \fBselinux_sepgsql_context_path\fR(3)). В ином случае будет использоваться фактическое указанное значение \fBSELABEL_OPT_PATH\fR (этот вариант необходимо использовать для поддержки баз данных, отличных от SE-PostgreSQL).
-.sp
-Файл контекстов объекта базы данных по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/sepgsql_context
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-Записи внутри файла контекстов базы данных показаны в разделах \fBЗначения строки имени объекта\fR и \fBФОРМАТ ФАЙЛА\fR.
-.
-.SH "Значения строки имени объекта"
-Имена строк, назначенные аргументам \fIobject_type\fR, которые могут присутствовать в файле контекстов базы данных:
-.TS
-center, allbox, tab(@);
-lI lB
-lB l .
-object_type@Текстовое имя
-SELABEL_DB_DATABASE@db_database
-SELABEL_DB_SCHEMA@db_schema
-SELABEL_DB_VIEW@db_view
-SELABEL_DB_LANGUAGE@db_language
-SELABEL_DB_TABLE@db_table
-SELABEL_DB_COLUMN@db_column
-SELABEL_DB_TUPLE@db_tuple
-SELABEL_DB_PROCEDURE@db_procedure
-SELABEL_DB_SEQUENCE@db_sequence
-SELABEL_DB_BLOB@db_blob
-SELABEL_DB_EXCEPTION@db_exception
-SELABEL_DB_DATATYPE@db_datatype
-.TE
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка внутри файла контекстов базы данных имеет следующий вид:
-.RS
-.I object_type object_name context
-.RE
-.sp
-Где:
-.RS
-.I object_type
-.RS
-Строковое представление типа объекта, показанное в разделе \fBЗначения строки имени объекта\fR.
-.RE
-.I object_name
-.RS
-Ключ, который используется для получения контекста на основе \fIobject_type\fR.
-.sp
-Запись может содержать подстановочные знаки '*' или '?' для выполнения сопоставления с дополнением или подстановкой.
-.sp
-Следует учитывать, что при использовании '*' важен порядок записей в файле. '*' в отдельном виде используется для того, чтобы обеспечить назначение резервного контекста по умолчанию, это должна быть последняя запись в блоке \fIobject_type\fR.
-.RE
-.I context
-.RS
-К объекту будет применён этот контекст безопасности.
-.RE
-.RE
-.sp
-Далее приведён пример для SE-PostgreSQL:
-.sp
-# ./contexts/sepgsql_contexts file
-.br
-# object_type  object_name   context
-.br
-db_database    my_database   system_u:object_r:sepgsql_db_t:s0
-.br
-db_database    *             system_u:object_r:sepgsql_db_t:s0
-.br
-db_schema      *.*           system_u:object_r:sepgsql_schema_t:s0
-.br
-db_tuple       row_low       system_u:object_r:sepgsql_table_t:s0
-.br
-db_tuple       row_high      system_u:object_r:sepgsql_table_t:s0:c1023
-.br
-db_tuple       *.*.*         system_u:object_r:sepgsql_table_t:s0
-.
-.SH "ПРИМЕЧАНИЯ"
-.IP "1." 4
-Для целевой реляционной СУБД необходимо записать подходящий файл контекстов базы данных и использовать для его загрузки параметр \fBSELABEL_OPT_PATH\fR в \fBselabel_open\fR(3).
-.IP "2." 4
-Иерархия пространства имён для объектов базы данных зависит от реляционной СУБД, но интерфейсы \fIselabel*\fR не предусматривают какой-либо особой поддержки иерархии пространства имён.
-.sp
-В иерархии пространства имён SE-PostgreSQL объектом верхнего уровня является база данных, объектом следующего уровня - схема. На следующем после объекта схемы уровне могут находиться другие типы объектов, например, таблицы и процедуры. Эта иерархия поддерживается следующим образом:
-.RS
-.RS
-.sp
-Если для таблицы "my_table" в схеме "public"
-внутри базы данных "postgres" требуется контекст безопасности, то параметрами \fBselabel_lookup\fR(3)
-для \fIobject_type\fR будет \fBSELABEL_DB_TABLE\fR, для \fIobject_name\fR - "postgres.public.my_table", контекст безопасности (если доступно) будет возвращён в \fIcontext\fR.
-.RE
-.RE
-.IP "3." 4
-Если контексты должны быть проверены, необходимо указать глобальный параметр  \fBSELABEL_OPT_VALIDATE\fR перед вызовом \fBselabel_open\fR(3). Если этот параметр не указан, может быть возвращён недействительный контекст.
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_sepgsql_context_path "(3), " freecon "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/selabel_file.5 b/libselinux/man/ru/man5/selabel_file.5
deleted file mode 100644
index 0857b9a7..00000000
--- a/libselinux/man/ru/man5/selabel_file.5
+++ /dev/null
@@ -1,219 +0,0 @@
-.\" Hey Emacs! This file is -*- nroff -*- source.
-.\"
-.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
-.TH "selabel_file" "5" "01 декабря 2011" "Security Enhanced Linux" "Документация API SELinux"
-.SH "ИМЯ"
-selabel_file \- интерфейс проставления меток SELinux в пространстве пользователя и формат файла конфигурации для внутренней службы контекстов файлов
-.
-.SH "ОБЗОР"
-.B #include <selinux/label.h>
-.sp
-.BI "int selabel_lookup(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" path ", int " mode ");"
-.in
-.sp
-.BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" path ", int " mode ");"
-.
-.SH "ОПИСАНИЕ"
-Внутренняя служба контекстов файлов сопоставляет сочетания 'путь/режим' с контекстами безопасности. Это действие служит для нахождения правильного контекста для каждого файла при повторном проставлении меток в файловой системе. Необходимо освободить возвращённый \fIcontext\fR с помощью \fBfreecon\fR(3).
-.br
-\fBselabel_lookup\fR(3) описывает функцию с её возвращаемыми значениями и кодами ошибок. Тем не менее, далее приводится более подробное описание следующих значений \fIerrno\fR для внутренней службы контекстов файлов:
-.RS
-.TP
-.B ENOENT
-Не найден контекст, соответствующий \fIpath\fR и \fImode\fR, - это сообщение будет возвращено и в том случае, если серия файлов контекстов файлов имеет контекст \fB<<none>>\fR относительно \fIpath\fR (см. раздел \fBФОРМАТ ФАЙЛА\fR).
-.RE
-.sp
-Аргумент \fIpath\fR должен быть установлен в полный путь к файлу, назначенный контекст которого проверяется. Аргумент \fImode\fR должен быть установлен в биты режима файла, как определено \fBlstat\fR(2). Аргумент \fImode\fR может быть нулевым, но в этом случае, возможно, не удастся установить полное соответствие.
-.sp
-Все сообщения, созданные с помощью \fBselabel_lookup\fR(3), по умолчанию отправляются в \fIstderr\fR. Это поведение можно изменить с помощью \fBselinux_set_callback\fR(3).
-.sp
-.BR selabel_lookup_raw (3)
-работает аналогично \fBselabel_lookup\fR(3), но не выполняет преобразование контекста.
-.sp
-В разделе \fBФАЙЛЫ\fR приводится описание файлов конфигурации, которые используются для определения контекста файла.
-.
-.SH "ПАРАМЕТРЫ"
-Помимо глобальных параметров, описание которых приведено в 
-.BR selabel_open (3),
-эта внутренняя служба распознаёт следующие параметры:
-.RS
-.TP
-.B SELABEL_OPT_PATH
-Значение этого параметра, отличное от null, определяет путь к файлу, который будет открыт вместо стандартного файла контекстов файлов. Это значение также используется как базовое имя для определения имён локальных файлов настройки.
-.TP
-.B SELABEL_OPT_BASEONLY
-Отличное от null значение этого параметра означает, что любую локальную настройку сопоставления контекста файла следует игнорировать.
-.TP
-.B SELABEL_OPT_SUBSET
-Отличное от null значение этого параметра интерпретируется как префикс пути, например, "/etc". Будут загружены только те спецификации контекстов файлов, первый компонент которых совпадает с указанным префиксом. Это может ускорить выполнение поиска, но, возможно, не удастся найти путь, который не начинается с указанного префикса. Данная оптимизация поиска больше не требуется (и устарела), вместо неё используется
-.I file_contexts.bin.
-.RE
-.
-.SH "ФАЙЛЫ"
-То, какие файлы контекстов файлов используются для получения контекста по умолчанию, зависит от параметра \fBSELABEL_OPT_PATH\fR, переданного в \fBselabel_open\fR(3). Если это \fINULL\fR, то \fBSELABEL_OPT_PATH\fR по умолчанию примет значение расположения контекстов файлов активной политики (которое возвращает \fBselinux_file_context_path\fR(3)), в ином случае будет использовано фактическое указанное значение \fBSELABEL_OPT_PATH\fR.
-.sp
-Если параметр \fBSELABEL_OPT_BASEONLY\fR задан, будут обрабатываться следующие файлы:
-.RS
-.IP "1." 4
-Обязательный файл контекстов файлов - это либо полное имя файла из \fISELABEL_OPT_PATH.value\fR, либо (если \fINULL\fR) путь, который возвращает \fBselinux_file_context_path\fR(3).
-.IP "2." 4
-Необязательные файлы для замены имён (файл для локального использования и файл для использования с дистрибутивами), которые присваивают псевдонимы пути для 'находящейся в памяти' версии файла контекстов файлов.
-.br
-Эти файлы имеют то же имя, что и у обязательного файла контекстов файлов, и расширения \fI.subs\fR и \fI.subs_dist\fR.
-.RE
-.sp
-Если параметр \fBSELABEL_OPT_BASEONLY\fR не задан, будут обработаны следующие файлы:
-.RS
-.IP "1." 4
-Обязательный файл контекстов файлов, который является либо полным именем файла из \fISELABEL_OPT_PATH.value\fR, либо (если \fINULL\fR) путём, который возвращает \fBselinux_file_context_path\fR(3).
-.IP "2." 4
-Необязательный файл локальной настройки, имеющий то же имя, что и обязательный файл контекстов файлов, и расширение \fI.local\fR.
-.br
-\fBselinux_file_context_local_path\fR(3) вернёт путь по умолчанию к этому файлу.
-.IP "3." 4
-Необязательный файл настройки домашнего каталога пользователя, имеющий то же имя, что и обязательный файл контекстов файлов, и расширение \fI.homedirs\fR.
-.br
-\fBselinux_file_context_homedir_path\fR(3) вернёт путь по умолчанию к этому файлу.
-.IP "4." 4
-Необязательные файлы для замены имён (файл для локального использования и файл для использования с дистрибутивами), которые присваивают псевдонимы пути для 'находящейся в памяти' версии файла контекстов файлов (и \fI.local\fR и/или \fI.homedirs\fR, если они имеются). Эти файлы имеют то же имя, что и обязательный файл контекстов файлов, и расширения \fI.subs\fR и \fI.subs_dist\fR.
-.br
-\fBselinux_file_context_subs_path\fR(3) и \fBselinux_file_context_subs_dist_path\fR(3) вернут пути по умолчанию к этим файлам.
-.RE
-.sp
-По умолчанию серия файлов контекстов файлов:
-.RS 6
-.I /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts
-.br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.local
-.br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.homedirs
-.br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs
-.br
-.I  /etc/selinux/{SELINUXTYPE}/contexts/files/file_contexts.subs_dist
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-Обязательным является только файл \fIfile_contexts\fR, все остальные являются необязательными.
-.sp
-Записи внутри серии файлов контекстов файлов показаны в разделе \fBФОРМАТ ФАЙЛА\fR.
-.
-.SH "ФОРМАТ ФАЙЛА"
-.sp
-.SH "Формат контекстов файлов"
-.sp
-Каждая строка внутри \fIfile_contexts\fR и двух файлов настройки (\fI.local\fR и \fI.homedirs\fR) имеет следующий вид:
-.sp
-.RS
-.I pathname [file_type] context
-.RE
-.sp
-Где:
-.br
-.RS
-.I pathname
-.RS
-Определяющая имя пути запись, которая может быть в виде регулярного выражения.
-.RE
-.I file_type
-.RS
-Необязательный тип файла, который состоит из:
-.RS
-\fI\-b\fR - устройство блочного ввода-вывода      \fI\-c\fR - устройство символьного ввода-вывода
-.br
-\fI\-d\fR - каталог                               \fI\-p\fR - именованный канал
-.br
-\fI\-l\fR - символическая ссылка                  \fI\-s\fR - сокет
-.br
-\fI\-\-\fR - обычный файл
-.RE
-.RE
-.I context
-.RS
-Запись может быть одним из следующих:
-.RS
-.IP "a." 4
-Контекст безопасности, который будет назначен этому файлу (то есть возвращён как \fIcontext\fR).
-.IP "b." 4
-Значение \fB<<none>>\fR можно использовать, чтобы указать, что для соответствующих файлов не следует повторно проставлять метки, а также при этом значении \fBselabel_lookup\fR(3) вернёт \-1 при установке \fIerrno\fR в \fBENOENT\fR.
-.RE
-.RE
-.RE
-.sp
-Пример:
-.RS
-# ./contexts/files/file_contexts
-.br
-# pathname file_type  context
-.br
-/.*                   system_u:object_r:default_t:s0
-.br
-/[^/]+        \-\-      system_u:object_r:etc_runtime_t:s0
-.br
-/tmp/.*               <<none>>
-.RE
-.sp
-.SH "Формат файла подстановки"
-.sp
-Каждая строка внутри файлов подстановки (\fI.subs\fR и \fI.subs_dist\fR) имеет вид:
-.RS
-.I subs_pathname pathname
-.RE
-.sp
-Где:
-.RS
-.I pathname
-.RS
-Путь, который соответствует записи в одном или нескольких файлах конфигурации политики контекстов файлов.
-.RE
-.I subs_pathname
-.RS
-Путь, который станет псевдонимом имени пути (считается равнозначным при поиске).
-.RE
-.RE
-.sp
-Пример:
-.RS
-# ./contexts/files/file_contexts.subs
-.br
-# pathname  subs_pathname
-.br
-/myweb      /var/www
-.br
-/myspool    /var/spool/mail
-.sp
-Пример выше: когда в \fBselabel_lookup\fR(3) передаётся путь \fI/myweb/index.html\fR, функция заменяет компонент \fI/myweb\fR
-на \fI/var/www\fR, поэтому будет использоваться следующий путь:
-.sp
-.RS
-.I /var/www/index.html
-.RE
-.RE
-.
-.SH "ПРИМЕЧАНИЯ"
-.IP "1." 4
-Если контексты должны быть проверены, необходимо указать глобальный параметр \fBSELABEL_OPT_VALIDATE\fR перед вызовом \fBselabel_open\fR(3). Если этот параметр не указан, может быть возвращён недействительный контекст.
-.IP "2." 4
-Если серия файлов контекстов файлов содержит много записей, \fBselabel_open\fR(3) может медленно выполнять чтение в файлах и (если это запрошено) проверку записей.
-.IP "3." 4
-В некоторых версиях SELinux также может присутствовать файл \fIfile_contexts.template\fR, но он устарел.
-.br
-Файл шаблона имеет тот же формат, что и файл \fIfile_contexts\fR, а также может содержать ключевые слова \fBHOME_ROOT\fR, \fBHOME_DIR\fR, \fBROLE\fR и \fBUSER\fR. Эта функциональность была перемещена в хранилище политик и управляется \fBsemodule\fR(8) и \fBgenhomedircon\fR(8).
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_file_context_path "(3), " freecon "(3), " selinux_config "(5), " lstat "(2), "selinux_file_context_subs_path "(3), " selinux_file_context_subs_dist_path "(3), " selinux_file_context_homedir_path "(3), "selinux_file_context_local_path "(3), " semodule "(8), " genhomedircon "(8) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/selabel_media.5 b/libselinux/man/ru/man5/selabel_media.5
deleted file mode 100644
index 9fec7b0c..00000000
--- a/libselinux/man/ru/man5/selabel_media.5
+++ /dev/null
@@ -1,92 +0,0 @@
-.\" Hey Emacs! This file is -*- nroff -*- source.
-.\"
-.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
-.TH "selabel_media" "5" "29 ноября 2011" "Security Enhanced Linux" "Документация API SELinux"
-.SH "ИМЯ"
-selabel_media \- интерфейс проставления меток SELinux в пространстве пользователя и формат файла конфигурации для внутренней службы контекстов носителей
-.
-.SH "ОБЗОР"
-.B #include <selinux/label.h>
-.sp
-.BI "int selabel_lookup(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" device_name ", int " unused ");"
-.in
-.sp
-.BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" device_name ", int " unused ");"
-.
-.SH "ОПИСАНИЕ"
-Внутренняя служба контекстов носителей сопоставляет имена устройств мультимедиа, например, "cdrom" или "floppy", с контекстами безопасности. Это действие служит для нахождения правильного контекста для установки контекстных подключений к этим устройствам. Необходимо освободить возвращённый \fIcontext\fR с помощью \fBfreecon\fR(3).
-.br
-\fBselabel_lookup\fR(3) описывает функцию с её возвращаемыми значениями и кодами ошибок.
-.sp
-Аргумент поиска целого числа в настоящее время не используется, для него следует указать равное нулю значение.
-.sp
-Все сообщения, созданные с помощью \fBselabel_lookup\fR(3), по умолчанию отправляются в \fIstderr\fR. Это поведение можно изменить с помощью \fBselinux_set_callback\fR(3).
-.sp
-.BR selabel_lookup_raw (3)
-работает аналогично \fBselabel_lookup\fR(3), но не выполняет преобразование контекста.
-.sp
-В разделе \fBФАЙЛЫ\fR приводится описание файлов конфигурации, которые используются для определения контекстов носителей.
-.
-.SH "ПАРАМЕТРЫ"
-Помимо глобальных параметров, описание которых приведено в \fBselabel_open\fR(3), эта внутренняя служба распознаёт следующие параметры:
-.TP
-.B SELABEL_OPT_PATH
-Значение этого параметра, отличное от null, определяет путь к файлу, который будет открыт вместо стандартного файла контекстов носителей \fImedia\fR.
-.
-.SH "ФАЙЛЫ"
-То, какой файл контекстов носителей будет использоваться для получения контекста по умолчанию, зависит от параметра \fBSELABEL_OPT_PATH\fR, переданного в \fBselabel_open\FR(3). Если это \fINULL\fR, то значением \fBSELABEL_OPT_PATH\fR по умолчанию станет расположение контекстов носителей активной политики (возвращённое  \fBselinux_media_context_path\fR(3)). В ином случае будет использовано фактическое указанное значение \fBSELABEL_OPT_PATH\fR.
-.sp
-Файл контекстов носителей по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/files/media
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка внутри файла \fImedia\fR имеет следующий вид:
-.RS
-.I device_name context
-.RE
-.sp
-Где:
-.RS
-.I device_name
-.RS
-Идентификатор носителя (например, cdrom, floppy, disk и usb).
-.RE
-.I context
-.RS
-Контекст, который следует использовать для проставления метки устройства.
-.RE
-.RE
-.sp
-Пример:
-.RS
-# contexts/files/media
-.br
-cdrom system_u:object_r:removable_device_t
-.br
-floppy system_u:object_r:removable_device_t
-.br
-disk system_u:object_r:fixed_disk_device_t
-.
-.SH "ПРИМЕЧАНИЯ"
-Если контексты должны быть проверены, необходимо указать глобальный параметр  \fBSELABEL_OPT_VALIDATE\fR перед вызовом \fBselabel_open\fR(3). Если этот параметр не указан, может быть возвращён недействительный контекст.
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_media_context_path "(3), " freecon "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/selabel_x.5 b/libselinux/man/ru/man5/selabel_x.5
deleted file mode 100644
index 969ce1e0..00000000
--- a/libselinux/man/ru/man5/selabel_x.5
+++ /dev/null
@@ -1,168 +0,0 @@
-.\" Hey Emacs! This file is -*- nroff -*- source.
-.\"
-.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2007
-.TH "selabel_x" "5" "29 ноября 2011" "Security Enhanced Linux" "Документация API SELinux"
-.SH "ИМЯ"
-selabel_x \- интерфейс проставления меток SELinux в пространстве пользователя и формат файла конфигурации для внутренней службы контекстов оконной системы X Window System. Эта внутренняя служба также используется для определения контекста по умолчанию, который следует присвоить подключённым удалённо клиентам X
-.
-.SH "ОБЗОР"
-.B #include <selinux/label.h>
-.sp
-.BI "int selabel_lookup(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" object_name ", int " object_type ");"
-.in
-.sp
-.BI "int selabel_lookup_raw(struct selabel_handle *" hnd ,
-.in +\w'int selabel_lookup('u
-.BI "char **" context ,
-.br
-.BI "const char *" object_name ", int " object_type ");"
-.
-.SH "ОПИСАНИЕ"
-Внутренняя служба контекстов X сопоставляет имена объектов X Window System с контекстами безопасности. Это действие служит для нахождения правильного контекста для объектов X Window System, значимость и/или семантика использования которых в основном определяются именем. Необходимо освободить возвращённый \fIcontext\fR с помощью \fBfreecon\fR(3).
-.br
-\fBselabel_lookup\fR(3) описывает функцию с её возвращаемыми значениями и кодами ошибок.
-.sp
-Эта внутренняя служба также используется для определения контекста по умолчанию, который следует назначить для подключённых удалённо клиентов X.
-.sp
-Для аргумента \fIobject_type\fR необходимо установить одно из следующих значений:
-.RS
-.TP
-.B SELABEL_X_PROP
-Аргумент
-.I object_name
-указывает имя свойства окна, например, "WM_NAME".
-.TP
-.B SELABEL_X_SELN
-Аргумент
-.I object_name
-указывает имя выделения, например, "PRIMARY".
-.TP
-.B SELABEL_X_EXT
-Аргумент
-.I object_name
-указывает имя расширения протокола, например, "RENDER".
-.TP
-.B SELABEL_X_EVENT
-Аргумент
-.I object_name
-указывает имя типа события, например, "X11:ButtonPress".
-.TP
-.B SELABEL_X_CLIENT
-Аргумент
-.I object_name
-игнорируется, но его значением необходимо установить либо \fI*\fR (звёздочка, 'подстановочный знак': будет выбрана запись по умолчанию), либо конкретную запись, такую как "remote" в файле контекстов X, как показано в разделе \fBПРИМЕР\fR. В этом случае будет возвращён контекст по умолчанию, который следует присвоить удалённым клиентам X.
-.TP
-.B SELABEL_X_POLYPROP
-Работает аналогично
-.BR SELABEL_X_PROP ,
-но проверяет, было ли свойство отмечено как многоэкземплярное. См. \fBПРИМЕЧАНИЯ\fR далее.
-.TP
-.B SELABEL_X_POLYSELN
-Аналогично
-.BR SELABEL_X_SELN ,
-но проверяет, было ли выделение отмечено как многоэкземплярное. См. \fBПРИМЕЧАНИЯ\fR далее.
-.RE
-.sp
-Все сообщения, созданные \fBselabel_lookup\fR(3), по умолчанию отправляются в \fIstderr\fR. Это поведение можно изменить с помощью \fBselinux_set_callback\fR(3).
-.sp
-.B selabel_lookup_raw
-работает аналогично \fBselabel_lookup\fR, но не выполняет преобразование контекста.
-.sp
-В разделе \fBФАЙЛЫ\fR приводится описание файлов конфигурации, которые используются для определения контекстов объектов Х.
-.
-.SH "ПАРАМЕТРЫ"
-Помимо глобальных параметров, описание которых приведено в \fBselabel_open\fR(3), эта внутренняя служба распознаёт следующие параметры:
-.RS
-.TP
-.B SELABEL_OPT_PATH
-Значение этого параметра, отличное от null, определяет путь к файлу, который будет открыт вместо стандартного файла контекстов Х (подробные сведения см. в разделе \fBФАЙЛЫ\fR).
-.RE
-.
-.SH "ФАЙЛЫ"
-То, какой файл контекста Х будет использоваться для получения контекста по умолчанию, зависит от параметра \fBSELABEL_OPT_PATH\fR, переданного в \fBselabel_open\fR(3). Если \fINULL\fR, то значением \fBSELABEL_OPT_PATH\fR по умолчанию станет расположение контекстов Х активной политики (возвращённое \fBselinux_x_context_path\fR(3)). В ином случае будет использовано фактическое указанное значение \fBSELABEL_OPT_PATH\fR.
-.sp
-Файл контекстов объектов Х по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/x_contexts
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-Записи, находящиеся внутри файла контекстов X, показаны в разделах \fBЗначения строки имени объекта\fR и \fBФОРМАТ ФАЙЛА\fR.
-.
-.SH "Значения строки имени объекта"
-Имена строк, назначенные аргументам \fIobject_type\fR, которые могут присутствовать в файле контекстов X:
-.TS
-center, allbox, tab(@);
-lI lB
-lB l .
-object_type@Текстовое имя
-SELABEL_X_PROP@property
-SELABEL_X_SELN@selection
-SELABEL_X_EXT@extension
-SELABEL_X_EVENT@event
-SELABEL_X_CLIENT@client
-SELABEL_X_POLYPROP@poly_property
-SELABEL_X_POLYSELN@poly_selection
-.TE
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка внутри файла контекстов X имеет следующий вид:
-.RS
-.I object_type object_name context
-.RE
-.sp
-Где:
-.RS
-.I object_type
-.RS
-Это строковое представление типа объекта, показанное в разделе \fBЗначения строки имени объекта\fR.
-Несколько строк с одной и той же строкой \fIobject_type\fR сформируют блок записей (каждая со своей строкой \fIobject_name\fR).
-.RE
-.I object_name
-.RS
-Это имена объектов конкретного ресурса сервера X, например,
-\fBPRIMARY\fR, \fBCUT_BUFFER0\fR и т.д. Обычно они определены в исходном коде сервера  X (\fIprotocol.txt\fR и \fIBuiltInAtoms\fR в каталоге
-dix исходного пакета xorg\-server).
-Запись может содержать подстановочные знаки '*' или '?' для выполнения сопоставления с дополнением или подстановкой.
-Следует учитывать, что при использовании '*' важен порядок записей в файле. '*' в отдельном виде используется для того, чтобы обеспечить назначение резервного контекста по умолчанию, это должна быть последняя запись в блоке \fIobject_type\fR.
-.RE
-.I context
-.RS
-Контекст безопасности, который будет применён к объекту.
-.RE
-.RE
-.sp
-Пример 1:
-.sp
-.nf
-# object_type  object_name  context
-selection      PRIMARY      system_u:object_r:clipboard_xselection_t:s0
-selection      *            system_u:object_r:xselection_t:s0
-.fi
-.sp
-Пример 2 - этот пример показывает, как можно настроить запись клиента таким образом, чтобы она всегда находилась:
-.sp
-.nf
-# object_type  object_name  context
-client         *            system_u:object_r:remote_t:s0
-.fi
-.
-.SH "ПРИМЕЧАНИЯ"
-.IP "1." 4
-Свойства и выделения отмечаются как многоэкземплярные или нет. Для этих типов имён параметр "POLY" выполняет поиск только имён, которые отмечены как многоэкземплярные, в то время как другой параметр выполняет поиск только имён, которые отмечены как не многоэкземплярные. Пользователям этого интерфейса следует проверить оба сопоставления и затем (необязательно) действовать на основе полученного результата (например, сделать объект многоэкземплярным).
-.IP "2." 4
-Если контексты должны быть проверены, необходимо указать глобальный параметр  \fBSELABEL_OPT_VALIDATE\fR перед вызовом \fBselabel_open\fR(3). Если этот параметр не указан, может быть возвращён недействительный контекст.
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selabel_open "(3), " selabel_lookup "(3), " selabel_stats "(3), " selabel_close "(3), " selinux_set_callback "(3), " selinux_x_context_path "(3), " freecon "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/sepgsql_contexts.5 b/libselinux/man/ru/man5/sepgsql_contexts.5
deleted file mode 100644
index ec2bb47d..00000000
--- a/libselinux/man/ru/man5/sepgsql_contexts.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_db.5
diff --git a/libselinux/man/ru/man5/service_seusers.5 b/libselinux/man/ru/man5/service_seusers.5
deleted file mode 100644
index fe57ed69..00000000
--- a/libselinux/man/ru/man5/service_seusers.5
+++ /dev/null
@@ -1,71 +0,0 @@
-.TH "service_seusers" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-service_seusers \- файлы конфигурации сопоставления пользователей и служб GNU/Linux с пользователями SELinux
-.
-.SH "ОПИСАНИЕ"
-Это необязательные файлы, которые позволяют службам определять пользователя SELinux при аутентификации через поддерживающие SELinux приложения для входа, например,
-.BR PAM "(8). "
-.sp
-Для каждого имени пользователя GNU/Linux имеется один файл, который потребуется для запуска службы с определённым именем пользователя SELinux.
-.sp
-Путь к каждому файлу конфигурации формируется путём, который был возвращён
-.BR selinux_policy_root "(3), с добавлением  "
-.IR /logins/username
-в конце (где \fIusername\fR - это файл, представляющий имя пользователя GNU/Linux). Каталог служб по умолчанию расположен по следующему адресу:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/logins
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-.BR getseuser "(3) выполняет чтение этого файла для сопоставления служб с пользователем SELinux. "
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка внутри файла \fIusername\fR имеет следующий формат, каждый компонент отделяется двоеточием:
-.RS
-.IB service : seuser \fR[\fB:\fIrange\fR]
-.RE
-.sp
-Где:
-.RS
-.I service
-.RS
-Имя службы, которая используется приложением.
-.RE
-.I seuser
-.RS
-Имя пользователя SELinux.
-.RE
-.I range
-.RS
-Диапазон для политики MCS/MLS.
-.RE
-.RE
-.
-.SH "ПРИМЕРЫ"
-Пример 1 - для пользователя 'root':
-.RS
-# ./logins/root
-.br
-ipa:user_u:s0
-.br
-this_service:unconfined_u:s0
-.RE
-.sp
-Пример 2 - для пользователя GNU/Linux 'rch':
-.RS
-# ./logins/rch
-.br
-ipa:unconfined_u:s0
-.br
-that_service:unconfined_u:s0
-.RE
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " PAM "(8), " selinux_policy_root "(3), " getseuser "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/seusers.5 b/libselinux/man/ru/man5/seusers.5
deleted file mode 100644
index f8296530..00000000
--- a/libselinux/man/ru/man5/seusers.5
+++ /dev/null
@@ -1,67 +0,0 @@
-.TH "seusers" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-seusers \- файл конфигурации сопоставления пользователей GNU/Linux с пользователями SELinux
-.
-.SH "ОПИСАНИЕ"
-Файл
-.I seusers
-содержит список сопоставления пользователей GNU/Linux с пользователями SELinux, который используется поддерживающими SELinux приложениями для входа, например, \fBPAM\fR(8).
-.sp
-.BR selinux_usersconf_path "(3) "
-вернёт путь активной политики к этому файлу. Файл сопоставления пользователей SELinux по умолчанию находится по следующему адресу:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/seusers
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-.BR getseuserbyname "(3) выполняет чтение этого файла для сопоставления пользователя или группы GNU/Linux с пользователем SELinux. "
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка файла конфигурации
-.I seusers
-состоит из следующих компонентов:
-.sp
-.RS
-\fR[\fB%\fIgroup_id\fR]|[\fIuser_id\fR]\fB:\fIseuser_id\fR[\fB:\fIrange\fR]
-.RE
-.sp
-Где:
-.RS
-\fIgroup_id\fR|\fIuser_id
-.RS
-\fRИдентификатор пользователя GNU/Linux или (если предваряется символом процентного значения (\fB%\fR)) идентификатор группы GNU/Linux.
-.br
-При необходимости в качестве резервной записи можно предоставить необязательную запись, установленную в \fB__default__\fR.
-.RE
-.I seuser_id
-.RS
-Идентификатор пользователя SELinux.
-.RE
-.I range
-.RS
-Необязательный уровень или диапазон для политики MLS/MCS.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./seusers
-.br
-system_u:system_u:s0\-s15:c0.c255
-.br
-root:root:s0\-s15:c0.c255
-.br
-fred:user_u:s0
-.br
-__default__:user_u:s0
-.br
-%user_group:user_u:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " PAM "(8), " selinux_usersconf_path "(3), " getseuserbyname "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/user_contexts.5 b/libselinux/man/ru/man5/user_contexts.5
deleted file mode 100644
index de3a8bd8..00000000
--- a/libselinux/man/ru/man5/user_contexts.5
+++ /dev/null
@@ -1,85 +0,0 @@
-.TH "user_contexts" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-user_contexts \- файлы конфигурации SELinux-контекстов пользователей SELinux
-.
-.SH "ОПИСАНИЕ"
-Эти необязательные файлы конфигурации контекстов пользователей содержат записи, которые позволяют поддерживающим SELinux приложениям для входа, например,
-.BR PAM (8)
-(запущенным в своих собственных контекстах процессов), определять контекст, в котором должен запускаться сеанс пользователя.
-.sp
-Обычно поддерживающие SELinux приложения для входа используют одну или несколько следующих функций libselinux, которые выполняют чтение этих файлов по пути активной политики:
-.RS
-.BR get_default_context (3)
-.br
-.BR get_ordered_context_list (3)
-.br
-.BR get_ordered_context_list_with_level (3)
-.br
-.BR get_default_context_with_level (3)
-.br
-.BR get_default_context_with_role (3)
-.br
-.BR get_default_context_with_rolelevel (3)
-.br
-.BR query_user_context (3)
-.br
-.BR manual_user_enter_context (3)
-.RE
-.sp
-Для каждого пользователя SELinux можно настроить только один файл. Путь к файлу формируется с помощью пути, возвращённого
-.BR \%selinux_user_contexts_path (3)
-для активной политики, с добавлением в конце имени пользователя SELinux, например:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/users/unconfined_u
-.br
-.I /etc/selinux/{SELINUXTYPE}/contexts/users/xguest_u
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.sp
-Эти файлы содержат информацию о контексте в соответствии с описанием в разделе
-.B ФОРМАТ ФАЙЛА.
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка в файле конфигурации контекста пользователя состоит из следующих компонентов:
-.RS
-.I login_process user_login_process
-.RE
-.sp
-Где:
-.RS
-.I login_process
-.RS
-Состоит из записи \fIrole\fB:\fItype\fR[\fB:\fIrange\fR], которая представляет собой контекст процесса входа.
-.RE
-.I user_login_process
-.RS
-Состоит из записи \fIrole\fB:\fItype\fR[\fB:\fIrange\fR], которая представляет собой контекст процесса входа пользователя.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# Пример для xguest_u в /etc/selinux/targeted/contexts/users/xguest_u
-.br
-system_r:crond_t:s0			xguest_r:xguest_t:s0
-.br
-system_r:initrc_t:s0		xguest_r:xguest_t:s0
-.br
-system_r:local_login_t:s0	xguest_r:xguest_t:s0
-.br
-system_r:remote_login_t:s0	xguest_r:xguest_t:s0
-.br
-system_r:sshd_t:s0			xguest_r:xguest_t:s0
-.br
-system_r:xdm_t:s0			xguest_r:xguest_t:s0
-.br
-xguest_r:xguest_t:s0		xguest_r:xguest_t:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " selinux_user_contexts_path "(3), " PAM "(8), "  get_ordered_context_list "(3), " get_ordered_context_list_with_level "(3), " get_default_context_with_level "(3), " get_default_context_with_role "(3), " get_default_context_with_rolelevel "(3), " query_user_context "(3), " manual_user_enter_context "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/virtual_domain_context.5 b/libselinux/man/ru/man5/virtual_domain_context.5
deleted file mode 100644
index 617eeeca..00000000
--- a/libselinux/man/ru/man5/virtual_domain_context.5
+++ /dev/null
@@ -1,44 +0,0 @@
-.TH "virtual_domain_context" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-virtual_domain_context \- файл конфигурации SELinux-контекста домена виртуальной машины 
-.
-.SH "ОПИСАНИЕ"
-Файл
-.I virtual_domain_context
-содержит список контекстов доменов, которые доступны для использования поддерживающему SELinux API виртуализации libvirt (см. \fBlibvirtd\fR(8)).
-.sp
-.BR selinux_virtual_domain_context_path "(3) "
-вернёт путь активной политики к этому файлу. Файл контекстов виртуальных доменов по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/virtual_domain_context
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка в файле состоит из записи следующего вида:
-.RS
-.IB user : role : type \fR[\fB:\fIrange\fR]
-.RE
-.sp
-Где:
-.RS
-.I user role type range
-.RS
-Пользователь, роль, тип и необязательный диапазон (для MCS/MLS), разделённые двоеточиями (:), которые могут использоваться в качестве контекста виртуального домена.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/virtual_domain_context
-.br
-system_u:object_r:svirt_t:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " libvirtd "(8), " selinux_virtual_domain_context_path "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/virtual_image_context.5 b/libselinux/man/ru/man5/virtual_image_context.5
deleted file mode 100644
index 560229fa..00000000
--- a/libselinux/man/ru/man5/virtual_image_context.5
+++ /dev/null
@@ -1,46 +0,0 @@
-.TH "virtual_image_context" "5" "28 ноября 2011" "Security Enhanced Linux" "Конфигурация SELinux"
-.SH "ИМЯ"
-virtual_image_context \- файл конфигурации SELinux-контекста образа виртуальной машины
-.
-.SH "ОПИСАНИЕ"
-Файл
-.I virtual_image_context
-содержит список контекстов образов для использования поддерживающим SELinux API виртуализации libvirt (см. \fBlibvirtd\fR(8)).
-.sp
-.BR selinux_virtual_image_context_path "(3) "
-вернёт путь активной политики к этому файлу. Файл контекстов виртуальных образов по умолчанию:
-.RS
-.I /etc/selinux/{SELINUXTYPE}/contexts/virtual_image_context
-.RE
-.sp
-Где \fI{SELINUXTYPE}\fR - запись из файла конфигурации selinux \fIconfig\fR (см. \fBselinux_config\fR(5)).
-.
-.SH "ФОРМАТ ФАЙЛА"
-Каждая строка в файле состоит из записи следующего вида:
-.RS
-.IB user : role : type \fR[\fB:\fIrange\fR]
-.RE
-.sp
-Где:
-.RS
-.I user role type range
-.RS
-Пользователь, роль, тип и необязательный диапазон (для MCS/MLS), разделённые двоеточиями (:), которые могут использоваться в качестве контекста виртуального образа.
-.RE
-.RE
-.
-.SH "ПРИМЕР"
-# ./contexts/virtual_image_context
-.br
-system_u:object_r:svirt_image_t:s0
-.br
-system_u:object_r:svirt_content_t:s0
-.
-.SH "СМОТРИТЕ ТАКЖЕ"
-.ad l
-.nh
-.BR selinux "(8), " libvirtd "(8), " selinux_virtual_image_context_path "(3), " selinux_config "(5) "
-
-
-.SH АВТОРЫ
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
diff --git a/libselinux/man/ru/man5/x_contexts.5 b/libselinux/man/ru/man5/x_contexts.5
deleted file mode 100644
index 3796d2a7..00000000
--- a/libselinux/man/ru/man5/x_contexts.5
+++ /dev/null
@@ -1 +0,0 @@
-.so man5/selabel_x.5
-- 
2.41.0

