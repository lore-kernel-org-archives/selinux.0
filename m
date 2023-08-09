Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC0C41513
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHIQbO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjHIQbM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 12:31:12 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320551BF7
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 09:31:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc886d1504so6293814a34.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598668; x=1692203468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVVuh7zbFzPPUspoXdHm5yBTNzdchQ+dv8eBtqJp4qg=;
        b=AewA+SfnXCUvSEBhZECMUfEIq/rUV16+XXGWAhZKCnuGKWzHX0zcXEenpBGf5sU8xK
         we+toV2ToXIDTiCVo0797WFduvlD1hvMs8HTZ+6eHh9AaduvGsQpYypNlajHTLGQZZph
         qsFJ2cfzOjPlOOD6qlKh9JjzxCgAQxu52ihHIEKLrSE26HQwEF+/7c/fAj4062L7s2K3
         E8rJCDl6KzWtC9Ulwx/WFlREeMUi8DqxSHEmoYuhJacmMJxuZsW92TrIRQUy+JS3TiDY
         hGg5ezbnjIJT9Dg7G4Uh5NhYk5lNNdji20utks15tqLgSRtv188xikz5+kZydF26Wxz3
         u3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598668; x=1692203468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVVuh7zbFzPPUspoXdHm5yBTNzdchQ+dv8eBtqJp4qg=;
        b=Re94Bs2r7hmjY3a+Ntv7tWLZGHsNXCT4LVrqjWu8tqGamIt2GEPZmlgQ+mNkkL9nDx
         L9sTvcQvKqFDIx3g4U1C/X/E4cHdvVabsvwDFmktMOIhTuA1IhGBo5bNVNUYH0ZXJIpj
         C0oEzu+zWmu8A9LClL0drdgJevM2aD5NloRFEC/NAUwYEpKRsxF9GIHiAauq3Ue/Ghav
         qIA3K/pZOrKFVbP2sS57itJjmU1oaP6/CYxgbOFE/8m71W42DKS2wqcOoW3aQebAD2OY
         b1SvyV4mCxRieHf2ACJinhpmcJB6uoPENF7kVbMCf1ExNQYXkkAxsMJMd5H8Yb8ujc4h
         o6OA==
X-Gm-Message-State: AOJu0Yxfn+2/SM90K9fnWpgJmArpt687tLcJykeq223osF1AaFHPMtUy
        q5idwvNofeeN3SJNfy0DKzzVC4bA4cI=
X-Google-Smtp-Source: AGHT+IGG8QAMmPrzGmzC8eqKhZuM9PW6sVgevdPxcRoaXJCTTZhatfAJtlgGbYxnKRSrAujgpBQC5Q==
X-Received: by 2002:aca:1c0f:0:b0:3a3:64a3:b5a1 with SMTP id c15-20020aca1c0f000000b003a364a3b5a1mr3576761oic.7.1691598667984;
        Wed, 09 Aug 2023 09:31:07 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a0ce507000000b0063d2ea55018sm4609570qvm.125.2023.08.09.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:31:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 06/12] libsepol: Remove the Russian translations
Date:   Wed,  9 Aug 2023 12:30:51 -0400
Message-ID: <20230809163059.97671-6-jwcart2@gmail.com>
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

