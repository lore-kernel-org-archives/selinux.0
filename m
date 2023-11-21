Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C3AC61D97
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 23:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjKUXqk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 18:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjKUXqj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 18:46:39 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDBF98
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 15:46:35 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso5691222276.0
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700610394; x=1701215194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQufjF28qpPrJPBHFbfkrMnyNqB98p93lClEfrJEVXU=;
        b=PrQgn6Kc8wJvvgfZiJs4+EV+BdzZqZ46I10Bl56BiX+WDDoFYKhw5rbhNfwYkZy8oN
         rXi3wDo7Jc58/+lGAcyEWVqLg5rHhg5WnlCeKN62xE8dskRkinwOcsmLHHd9MrNFAJ6y
         OwDXprMOCvszw7YEMTxkmLrY22kCv+UyD3I8ESpchSpg1KrfvrY0MtFi8ExYUUVYZgq8
         k/RqHcbvltu4zd/cw51m2DGz3etIO4Q8bIaKhuFJFNkOuUCjLvWsERa49/U/TNLavqZK
         eyh/XcPrsWRJDq11+3Emww57+9MxdvbNxMEdcoL+bXi+DQYs233++Tra6xqeC0UqccKR
         b8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610394; x=1701215194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQufjF28qpPrJPBHFbfkrMnyNqB98p93lClEfrJEVXU=;
        b=SiHggdDrT9DlX9xd7Q25YnbA6aPKjV7wxyseeRKJk9lo0K5yCChbIMZJDiDyiUAvhP
         Xcu4h22K4VVa0V0o5e3lfkdpifaDWANVgeFGRS8bfCqD0pl64eExgLen1o6UHZ9poyEY
         DROsclzazkl3GQw2vXGVstYkGVsqOrjuE2UzCNmPYJTWpLtyLyzg1Mc3WfWppaa4WnfK
         1IrCW0R29mdgNB+BFc8b95JmYqaN+W2Z0dtGkshs/B45edU9dF3JIc7B3nffKd6CgEPO
         hqW7DuZ81mCEgyBG+rvltMf5EHDmZneizeqcxJ5oCFjCyfLtn1nH8lpeZci4m50TPTrH
         Ox4g==
X-Gm-Message-State: AOJu0Yz3NB+4t8n2BWI4xG1RMESeo5VULh11w9p+xP2eT58TDqHqb9T9
        ZK8z/mrvDGgiTk+am7mp40zUhkyUhsdpPQrpwn2BSCsRLUUhppRPlQ==
X-Google-Smtp-Source: AGHT+IEGNXqX3Yq1hRXsFayQnpVZ+Dv2XYMh6ODoTLMyA4WKH61+t6f0F2DBKvTEwGE3brGn6TdQlUh+6eQ2hGKtb5s=
X-Received: by 2002:a05:6902:11cc:b0:da0:5043:db17 with SMTP id
 n12-20020a05690211cc00b00da05043db17mr532686ybu.47.1700610394389; Tue, 21 Nov
 2023 15:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20231114155116.462883-1-omosnace@redhat.com> <CAEjxPJ4bSxh0wTar4otZu+PYkb6Aa=tKR_OpF0pBAS-vJf_rTQ@mail.gmail.com>
 <CAFqZXNs8ENEJowp9pHE=hWeBY+g6oz=zAExdTE6G6MNupjmMtg@mail.gmail.com>
In-Reply-To: <CAFqZXNs8ENEJowp9pHE=hWeBY+g6oz=zAExdTE6G6MNupjmMtg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Nov 2023 18:46:23 -0500
Message-ID: <CAHC9VhQgCdvDHeXjWzySD3CknVhOQUmP9fu-CUjTAtQStMRygQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 21, 2023 at 9:59=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Nov 21, 2023 at 3:01=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Nov 14, 2023 at 10:51=E2=80=AFAM Ondrej Mosnacek <omosnace@redh=
at.com> wrote:
> > >
> > > Currently, SELinux doesn't allow distinguishing between kernel thread=
s
> > > and userspace processes that are started before the policy is first
> > > loaded - both get the label corresponding to the kernel SID. The only
> > > way a process that persists from early boot can get a meaningful labe=
l
> > > is by doing a voluntary dyntransition or re-executing itself.
> > >
> > > Reusing the kernel label for userspace processes is problematic for
> > > several reasons:
> > > 1. The kernel is considered to be a privileged domain and generally
> > >    needs to have a wide range of permissions allowed to work correctl=
y,
> > >    which prevents the policy writer from effectively hardening agains=
t
> > >    early boot processes that might remain running unintentionally aft=
er
> > >    the policy is loaded (they represent a potential extra attack surf=
ace
> > >    that should be mitigated).
> > > 2. Despite the kernel being treated as a privileged domain, the polic=
y
> > >    writer may want to impose certain special limitations on kernel
> > >    threads that may conflict with the requirements of intentional ear=
ly
> > >    boot processes. For example, it is a good hardening practice to li=
mit
> > >    what executables the kernel can execute as usermode helpers and to
> > >    confine the resulting usermode helper processes. However, a
> > >    (legitimate) process surviving from early boot may need to execute=
 a
> > >    different set of executables.
> > > 3. As currently implemented, overlayfs remembers the security context=
 of
> > >    the process that created an overlayfs mount and uses it to bound
> > >    subsequent operations on files using this context. If an overlayfs
> > >    mount is created before the SELinux policy is loaded, these "mount=
er"
> > >    checks are made against the kernel context, which may clash with
> > >    restrictions on the kernel domain (see 2.).
> > >
> > > To resolve this, introduce a new initial SID (reusing the slot of the
> > > former "init" initial SID) that will be assigned to any userspace
> > > process started before the policy is first loaded. This is easy to do=
,
> > > as we can simply label any process that goes through the
> > > bprm_creds_for_exec LSM hook with the new init-SID instead of
> > > propagating the kernel SID from the parent.
> > >
> > > To provide backwards compatibility for existing policies that are
> > > unaware of this new semantic of the "init" initial SID, introduce a n=
ew
> > > policy capability "userspace_initial_context" and set the "init" SID =
to
> > > the same context as the "kernel" SID unless this capability is set by
> > > the policy.
> > >
> > > Another small backwards compatibility measure is needed in
> > > security_sid_to_context_core() for before the initial SELinux policy
> > > load - see the code comment for explanation.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> >
> >
> > > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/ser=
vices.c
> > > index 1eeffc66ea7d7..344c598fc1e74 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -1322,8 +1322,19 @@ static int security_sid_to_context_core(u32 si=
d, char **scontext,
> > >         if (!selinux_initialized()) {
> > >                 if (sid <=3D SECINITSID_NUM) {
> > >                         char *scontextp;
> > > -                       const char *s =3D initial_sid_to_string[sid];
> > > +                       const char *s;
> > >
> > > +                       /*
> > > +                        * Before the policy is loaded, translate
> > > +                        * SECINITSID_INIT to "kernel", because syste=
md and
> > > +                        * libselinux < 2.6 take getcon_raw() !=3D "k=
ernel" to
> >
> > Don't you mean getcon_raw() =3D=3D "kernel"?
> > The old test for SELinux-disabled was to check whether policy was not
> > loaded by checking that we get "kernel" when reading
> > /proc/thread-self/attr/current.
>
> You're right, I misread the systemd code (which I used as reference
> for the comment; didn't bother to look at the old libsepol code). I
> also typo'd "that" into "than"... The comment should say "[...] take
> getcon_raw() is non-null and not "kernel" to mean that a policy is
> already loaded." or similar.
>
> Paul, do you want me to resubmit the patch?

No, that's okay. As this is both a comment and a fairly minor change
so I'll just take care of it when I merge it ... which I'm doing right
now.

Here is the newly edited comment:

  /*
   * Before the policy is loaded, translate
   * SECINITSID_INIT to "kernel", because systemd and
   * libselinux < 2.6 take a getcon_raw() result that is
   * both non-null and not "kernel" to mean that a policy
   * is already loaded.
   */

... if you think it should be different, submit a fixup patch and I'll merg=
e it.

Thanks!

--=20
paul-moore.com
