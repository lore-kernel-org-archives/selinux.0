Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127C1DDC3B
	for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083104; cv=none; b=mE20bvozcR3U61Up1y/hykdcU+v0pGKSPPR3HBktOrYGmYfEQalOqynm9hzwNBw/mRx4HwNSMduTTbOIFudUwtEPKUhQI6ZDl0MRMabNpec/hNeK3Ni0aFKiwMrUN6sDbMFX+DSu3cDctaixJuejWdSwbq1t+yNgd3G9JOUq4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083104; c=relaxed/simple;
	bh=IdNp+1gm4rJnRh3ypGaydC8T9fQ88N4nnQvp2+CJBl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLThOswjKTyq+cGWjH3HSXgGBDVsG/PrroPXJR76D8axb8hUIiGVUkTXi00Ek0GXZAm81teJlAtr4oRdJpHe6IIkbIqcunyvr7c0s+T6yeSvJm8E+AKAjzTlCd56FFJMTTIpcjXILQeM5Ay7PGuXq0d6qFbMjq7h0JghOR260oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKX3zAD3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKX3zAD3"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso2235510a91.1
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083101; x=1740687901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vL8QiGjgQqd9SXQYuR1WJoIUvCEispcI+klPYbEyYw=;
        b=KKX3zAD3duYE8G/3N6AKxABWon0sQxuWKHvCN8Ku5n6mMwv8Wur6m0SeE1/vZXcR+u
         h98QLS2M8raDHmjGhLOHZ04WYCAsvfPS8YieaxPXJPVVywjG4OVmk5SeFEgoE7rFZnrV
         6k1cNfUvfizCOf0Ot5JK0qMQhjuMU1Mu5e4jbQWIhaEtFrLTSIbCY7DJ0coHIHd0gVBW
         yNPXkeADOv0nyMzdda41/L5Fx5CT+fSpusLMLq6R/aEAWx4c1/sHDlH9d9WNl3NC1yWA
         1n27066J17AyRCq93b5wnwslUN+HcAmdkVscFy5DPKLhDuWO2h4CzRQDjOQC7vN8pCt3
         Ru8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083101; x=1740687901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vL8QiGjgQqd9SXQYuR1WJoIUvCEispcI+klPYbEyYw=;
        b=ZZsBDlBbkaTwHl7EQEZIX7wEc894K5ZfOBTGnsKiybIb0Khgro2ZkKainPPp0v1Q0p
         93u92VITE2AJk1PtC/ep0+FYta/M6Y9R2yyh2xgMzybtqG2dxLK+StHv+ZAe1DMGs/Ls
         isiGPL+aNtLGxcy7d0ui+dZDFx1rMujqhHnM8p9xe8eC0mddu5EgdAGcC9XFEaURlSWo
         vP4SYGevqhdpOWeEM2qvdDTBF46i6TEX12YD3WimhY4NFh4UiIs8BtKjd+Pcikktgm9h
         0V36YqZfBwC0ZPXnd4Zx+R9qc/6gA69TyCU+mSGB53d8RMAluMKh8jUwTproD/pK5YSL
         XqZg==
X-Forwarded-Encrypted: i=1; AJvYcCVMXmCpgfG0t7Omd4DW3nrU2gY/FrpXEAkmiBe37M6dXyxLim2nwjpj166+7j867NnrQZTEQv9U@vger.kernel.org
X-Gm-Message-State: AOJu0YyaoN82usmXN/xarjZRRyOCpLO6B5AWtvQQ7v9IbCWTnBfLSBRE
	6fB5iBOv3iIAhAREg8Cw68xSSTvAb7kp3So4gzfnIMAd5/8UnD7zqV96UNCGwfgezz6DlTUaR01
	DY9PXkOmNz1/y/3NqPeRnbecLRk0=
X-Gm-Gg: ASbGnct0/I3GCR06Qjy45Pn46g/qYecGrd4H884Z3rHovHUiAfrbfo2PcO8GUEnRTj4
	wZegD4SLaYFFozEp6CIuevOxW2oIM3PyKQpWIyIXohtkhDuB13sNM0Utn9lx7E+NFR61WBofU
X-Google-Smtp-Source: AGHT+IGFMAFF6NwzQs9/IMM2pORXIQhL3v7dppfUTnHnSdKqBzMz59VG/LraajTg5X+MhPmi+v00PZPXPIJudbaRMYA=
X-Received: by 2002:a17:90b:5488:b0:2fc:a3b7:1099 with SMTP id
 98e67ed59e1d1-2fce789b23bmr875573a91.4.1740083101437; Thu, 20 Feb 2025
 12:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
 <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com> <CAEjxPJ7eqMriJmcwoKPwSnLeKkgW+woYGwzKxyOQ1SnY1N0Eig@mail.gmail.com>
In-Reply-To: <CAEjxPJ7eqMriJmcwoKPwSnLeKkgW+woYGwzKxyOQ1SnY1N0Eig@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 15:24:50 -0500
X-Gm-Features: AWEUYZnjn5XUDWZUGmVrbebEnFDpeqc2UmyQwj6QH8c4_jiJa3YrvfpV-gRsNG4
Message-ID: <CAEjxPJ4CDt6NmsLJhLtGQCoKHR6vxnBqY0JB5RQCyx84PKO9rg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: kippndavis.work@gmx.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Feb 17, 2025 at 3:58=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Tue, 11 Feb 2025 at 19:22, <kippndavis.work@gmx.com> wrote:
> > >
> > > From: "Kipp N. Davis" <kippndavis.work@gmx.com>
> > >
> > > Although the LSM hooks for loading kernel modules were later generali=
zed
> > > to cover loading other kinds of files, SELinux didn't implement
> > > corresponding permission checks, leaving only the module case covered=
.
> > > Define and add new permission checks for these other cases.
> > >
> > > Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> > > Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
> > >
> > > ---
> > > Changes in v2:
> > >   - Removed the `-EACCES` return in default case in
> > >     selinux_kernel_read_file() and selinux_kernel_load_from_file(),
> > >     reverting previous fallback behavior.
> > >   - Added a compile-time check in these functions to catch new
> > >     READING/LOADING_XXX entries.
> > >
> > > Thanks for your review! I've adjusted the default case so as to not
> > > return an error and depart from pre-existing logic. I first tried to =
use
> > > the pre-processor #errors but failed with the READING/LOADING_MAX_ID
> > > enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> > > those same enums instead to catch new entries.
> > > ---
> > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++----=
--
> > >  security/selinux/include/classmap.h |  4 ++-
> > >  2 files changed, 49 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 7b867dfec88b..67bf37693cd7 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char *=
kmod_name)
> > >                             SYSTEM__MODULE_REQUEST, &ad);
> > >  }
> > >
> > > -static int selinux_kernel_module_from_file(struct file *file)
> > > +static int selinux_kernel_load_from_file(struct file *file, u32 requ=
ested)
> > >  {
> > >         struct common_audit_data ad;
> > >         struct inode_security_struct *isec;
> > > @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(str=
uct file *file)
> > >         u32 sid =3D current_sid();
> > >         int rc;
> > >
> > > -       /* init_module */
> > >         if (file =3D=3D NULL)
> > >                 return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> > > -                                       SYSTEM__MODULE_LOAD, NULL);
> > > -
> > > -       /* finit_module */
> > > +                                       requested, NULL);
> > >
> > >         ad.type =3D LSM_AUDIT_DATA_FILE;
> > >         ad.u.file =3D file;
> > > @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(stru=
ct file *file)
> > >
> > >         isec =3D inode_security(file_inode(file));
> > >         return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> > > -                               SYSTEM__MODULE_LOAD, &ad);
> > > +                               requested, &ad);
> > >  }
> > >
> > >  static int selinux_kernel_read_file(struct file *file,
> > > @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct fi=
le *file,
> > >                                     bool contents)
> > >  {
> > >         int rc =3D 0;
> > > -
> > > +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> > > +                 "New kernel_read_file_id introduced; update SELinux=
!");
> > >         switch (id) {
> >
> > Should READING_UNKNOWN be handled?
> > It seems not to be used currently in-tree, but maybe stay on the safe s=
ide?
>
> IMHO, no. READING_UNKNOWN/LOADING_UNKNOWN aren't intended to be used
> and would be a bug elsewhere in the kernel.
>
> >
> > > +       case READING_FIRMWARE:
> > > +               rc =3D selinux_kernel_load_from_file(contents ? file =
: NULL,
> > > +                               SYSTEM__FIRMWARE_LOAD);
> > > +               break;
> > >         case READING_MODULE:
> > > -               rc =3D selinux_kernel_module_from_file(contents ? fil=
e : NULL);
> > > +               rc =3D selinux_kernel_load_from_file(contents ? file =
: NULL,
> > > +                               SYSTEM__MODULE_LOAD);
> > > +               break;
> > > +       case READING_KEXEC_IMAGE:
> > > +               rc =3D selinux_kernel_load_from_file(contents ? file =
: NULL,
> > > +                               SYSTEM__KEXEC_IMAGE_LOAD);
> > > +               break;
> > > +       case READING_KEXEC_INITRAMFS:
> > > +               rc =3D selinux_kernel_load_from_file(contents ? file =
: NULL,
> > > +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
> > > +               break;
> > > +       case READING_POLICY:
> > > +               rc =3D selinux_kernel_load_from_file(contents ? file =
: NULL,
> > > +                               SYSTEM__POLICY_LOAD);
> > > +               break;
> > > +       case READING_X509_CERTIFICATE:
> > > +               rc =3D selinux_kernel_load_from_file(contents ? file =
: NULL,
> > > +                               SYSTEM__X509_CERTIFICATE_LOAD);
> > >                 break;
> > >         default:
> > >                 break;
> > > @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct fi=
le *file,
> > >  static int selinux_kernel_load_data(enum kernel_load_data_id id, boo=
l contents)
> > >  {
> > >         int rc =3D 0;
> > > -
> > > +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> > > +        "New kernel_load_data_id introduced; update SELinux!");
> > >         switch (id) {
> >
> > dito
> >
> > > +       case LOADING_FIRMWARE:
> > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__FI=
RMWARE_LOAD);
> > > +               break;
> > >         case LOADING_MODULE:
> > > -               rc =3D selinux_kernel_module_from_file(NULL);
> > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__MO=
DULE_LOAD);
> > > +               break;
> > > +       case LOADING_KEXEC_IMAGE:
> > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KE=
XEC_IMAGE_LOAD);
> > > +               break;
> > > +       case LOADING_KEXEC_INITRAMFS:
> > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KE=
XEC_INITRAMFS_LOAD);
> > > +               break;
> > > +       case LOADING_POLICY:
> > > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__PO=
LICY_LOAD);
> > > +               break;
> > > +       case LOADING_X509_CERTIFICATE:
> > > +               rc =3D selinux_kernel_load_from_file(NULL,
> > > +                               SYSTEM__X509_CERTIFICATE_LOAD);
> > >                 break;
> > >         default:
> > >                 break;
> > > diff --git a/security/selinux/include/classmap.h b/security/selinux/i=
nclude/classmap.h
> > > index 03e82477dce9..cfac41d12f7d 100644
> > > --- a/security/selinux/include/classmap.h
> > > +++ b/security/selinux/include/classmap.h
> > > @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[] =
=3D {
> > >         { "process2", { "nnp_transition", "nosuid_transition", NULL }=
 },
> > >         { "system",
> > >           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console"=
,
> > > -           "module_request", "module_load", NULL } },
> > > +           "module_request", "module_load", "firmware_load",
> > > +           "kexec_image_load", "kexec_initramfs_load", "policy_load"=
,
> >
> > In the SELinux world the word "policy" refers mostly to the SELinux pol=
icy.
> > Maybe rename the permission verb "policy_load" to
> > "security_policy_load" or similar? (it seems to be used by IMA,
> > loadpin and zram currently)
>
> I don't really see how that is less ambiguous since SELinux policy is
> a security policy too, but don't have any strong feelings either way.
> We have the load_policy permission in the security class for loading
> SELinux policy, so if we use security_policy_load here, then we'll end
> up with SECURITY__LOAD_POLICY and SYSTEM__SECURITY_LOAD_POLICY.
> What could go wrong?

Sorry, that last one would be SYSTEM__SECURITY_POLICY_LOAD to be
precise, but the point remains.

>
> >
> > > +           "x509_certificate_load", NULL } },
> > >         { "capability", { COMMON_CAP_PERMS, NULL } },
> > >         { "filesystem",
> > >           { "mount", "remount", "unmount", "getattr", "relabelfrom",
> > > --
> > > 2.48.1
> > >
> > >
