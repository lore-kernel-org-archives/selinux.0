Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33EC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 20:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D5B2080F
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 20:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBUURe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:17:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:60687 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfBUURe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 15:17:34 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EA2DF560617
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 21:17:30 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id n8so46058410otl.6
        for <selinux@vger.kernel.org>; Thu, 21 Feb 2019 12:17:30 -0800 (PST)
X-Gm-Message-State: AHQUAuaDDK5LxuGu/7/1WWYdLff1DBfZgc4TwYtWSmAOhaNN89bAh2Fh
        ZACTd0A1fGAVV+45GcTBhMkY6IXVr7/xTBEEUkE=
X-Google-Smtp-Source: AHgI3IYDdj1DM6WIPcHC44gs/JQ46TVAyPKmHzt8ynFAcvb8YwdpefH3+v3EWKHlDEhKsAjWs2+2CcGg6ABX4I0v7cc=
X-Received: by 2002:a9d:66c8:: with SMTP id t8mr248378otm.368.1550780249879;
 Thu, 21 Feb 2019 12:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20190220160446.23150-1-plautrba@redhat.com> <20190220160446.23150-2-plautrba@redhat.com>
In-Reply-To: <20190220160446.23150-2-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 Feb 2019 21:17:18 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kL2D5K9J-+C8bK4KqeEV4qQed745AMrAZ+BhH=ODiihQ@mail.gmail.com>
Message-ID: <CAJfZ7=kL2D5K9J-+C8bK4KqeEV4qQed745AMrAZ+BhH=ODiihQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Always use /usr/bin/python3 in Python scripts
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb 21 21:17:31 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 5:04 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

For the 3 patches:
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>  dbus/selinux_server.py                   | 2 +-
>  libsemanage/utils/semanage_migrate_store | 2 +-
>  mcstrans/share/util/mlscolor-test        | 2 +-
>  mcstrans/share/util/mlstrans-test        | 2 +-
>  python/semanage/semanage                 | 2 +-
>  sandbox/start                            | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> index 6e380e58..98ab53dd 100644
> --- a/dbus/selinux_server.py
> +++ b/dbus/selinux_server.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/python3
>
>  import dbus
>  import dbus.service
> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
> index 018b1a3e..c6caf3bf 100755
> --- a/libsemanage/utils/semanage_migrate_store
> +++ b/libsemanage/utils/semanage_migrate_store
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python -E
> +#!/usr/bin/python3 -E
>
>
>  from __future__ import print_function
> diff --git a/mcstrans/share/util/mlscolor-test b/mcstrans/share/util/mlscolor-test
> index 03fc4be4..240e996d 100644
> --- a/mcstrans/share/util/mlscolor-test
> +++ b/mcstrans/share/util/mlscolor-test
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python -E
> +#!/usr/bin/python3 -E
>  import sys
>  import selinux
>
> diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
> index c026d00e..085fa82d 100644
> --- a/mcstrans/share/util/mlstrans-test
> +++ b/mcstrans/share/util/mlstrans-test
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python -E
> +#!/usr/bin/python3 -E
>  import sys
>  import selinux
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index d6d68248..144cc000 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python3 -Es
> +#!/usr/bin/python3 -Es
>  # Copyright (C) 2012-2013 Red Hat
>  # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
>  # AUTHOR: David Quigley <selinux@davequigley.com>
> diff --git a/sandbox/start b/sandbox/start
> index 7f83532f..4ed3cb5c 100644
> --- a/sandbox/start
> +++ b/sandbox/start
> @@ -1,4 +1,4 @@
> -#! /usr/bin/python -Es
> +#!/usr/bin/python3 -Es
>  try:
>      from subprocess import getstatusoutput
>  except ImportError:
> --
> 2.20.1
>

