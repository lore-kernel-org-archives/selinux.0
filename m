Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346AC41513
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHIULE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjHIULD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 16:11:03 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF6510E0
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 13:11:02 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-487442d5e49so103218e0c.2
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691611861; x=1692216661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVVuh7zbFzPPUspoXdHm5yBTNzdchQ+dv8eBtqJp4qg=;
        b=gkqMbo+1uytNvhGVUoSNq7lx9hxD5bryHODe4s2n9kivZgZnuaY6Tg8R9RBR1U2TKo
         sWWcIrU686rPIFdLZ7RPMz/qWd+Vf+ReRqbo4ivDiIRnj0MCOjJqKfQQ/UFqpQoRnf9b
         uc9/RF6ThAMi0VkJYPBX63XzDW0x4I9Z4vaBTMpZgAebk3Hav+xGPNqyDoU5S0X3GXtx
         b4HHm3WwFLm2H7cWCgnhQ32DDNKRKvqukDX4tkWThLpI9FMUsx64pRr8gfhuKE/iBD2X
         Y07knPmSJL7xSjvcgxiW0HyKv5grsjM02LePFB1G+K+knUp5hBpY0WndIC4DN8VYtS3b
         2/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611861; x=1692216661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVVuh7zbFzPPUspoXdHm5yBTNzdchQ+dv8eBtqJp4qg=;
        b=CHlwJlAK3kC5Z92SNLEl0h3cztuPAN2Cf5WvPf0khdC1+xDbfgZ3QlWpDVuejvXrJg
         N48JqhWdUqpp/ALaJM0zygW/nD2xCGjHJP5KNlQo/o4efto8nC82MKsTKSWHx9VPruZH
         raLyVl7MGhYYV+gwx4EWuhLbIWoVg3vzb6H/pXUnL4cZ8WHADdvstYlZCu5npgnD7EWk
         vE5r+/9vtstToywLbArsNA3o+Xd26bJ1anvh8TmJCumOJnWynakmtQY9oJy+sIK8m7Pc
         EJCxLS3Imi7qUS9nPrfaBBorkQTnmm3Z7MD8G6ONTmPcmkDThQqwH1SW8rVNqrd6cHHZ
         q0EQ==
X-Gm-Message-State: AOJu0YxGJYkqQhwZwqndP0VNkOhhoTgyWPSodk1CZypg6tkqEAbfUhhK
        cPqqGCnGEHjigMSiO7zobqbcm7dr9cA=
X-Google-Smtp-Source: AGHT+IG8pbOcvTNUa2MqagBG9vJIAVuXVr28yPpzXt3z+fPE2qtjbQEx32NCOuYOYdabFcfpcldIpQ==
X-Received: by 2002:a67:be16:0:b0:443:7516:450b with SMTP id x22-20020a67be16000000b004437516450bmr105352vsq.35.1691611861517;
        Wed, 09 Aug 2023 13:11:01 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id w11-20020ae9e50b000000b00767d572d651sm4220210qkf.87.2023.08.09.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:11:00 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/13 v2] libsepol: Remove the Russian translations
Date:   Wed,  9 Aug 2023 16:10:42 -0400
Message-ID: <20230809201051.108944-7-jwcart2@gmail.com>
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
 libsepol/man/ru/man8/chkcon.8 | 39 -----------------------------------
 1 file changed, 39 deletions(-)
 delete mode 100644 libsepol/man/ru/man8/chkcon.8

diff --git a/libsepol/man/ru/man8/chkcon.8 b/libsepol/man/ru/man8/chkcon.8
deleted file mode 100644
index 2661afb0..00000000
--- a/libsepol/man/ru/man8/chkcon.8
+++ /dev/null
@@ -1,39 +0,0 @@
-.\" Hey, Emacs! This is an -*- nroff -*- source file.
-.\" Copyright (c) 1997 Manoj Srivastava <srivasta@debian.org>
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
-.TH CHKCON 8 "12 марта 2005" "SELinux" "Документация по командной строке SELinux"
-.SH ИМЯ
-chkcon \-  определить, является ли контекст безопасности действительным для конкретной двоичной политики
-.SH ОБЗОР
-chkcon policy_file context
-.SH ОПИСАНИЕ
-Эта утилита проверяет контекст безопасности (его строковое представление), заданный аргументом
-.I context,
-относительно данных конфигурации, прочтённых из файла двоичного представления базы данных политик, заданного аргументом
-.I policy_file.
-.SH ФАЙЛЫ
-policy file
-.SH АВТОРЫ
-Эта страница руководства (и только она) была написана Manoj
-Srivastava <srivasta@debian.org>.
-Перевод на русский язык выполнила Герасименко Олеся <gammaray@basealt.ru>.
-- 
2.41.0

