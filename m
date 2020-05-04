Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42755C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1082D20705
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 14:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHX0C8dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgEDOMz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 10:12:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728233AbgEDOMz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 10:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588601573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD8bK0kri+DP+rvG3eXH1tdErJ/6C0axEzxm/6ZCEk0=;
        b=XHX0C8dhmk8CiGYDKboWN9NPuj97Iv3JgKwYAyAsYe7taHoaZy17Tal+QIVZrffAHg88gm
        Hvjzq3QD/WODBhRIoC9LG/xUFc/1NEya7oZ1KypyHNe3sVhtor5737p74jUACmj413pOfi
        RlS3OHna2bjGuE8RpAmc70558CKLT10=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Vad1sAzZN_GTMSI_ZH-jWg-1; Mon, 04 May 2020 10:12:47 -0400
X-MC-Unique: Vad1sAzZN_GTMSI_ZH-jWg-1
Received: by mail-oi1-f198.google.com with SMTP id k193so5867546oih.0
        for <selinux@vger.kernel.org>; Mon, 04 May 2020 07:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YD8bK0kri+DP+rvG3eXH1tdErJ/6C0axEzxm/6ZCEk0=;
        b=sHswfV6FgOQ2GY0XSD97ngZHfjG9aFRRU5PXr+9pozmZVVHuGVCje8QCp+Lw21Qv/A
         UqUh2PTlnmJhEbnwcLjOJ+wyXXmvrXEMuBcY/XqsoS16WuvEqGm4qSA6qAvC3w0BzTty
         roDW39jF5FlvmciouJnsOEMy2zU3Yni/wQa9QiM5Ic4Lsta05DnaTGk0Y7HLX+p4SNHz
         kp7zWKS8iUwlNaeXGPBaEjCrt3I0YmY4WObjeODW/38aQju5OX/WOx6sc6Hgabq/+NXZ
         BQdCE+9u+aM+mpyGADLf+YEH6kobP3y6PPp56RgYFAKllAVWSupA1cVvCor9r7ZXoW6A
         kp2Q==
X-Gm-Message-State: AGi0PuaADBFJkH13Uo5MCH6l3E1rBDsSyWQJ2I6mayihenyxE1Fagg37
        XJrcuVSq5bGqMAAGpl1zNwUjGCgn7DqeX8rClKUNUwLWgagWXQj850iX2yyBK1J+ITm0Y7TzyAj
        lpCITmvXmUzuKAzVrg5etfBK/DjRdn/41ow==
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr13869608otb.367.1588601566123;
        Mon, 04 May 2020 07:12:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypKTCzuF3eQjK9UmnJU12b59FtLlbnJqdT6jYW53C4bw9gD4mbQeWl/L5BSh7+3y8k84DqgYfp/GqwXxKhJuCaA=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr13869589otb.367.1588601565822;
 Mon, 04 May 2020 07:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200407114514.40253-1-cgzones@googlemail.com>
 <20200501134604.20070-1-cgzones@googlemail.com> <20200504130323.GC251987@workstation>
In-Reply-To: <20200504130323.GC251987@workstation>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 4 May 2020 16:12:34 +0200
Message-ID: <CAFqZXNs3WwmzqRYovw4UdudVEP2MQBun7DsPZCq5kfmiUCfvng@mail.gmail.com>
Subject: Re: [PATCH v2] tree-wide: introduce PYTON_SETUP_ARGS to customize
 setup.py calls on Debian
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 4, 2020 at 3:03 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> On Fri, May 01, 2020 at 03:46:04PM +0200, Christian G=C3=B6ttsche wrote:
> > On Debian the `distutils` module is patched, so `get_python_lib()` retu=
rns by default `/usr/lib/python3/dist-packages` (no minor version).
> >
>
> Could you wrap the commit message to 75 chars per line, please?
>
> > But `setuptools` affecting setup.py is not patched to create the librar=
y directory at `/usr/lib/python3/dist-packages` by default, rather than a c=
ommand line argument `--install-layout deb` is added.
> >
> > Add PYTON_SETUP_ARGS as argument to affected setup.py calls and add a n=
ote in the global ReadMe.
>
> Fix the file name - ReadMe -> README.md
>
> >
> > See https://www.debian.org/doc/packaging-manuals/python-policy/packagin=
g_tools.html section B.1.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/187
>
> Please provide Signed-off-by:
>
> Also there's a conflicting patch which changes README.md as well -
> https://patchwork.kernel.org/patch/11522349/ which I'm going to merge. Co=
uld you
> please rebase this patch based on changes from the mentioned patch?
>
> Other than the comments above, I like the patch. Thanks!

Also, please fix the typo: s/PYTON/PYTHON/g (both in the commit
message and code/README). I only spotted it now after reading Petr's
reply :)

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

