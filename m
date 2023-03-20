Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13643C7619A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 16:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjCTQcC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjCTQbl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 12:31:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FD7BBAD
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:24:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j7so13778583ybg.4
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679329473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p46zmrOttkh23WdGN/51jRyM1sbUVzjnWSTcpNfiF3w=;
        b=YeAdBhgUm+4yhRqKfU6WV+zF5RYj4U63fdFu5tlHj0lw8r74wyw5DK0sTi7RW3eYK4
         klkDrUW12TsHKc84H6rrdT2xxCzmnuICxTnhfq7rpzZGAn9gjux9wRYHaLoY6YmYKgCW
         UDAfZ2Hg9CtBRnsY9XvX1SSuC6bIJM6rN8cVPVEN9dRn98np78OigZe1LcLv5eos7i99
         SIgKkUskQ/cpU7CLBtaQXupuaHpBrwsVrzWAJAt3iW1B53LanMruPt5B/EHHPWfgGX4l
         yAdYDSACe+xJ5fdefF9nS9/RlhkQyU1TkMQUxj69PmV1fk/d9cq+Wzih3DFEjJw2oty7
         2GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p46zmrOttkh23WdGN/51jRyM1sbUVzjnWSTcpNfiF3w=;
        b=SVWCGu7zSqNZUYOCj7thf4uHcThaWbQP4BmCvXvVf3gCfApU5puOnpysJ00aBzmsCf
         vw+TKlWA9iar7d7JJCL9dv/44oiNbdwRTkLAXl4NiNFMUfNn7Pnot74HXJn2liPCmAzC
         Wb5wdjxiVWDGeerLAsRm99MSrqjgxXbB7njQ5AtEW8R3b0eUQE55kMGccmLJFxDrAmZ7
         ZpaY7LpUC301rsk4UzkLKjTw9nSpxlc5qZ4qOChz40mbbcq7XefwcdYLqCHaNiSSP5kS
         kV6OSHW86wZs+wVL6amwmkBvJGldSukyUxCIqaGAhr7fXYqt5v2LKLWXAGFxThDvymiH
         kUjA==
X-Gm-Message-State: AO0yUKU54bq0TShoxw6uibtnALuNY2nwcsc9Lf0TwzHRLqjVWMVybozE
        PE42hwW31SV4+BXAE2YNp18u5lsvCY1zKAUlK0jE
X-Google-Smtp-Source: AK7set/o0sgJ6r7cXd+kojJ22LhCLYSOUpU8YGfVDef62fzVXCTNDXpRUS2GqNWwHqt+OFDLjyTaQvKYccC40rXWtSg=
X-Received: by 2002:a05:6902:385:b0:b6e:361a:c86 with SMTP id
 f5-20020a056902038500b00b6e361a0c86mr970015ybs.3.1679329473378; Mon, 20 Mar
 2023 09:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195615.281810-1-paul@paul-moore.com> <CAFqZXNuzNk70yS-BuChSdaG-n3jNR4vq+bQFryLfAnWODGprfg@mail.gmail.com>
In-Reply-To: <CAFqZXNuzNk70yS-BuChSdaG-n3jNR4vq+bQFryLfAnWODGprfg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 12:24:22 -0400
Message-ID: <CAHC9VhRW_efeWBDqk3TgQv4MbPh4VM2tLx8Hu6Jui-=FJk=gsA@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Mar 18, 2023 at 3:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Fri, Mar 17, 2023 at 8:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > After working with the larger SELinux-based distros for several
> > years, we're finally at a place where we can disable the SELinux
> > runtime disable functionality.  The existing kernel deprecation
> > notice explains the functionality and why we want to remove it:
> >
> >   The selinuxfs "disable" node allows SELinux to be disabled at
> >   runtime prior to a policy being loaded into the kernel.  If
> >   disabled via this mechanism, SELinux will remain disabled until
> >   the system is rebooted.
> >
> >   The preferred method of disabling SELinux is via the "selinux=3D0"
> >   boot parameter, but the selinuxfs "disable" node was created to
> >   make it easier for systems with primitive bootloaders that did not
> >   allow for easy modification of the kernel command line.
> >   Unfortunately, allowing for SELinux to be disabled at runtime makes
> >   it difficult to secure the kernel's LSM hooks using the
> >   "__ro_after_init" feature.
> >
> > It is that last sentence, mentioning the '__ro_after_init' hardening,
> > which is the real motivation for this change, and if you look at the
> > diffstat you'll see that the impact of this patch reaches across all
> > the different LSMs, helping prevent tampering at the LSM hook level.
> >
> > From a SELinux perspective, it is important to note that if you
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
>
> Nice, thank you for closing the loop on this :)

Thanks also goes to all the people who worked in the userspace and
distros to get us to that point.  The kernel patch is the easy part ;)

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 9a58971f9a16..79b4890e9936 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6769,7 +6769,7 @@ static void selinux_bpf_prog_free(struct bpf_prog=
_aux *aux)
> >  }
> >  #endif
> >
> > -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init =3D {
> > +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> >         .lbs_cred =3D sizeof(struct task_security_struct),
> >         .lbs_file =3D sizeof(struct file_security_struct),
> >         .lbs_inode =3D sizeof(struct inode_security_struct),
> > @@ -6905,7 +6905,7 @@ static int selinux_uring_cmd(struct io_uring_cmd =
*ioucmd)
> >   * safely. Breaking the ordering rules above might lead to NULL pointe=
r derefs
> >   * when disabling SELinux at runtime.
> >   */
> > -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =
=3D {
> > +static struct security_hook_list selinux_hooks[] __ro_after_init =3D {
> >         LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_contex=
t_mgr),
> >         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> >         LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_b=
inder),
>
> It would be nice to also undo cfff75d8973a ("selinux: reorder hooks to
> make runtime disable less broken"), which is no longer necessary.

True, but I would prefer to do that later once we've landed this
without any major breakage.  The only reason I combined the
__lsm_ro_after_init changes with the runtime disable changes is that
the latter doesn't make sense without the former, and I worry that
separating the changes into two patches would lead to problems if/when
people start cherry picking for backports.

--=20
paul-moore.com
