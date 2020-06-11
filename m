Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AD4C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD019207ED
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA6q0BjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFKQok (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQok (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 12:44:40 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA3C08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 09:44:39 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p5so6072266ile.6
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjNzPU3uHutCI95NAdFNndsD6ShvMY3I8tK+xFieYAs=;
        b=MA6q0BjTXFKiXetNmk65dIl+XST27kzmkYL0srab8GU2F8gdXz1PbyUXjEQ73+/c3s
         pnLVjgpvbO5D5E0cLNiXbmcLDh0+xtOL635xCs9Ax9pF1CnrcuL7rOHnNYk4URfZsRp/
         AU2CeJX9naNW9I7NiVRzGYvUD8K055vMdhhWSmk/yt3m2kxmgoY6jYO2hHCWXtEfyhwI
         FTWGN5YvA6lcW8O2z35WGjP0GoSwk8PP9UDtO9iPIceWKZkEeRihYJgDS3562iUgTjpO
         3kGN433RVq8cTb3G2IQrBUNoEAEjHUppgH5NY72NH/XwIl7DypB41D63bWm9B5sqsqro
         /Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjNzPU3uHutCI95NAdFNndsD6ShvMY3I8tK+xFieYAs=;
        b=LSIZ0Y8livNS7JBZ2DaKK53wDCIlzti/X9ij3f1sw1lBvC7ZSjg4Vg/lsQw1WyBeTV
         /BQgpK+B600+536N8FPLTvQT++pLL2tbIl079doavO0hylPdH9boN1mzlwyEzcKh/FPP
         eyGU1EhIkmd+vVdKPjtG/ezcKBxETvit2NSW5jLshgxMGXp8Uavh9KbMmK80CJ78hwna
         61um5Bm0zvYEcIWnxc8p4P3T9voshr8dRo6n3oAK0QOFJi/A7hjh5tuTyPhH6eFENN4d
         VYyna43Zhf9569YlqBTu10VlkRy3xt2kDpvpd9FwyXBFNB6FM5HstpYCXucnFewAbzgX
         O3YQ==
X-Gm-Message-State: AOAM531PioTEFnPbQYDk338frsyiD8fEOEnFhtri4TaCnb0QfpU4x+gb
        g0cLjoBVXzTJef3nsldVcTwTUvD4ACE3lA+YudjDpwdn
X-Google-Smtp-Source: ABdhPJyN6MgFeBVwHl9/0s/TkJodIPMFcWZlJjmlG2M1QjUGYAVbypukVepMoEnsN3A6cqTMAGrHhG1YCjJyG6E9Q2o=
X-Received: by 2002:a92:5b15:: with SMTP id p21mr8987670ilb.22.1591893878969;
 Thu, 11 Jun 2020 09:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
 <20200611140557.6359-1-william.c.roberts@intel.com> <20200611153434.GA468661@localhost.localdomain>
 <20200611155522.GB468661@localhost.localdomain> <CAFftDdocJcTrZh9WV8Jxu9CPPcjJDyFtnSHA8n8MyZtCQCJztg@mail.gmail.com>
In-Reply-To: <CAFftDdocJcTrZh9WV8Jxu9CPPcjJDyFtnSHA8n8MyZtCQCJztg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Jun 2020 11:44:27 -0500
Message-ID: <CAFftDdrszrtxO64GtiGKyszae-rNv9Kohzs-jwmxgtW3rfTnJw@mail.gmail.com>
Subject: Re: [PATCH] ci: dont use hardcoded project name
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 11:19 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Jun 11, 2020 at 10:55 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > On Thu, Jun 11, 2020 at 05:34:34PM +0200, Petr Lautrbach wrote:
> > > On Thu, Jun 11, 2020 at 09:05:57AM -0500, bill.c.roberts@gmail.com wrote:
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > Not everyone's github project is "selinux" so use the projects
> > > > name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> > > > the absolute path to the project checkout on disk, so the
> > > > basename should be sufficient.
> > > >
> > > > Tested on Travis CI here:
> > > >   - https://travis-ci.org/github/williamcroberts/selinux/jobs/697201376
> > > >
> > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > ---
> > > >  scripts/ci/travis-kvm-setup.sh | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> > > > index 864dbac96a46..ceedaa6f4e27 100755
> > > > --- a/scripts/ci/travis-kvm-setup.sh
> > > > +++ b/scripts/ci/travis-kvm-setup.sh
> > > > @@ -120,6 +120,7 @@ fi
> > > >  # we don't get blocked on asking to add the servers key to
> > > >  # our known_hosts.
> > > >  #
> > > > -ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> > > > +project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> > > > +ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/$project_dir/$TEST_RUNNER"
> > > >
> > > >  exit 0
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > Thanks!
> > >
> > > I'm running a new job again with this fix. But I guess you need to change
> > > fedora-test-runner.sh as well. There's also hardcoded "selinux":
> > >
> > > ~~~
> > > # Move to selinux code and build
> > > #
> > > cd "$HOME/selinux"
> > > ~~~
> > >
> >
> > https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697271776
> >
> > ~~~
> > # Move to selinux code and build
> > #
> > cd "$HOME/selinux"
> > /root/SELinuxProject-selinux/scripts/ci/fedora-test-runner.sh: line 61: cd: /root/selinux: No such file or directory
> > The command "scripts/ci/travis-kvm-setup.sh" exited with 1.
> >
> > Done. Your build exited with 1.
> > ~~~
>
> You can add this diff for now, ill post a v2 patch after I confirm
> travis still runs.
>
> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> index 0927ed5dad8f..067d7bd65906 100755
> --- a/scripts/ci/fedora-test-runner.sh
> +++ b/scripts/ci/fedora-test-runner.sh
> @@ -58,7 +58,8 @@ dnf install -y \
>  #
>  # Move to selinux code and build
>  #
> -cd "$HOME/selinux"
> +project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> +cd "$HOME/$project_dir"
>
>  # Show HEAD commit for sanity checking
>  git log -1
> @@ -71,7 +72,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64
> install-pywrap
>  make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel
>
>  #
> -# Get the selinux testsuite, but don't clone it in $HOME/selinux, move to $HOME
> +# Get the selinux testsuite, but don't clone it in
> $HOME/$project_dir, move to $HOME
>  # first.
>  #
>  cd "$HOME"

Oh darn that won't work, as the travis env variables are not
propagated into the environment... let me
see if I can do that.
