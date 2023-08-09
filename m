Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD150C04FE1
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjHIQbQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHIQbN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:13 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB71A10FE
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:12 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56ccdb2c7bbso16364eaf.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598671; x=1692203471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWcFYaGSuqSygNA1A5+mhzKgV/pHHX0wPaj4dypTDFM=;
        b=Idx087p1UfIfeAzTzCyyDz0akKUPVNG4vZKKRPZqXj0ZCD4+JBvKWhOI0lMdZI7orf
         gsAyp97bhOfl3mqTgWh2kSB6SJZqBEawMVwKYH7If/KamOE7UkKqJ9oGvPA0Rp4Jy2Rx
         AIGJwvvcpiL2aMpPx3tM8+ZsY208ADhjA/2ex6AxGHrRU8YwBW/GQ5Jdeei3l0uwqCjl
         BVMq4qJX7BM0QqyNkK8+kI30GVSrhRBlVFU3Mr6+XvifG2ezo6dURjxP/6MzGBLiGwx3
         zlX2Eqn0pXr6N/GfasbTnmkxhKNhdajBFrYNwR48pJCQgQXuqeVzwr8h022ROwgGfMeH
         QXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598671; x=1692203471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWcFYaGSuqSygNA1A5+mhzKgV/pHHX0wPaj4dypTDFM=;
        b=MnMKjVFmanRML21mytwqA1ZbbYwXB3eUpXDVFad/rsPSxpBYGwUB8rg3TlC+NbExWi
         rYdriF7tV480rvXmuto+CemPrh+NQl316M9yFpLm7NSaMLOvZhkRTtVIQEVrjMeRcYuq
         0NNf28A6V89rKgxEGkEDDUMysrL/cxOLsiPTzkB9slLRmcP4ctMPxZpK1iNT8zelsdf9
         015hBHHf2HGqzHm8YUXE27tFiteuEUkUmVPHQ1EIZuLClZDmra60YqkYMpjAtNkPACTY
         24MaLtWSy9QvjlxVQ9qodE4VsrjHFLKvS4DnI3eLmWinb+14YrOtGdGicpRlDbkSC6Cr
         o8dw==
X-Gm-Message-State: AOJu0Yy2C+nlPAGuQdAP8RwRo2ii8mn5AO0V4k8p3mI92KsAvldEdFPP
        YFNCuM2qaRTfZaWBETDtIbbJaUxF/1M=
X-Google-Smtp-Source: AGHT+IHf829b9lvTA2YEGWKeWt0o12V47G1QHrDywVeEoQSdzH282QTCrdZ7OMXyRIDBy4I4IhHurA==
X-Received: by 2002:a54:4e85:0:b0:3a7:30cb:c092 with SMTP id c5-20020a544e85000000b003a730cbc092mr3239514oiy.48.1691598671686;
        Wed, 09 Aug 2023 09:31:11 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:11 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 10/12] restorecond: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:55 -0400
Message-ID: <20230809163059.97671-10-jwcart2@gmail.com>
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
 restorecond/ru/restorecond.8 | 41 ------------------------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 restorecond/ru/restorecond.8

diff --git a/restorecond/ru/restorecond.8 b/restorecond/ru/restorecond.8
deleted file mode 100644
index 72d91199..00000000
--- a/restorecond/ru/restorecond.8
+++ /dev/null
@@ -1,41 +0,0 @@
-.TH "restorecond" "8" "2002031409" "" ""
-.SH "ИМЯ"
-restorecond \- внутренняя служба, которая отслеживает создание файлов и затем задаёт для них SELinux-контекст по умолчанию
-
-.SH "ОБЗОР"
-.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-u] [\-v]
-.P
-
-.SH "ОПИСАНИЕ"
-Эта страница руководства содержит описание программы
-.BR restorecond.
-.P
-Эта внутренняя служба использует inotify для отслеживания файлов, перечисленных в /etc/selinux/restorecond.conf. После создания этих файлов эта служба обеспечивает присвоение им правильного контекста, связанного с политикой.
-
-.SH "ПАРАМЕТРЫ"
-.TP 
-.B \-d
-Включить режим отладки. Приложение останется на переднем плане, будет показано много отладочных сообщений.
-.TP
-. B \-h
-Вывести сведения об использовании.
-.TP
-.B \-f restorecond_file
-Использовать альтернативный файл restorecond.conf.
-.TP
-.B \-u
-Включить пользовательский режим. Запускает restorecond в сеансе пользователя и выполняет чтение /etc/selinux/restorecond_user.conf. Использует dbus, чтобы удостовериться, что в одном сеансе пользователя запущен только один экземпляр restorecond.
-.TP
-.B \-v
-Включить отладку с подробным выводом. (Сообщать об отсутствующих файлах)
-
-.SH "ФАЙЛЫ"
-/etc/selinux/restorecond.conf
-/etc/selinux/restorecond_user.conf
-
-.SH "СМОТРИТЕ ТАКЖЕ"
-.BR restorecon (8)
-
-.SH "АВТОРЫ"
-Эта man-страница и программа были написаны Dan Walsh <dwalsh@redhat.com>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

