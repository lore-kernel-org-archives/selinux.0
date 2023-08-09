Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A81BC04A94
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHIQbN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjHIQbG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:06 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FFC171D
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so5669096d6.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598664; x=1692203464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iku1RXLNdAH6XvnWbhdz6W+Elx5TBsR1cwvG0ARme6U=;
        b=dQIhNjQ0eWIR6sWLH/abn4/leKs/I9EdMPNQyISKN+qCr7atUkVyk87jetcCCRXSup
         +Bws55kgKHeqdvJmH/cNKPmH8FDYh4TVb8suCftxt7stcd0wu5zVM4BAObDPWfVYAmc6
         OV+FPBGntsUYYNA+Hz81rKc+mS8XTSEEaZuoW6q7NaLMdwVoeWGHuYe1oGGaX9hqKljL
         1SgxiaVO8/qPUTM7YYaK9ofoZBEFnm26Tg3w+wc6k8BhhKVvyqhbSk2VCoCTcu3MzaZg
         uiLq7WRgdMe/NkGcZr183Kd34vFzFhhmrfqzn2iZ3VgQBqxL4gzbp1tkWE2YPv+jRIZy
         crNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598664; x=1692203464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iku1RXLNdAH6XvnWbhdz6W+Elx5TBsR1cwvG0ARme6U=;
        b=NlZnNNtKv4SZGQ2iF+Wvt34pwX6jqUguNjA6WRN7dlcW3g6Cm0hiNte27K85jlB6tX
         jAPqIk9uDEpAoOt8MYZzkNEWgcGpjzquiLMk7cAcSr21qIPe8gwnP/UTEoSM3vMinhyr
         qGvzVoLWnq0fXB0XsAn9JyxRiMVRCW0bvhKeDE8oOW1qoxAf4+gXgnr2/OZWy8HERYC3
         OtcSdAbHnOpshcjnBnJYFSUf5qo1NSP72xKr14iR2CNWk6Jp6pX9mlEahzgDk9C4nNHR
         6wbVPft8Q7Ovp9YgrotqRdOXbaQfwxHRk25GJ4uYJvGzLT0TsiqvzcheIvHZ2LAlAQyv
         hfpA==
X-Gm-Message-State: AOJu0Yyqw/xzzgHuuqau+9lGD/Wmlt5BXsx1DdaV/FrVBjMwEfPNhGOw
        Pv7iXN75sIxP+egySOmn8TT8JgkCAhI=
X-Google-Smtp-Source: AGHT+IED2wcITpBc4FMFjX9jPalMZ2fLNyAiY7+6V0mBXhb3YsyzIxSnYhhFEA0BjrlUcEJzUiIHTw==
X-Received: by 2002:a0c:f2cd:0:b0:636:1d3f:3d77 with SMTP id c13-20020a0cf2cd000000b006361d3f3d77mr4012879qvm.14.1691598663933;
        Wed, 09 Aug 2023 09:31:03 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:03 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/12] gui: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:47 -0400
Message-ID: <20230809163059.97671-2-jwcart2@gmail.com>
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

