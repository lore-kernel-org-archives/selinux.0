Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66FC6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 16:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjCTQiE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjCTQhs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 12:37:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98224BE6
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:32:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e71so13870222ybc.0
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679329927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz1XKq8/tT7ntol+vJit20XqFPxFC3Q1HxkLByFkPwQ=;
        b=OKErbYvu37p+PMn/U4QNE96K+SpMzDUaE6HBNyhB3apNQxpJmiI+3s4lyjMJ8C4gJi
         blNdhZytr24hJWb9BdSd2gNJelp43Th23rZ3B1E/t6KUC+DY/u0tin3GKPrJGhWU9h/2
         2ydZin6Saq+A0yqIawnhib9CKuccMWR59nvmTf2Mk1zRdR0YjDqe3XhoobR8cP4o/auV
         D8YDQWQi/pqVIzBQSwTGhDkdKfuFBkjeb6eDK2fINeq1AQ6C+zqil1xQF9ZUsQT3KVxR
         9Ym1uKylPoXFbQe1yZGHC//M2Bg2eOUSddeAQmbh0XSwWOVB85uOJz9x6LhHxyyko3+R
         DSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz1XKq8/tT7ntol+vJit20XqFPxFC3Q1HxkLByFkPwQ=;
        b=29eXx73+i85D9CX+Li4m+8gULY9CqCUzVvlikfeqP/QL/NgFuwPNrD3zSUQNd7sVyQ
         KC1Q1DcahXEsytwJf+l+fHW4CK0nnoUVwtLw0XUv1bt4yxHx6jysivnkdBs86Mw0cIV3
         2dP7Tr2FUxeAb0PlAh8CQkwWtAETChr0Sl/2CDNItm1GGV3LEXtzUOZe9goQWrCDnA9i
         r0YCHOrq/+3uhjiO0nPgzjvwW4PQ9xrqIbBGXV12hg18ejydfccJJOkTOlSnL6TV757u
         m3WQXwGcqn5C0YDIuqMWDiFbRAUkYZ5TdXhbgsgsNVydpBV/SpMWC1WPdgPhFcnnq+8g
         QWjg==
X-Gm-Message-State: AO0yUKVJI5pfJySvg3sYWzn85pkL5vPFNVspzvWdgqTwn7vmzBOsAzae
        nnu3qcfqgi0PjmLxx9tGk8jIYfSo4JfUT46F1EQF
X-Google-Smtp-Source: AK7set+KMEozi+4OcWS6tsgmaEFsVgWU2+VdEU0sE3kmZY/clZmQ6Y9ceVnK1L7uCRjAZECoCNyBN2N9a3PlrMDL2AA=
X-Received: by 2002:a5b:d05:0:b0:b68:7a4a:5258 with SMTP id
 y5-20020a5b0d05000000b00b687a4a5258mr5525835ybp.3.1679329927257; Mon, 20 Mar
 2023 09:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195615.281810-1-paul@paul-moore.com> <004b613e-c139-b4dc-157b-2f61433fe1d2@digikod.net>
In-Reply-To: <004b613e-c139-b4dc-157b-2f61433fe1d2@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 12:31:56 -0400
Message-ID: <CAHC9VhQ1kPCnx9Ha_ZX+6rq2hdLOESFrz5qF2kw05j8szFu1jQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 11:14=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> This looks great, but I cannot apply it on any of these trees: Linus's,
> the LSM's next, nor the next one.

Likely because it's based on the SELinux next branch with the
checkreqprot removal patch added on top as I expect to merge both of
these patches soon.  There have also been some pretty widespread
changes in the SELinux tree this dev cycle outside these two
deprecation/removal patches.

One could make an argument that this should go in via the LSM tree as
it touches all of the LSMs, but those impacts are trivial, and the
SELinux changes are more significant so I made the decision to do the
development and merge the patch via the SELinux tree.

> On 17/03/2023 20:56, Paul Moore wrote:
> > After working with the larger SELinux-based distros for several
> > years, we're finally at a place where we can disable the SELinux
> > runtime disable functionality.  The existing kernel deprecation
> > notice explains the functionality and why we want to remove it:
> >
> >    The selinuxfs "disable" node allows SELinux to be disabled at
> >    runtime prior to a policy being loaded into the kernel.  If
> >    disabled via this mechanism, SELinux will remain disabled until
> >    the system is rebooted.
> >
> >    The preferred method of disabling SELinux is via the "selinux=3D0"
> >    boot parameter, but the selinuxfs "disable" node was created to
> >    make it easier for systems with primitive bootloaders that did not
> >    allow for easy modification of the kernel command line.
> >    Unfortunately, allowing for SELinux to be disabled at runtime makes
> >    it difficult to secure the kernel's LSM hooks using the
> >    "__ro_after_init" feature.
> >
> > It is that last sentence, mentioning the '__ro_after_init' hardening,
> > which is the real motivation for this change, and if you look at the
> > diffstat you'll see that the impact of this patch reaches across all
> > the different LSMs, helping prevent tampering at the LSM hook level.
> >
> >>From a SELinux perspective, it is important to note that if you
> > continue to disable SELinux via "/etc/selinux/config" it may appear
> > that SELinux is disabled, but it is simply in an uninitialized state.
> > If you load a policy with `load_policy -i`, you will see SELinux
> > come alive just as if you had loaded the policy during early-boot.
> >
> > It is also worth noting that the "/sys/fs/selinux/disable" file is
> > always writable now, regardless of the Kconfig settings, but writing
> > to the file has no effect on the system, other than to display an
> > error on the console if a non-zero/true value is written.
> >
> > Finally, in the several years where we have been working on
> > deprecating this functionality, there has only been one instance of
> > someone mentioning any user visible breakage.  In this particular
> > case it was an individual's kernel test system, and the workaround
> > documented in the deprecation notice ("selinux=3D0" on the kernel
> > command line) resolved the issue without problem.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   .../sysfs-selinux-disable                     |  3 +
> >   include/linux/lsm_hooks.h                     |  7 ---
> >   security/Kconfig                              |  5 --
> >   security/apparmor/lsm.c                       |  6 +-
> >   security/bpf/hooks.c                          |  4 +-
> >   security/commoncap.c                          |  2 +-
> >   security/landlock/cred.c                      |  2 +-
> >   security/landlock/fs.c                        |  2 +-
> >   security/landlock/ptrace.c                    |  2 +-
> >   security/landlock/setup.c                     |  4 +-
> >   security/loadpin/loadpin.c                    |  2 +-
> >   security/lockdown/lockdown.c                  |  2 +-
> >   security/security.c                           |  4 +-
> >   security/selinux/Kconfig                      | 24 --------
> >   security/selinux/hooks.c                      | 57 +-----------------=
-
> >   security/selinux/include/security.h           | 21 -------
> >   security/selinux/selinuxfs.c                  | 43 ++------------
> >   security/smack/smack_lsm.c                    |  4 +-
> >   security/tomoyo/tomoyo.c                      |  6 +-
> >   security/yama/yama_lsm.c                      |  2 +-
> >   20 files changed, 32 insertions(+), 170 deletions(-)
> >   rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-disabl=
e (90%)

--=20
paul-moore.com
