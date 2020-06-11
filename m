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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB9C433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E928206DC
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgC1zGGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgFKQTM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQTM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 12:19:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F876C08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 09:19:12 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r77so6956646ior.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1jxi9phB3irZQyubB214P9rzhqEFUWsIl8ah6anTHI=;
        b=EgC1zGGUhSdY2wXarAjhGm1hkbWWT3XN1rwFo7/7UO6nHmpSxNsJsQBkwxluPL8dz0
         BRAEHgNTluRDRz3tL8No7cEddGpaBRFHP411kT7FsmFeUS8JchDABOXVmIthDswprdcR
         wv1kDZbr1sUozkFyJ/mdSu0jJTndhUOc5R5ll76VlZCfNEYYkz7vownvQ7K51Qe8h1Hy
         cmaTsIfEkoourHsIHNGDsShImK5WJZnZbNFCkh46zOhboa+rsKjgG97b2erBropfhoe7
         wt7CTLHshynTF2ikAb8Hg/c6NdokPz4rs3kK61nadikNeNK4Tud8o5t+/Rjd7gqm7zuv
         hOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1jxi9phB3irZQyubB214P9rzhqEFUWsIl8ah6anTHI=;
        b=Mr0+lec1hASa90IPJRfzdAqUdQR5atn34BJVKsBg+2wnDLAxszuHlQ2D94VUGDq4bp
         VOw1gsnMlivbQVcGtWjpDmBJOesbUrFhqpI+6j0Jp77nl5dOePIKzvryfHtYzo5hNU60
         L8pEbgepGdgY9CCeTfOILJqrSxovjBUw4tmqwof+Ox0L5OMW/wfPv3O8oz4JjzaXaNpg
         oqcsAKZ/OHJljm0H8fJ4z0EdH6Wqqef7vbJ9ecCgRol2fy2cc/+xPYDRAQwqneF4F216
         n48prRSqjjF9BlTZvZTHUp0CMr+Feh9nEk0s9H2mgmeSurcmegU6zUMv+t41iUKxq6Tw
         LRng==
X-Gm-Message-State: AOAM530o0wpFvQyol7DyKWMX4c9eqMJzhVH2x8JEtQOiCMJpeE46deZG
        naOU/q543Zc6hkUvijKOJyPrIZxf8LP9HzsIhgI=
X-Google-Smtp-Source: ABdhPJzxlT9879jDFNgcvxqP92EaOHDGQ9/j3DBnBLB4XGqBTkZNZGPyNeqyGuPwTe0xRPs3pDXgrym2oQVsr3s906A=
X-Received: by 2002:a05:6602:164c:: with SMTP id y12mr9275916iow.143.1591892351647;
 Thu, 11 Jun 2020 09:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
 <20200611140557.6359-1-william.c.roberts@intel.com> <20200611153434.GA468661@localhost.localdomain>
 <20200611155522.GB468661@localhost.localdomain>
In-Reply-To: <20200611155522.GB468661@localhost.localdomain>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Jun 2020 11:19:00 -0500
Message-ID: <CAFftDdocJcTrZh9WV8Jxu9CPPcjJDyFtnSHA8n8MyZtCQCJztg@mail.gmail.com>
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

On Thu, Jun 11, 2020 at 10:55 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Jun 11, 2020 at 05:34:34PM +0200, Petr Lautrbach wrote:
> > On Thu, Jun 11, 2020 at 09:05:57AM -0500, bill.c.roberts@gmail.com wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > Not everyone's github project is "selinux" so use the projects
> > > name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> > > the absolute path to the project checkout on disk, so the
> > > basename should be sufficient.
> > >
> > > Tested on Travis CI here:
> > >   - https://travis-ci.org/github/williamcroberts/selinux/jobs/697201376
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  scripts/ci/travis-kvm-setup.sh | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
> > > index 864dbac96a46..ceedaa6f4e27 100755
> > > --- a/scripts/ci/travis-kvm-setup.sh
> > > +++ b/scripts/ci/travis-kvm-setup.sh
> > > @@ -120,6 +120,7 @@ fi
> > >  # we don't get blocked on asking to add the servers key to
> > >  # our known_hosts.
> > >  #
> > > -ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> > > +project_dir="$(basename "$TRAVIS_BUILD_DIR")"
> > > +ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/$project_dir/$TEST_RUNNER"
> > >
> > >  exit 0
> > > --
> > > 2.17.1
> > >
> >
> > Thanks!
> >
> > I'm running a new job again with this fix. But I guess you need to change
> > fedora-test-runner.sh as well. There's also hardcoded "selinux":
> >
> > ~~~
> > # Move to selinux code and build
> > #
> > cd "$HOME/selinux"
> > ~~~
> >
>
> https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697271776
>
> ~~~
> # Move to selinux code and build
> #
> cd "$HOME/selinux"
> /root/SELinuxProject-selinux/scripts/ci/fedora-test-runner.sh: line 61: cd: /root/selinux: No such file or directory
> The command "scripts/ci/travis-kvm-setup.sh" exited with 1.
>
> Done. Your build exited with 1.
> ~~~

You can add this diff for now, ill post a v2 patch after I confirm
travis still runs.

diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
index 0927ed5dad8f..067d7bd65906 100755
--- a/scripts/ci/fedora-test-runner.sh
+++ b/scripts/ci/fedora-test-runner.sh
@@ -58,7 +58,8 @@ dnf install -y \
 #
 # Move to selinux code and build
 #
-cd "$HOME/selinux"
+project_dir="$(basename "$TRAVIS_BUILD_DIR")"
+cd "$HOME/$project_dir"

 # Show HEAD commit for sanity checking
 git log -1
@@ -71,7 +72,7 @@ make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64
install-pywrap
 make -j"$(nproc)" LIBDIR=/usr/lib64 SHLIBDIR=/lib64 relabel

 #
-# Get the selinux testsuite, but don't clone it in $HOME/selinux, move to $HOME
+# Get the selinux testsuite, but don't clone it in
$HOME/$project_dir, move to $HOME
 # first.
 #
 cd "$HOME"
