Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA3C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiGFUL6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiGFUL5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 16:11:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A941EADA
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 13:11:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l81so21134296oif.9
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YatNl4xTFFyak3rdin2L4kKjQeWTzmHk5FGZcv7zvdU=;
        b=ChETzjFOTXz/GG9Qb0Edrr6br/byLqbyv4ncFVHQgLlfvuVjsbLMANae9SmpGprvMR
         j+kx8Cr3m+82P18sDwmBvDx8zR19LQG5pKEHO3b+hvYtWCEOc7WVXf2gzThJXKNliRCv
         YEtOOcNn0YlHasxGIg6ETiHFvv2dgXOE+l6omjTz5aKc1OwLbKLKoNtnF3ZqaVVu4QSo
         UAFw3noLok3LaCW6GgAFqPv8ozUOu0JIwO+GI5z8EnyUb+MsdoklkUh7s6wVMGTtAC81
         yTRO+ojXBX0reMvXwreW5YaDvIlqnaOfrAI6yQREbSpQ7MNhUi7o0ZmempPedkaiW08O
         MNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YatNl4xTFFyak3rdin2L4kKjQeWTzmHk5FGZcv7zvdU=;
        b=gul08HM7dIXsIYxulWm7IhGYGKi1DsJLBt4Hpfkq+SzS+hzv+qtbUYm7r254a12bxJ
         oU6GO3hpFq6g2fbY1E3UD60H14/3pr42G03sb+ijM/LwT3ePhspEmJB82nzTjCWZOsE4
         z/ESCRxmpaTA9u8HVA8I7WOnQnK5lKYuPNWl6H5v2MZtE5gg2jRpF/+q0knnQZSCqgp4
         q0b7hPwxs6gHdcYFAl8mBUfV1crCpShc/Fb0AKZqwSsuyKekhXxR3uXkq9E9sCkwrsy4
         2DWJap/LljH2BQtL8gPCyyLLazmqAUP2PWP/kW/5hGVXKTzuwj5vfWlRHbPmdQH0gr3U
         4dUA==
X-Gm-Message-State: AJIora9GQ7lfQxfgFqHkgHcn7r/LD0oDmf1heu9x9d8zEOKuqYjKz53p
        9bzVYuBnmm1Nn1IzF5ai/kCONss0+UsmhImVMrtL8v0F
X-Google-Smtp-Source: AGRyM1vddMe2ZYJ1i+Ap535HEPtDjDoRKSpHtzsTs+KEzON9YvcPfayUvmmUi1b3p2DqhsP1kSCQr0iipP9y4NLA9Do=
X-Received: by 2002:a05:6808:198c:b0:335:9b27:95b with SMTP id
 bj12-20020a056808198c00b003359b27095bmr239211oib.182.1657138316076; Wed, 06
 Jul 2022 13:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220629071254.2653210-1-nicolas.iooss@m4x.org> <CAP+JOzTjz=5sn0e=R1cNZKwodP6bFnuV8dxOwQwevFof0pWYLA@mail.gmail.com>
In-Reply-To: <CAP+JOzTjz=5sn0e=R1cNZKwodP6bFnuV8dxOwQwevFof0pWYLA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Jul 2022 16:11:45 -0400
Message-ID: <CAP+JOzS=kYu75A+5oo65=WUggNLC89rLTaX35C2dMqbg899i3Q@mail.gmail.com>
Subject: Re: [PATCH userspace 1/1] CircleCI: do not add Debian-specific
 parameter when invoking setup.py
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 30, 2022 at 2:14 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 3:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Runners on https://circleci.com/ use a custom version of Python without
> > Debian-specific patches which added option --install-layout=deb. This
> > leads to the following error:
> >
> >     error: option --install-layout not recognized
> >
> > Fix this by creating a new environment variable dedicated to detect
> > CircleCI platform.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > Hello,
> > Even though the https://github.com/SELinuxProject/selinux is not using CircleCI,
> > I have been using it for some years to generate a scan-build output which is
> > directly hosted as build artifacts. This commit is about making the CircleCI
> > work again.
> >
> > If you are interested about the results, the "pipeline" I am using is on
> > https://app.circleci.com/pipelines/github/fishilico/selinux?filter=all
> > and it generates scan-build reports such as
> > https://output.circle-artifacts.com/output/job/20523141-5b39-4604-913b-78701e506f2b/artifacts/0/output-scan-build/2022-06-28-220742-7144-1/index.html
> >
> > Cheers,
> > Nicolas
> >
> >  .circleci/config.yml   | 1 +
> >  scripts/run-scan-build | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/.circleci/config.yml b/.circleci/config.yml
> > index af20484b9ca5..a75d34c23959 100644
> > --- a/.circleci/config.yml
> > +++ b/.circleci/config.yml
> > @@ -19,6 +19,7 @@ jobs:
> >          name: Setup environment variables
> >          command: |
> >            echo 'export DESTDIR=$HOME/destdir' >> "$BASH_ENV"
> > +          echo 'export IS_CIRCLE_CI=1' >> "$BASH_ENV"
> >
> >      # Download and install refpolicy headers for sepolgen tests
> >      - run:
> > diff --git a/scripts/run-scan-build b/scripts/run-scan-build
> > index fad2a887bc5b..9c3bf0877332 100755
> > --- a/scripts/run-scan-build
> > +++ b/scripts/run-scan-build
> > @@ -24,7 +24,7 @@ export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH
> >  export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
> >  export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
> >
> > -if [ -f /etc/debian_version ]; then
> > +if [ -f /etc/debian_version ] && [ -z "${IS_CIRCLE_CI:-}" ] ; then
> >      export PYTHON_SETUP_ARGS='--install-layout=deb'
> >  fi
> >
> > --
> > 2.36.1
> >
