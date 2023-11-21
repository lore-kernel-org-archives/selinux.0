Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1868C61D85
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 14:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjKUO7M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Nov 2023 09:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjKUO7L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Nov 2023 09:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBD113
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700578745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmUjBLqPlNFt4LwXZS/aGu5wMxPn10GN9Z9tgbmgO/U=;
        b=dYfHwwKPBM781xb94fTudHqdmbI9XcWkLkJgSr3GzR/yeP/O9LI3MfEkWbTde9vSfvBL48
        d+H+4HOe/XqPBR+TF/UKbWZCfRSJTww07cax4kL0Es7zHwztuJu8Lvx3fAPE/hQCTNm8ud
        SCXYmz1ZtWFcfhI+MaUGNsLEl7llpjs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-vZPD8kDwPQmD3CzCP7OpiQ-1; Tue, 21 Nov 2023 09:59:03 -0500
X-MC-Unique: vZPD8kDwPQmD3CzCP7OpiQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so7402259a12.3
        for <selinux@vger.kernel.org>; Tue, 21 Nov 2023 06:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700578742; x=1701183542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmUjBLqPlNFt4LwXZS/aGu5wMxPn10GN9Z9tgbmgO/U=;
        b=taZdVfVwiilLVuzvmqciMQJhXb479dQ3jT9hLXH3u4okoVgTOrc1W8bI3mXlA9/ZG2
         qr+hznHeICGH+FMhWEfEuQpdYUBrT/yHd+QQF3aaDZ0ib7bmxldi8LPdx+a37K1KYOkP
         8mVFkVheBoKjiQDTBxf1Kzhb84B6Ft18mOZgtBkKjky8QerzC5V9BFmieoZ+WrIigPUU
         qSZ5TY39AEyX0k5KCWAiNkbjOcVwh0nwtiiaT19V0M5SrJxPricVpMc0pz/vfY6u0mE9
         /o7tOCacmCGpZ6dIGqGoUEFxVDegKUgw2bRTOiRM0TO3ZGRebAzixqoXZv32UtGBiZ+y
         T2Fw==
X-Gm-Message-State: AOJu0Yx3LpnfVxOrL2exAk7ARnuuFJyKeI99HsIlpihcykbnUpOE47L2
        igZKfIjXER5rgHDVu9h9tEZAxtOvhgew9G30VU9QOF2XgfEpx6/ikfPBA0ZrqamhTInsqiev0LQ
        AMOW7CYeRrhShTkHhxtcDEQrHThqixwu/jQ==
X-Received: by 2002:a05:6a20:bea0:b0:189:baaa:23e7 with SMTP id gf32-20020a056a20bea000b00189baaa23e7mr8328379pzb.40.1700578742259;
        Tue, 21 Nov 2023 06:59:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaSsve8iqXcZsNUC4A9kFNp2jA1WXnsaGDEdWSEjVmEtUSvz4e3xfKBRw/NBOj1PsPQ1VLsoBosyM4Ot+PqiI=
X-Received: by 2002:a05:6a20:bea0:b0:189:baaa:23e7 with SMTP id
 gf32-20020a056a20bea000b00189baaa23e7mr8328365pzb.40.1700578741928; Tue, 21
 Nov 2023 06:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20231114155116.462883-1-omosnace@redhat.com> <CAEjxPJ4bSxh0wTar4otZu+PYkb6Aa=tKR_OpF0pBAS-vJf_rTQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4bSxh0wTar4otZu+PYkb6Aa=tKR_OpF0pBAS-vJf_rTQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 21 Nov 2023 15:58:50 +0100
Message-ID: <CAFqZXNs8ENEJowp9pHE=hWeBY+g6oz=zAExdTE6G6MNupjmMtg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: introduce an initial SID for early boot processes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 21, 2023 at 3:01=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Nov 14, 2023 at 10:51=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> >
> > Currently, SELinux doesn't allow distinguishing between kernel threads
> > and userspace processes that are started before the policy is first
> > loaded - both get the label corresponding to the kernel SID. The only
> > way a process that persists from early boot can get a meaningful label
> > is by doing a voluntary dyntransition or re-executing itself.
> >
> > Reusing the kernel label for userspace processes is problematic for
> > several reasons:
> > 1. The kernel is considered to be a privileged domain and generally
> >    needs to have a wide range of permissions allowed to work correctly,
> >    which prevents the policy writer from effectively hardening against
> >    early boot processes that might remain running unintentionally after
> >    the policy is loaded (they represent a potential extra attack surfac=
e
> >    that should be mitigated).
> > 2. Despite the kernel being treated as a privileged domain, the policy
> >    writer may want to impose certain special limitations on kernel
> >    threads that may conflict with the requirements of intentional early
> >    boot processes. For example, it is a good hardening practice to limi=
t
> >    what executables the kernel can execute as usermode helpers and to
> >    confine the resulting usermode helper processes. However, a
> >    (legitimate) process surviving from early boot may need to execute a
> >    different set of executables.
> > 3. As currently implemented, overlayfs remembers the security context o=
f
> >    the process that created an overlayfs mount and uses it to bound
> >    subsequent operations on files using this context. If an overlayfs
> >    mount is created before the SELinux policy is loaded, these "mounter=
"
> >    checks are made against the kernel context, which may clash with
> >    restrictions on the kernel domain (see 2.).
> >
> > To resolve this, introduce a new initial SID (reusing the slot of the
> > former "init" initial SID) that will be assigned to any userspace
> > process started before the policy is first loaded. This is easy to do,
> > as we can simply label any process that goes through the
> > bprm_creds_for_exec LSM hook with the new init-SID instead of
> > propagating the kernel SID from the parent.
> >
> > To provide backwards compatibility for existing policies that are
> > unaware of this new semantic of the "init" initial SID, introduce a new
> > policy capability "userspace_initial_context" and set the "init" SID to
> > the same context as the "kernel" SID unless this capability is set by
> > the policy.
> >
> > Another small backwards compatibility measure is needed in
> > security_sid_to_context_core() for before the initial SELinux policy
> > load - see the code comment for explanation.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 1eeffc66ea7d7..344c598fc1e74 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1322,8 +1322,19 @@ static int security_sid_to_context_core(u32 sid,=
 char **scontext,
> >         if (!selinux_initialized()) {
> >                 if (sid <=3D SECINITSID_NUM) {
> >                         char *scontextp;
> > -                       const char *s =3D initial_sid_to_string[sid];
> > +                       const char *s;
> >
> > +                       /*
> > +                        * Before the policy is loaded, translate
> > +                        * SECINITSID_INIT to "kernel", because systemd=
 and
> > +                        * libselinux < 2.6 take getcon_raw() !=3D "ker=
nel" to
>
> Don't you mean getcon_raw() =3D=3D "kernel"?
> The old test for SELinux-disabled was to check whether policy was not
> loaded by checking that we get "kernel" when reading
> /proc/thread-self/attr/current.

You're right, I misread the systemd code (which I used as reference
for the comment; didn't bother to look at the old libsepol code). I
also typo'd "that" into "than"... The comment should say "[...] take
getcon_raw() is non-null and not "kernel" to mean that a policy is
already loaded." or similar.

Paul, do you want me to resubmit the patch?

>
> Other than that,
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> And I did test the SELINUX=3Ddisabled case.
>
> > +                        * mean than SELinux is not enabled as the majo=
r LSM
> > +                        * and thus returning "init" would make them mi=
sbehave.
> > +                        */
> > +                       if (sid =3D=3D SECINITSID_INIT)
> > +                               sid =3D SECINITSID_KERNEL;
> > +
> > +                       s =3D initial_sid_to_string[sid];
> >                         if (!s)
> >                                 return -EINVAL;
> >                         *scontext_len =3D strlen(s) + 1;
> > --
> > 2.41.0
> >
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

