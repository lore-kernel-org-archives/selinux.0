Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF3C0015E
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 17:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGSRAR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSRAQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 13:00:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D1B7
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 10:00:11 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403fa83523eso14682981cf.2
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 10:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689786010; x=1690390810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khiWLd2mrAh7hhlwm7TNVIeIEJyKrRNzyQyEx3FU6tQ=;
        b=GhiH/Cns8flIqGPok7kbKb+MWnv1i2WdKAgEwVP+8IkyjymIZqNUu7Bp35pzqfMFwH
         QT2i+h1JQVc+RDj7en1i4AVlWxQbuAOZjAvd5Imvo089uxA13+MIPEie97uaZqdHRBlw
         TnQL7gQxrtpVZ4/CQJANvA/3uEo0cIrjUQ91Il9ibvTenTwyxgwB3bdxWz2jb/iSFh3L
         MxWO3ggImkUVaP4xfxoOz71WRhnwB+ZyBK99/I/3H5+XODmy7k2u0aiJu66VrocXrFKQ
         EfwrMoVip5TKUoUMkPbOESpUlD16211CKOESyFq2g9lYU9DH98peHHgX7pS6TH0doxX3
         svvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689786010; x=1690390810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khiWLd2mrAh7hhlwm7TNVIeIEJyKrRNzyQyEx3FU6tQ=;
        b=WzdjdQIyi22EX8aWrvoeZG4DRcLkruWmH8IeiVa68vjwktpMnGNcBmLcHOWoAhoGF+
         RT6z02mIQ/NJZ3fp8WgokHFFGv+fKIQDyacTVtF56V2cH+9jhWj3NSvsloLN/O+uEFDR
         5z3FqYg4Xkiga6rBWP0AKPuAfC95lVu1ZRRiig+vMgbgt3bt9GLDuISnGO0H3Z7+4Off
         XtNtcfHVsbBoS3tGv6pH3DJk3Upisfifv+iLc4WHusUDTWPnqSKUaRTQ5u2SrRBI6SaO
         tpA4LjB4bKmApEJ6uz5ePirF8+9Im/WBAc1piK2XCaSaYahAvSpGIp/1OsnTqGrjKOcp
         qojw==
X-Gm-Message-State: ABy/qLa0c4UGN8MHSjH70Ovx5dc1leV38IP8F+uOs7ckELOSa0TQ1Is9
        Q7fhVKjxMkb+VnIkzNmD6tBx5lHEeEc=
X-Google-Smtp-Source: APBJJlF8Qtj5XUeZB0XyhmqcZ5PNHf4W8xWrl3siJG2IQdxQCGIgPKOF+kGQyQjx0GZioXinO3rzEA==
X-Received: by 2002:a05:622a:199d:b0:403:a662:a408 with SMTP id u29-20020a05622a199d00b00403a662a408mr7327895qtc.34.1689786010441;
        Wed, 19 Jul 2023 10:00:10 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8130c000000b003f9aecb599fsm1466393qtj.35.2023.07.19.10.00.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:00:10 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH userspace] libselinux,policycoreutils,python,semodule-utils: de-brand SELinux
Date:   Wed, 19 Jul 2023 12:57:17 -0400
Message-Id: <20230719165716.18285-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change "NSA SELinux" to just "SELinux" and remove NSA from the
SELinux manual pages.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/man/man8/selinux.8                           | 4 ++--
 libselinux/man/ru/man8/selinux.8                        | 4 ++--
 policycoreutils/load_policy/load_policy.8               | 2 +-
 policycoreutils/load_policy/ru/load_policy.8            | 2 +-
 policycoreutils/newrole/newrole.1                       | 2 +-
 policycoreutils/newrole/ru/newrole.1                    | 2 +-
 policycoreutils/run_init/open_init_pty.8                | 2 +-
 policycoreutils/run_init/ru/open_init_pty.8             | 2 +-
 policycoreutils/run_init/ru/run_init.8                  | 2 +-
 policycoreutils/run_init/run_init.8                     | 2 +-
 policycoreutils/secon/ru/secon.1                        | 2 +-
 policycoreutils/secon/secon.1                           | 2 +-
 policycoreutils/semodule/ru/semodule.8                  | 2 +-
 policycoreutils/semodule/semodule.8                     | 2 +-
 python/audit2allow/audit2allow.1                        | 2 +-
 python/audit2allow/ru/audit2allow.1                     | 2 +-
 semodule-utils/semodule_expand/ru/semodule_expand.8     | 2 +-
 semodule-utils/semodule_expand/semodule_expand.8        | 2 +-
 semodule-utils/semodule_link/ru/semodule_link.8         | 2 +-
 semodule-utils/semodule_link/semodule_link.8            | 2 +-
 semodule-utils/semodule_package/ru/semodule_package.8   | 2 +-
 semodule-utils/semodule_package/ru/semodule_unpackage.8 | 2 +-
 semodule-utils/semodule_package/semodule_package.8      | 2 +-
 semodule-utils/semodule_package/semodule_unpackage.8    | 2 +-
 24 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 5842150b..9c466d57 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -1,9 +1,9 @@
 .TH  "selinux"  "8"  "29 Apr 2005" "dwalsh@redhat.com" "SELinux Command Line documentation"
 .SH "NAME"
-SELinux \- NSA Security-Enhanced Linux (SELinux)
+SELinux \- Security-Enhanced Linux (SELinux)
 .
 .SH "DESCRIPTION"
-NSA Security-Enhanced Linux (SELinux) is an implementation of a
+Security-Enhanced Linux (SELinux) is an implementation of a
 flexible mandatory access control architecture in the Linux operating
 system.  The SELinux architecture provides general support for the
 enforcement of many kinds of mandatory access control policies,
diff --git a/libselinux/man/ru/man8/selinux.8 b/libselinux/man/ru/man8/selinux.8
index 271809de..4ab64276 100644
--- a/libselinux/man/ru/man8/selinux.8
+++ b/libselinux/man/ru/man8/selinux.8
@@ -1,9 +1,9 @@
 .TH  "selinux"  "8"  "29 апреля 2005" "dwalsh@redhat.com" "Документация по командной строке SELinux"
 .SH "ИМЯ"
-SELinux \- Linux с улучшенной безопасностью от NSA (SELinux)
+SELinux \- Linux с улучшенной безопасностью от (SELinux)
 .
 .SH "ОПИСАНИЕ"
-Linux с улучшенной безопасностью от NSA - это реализация гибкой архитектуры мандатного
+Linux с улучшенной безопасностью от - это реализация гибкой архитектуры мандатного
 управления доступом в операционной системе Linux. Архитектура SELinux предоставляет
 общую поддержку использования различных видов политик мандатного управления доступом,
 включая основанные на концепциях Type Enforcement® (принудительное присвоение типов),
diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/load_policy/load_policy.8
index 0810995c..867c35e4 100644
--- a/policycoreutils/load_policy/load_policy.8
+++ b/policycoreutils/load_policy/load_policy.8
@@ -1,4 +1,4 @@
-.TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux" NSA
+.TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux"
 .SH NAME
 load_policy \- load a new SELinux policy into the kernel
 
diff --git a/policycoreutils/load_policy/ru/load_policy.8 b/policycoreutils/load_policy/ru/load_policy.8
index db3d9f65..25140b2e 100644
--- a/policycoreutils/load_policy/ru/load_policy.8
+++ b/policycoreutils/load_policy/ru/load_policy.8
@@ -1,4 +1,4 @@
-.TH LOAD_POLICY "8" "Май 2003" "Security Enhanced Linux" NSA
+.TH LOAD_POLICY "8" "Май 2003" "Security Enhanced Linux"
 .SH ИМЯ
 load_policy \- загрузить новую политику SELinux в ядро
 
diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
index 893c42f7..544274d7 100644
--- a/policycoreutils/newrole/newrole.1
+++ b/policycoreutils/newrole/newrole.1
@@ -1,4 +1,4 @@
-.TH NEWROLE "1" "October 2000" "Security Enhanced Linux" NSA
+.TH NEWROLE "1" "October 2000" "Security Enhanced Linux"
 .SH NAME
 newrole \- run a shell with a new SELinux role
 .SH SYNOPSIS
diff --git a/policycoreutils/newrole/ru/newrole.1 b/policycoreutils/newrole/ru/newrole.1
index c4078789..6d9c6dd0 100644
--- a/policycoreutils/newrole/ru/newrole.1
+++ b/policycoreutils/newrole/ru/newrole.1
@@ -1,4 +1,4 @@
-.TH NEWROLE "1" "Октябрь 2000" "Security Enhanced Linux" NSA
+.TH NEWROLE "1" "Октябрь 2000" "Security Enhanced Linux"
 .SH ИМЯ
 newrole \- запустить оболочку с новой ролью SELinux
 .SH ОБЗОР
diff --git a/policycoreutils/run_init/open_init_pty.8 b/policycoreutils/run_init/open_init_pty.8
index 4b0a2f3c..8bfb9d69 100644
--- a/policycoreutils/run_init/open_init_pty.8
+++ b/policycoreutils/run_init/open_init_pty.8
@@ -22,7 +22,7 @@
 .\" USA.
 .\"
 .\"
-.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux" NSA
+.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux"
 .SH NAME
 open_init_pty \- run an program under a pseudo terminal
 .SH SYNOPSIS
diff --git a/policycoreutils/run_init/ru/open_init_pty.8 b/policycoreutils/run_init/ru/open_init_pty.8
index bac4fd94..143941e1 100644
--- a/policycoreutils/run_init/ru/open_init_pty.8
+++ b/policycoreutils/run_init/ru/open_init_pty.8
@@ -22,7 +22,7 @@
 .\" USA.
 .\"
 .\"
-.TH OPEN_INIT_PTY "8" "Январь 2005" "Security Enhanced Linux" NSA
+.TH OPEN_INIT_PTY "8" "Январь 2005" "Security Enhanced Linux"
 .SH ИМЯ
 open_init_pty \- запустить программу под псевдотерминалом
 .SH ОБЗОР
diff --git a/policycoreutils/run_init/ru/run_init.8 b/policycoreutils/run_init/ru/run_init.8
index 174d9c53..26b767ce 100644
--- a/policycoreutils/run_init/ru/run_init.8
+++ b/policycoreutils/run_init/ru/run_init.8
@@ -1,4 +1,4 @@
-.TH RUN_INIT "8" "Май 2003" "Security Enhanced Linux" NSA
+.TH RUN_INIT "8" "Май 2003" "Security Enhanced Linux"
 .SH ИМЯ
 run_init \- запустить сценарий init в правильном контексте SELinux
 .SH ОБЗОР
diff --git a/policycoreutils/run_init/run_init.8 b/policycoreutils/run_init/run_init.8
index a031d5d2..d7ff45d0 100644
--- a/policycoreutils/run_init/run_init.8
+++ b/policycoreutils/run_init/run_init.8
@@ -1,4 +1,4 @@
-.TH RUN_INIT "8" "May 2003" "Security Enhanced Linux" NSA
+.TH RUN_INIT "8" "May 2003" "Security Enhanced Linux"
 .SH NAME
 run_init \- run an init script in the proper SELinux context
 .SH SYNOPSIS
diff --git a/policycoreutils/secon/ru/secon.1 b/policycoreutils/secon/ru/secon.1
index acbc14fb..3c9aa535 100644
--- a/policycoreutils/secon/ru/secon.1
+++ b/policycoreutils/secon/ru/secon.1
@@ -1,4 +1,4 @@
-.TH SECON "1" "Апрель 2006" "Security Enhanced Linux" NSA
+.TH SECON "1" "Апрель 2006" "Security Enhanced Linux"
 .SH ИМЯ
 secon \- показать контекст SELinux для файла, программы или ввода пользователя.
 .SH ОБЗОР
diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
index c0e8b05a..1a454edc 100644
--- a/policycoreutils/secon/secon.1
+++ b/policycoreutils/secon/secon.1
@@ -1,4 +1,4 @@
-.TH SECON "1" "April 2006" "Security Enhanced Linux" NSA
+.TH SECON "1" "April 2006" "Security Enhanced Linux"
 .SH NAME
 secon \- See an SELinux context, from a file, program or user input.
 .SH SYNOPSIS
diff --git a/policycoreutils/semodule/ru/semodule.8 b/policycoreutils/semodule/ru/semodule.8
index 26515201..d7ff9b56 100644
--- a/policycoreutils/semodule/ru/semodule.8
+++ b/policycoreutils/semodule/ru/semodule.8
@@ -1,4 +1,4 @@
-.TH SEMODULE "8" "Ноябрь 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE "8" "Ноябрь 2005" "Security Enhanced Linux"
 .SH ИМЯ 
 semodule \- управление модулями политики SELinux.
 
diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 01757b00..00c60c1e 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -1,4 +1,4 @@
-.TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux"
 .SH NAME
 semodule \- Manage SELinux policy modules.
 
diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
index c31021d3..c208b3b2 100644
--- a/python/audit2allow/audit2allow.1
+++ b/python/audit2allow/audit2allow.1
@@ -23,7 +23,7 @@
 .\" USA.
 .\"
 .\"
-.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux" NSA
+.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux"
 .SH NAME
 .BR audit2allow
 \- generate SELinux policy allow/dontaudit rules from logs of denied operations
diff --git a/python/audit2allow/ru/audit2allow.1 b/python/audit2allow/ru/audit2allow.1
index 1633fa3b..b631895d 100644
--- a/python/audit2allow/ru/audit2allow.1
+++ b/python/audit2allow/ru/audit2allow.1
@@ -23,7 +23,7 @@
 .\" USA.
 .\"
 .\"
-.TH AUDIT2ALLOW "1" "Октябрь 2010" "Security Enhanced Linux" NSA
+.TH AUDIT2ALLOW "1" "Октябрь 2010" "Security Enhanced Linux"
 .SH ИМЯ
 .BR audit2allow
 \- создаёт правила политики SELinux allow/dontaudit из журналов отклонённых операций
diff --git a/semodule-utils/semodule_expand/ru/semodule_expand.8 b/semodule-utils/semodule_expand/ru/semodule_expand.8
index afdc129e..28b381af 100644
--- a/semodule-utils/semodule_expand/ru/semodule_expand.8
+++ b/semodule-utils/semodule_expand/ru/semodule_expand.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_EXPAND "8" "ноябрь 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_EXPAND "8" "ноябрь 2005" "Security Enhanced Linux"
 .SH ИМЯ 
 semodule_expand \- расширить пакет модуля политики SELinux
 
diff --git a/semodule-utils/semodule_expand/semodule_expand.8 b/semodule-utils/semodule_expand/semodule_expand.8
index 1b482a1f..eba7b40e 100644
--- a/semodule-utils/semodule_expand/semodule_expand.8
+++ b/semodule-utils/semodule_expand/semodule_expand.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_EXPAND "8" "Nov 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_EXPAND "8" "Nov 2005" "Security Enhanced Linux"
 .SH NAME 
 semodule_expand \- Expand a SELinux policy module package.
 
diff --git a/semodule-utils/semodule_link/ru/semodule_link.8 b/semodule-utils/semodule_link/ru/semodule_link.8
index 31d81206..4a8f414e 100644
--- a/semodule-utils/semodule_link/ru/semodule_link.8
+++ b/semodule-utils/semodule_link/ru/semodule_link.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_LINK "8" "Ноябрь 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_LINK "8" "Ноябрь 2005" "Security Enhanced Linux"
 .SH ИМЯ 
 semodule_link \- связать вместе пакеты модулей политики SELinux
 
diff --git a/semodule-utils/semodule_link/semodule_link.8 b/semodule-utils/semodule_link/semodule_link.8
index a2bda3f9..95a9ba19 100644
--- a/semodule-utils/semodule_link/semodule_link.8
+++ b/semodule-utils/semodule_link/semodule_link.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_LINK "8" "Nov 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_LINK "8" "Nov 2005" "Security Enhanced Linux"
 .SH NAME 
 semodule_link \- Link SELinux policy module packages together
 
diff --git a/semodule-utils/semodule_package/ru/semodule_package.8 b/semodule-utils/semodule_package/ru/semodule_package.8
index 6af67b29..3f4b16a9 100644
--- a/semodule-utils/semodule_package/ru/semodule_package.8
+++ b/semodule-utils/semodule_package/ru/semodule_package.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_PACKAGE "8" "Ноябрь 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_PACKAGE "8" "Ноябрь 2005" "Security Enhanced Linux"
 .SH ИМЯ 
 semodule_package \- создать пакет модуля политики SELinux
 
diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8 b/semodule-utils/semodule_package/ru/semodule_unpackage.8
index 910fee02..6c7e234b 100644
--- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
+++ b/semodule-utils/semodule_package/ru/semodule_unpackage.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_PACKAGE "8" "Ноябрь 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_PACKAGE "8" "Ноябрь 2005" "Security Enhanced Linux"
 .SH ИМЯ
 semodule_unpackage \- извлечь модуль политики и файл контекстов файлов из пакета модуля политики SELinux
 
diff --git a/semodule-utils/semodule_package/semodule_package.8 b/semodule-utils/semodule_package/semodule_package.8
index 9697cc55..1d64bad3 100644
--- a/semodule-utils/semodule_package/semodule_package.8
+++ b/semodule-utils/semodule_package/semodule_package.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux"
 .SH NAME 
 semodule_package \- Create a SELinux policy module package.
 
diff --git a/semodule-utils/semodule_package/semodule_unpackage.8 b/semodule-utils/semodule_package/semodule_unpackage.8
index 5c92bf51..0432f7a1 100644
--- a/semodule-utils/semodule_package/semodule_unpackage.8
+++ b/semodule-utils/semodule_package/semodule_unpackage.8
@@ -1,4 +1,4 @@
-.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
+.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux"
 .SH NAME
 semodule_unpackage \- Extract policy module and file context file from an SELinux policy module package.
 
-- 
2.40.1

