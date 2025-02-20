Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFD2641C3
	for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083030; cv=none; b=YXKF7bjDPBpobD1J6J+ynrXY5xtPGR+k08SdIavTKuR4siuUYbUOvM+JKa/X/b/p5q4DAzQWB4o17MkEoF2GEZLMsC7suEQ97F/At5Y1uudjNdmTrWe0DwePXOtxa/cOyc6X3MCkOM7RGdG/aSujCEZokau2UcWku5w2bXI1Nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083030; c=relaxed/simple;
	bh=7ql04ucVhQpI+XyIXM2Jf9qsorLWLasTdeKGylXkeuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmCUO9QFYKueofQ7f7jx6LqRTIsNQgYlHw3MPs4ID93Ab0a51I8z5rxNSug4cJAwlT15e7ONMzLS33Iyzg0D8SE+g+/QnKq+keai/60dP4KasUzoZpbypwTV8Rlcz7J1nhTrUp9GW1DaFhOyjKfBBPXP3xBTOMJ52XgkSCvqmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1vRHidE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1vRHidE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so2220540a91.2
        for <selinux@vger.kernel.org>; Thu, 20 Feb 2025 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083028; x=1740687828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4qiNbb6UwSsIENHfAaZ0s03Bm2HrKBV0ijsXM/2CoM=;
        b=B1vRHidEt327LxiSdx5WkjerG4K4g04qTUyGRrzKsdrcIVsOP4IZK02tMyYfDuOLyn
         5pGf6GE+WfEICK7zeZ/D+sew4yv1HeQLeGW2hbMr42KFgRMQMhZPqhucYQHv+xwGh8fB
         1+CQ8DrHMBaEMSXRdVLzQtzW+7gmRnDXK8sYHqPV5CGXSp7ASP466l8cwnHjxXnS39iY
         jYR7nZBPb5g+qS50zx9ygVUq+K/BzliKYpu01+S4CwUIQGycw6euma6GO7sfCr7tqR7R
         v8aI2bAytyqFzvluYbKWjFkOcQFUtnl2N9iX/B39DZmV+Tehm+0XrUBGBvI9dkqK5E6R
         +S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083028; x=1740687828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4qiNbb6UwSsIENHfAaZ0s03Bm2HrKBV0ijsXM/2CoM=;
        b=R7Sv02Z0hWYoeb54dWkQ34T2I+CqLNVHLsiXZy2et7IQh9ZuU4+KhYkeznJp4Jk1xm
         vgfgNjpaFKk3Tc645y4xZ32Ns++FEcz9++5jw0ZfA1yGeQKvbR2l7vD2TqdQtd5YxWW4
         m1HlIGnQAUFGkjilSY4ScKsx0m+YMc+8tLpAnC1laInhtWyfGiG9qDCel0YIoYVEgnal
         hR735JZvEO5xWN6yHCpQmAynr95o5XVqn09BIVgEyr9ONxjkISs77eWM62vFN1THVVdK
         iID3sgvUvVq47+FxEi4HREVItuO1/sIGuEWXrICHZ+j2IJcTCqxit+lD3qVMTqbwMRfv
         SqAw==
X-Forwarded-Encrypted: i=1; AJvYcCWG7+XpXv1sGwtl/u+ODb7vS0DDDXZl9jODtOB5bTrFKwjVrbq/YxZ2Y4ZDIbINBJwJkX356A0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzcW0cX6Ye4EodLK86PI53iD4eMYNfQSYT3gQe6Tr/xAK+y4iJR
	e21HjGSsvyseNrqlXPxl8bu1JO0ME92VxkbukG80sF/I6zbRowWvNOG/D/mveG7NSfyZy+C+vTV
	OxrMp2YWGOuD8i0jTfAJwb6R4uJ4=
X-Gm-Gg: ASbGncsyxowWUJ3z0GowSBylOTJ7v95UtVzMRvSor1608zs80in5hiUvUJB9bAJpsIH
	iDBU7qtUHWt9BPuH2jyxm8Zv3COal6hPzWZWuXkyhHw79lzU14YI0uMGeGR1xUK+Rpd/eQpyc
X-Google-Smtp-Source: AGHT+IFXxMwoaiqD5WhYswjvZmq2LwRIfzeZKLAQ92rKBgDL3/4Bip85YJRPkVqeXNa0JVYtiQgQuVEUCzYlJsPtbvk=
X-Received: by 2002:a17:90b:53cc:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-2fce75eecf5mr1049818a91.0.1740083028038; Thu, 20 Feb 2025
 12:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211182159.37744-1-kippndavis.work@gmx.com> <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com>
In-Reply-To: <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Feb 2025 15:23:36 -0500
X-Gm-Features: AWEUYZmF5IdEMzvl-krfPmVhylXykvR60JQLCQDbP9qfuWdsOGiGoClYiZdD9VA
Message-ID: <CAEjxPJ7eqMriJmcwoKPwSnLeKkgW+woYGwzKxyOQ1SnY1N0Eig@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: kippndavis.work@gmx.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:58=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 11 Feb 2025 at 19:22, <kippndavis.work@gmx.com> wrote:
> >
> > From: "Kipp N. Davis" <kippndavis.work@gmx.com>
> >
> > Although the LSM hooks for loading kernel modules were later generalize=
d
> > to cover loading other kinds of files, SELinux didn't implement
> > corresponding permission checks, leaving only the module case covered.
> > Define and add new permission checks for these other cases.
> >
> > Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> > Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
> >
> > ---
> > Changes in v2:
> >   - Removed the `-EACCES` return in default case in
> >     selinux_kernel_read_file() and selinux_kernel_load_from_file(),
> >     reverting previous fallback behavior.
> >   - Added a compile-time check in these functions to catch new
> >     READING/LOADING_XXX entries.
> >
> > Thanks for your review! I've adjusted the default case so as to not
> > return an error and depart from pre-existing logic. I first tried to us=
e
> > the pre-processor #errors but failed with the READING/LOADING_MAX_ID
> > enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> > those same enums instead to catch new entries.
> > ---
> >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++------
> >  security/selinux/include/classmap.h |  4 ++-
> >  2 files changed, 49 insertions(+), 11 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..67bf37693cd7 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char *km=
od_name)
> >                             SYSTEM__MODULE_REQUEST, &ad);
> >  }
> >
> > -static int selinux_kernel_module_from_file(struct file *file)
> > +static int selinux_kernel_load_from_file(struct file *file, u32 reques=
ted)
> >  {
> >         struct common_audit_data ad;
> >         struct inode_security_struct *isec;
> > @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(struc=
t file *file)
> >         u32 sid =3D current_sid();
> >         int rc;
> >
> > -       /* init_module */
> >         if (file =3D=3D NULL)
> >                 return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> > -                                       SYSTEM__MODULE_LOAD, NULL);
> > -
> > -       /* finit_module */
> > +                                       requested, NULL);
> >
> >         ad.type =3D LSM_AUDIT_DATA_FILE;
> >         ad.u.file =3D file;
> > @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(struct=
 file *file)
> >
> >         isec =3D inode_security(file_inode(file));
> >         return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> > -                               SYSTEM__MODULE_LOAD, &ad);
> > +                               requested, &ad);
> >  }
> >
> >  static int selinux_kernel_read_file(struct file *file,
> > @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct file=
 *file,
> >                                     bool contents)
> >  {
> >         int rc =3D 0;
> > -
> > +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> > +                 "New kernel_read_file_id introduced; update SELinux!"=
);
> >         switch (id) {
>
> Should READING_UNKNOWN be handled?
> It seems not to be used currently in-tree, but maybe stay on the safe sid=
e?

IMHO, no. READING_UNKNOWN/LOADING_UNKNOWN aren't intended to be used
and would be a bug elsewhere in the kernel.

>
> > +       case READING_FIRMWARE:
> > +               rc =3D selinux_kernel_load_from_file(contents ? file : =
NULL,
> > +                               SYSTEM__FIRMWARE_LOAD);
> > +               break;
> >         case READING_MODULE:
> > -               rc =3D selinux_kernel_module_from_file(contents ? file =
: NULL);
> > +               rc =3D selinux_kernel_load_from_file(contents ? file : =
NULL,
> > +                               SYSTEM__MODULE_LOAD);
> > +               break;
> > +       case READING_KEXEC_IMAGE:
> > +               rc =3D selinux_kernel_load_from_file(contents ? file : =
NULL,
> > +                               SYSTEM__KEXEC_IMAGE_LOAD);
> > +               break;
> > +       case READING_KEXEC_INITRAMFS:
> > +               rc =3D selinux_kernel_load_from_file(contents ? file : =
NULL,
> > +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
> > +               break;
> > +       case READING_POLICY:
> > +               rc =3D selinux_kernel_load_from_file(contents ? file : =
NULL,
> > +                               SYSTEM__POLICY_LOAD);
> > +               break;
> > +       case READING_X509_CERTIFICATE:
> > +               rc =3D selinux_kernel_load_from_file(contents ? file : =
NULL,
> > +                               SYSTEM__X509_CERTIFICATE_LOAD);
> >                 break;
> >         default:
> >                 break;
> > @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct file=
 *file,
> >  static int selinux_kernel_load_data(enum kernel_load_data_id id, bool =
contents)
> >  {
> >         int rc =3D 0;
> > -
> > +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> > +        "New kernel_load_data_id introduced; update SELinux!");
> >         switch (id) {
>
> dito
>
> > +       case LOADING_FIRMWARE:
> > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__FIRM=
WARE_LOAD);
> > +               break;
> >         case LOADING_MODULE:
> > -               rc =3D selinux_kernel_module_from_file(NULL);
> > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__MODU=
LE_LOAD);
> > +               break;
> > +       case LOADING_KEXEC_IMAGE:
> > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KEXE=
C_IMAGE_LOAD);
> > +               break;
> > +       case LOADING_KEXEC_INITRAMFS:
> > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__KEXE=
C_INITRAMFS_LOAD);
> > +               break;
> > +       case LOADING_POLICY:
> > +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__POLI=
CY_LOAD);
> > +               break;
> > +       case LOADING_X509_CERTIFICATE:
> > +               rc =3D selinux_kernel_load_from_file(NULL,
> > +                               SYSTEM__X509_CERTIFICATE_LOAD);
> >                 break;
> >         default:
> >                 break;
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 03e82477dce9..cfac41d12f7d 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "process2", { "nnp_transition", "nosuid_transition", NULL } }=
,
> >         { "system",
> >           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
> > -           "module_request", "module_load", NULL } },
> > +           "module_request", "module_load", "firmware_load",
> > +           "kexec_image_load", "kexec_initramfs_load", "policy_load",
>
> In the SELinux world the word "policy" refers mostly to the SELinux polic=
y.
> Maybe rename the permission verb "policy_load" to
> "security_policy_load" or similar? (it seems to be used by IMA,
> loadpin and zram currently)

I don't really see how that is less ambiguous since SELinux policy is
a security policy too, but don't have any strong feelings either way.
We have the load_policy permission in the security class for loading
SELinux policy, so if we use security_policy_load here, then we'll end
up with SECURITY__LOAD_POLICY and SYSTEM__SECURITY_LOAD_POLICY.
What could go wrong?

>
> > +           "x509_certificate_load", NULL } },
> >         { "capability", { COMMON_CAP_PERMS, NULL } },
> >         { "filesystem",
> >           { "mount", "remount", "unmount", "getattr", "relabelfrom",
> > --
> > 2.48.1
> >
> >
