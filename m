Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D3C00144
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 07:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiHAH5Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 03:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiHAH5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 03:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE7FA2A419
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659340641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ed0OHbY+ow63uWH+pbXtqEsTWsMDjmjuofPVcuYiWPc=;
        b=Ui/IV1H4HFsf+7Jp5BkDWxBthk7NErNG7xd3tKr50Jvn7vScFs8Nd9yjQKQuLyxCk8GTmk
        UZmkjgMQlo4PPCNvQveVUE9z9Gxa4bIJzNWcjZGn70sCXCx693QQ2fwhZtCZqhdN+vVG1E
        +20M6qwv4Da/nXudgI1aIQ/wopidRGI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-RMmgJK1_OpyoJkRDd2kJPQ-1; Mon, 01 Aug 2022 03:57:21 -0400
X-MC-Unique: RMmgJK1_OpyoJkRDd2kJPQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-3225b644be1so86701417b3.1
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 00:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ed0OHbY+ow63uWH+pbXtqEsTWsMDjmjuofPVcuYiWPc=;
        b=dgVkWg0v+mUIHlKJ+ZlzF2TwN0XxjMKvOfU1dldvgvNf9rjVtOGfTEmirblUDr67JB
         0G/Bm6MX6ZKMxJgWfaROd3nKEe22bQxuX41q8Z/kyiH1TwNB+gBM+wI4kyd1TgelkQus
         IJ5RB/d3hz0D5E7UnRcU2hFz/R6gFEOjoykucbkG6tWKTauRH0OT9IuPOJyiTdc5HBxE
         U9fCxSknqvuCAE2KqFldgHoaQvL5Di/6a6lpNBJ7GLN8N6KvpHBcvtmhILKUaU3k3I1x
         pjH6aVgSOHYvO9BoZUdbsC3fr3JAyG6Qu2Ey4gMkOq8RhJDwKgetd7agQZVIx0XgTtrK
         0TLg==
X-Gm-Message-State: ACgBeo2F3fOSXduqxfwPB8XiI2Rb7ZaM0RDTY9xlS2/b8530SFyD+q4V
        NawvsCfuYQLL2MR8DTjFTvV/Ycu+j/x2hlGdWfWO5nHvX4RuGua8YYno7MusYK+HhogPGdbcrpf
        2dsIchf/b5oRyHNM0MgOIl8xp4BWhVTTWSw==
X-Received: by 2002:a25:b686:0:b0:670:ae47:72f1 with SMTP id s6-20020a25b686000000b00670ae4772f1mr10246581ybj.255.1659340640112;
        Mon, 01 Aug 2022 00:57:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4XUn3eYd2+W0Gq7M2O85pKiLsVi9ClQuPApsBdVa5EnhygV6IklJLdeOAVP8NGQn+e8wFEByhPa4dvrAbSom8=
X-Received: by 2002:a25:b686:0:b0:670:ae47:72f1 with SMTP id
 s6-20020a25b686000000b00670ae4772f1mr10246569ybj.255.1659340639926; Mon, 01
 Aug 2022 00:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <20220729120229.207584-25-omosnace@redhat.com>
 <a8ab7102-cf2e-fd7d-afb1-dafbd15278c0@gmail.com>
In-Reply-To: <a8ab7102-cf2e-fd7d-afb1-dafbd15278c0@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Aug 2022 09:57:08 +0200
Message-ID: <CAFqZXNtSeP5eFWoNvMg3mT+A0qx9AiSO3g6MuzcUE4xi-S+8gQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 24/24] ci: add sysadm_t to the test matrix
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jul 30, 2022 at 10:13 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> On 29.7.2022 15.02, Ondrej Mosnacek wrote:
> > The testsuite should now be passing under the sysadm user as well, so
> > test it.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   .github/workflows/checks.yml |  4 +++-
> >   Vagrantfile                  | 16 ++++++++++++++++
> >   2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/.github/workflows/checks.yml b/.github/workflows/checks.yml
> > index 96843e4..37455ea 100644
> > --- a/.github/workflows/checks.yml
> > +++ b/.github/workflows/checks.yml
> > @@ -15,6 +15,7 @@ jobs:
> >       strategy:
> >         fail-fast: false
> >         matrix:
> > +        domain: [unconfined_t, sysadm_t]
> >           env:
> >             - { version: 35, kernel: default }
> >             - { version: 36, kernel: default }
> > @@ -22,6 +23,7 @@ jobs:
> >       env:
> >         FEDORA_VERSION: ${{ matrix.env.version }}
> >         KERNEL_TYPE: ${{ matrix.env.kernel }}
> > +      ROOT_DOMAIN: ${{ matrix.domain }}
> >       steps:
> >         - uses: actions/checkout@v2
> >         # macOS sometimes allows symlinks to have permissions other than 777,
> > @@ -39,6 +41,6 @@ jobs:
> >         - name: Run SELinux testsuite
> >           run: vagrant ssh -- sudo make -C /root/testsuite test
> >         - name: Check unwanted denials
> > -        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep unconfined_t'
> > +        run: vagrant ssh -- '! sudo ausearch -m avc -i </dev/null | grep ${{ matrix.domain }}'
> >         - name: Check .gitignore coverage
> >           run: test "$(vagrant ssh -- sudo git -C /root/testsuite ls-files -o --exclude-standard | wc -l)" -eq 0
> > diff --git a/Vagrantfile b/Vagrantfile
> > index 783df5d..ec3a492 100644
> > --- a/Vagrantfile
> > +++ b/Vagrantfile
> > @@ -51,6 +51,21 @@ Vagrant.configure("2") do |config|
> >       abort
> >     end
> >
> > +  extra_commands = ''
> > +  case ENV['ROOT_DOMAIN']
> > +  when 'unconfined_t'
> > +  when 'sysadm_t'
> > +    extra_commands = <<EOF
> > +      semanage boolean --modify --on ssh_sysadm_login
> > +      semanage login --modify -s sysadm_u root
> > +      semanage login --add -s sysadm_u -r s0-s0:c0.c1023 vagrant
> > +EOF
> > +    reboot_cmd = 'reboot'
>
> Is this line needed?

Indeed it's not. I used an existing script for setting up MLS policy
on a host as inspiration when writing this and didn't think twice
about whether I also need to preserve the reboot part :) I'll remove
it.

Thanks for the suggestion!

>
> -Topi
>
> > +  else
> > +    print("Invalid ROOT_DOMAIN '#{ENV['ROOT_DOMAIN']}'")
> > +    abort
> > +  end
> > +
> >     config.vm.provision :shell, inline: <<SCRIPT
> >       dnf install -y #{dnf_opts} \
> >         --allowerasing \
> > @@ -79,6 +94,7 @@ Vagrant.configure("2") do |config|
> >         jfsutils \
> >         dosfstools \
> >         #{kernel_pkgs}
> > +    #{extra_commands}
> >       #{reboot_cmd}
> >   SCRIPT
> >   end
>

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

