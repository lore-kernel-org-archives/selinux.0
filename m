Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B736D
	for <selinux@vger.kernel.org>; Mon,  9 Jun 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450733; cv=none; b=N3Y817W26HHta02MYPJDHEXWmSUOhPDNg+p9yYydofXNnQ+qjj8bSRewygjUj7kdh8jO3F1Ffhf4MpU0I8VTIySIYLLYcCP1N2XdXh2TW7E7LJ79fJRnkbXZd98OQhgU6tv/LSOExtE9dQZh6beGGaEkAre6PiRAZivvYFK4nYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450733; c=relaxed/simple;
	bh=dyiDpJYpzo7Dh21ZEVGbiAYD4Bk3QFr2P1DKUZHayPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th7TVXZ++CL+b1IVTuWEFvfjqlWghgJkEyzG9BHtaQZqp84MJ753mknbGGRCcBA3bVFy9PLGGdcgJfF7SToICG/KTwOyPza9Oq79yj50bDdLPfwgz2h2PFKB4TpV2s+rbydilytGKg2T1tj1lp8jfhL0lmEasmMmt7oGfEs3OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjSDTcj7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjSDTcj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749450729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D1ue+MMjtFH+F3xHicqaLSbTSqk+6UTGB1gZAz3P+o=;
	b=XjSDTcj7vv1FZQfyAFYHzGddW+zEO0LuHezysF1q0tuDIGdIjkspOzp1HYf4aOz4N2ltNA
	PsJKbcyfQDprd3P5lpYKwTNh8daqVZP6kbeD4cY5K2eB7rFUiJmORnvsH58n5ghz30lmKG
	BUlFwfFZ9Fpw146KGrEDmitYs0kNRL4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-nxvKB_6KPTKT7So7_7yD_g-1; Mon, 09 Jun 2025 02:32:07 -0400
X-MC-Unique: nxvKB_6KPTKT7So7_7yD_g-1
X-Mimecast-MFC-AGG-ID: nxvKB_6KPTKT7So7_7yD_g_1749450726
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311d670ad35so3733809a91.3
        for <selinux@vger.kernel.org>; Sun, 08 Jun 2025 23:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749450726; x=1750055526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D1ue+MMjtFH+F3xHicqaLSbTSqk+6UTGB1gZAz3P+o=;
        b=nvXCzuzXjo26A9n1wUd6zfiWsuGbqM6phYmxveegXYzdo/b26wZWyzDQDp0k5Q1rrI
         NAnMrWQJZg0w7xN5vfLT75m4oUlpgR4SHd+TtLB/El7PkFWCw72BhVTUiCKk5Mmkp6tv
         +thxFPpi4+g00s7PZeFerMfzZFcWISnJvqiPYQToPhWb1rt32UPCZcml0kr+M6Sdq8Np
         Mte86FmR7JW7HbEQhEaiflbyf6QImfok5+6X5xdKkj3PE05Z3mE8RhRrwz/8LFvodmCu
         j6zopjenULRxrFIIwgupng5wQm2l1RE3biXVwwQmEl6tA/1KBc1ZabDfzcPbvJxB71rD
         GNDA==
X-Gm-Message-State: AOJu0YyaqBQn0O9K0+5wEudoLk80ttBXAh/xEULLkwD6D2kOT4x+TKBr
	GkKmdXj8ufpLFfFSl/kRHUPI0nzwi5As6OCNGLprfRcQfEYyXY7ZsEsuMAZcuPC7TOOkUmB9lLF
	wybE6/8HA6hhNONY2ghUG69eFtXHOV32z3wkjfLkyFiCjb+/iFJ6hu4V6C0eWDhopOTXEQNSZQR
	toN9e7Y61EEhZ+wgzAvDNOhNyaVngl+shDXtNCSWhob823
X-Gm-Gg: ASbGncuKlxOtNqrBFerJElyPczj7G1k8bIxXsc9O6yXxf69pVdrgcyOCS0QhteXhNeH
	oCCIVN4ZI2BcQ/63MLT9LPpz2/zsnssVocKuzPwWhq6Mj5Bj2v6agELYBPWwG4m7ZglpuZcRqXs
	XEmA==
X-Received: by 2002:a17:90b:1fc3:b0:311:ea13:2e6d with SMTP id 98e67ed59e1d1-313477982f3mr16792136a91.29.1749450726165;
        Sun, 08 Jun 2025 23:32:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAUBeQrzhuvs93JYC7Pi8oyccAtnQCyJ8uKHSym8Nvm/J6K3aMGx1Qj0RodJ+naKyYsH6C/HIgEGOwjvta4Cw=
X-Received: by 2002:a17:90b:1fc3:b0:311:ea13:2e6d with SMTP id
 98e67ed59e1d1-313477982f3mr16792112a91.29.1749450725702; Sun, 08 Jun 2025
 23:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1748100564.11369.2.camel@trentalancia.com> <CAFqZXNufHFEA8304qvTi8znWUmrznqyywWMDJYgBASN+VbvLSA@mail.gmail.com>
 <1749148831.7370.3.camel@trentalancia.com>
In-Reply-To: <1749148831.7370.3.camel@trentalancia.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 9 Jun 2025 08:31:52 +0200
X-Gm-Features: AX0GCFvq-iJtyN_VxGNKPK6USob9NRi9AqnoEDJe6SBDHYhTuURVbspK_E03MJE
Message-ID: <CAFqZXNvFo6Rpw+jSTF0_+EtfRv4V8+TyXxVz7QBji_d9xmfwRw@mail.gmail.com>
Subject: Re: [PATCH] Only set the initial SID for early-boot userspace tasks
 if the policy supports the new capability
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 8:40=E2=80=AFPM Guido Trentalancia
<guido@trentalancia.com> wrote:
>
> Yes, it obviously breaks something: systems based on sysvinit fail to
> boot !
>
> The full bug report is here:
>
> https://github.com/dracut-ng/dracut-ng/issues/377

Ah, the entrypoint denials are indeed unexpected in this case and the
cause really is the ae254858ce07 commit. I'll send a patch shortly
that should fix them.

BTW, the reason why @LoganSchmalz saw a similar error on Fedora with
systemd is likely that they had enabled the "selinux" dracut module,
which is not necessary with systemd (which can handle SELinux setup on
its own) and will only break things with the Fedora selinux-policy
(even when the entrypoint bug is fixed).

Thank you for reporting and for your efforts to fix the issue!

>
> Another solution was initially proposed as a dracut patch, however it
> has not been merged yet.
>
> You are right, the kernel patch proposed here is not acceptable, as the
> policy capabilities cannot be checked before the policy is loaded.
>
> Guido
>
> On Thu, 05/06/2025 at 14.45 +0200, Ondrej Mosnacek wrote:
> > On Sat, May 24, 2025 at 5:32=E2=80=AFPM Guido Trentalancia
> > <guido@trentalancia.com> wrote:
> > >
> > > Before the policy is loaded, only set the initial SID
> > > for early-boot userspace tasks if the policy supports
> > > such capability.
> > >
> > > Check for POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> > > otherwise preserve the old behavior of using the
> > > SECINITSID_KERNEL label for early-boot userspace
> > > processes.
> > >
> > > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > > boot processes")
> > > Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> > > ---
> > >  security/selinux/hooks.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > --- a/security/selinux/hooks.c  2025-05-24 14:37:45.499997561 +0200
> > > +++ b/security/selinux/hooks.c  2025-05-24 14:36:58.453997848 +0200
> > > @@ -2319,7 +2319,7 @@ static int selinux_bprm_creds_for_exec(s
> > >          * early boot end up with a label different from
> > > SECINITSID_KERNEL
> > >          * (if the policy chooses to set SECINITSID_INIT !=3D
> > > SECINITSID_KERNEL).
> > >          */
> > > -       if (!selinux_initialized()) {
> > > +       if (!selinux_initialized() &&
> > > selinux_policycap_userspace_initial_context()) {
> > >                 new_tsec->sid =3D SECINITSID_INIT;
> > >                 /* also clear the exec_sid just in case */
> > >                 new_tsec->exec_sid =3D 0;
> > >
> >
> > This doesn't make sense - obviously you can't check what capabilities
> > the policy supports when it's not loaded yet... Does the current
> > behavior break something for you?
> >
> > --
> > Ondrej Mosnacek
> > Senior Software Engineer, Linux Security - SELinux kernel
> > Red Hat, Inc.
> >
>


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

