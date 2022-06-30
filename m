Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29512C433EF
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiF3SOo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiF3SOd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 14:14:33 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B897741619
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 11:14:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so13448171otr.11
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWR1DJGBkpxDbRsFivnnSx8ff2dcDnqZ6V3MYTBaVVY=;
        b=CgcAvXd2zrAlUnUvVX9wqXmtkmIdfMd1WPgWBnfzSWhHcavIORxSsOAZOgB3mB7v7p
         cDVZOSXHDOyLvgVvmxGoiOfXPi6IOw1BGllvBgY1jXvh+sXzjQRf+Y/qig2JgLWZmNNM
         mMO5vCVN7yNa0MEBXHK8og/2RUW7q8f8GYQWXHWq+PAEHKhUKlT5TUfinoybTNvXsK9k
         P31l5VXUEdAPvqcuFPJXvtx5Hnmr4S9uOlUEWMfasQ7F9U6tPx3UIZ5GZMsAtYAp8iTz
         TE325wy5rE48QFXiH57NQS4P4+tKd54ngpQsF2VmN2x9QO0PghSdNKKHSS2JXbOuMhKz
         b/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWR1DJGBkpxDbRsFivnnSx8ff2dcDnqZ6V3MYTBaVVY=;
        b=6hqvSl8j0LyK17GIqzb/wjyF4EMlN/SL9jYa0Zv1BUw9DCZUgXzK21rXIlpj/oyQOL
         ebG3s/g+MIymR7dbAhThn23lw2S3ywad8/LrFSIaWLVXPjkQEellbdaJCoL2rTFJ/PHg
         eLAa3DsnN68Mm66NKCIua0jT4LMrnnfXJksBVqVFbPef49947dyN0K6wXaE9dDBxnAzc
         umZ6ZuwhLdHis2UL9uR7aOhWSuduueCmHvAAHEn44Cx1ft4T0GUoXSSi4pGJEr3wUDKl
         vtIVeACxIW7cSnkUdp9etHYHqT47TZ8rw1cemRffWSbCfjzWf0t66dqIT2WFsS2i1NTo
         O42A==
X-Gm-Message-State: AJIora9JEeRNmwEXw25YPFYuh5dhJ70/1b7/7Ugf0tolCnFGvpBSHVmj
        l5/WZmqWzA8aLfSxuZReYx7u5gJVVbFE9JsQt/YpTH9emaU=
X-Google-Smtp-Source: AGRyM1vFWmiIrsxgWKzL5RycstF2dNgMxqWCs9n2NqWB/aErh8Zx6Y93Em6z6rvpgvpzN35xkT5/TCrbSZcK84WQesE=
X-Received: by 2002:a05:6830:91d:b0:616:e98c:2581 with SMTP id
 v29-20020a056830091d00b00616e98c2581mr4763479ott.53.1656612858941; Thu, 30
 Jun 2022 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220629071254.2653210-1-nicolas.iooss@m4x.org>
In-Reply-To: <20220629071254.2653210-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Jun 2022 14:14:08 -0400
Message-ID: <CAP+JOzTjz=5sn0e=R1cNZKwodP6bFnuV8dxOwQwevFof0pWYLA@mail.gmail.com>
Subject: Re: [PATCH userspace 1/1] CircleCI: do not add Debian-specific
 parameter when invoking setup.py
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 3:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Runners on https://circleci.com/ use a custom version of Python without
> Debian-specific patches which added option --install-layout=deb. This
> leads to the following error:
>
>     error: option --install-layout not recognized
>
> Fix this by creating a new environment variable dedicated to detect
> CircleCI platform.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Hello,
> Even though the https://github.com/SELinuxProject/selinux is not using CircleCI,
> I have been using it for some years to generate a scan-build output which is
> directly hosted as build artifacts. This commit is about making the CircleCI
> work again.
>
> If you are interested about the results, the "pipeline" I am using is on
> https://app.circleci.com/pipelines/github/fishilico/selinux?filter=all
> and it generates scan-build reports such as
> https://output.circle-artifacts.com/output/job/20523141-5b39-4604-913b-78701e506f2b/artifacts/0/output-scan-build/2022-06-28-220742-7144-1/index.html
>
> Cheers,
> Nicolas
>
>  .circleci/config.yml   | 1 +
>  scripts/run-scan-build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.circleci/config.yml b/.circleci/config.yml
> index af20484b9ca5..a75d34c23959 100644
> --- a/.circleci/config.yml
> +++ b/.circleci/config.yml
> @@ -19,6 +19,7 @@ jobs:
>          name: Setup environment variables
>          command: |
>            echo 'export DESTDIR=$HOME/destdir' >> "$BASH_ENV"
> +          echo 'export IS_CIRCLE_CI=1' >> "$BASH_ENV"
>
>      # Download and install refpolicy headers for sepolgen tests
>      - run:
> diff --git a/scripts/run-scan-build b/scripts/run-scan-build
> index fad2a887bc5b..9c3bf0877332 100755
> --- a/scripts/run-scan-build
> +++ b/scripts/run-scan-build
> @@ -24,7 +24,7 @@ export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH
>  export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
>  export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
>
> -if [ -f /etc/debian_version ]; then
> +if [ -f /etc/debian_version ] && [ -z "${IS_CIRCLE_CI:-}" ] ; then
>      export PYTHON_SETUP_ARGS='--install-layout=deb'
>  fi
>
> --
> 2.36.1
>
