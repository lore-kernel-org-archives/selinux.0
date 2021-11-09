Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C55C433EF
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 20:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E81960724
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 20:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbhKIUwj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 15:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244763AbhKIUwj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 15:52:39 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D0C061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 12:49:53 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so561995ote.8
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCCf7snbBRyulfVErwe6sBGgqzDJwSfRcAB0Ox+gbUY=;
        b=REiPkkgS6Kuyj3NDV/mtoBb2/pVWCmn99J+RWvNoSptIj9J2ym84CsiUgmo+qvoVGX
         nKTsQN9etxlklsERaLSKCwtZb5ykvDyZ9gYrIoTmwTMj2rUArmpu/JUtMVj9YJ8hTssF
         XM3ifkKU9wWKbuLnYCpn9xEN/Y/OkN4SdSq72R5wdH07JecaNYt3CkER1jFBn5E11CPC
         eRWo8x9ZiFbKP8DH6Xzv1aTPI3QemwIC3IE8+jMehmkTH+rMY6SYGIvy2+BEf2DjWfwj
         8/s4AMJnYCUmZv+icxgpZY9UAmHhciPw3S6cnz1xjkCDl7XNiuFjJdHmlBIeGuXsWVZJ
         UXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCCf7snbBRyulfVErwe6sBGgqzDJwSfRcAB0Ox+gbUY=;
        b=aiyZXMZOEg7DcCVwtI/pU8G5+1uHCiJqP7i95o/Eby09u/Qe70mf5RKlDPwfoO1A5o
         72rqb6vlwRhyXRd0nxjO2PFAkQFSmyi+VojyIkfhptsQtpS4Ew8RhtwnGW+ENE0a7nuj
         IAeHxsoLXVFA9hFXascTY6oS89ZvFHy9LSikPJ8b8BrfmcsaK/bYW/ElvEssu03bkNda
         p2XYQOnYPx0P/8oBqa2T8yrQw8Qq1/feMwJG7x4Q9duaazjZd1deOg45vphQc6YXttj5
         ReWE7Y9qgUMaMRtqbthOQRC8q2b/1m7Ei7Ozqwlw9ixO2lEVA5TpnvfAgWJOuPTiOMn9
         JwlQ==
X-Gm-Message-State: AOAM533T6g8VuNrDHlT7MM6LIgOv344LUadYqqyBt6pLfkDxDoYyMwmG
        t2fV4lPdYBOtcM0zBA1wlx06AUOB+X0IfaAlaeAw+cwm
X-Google-Smtp-Source: ABdhPJzxDL/i97Zo6YJ1ao8UMQfjG0QC64xn0nrQuIuOGaXechMGAIbu2k1RniluvyQJOKqNYfuW/TWguV1gD8DS8p8=
X-Received: by 2002:a9d:6346:: with SMTP id y6mr8750632otk.154.1636490992390;
 Tue, 09 Nov 2021 12:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20211027181210.1019597-1-jwcart2@gmail.com> <CAEjxPJ4kNNPkzLcU1Ovr5DWSo7obkm+QyueMt7BE3r7ALuUnqg@mail.gmail.com>
 <CAJfZ7=k-1FE27swaxcnHki_0pJCZqZRgno=0fUN52VHWs7e3Bw@mail.gmail.com>
In-Reply-To: <CAJfZ7=k-1FE27swaxcnHki_0pJCZqZRgno=0fUN52VHWs7e3Bw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Nov 2021 15:49:41 -0500
Message-ID: <CAP+JOzQGSHHM_uuLhLywAERM4uwTxmpN-_-JnxcmfEV=JwC5Mg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix/add optional file type handling for genfscon rules
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 8, 2021 at 4:46 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Nov 4, 2021 at 9:09 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Oct 27, 2021 at 5:32 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > genfscon rules have always supported an optional file type, but when
> > > the ability for writing a policy.conf file from a kernel policy was
> > > added to libsepol it did not include that support. Support for the
> > > optional file type was also left out of CIL genfscon rules.
> > >
> > > This patch set fixes these problems.
> > >
> > > Patch 1 adds support for writing the optional file type in genfscon rules
> > > when writing a policy.conf file from a kernel policy.
> > >
> > > Patches 2-4 adds support in CIL for handling an optional file type
> > > in genfscon rules, updates the CIL documentation, and adds support
> > > when writing out CIL from a kernel policy or module as well.
> > >
> > > James Carter (4):
> > >   libsepol: Add support for file types in writing out policy.conf
> > >   libsepol/cil: Allow optional file type in genfscon rules
> > >   secilc/docs: Document the optional file type for genfscon rules
> > >   libsepol: Write out genfscon file type when writing out CIL policy
> > >
> > >  libsepol/cil/src/cil_binary.c               | 39 +++++++++++++++++++
> > >  libsepol/cil/src/cil_build_ast.c            | 43 +++++++++++++++++++--
> > >  libsepol/cil/src/cil_internal.h             |  1 +
> > >  libsepol/src/kernel_to_cil.c                | 35 ++++++++++++++++-
> > >  libsepol/src/kernel_to_conf.c               | 35 ++++++++++++++++-
> > >  libsepol/src/module_to_cil.c                | 27 ++++++++++++-
> > >  secilc/docs/cil_file_labeling_statements.md | 10 ++++-
> > >  7 files changed, 179 insertions(+), 11 deletions(-)
> >
> > Something here breaks on the selinux-testsuite policy:
> >
> > 3231# Run the test suite
> > 3232#
> > 3233make test
> > 3234make -C policy load
> > 3235make[1]: Entering directory '/root/selinux-testsuite/policy'
> > 3236# Test for "expand-check = 0" in /etc/selinux/semanage.conf
> > 3237# General policy build
> > 3238make[2]: Entering directory '/root/selinux-testsuite/policy/test_policy'
> > 3239Compiling targeted test_policy module
> > 3240Creating targeted test_policy.pp policy package
> > 3241rm tmp/test_policy.mod tmp/test_policy.mod.fc
> > 3242make[2]: Leaving directory '/root/selinux-testsuite/policy/test_policy'
> > 3243# General policy load
> > 3244domain_fd_use --> on
> > 3245/usr/sbin/semodule -i test_policy/test_policy.pp
> > test_mlsconstrain.cil test_overlay_defaultrange.cil
> > test_userfaultfd.cil test_add_levels.cil test_glblub.cil
> > 3246What is going on?
> > 3247Failed to generate binary
> > 3248/usr/sbin/semodule: Failed!
> > 3249make[1]: *** [Makefile:189: load] Error 1
> > 3250make[1]: Leaving directory '/root/selinux-testsuite/policy'
> > 3251make: *** [Makefile:7: test] Error 2
> > 3252Error: Process completed with exit code 2.
>
> Hello,
>
> This error happens because cil_genfscon_init() does not initialize
> ->file_type, and cil_genfscon_to_policydb() then reads an
> uninitialized value. The attached patch (on top of this series) fixed
> the CI for me.
>
> Cheers,
> Nicolas

Thanks for finding the problem. There is a few other additions that
are needed, so a v2 will be coming.
Jim
