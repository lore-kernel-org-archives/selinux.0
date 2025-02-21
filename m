Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484620F07C
	for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147997; cv=none; b=TtuSbR+Cnbkg6CFm0KURORVIN8G/0WANElk+tKETJP2RmyABiMtcecsmMXGIjTCeudS56p11EW0tYsXZpucd72+Svj7PDVlXQyu491fm4dUkv0gyBQIbYbfsJz0Mgs5Pbc48AqYtg/OZlXJN6KEFqKjvS8NysLsCBq7zVysSK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147997; c=relaxed/simple;
	bh=B1I5pszWzLB+eqHuskNCKztdrVrYSjnLNCVG0rVnpu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe5WeaSGpNlvvuC2S93Q+K9/6JGwRMj6M0Xt5wX6oEq2/rHypt4BcdDUf6vYpHcwMUe4+YmAkTE71gEHCfvd6VlY93TIx+0SKyOEFw/tKXNrZt++Z4JI2/0maEjnEXekIMSzX+Vk+m8+z7oSyujcrxiWqX/aFf/FCjHXuB9cTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeboCDKz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeboCDKz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso4350157a91.3
        for <selinux@vger.kernel.org>; Fri, 21 Feb 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740147994; x=1740752794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d1CsFX3T9qj1KcoYgUNvzhny//rvFsxhEwszmjQXwo=;
        b=eeboCDKzVXzkEtLlAAzc8CCYnPuvzTFsoOF2+p5voUUV44WE0aPpa6ynraKy/R7z0E
         4w7207OoSDwf099+qPKgz0zy9eZ6fAq9Y5ACeS9q1+Om4fVZqnf9YM91T8QUapBn7882
         wiaBVjOrDliH324HvzWAj2gTv02vfEakOJjmwXAZwAwqRgXg9/w0VnYcmA5TX5XtaZlY
         iTZErjrxVPYirz5ahMi5mEZl093aiJuchksmQcan2hcu0VDnUYPhyWOKZz2O1nMQCRP8
         RLUte3qVdP49h6R2JBe9sQ7rvTEGaPxrgdfPiLTa70fdQTgwV7jyEffqynYTiil+XLz3
         zMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147994; x=1740752794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d1CsFX3T9qj1KcoYgUNvzhny//rvFsxhEwszmjQXwo=;
        b=DhvWfqUtFt+x5nUfwXs72ZNcS/oYZ52BMNnTsD6Qoo3TiSUTjFJwACiFNipZmDFXNx
         8AFLVnF6VfOykbnuzZYTIFWM+dBev/y/DASfKj2004iRRrbZButFdIkb078VMcRYs25d
         tN6LQLGAxK+u/cgtQ/QGPAVa51cuNGTlJCNN74k+auyYnDdRWTGS2HDCqiRMEnWcWoGu
         387XVeOm7HMn0+ocZzxgPd3lJo+j8C+KX88lxSpMA+c6gVkwvhi8bUgUGp63CFp3whES
         2MahOomtHRurHliu9f41+w2mRuNYRdtaFs2JgzVJH9aPwcgZIyh4pY+3FMHrlJrrnCGz
         94aA==
X-Forwarded-Encrypted: i=1; AJvYcCUKmLxopYpqN3r2ZD6JJ1Ww6id+xvLgH8WWRqRjpundD7rjlsO9cbtm6kcnDm+T4In0TH/NAYGZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9G3VuYi2wIAJwUyOyvsScqCqghSwtfK/FRDQlP58Q+zBYsy9B
	4uEXEY234iqrh06uVuTRUa/h0xVSTHd6ap8AYO/CSjy6YfW/snFDTTosI4txmfaQJ9okdqBAkWM
	Wii1ZDKAGi0amD0B78fQBxGIZPs8=
X-Gm-Gg: ASbGnctZDh1t+HN5zqrQ5wpv4VPmIi73VgsxoY66CChwG0UrGOkR9IJRBvICyLy1Vxb
	gQU1AuothAS/RWVnkAD1fiFuaP246VwSTpQ5nbwfm1IiPWLW00K7R7IHawJzpR1eYvtgQ2BiP/a
	FLErGzANY=
X-Google-Smtp-Source: AGHT+IGtI6tAVd3Xcnz/rg3TdvctePPoc3Uteit7Q4uiuWZSYC/AKN05GTNNG4OjvG5n/Slczp/aibLo5+o/EPPj9PY=
X-Received: by 2002:a17:90b:5106:b0:2f9:9ddd:68b9 with SMTP id
 98e67ed59e1d1-2fce7b1da4amr5069845a91.26.1740147993969; Fri, 21 Feb 2025
 06:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
 <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com>
 <CAEjxPJ7eqMriJmcwoKPwSnLeKkgW+woYGwzKxyOQ1SnY1N0Eig@mail.gmail.com>
 <CAEjxPJ4CDt6NmsLJhLtGQCoKHR6vxnBqY0JB5RQCyx84PKO9rg@mail.gmail.com>
 <CAEjxPJ5yQD4=WK6xWDjx=vP+pXDBWNoaWPXQvH9MqX32NBipbQ@mail.gmail.com> <6f942608-6fa8-4bb0-a7c3-0a138065efb0@linux.microsoft.com>
In-Reply-To: <6f942608-6fa8-4bb0-a7c3-0a138065efb0@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Feb 2025 09:26:22 -0500
X-Gm-Features: AWEUYZl6GZ-o7pLI3DQo1YKcFhBD4ETlJu3mo50oe03LCQ3en0PS6qOF8OE6Pc0
Message-ID: <CAEjxPJ7vJMF9RvbPUimB3xupKHQQhMDmJMPRWcCZaaGDYZJykA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	kippndavis.work@gmx.com, selinux@vger.kernel.org, paul@paul-moore.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:12=E2=80=AFAM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 2/21/2025 8:52 AM, Stephen Smalley wrote:
> > On Thu, Feb 20, 2025 at 3:24=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Thu, Feb 20, 2025 at 3:23=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>>
> >>> On Mon, Feb 17, 2025 at 3:58=E2=80=AFPM Christian G=C3=B6ttsche
> >>> <cgzones@googlemail.com> wrote:
> >>>>
> >>>> On Tue, 11 Feb 2025 at 19:22, <kippndavis.work@gmx.com> wrote:
> >>>>>
> >>>>> From: "Kipp N. Davis" <kippndavis.work@gmx.com>
> >>>>>
> >>>>> Although the LSM hooks for loading kernel modules were later genera=
lized
> >>>>> to cover loading other kinds of files, SELinux didn't implement
> >>>>> corresponding permission checks, leaving only the module case cover=
ed.
> >>>>> Define and add new permission checks for these other cases.
> >>>>>
> >>>>> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> >>>>> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
> >>>>>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>>    - Removed the `-EACCES` return in default case in
> >>>>>      selinux_kernel_read_file() and selinux_kernel_load_from_file()=
,
> >>>>>      reverting previous fallback behavior.
> >>>>>    - Added a compile-time check in these functions to catch new
> >>>>>      READING/LOADING_XXX entries.
> >>>>>
> >>>>> Thanks for your review! I've adjusted the default case so as to not
> >>>>> return an error and depart from pre-existing logic. I first tried t=
o use
> >>>>> the pre-processor #errors but failed with the READING/LOADING_MAX_I=
D
> >>>>> enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> >>>>> those same enums instead to catch new entries.
> >>>>> ---
> >>>>>   security/selinux/hooks.c            | 56 +++++++++++++++++++++++-=
-----
> >>>>>   security/selinux/include/classmap.h |  4 ++-
> >>>>>   2 files changed, 49 insertions(+), 11 deletions(-)
> >>>>>
> >>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>>>> index 7b867dfec88b..67bf37693cd7 100644
> >>>>> --- a/security/selinux/hooks.c
> >>>>> +++ b/security/selinux/hooks.c
> >>>>> @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char=
 *kmod_name)
> >>>>>                              SYSTEM__MODULE_REQUEST, &ad);
> >>>>>   }
> >>>>>
> >>>>> -static int selinux_kernel_module_from_file(struct file *file)
> >>>>> +static int selinux_kernel_load_from_file(struct file *file, u32 re=
quested)
> >>>>>   {
> >>>>>          struct common_audit_data ad;
> >>>>>          struct inode_security_struct *isec;
> >>>>> @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(s=
truct file *file)
> >>>>>          u32 sid =3D current_sid();
> >>>>>          int rc;
> >>>>>
> >>>>> -       /* init_module */
> >>>>>          if (file =3D=3D NULL)
> >>>>>                  return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> >>>>> -                                       SYSTEM__MODULE_LOAD, NULL);
> >>>>> -
> >>>>> -       /* finit_module */
> >>>>> +                                       requested, NULL);
> >>>>>
> >>>>>          ad.type =3D LSM_AUDIT_DATA_FILE;
> >>>>>          ad.u.file =3D file;
> >>>>> @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(st=
ruct file *file)
> >>>>>
> >>>>>          isec =3D inode_security(file_inode(file));
> >>>>>          return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> >>>>> -                               SYSTEM__MODULE_LOAD, &ad);
> >>>>> +                               requested, &ad);
> >>>>>   }
> >>>>>
> >>>>>   static int selinux_kernel_read_file(struct file *file,
> >>>>> @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct =
file *file,
> >>>>>                                      bool contents)
> >>>>>   {
> >>>>>          int rc =3D 0;
> >>>>> -
> >>>>> +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> >>>>> +                 "New kernel_read_file_id introduced; update SELin=
ux!");
> >>>>>          switch (id) {
> >>>>
> >>>> Should READING_UNKNOWN be handled?
> >>>> It seems not to be used currently in-tree, but maybe stay on the saf=
e side?
> >>>
> >>> IMHO, no. READING_UNKNOWN/LOADING_UNKNOWN aren't intended to be used
> >>> and would be a bug elsewhere in the kernel.
> >>>
> >>>>
> >>>>> +       case READING_FIRMWARE:
> >>>>> +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> >>>>> +                               SYSTEM__FIRMWARE_LOAD);
> >>>>> +               break;
> >>>>>          case READING_MODULE:
> >>>>> -               rc =3D selinux_kernel_module_from_file(contents ? f=
ile : NULL);
> >>>>> +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> >>>>> +                               SYSTEM__MODULE_LOAD);
> >>>>> +               break;
> >>>>> +       case READING_KEXEC_IMAGE:
> >>>>> +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> >>>>> +                               SYSTEM__KEXEC_IMAGE_LOAD);
> >>>>> +               break;
> >>>>> +       case READING_KEXEC_INITRAMFS:
> >>>>> +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> >>>>> +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
> >>>>> +               break;
> >>>>> +       case READING_POLICY:
> >>>>> +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> >>>>> +                               SYSTEM__POLICY_LOAD);
> >>>>> +               break;
> >>>>> +       case READING_X509_CERTIFICATE:
> >>>>> +               rc =3D selinux_kernel_load_from_file(contents ? fil=
e : NULL,
> >>>>> +                               SYSTEM__X509_CERTIFICATE_LOAD);
> >>>>>                  break;
> >>>>>          default:
> >>>>>                  break;
> >>>>> @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct =
file *file,
> >>>>>   static int selinux_kernel_load_data(enum kernel_load_data_id id, =
bool contents)
> >>>>>   {
> >>>>>          int rc =3D 0;
> >>>>> -
> >>>>> +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> >>>>> +        "New kernel_load_data_id introduced; update SELinux!");
> >>>>>          switch (id) {
> >>>>
> >>>> dito
> >>>>
> >>>>> +       case LOADING_FIRMWARE:
> >>>>> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
FIRMWARE_LOAD);
> >>>>> +               break;
> >>>>>          case LOADING_MODULE:
> >>>>> -               rc =3D selinux_kernel_module_from_file(NULL);
> >>>>> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
MODULE_LOAD);
> >>>>> +               break;
> >>>>> +       case LOADING_KEXEC_IMAGE:
> >>>>> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
KEXEC_IMAGE_LOAD);
> >>>>> +               break;
> >>>>> +       case LOADING_KEXEC_INITRAMFS:
> >>>>> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
KEXEC_INITRAMFS_LOAD);
> >>>>> +               break;
> >>>>> +       case LOADING_POLICY:
> >>>>> +               rc =3D selinux_kernel_load_from_file(NULL, SYSTEM__=
POLICY_LOAD);
> >>>>> +               break;
> >>>>> +       case LOADING_X509_CERTIFICATE:
> >>>>> +               rc =3D selinux_kernel_load_from_file(NULL,
> >>>>> +                               SYSTEM__X509_CERTIFICATE_LOAD);
> >>>>>                  break;
> >>>>>          default:
> >>>>>                  break;
> >>>>> diff --git a/security/selinux/include/classmap.h b/security/selinux=
/include/classmap.h
> >>>>> index 03e82477dce9..cfac41d12f7d 100644
> >>>>> --- a/security/selinux/include/classmap.h
> >>>>> +++ b/security/selinux/include/classmap.h
> >>>>> @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[=
] =3D {
> >>>>>          { "process2", { "nnp_transition", "nosuid_transition", NUL=
L } },
> >>>>>          { "system",
> >>>>>            { "ipc_info", "syslog_read", "syslog_mod", "syslog_conso=
le",
> >>>>> -           "module_request", "module_load", NULL } },
> >>>>> +           "module_request", "module_load", "firmware_load",
> >>>>> +           "kexec_image_load", "kexec_initramfs_load", "policy_loa=
d",
> >>>>
> >>>> In the SELinux world the word "policy" refers mostly to the SELinux =
policy.
> >>>> Maybe rename the permission verb "policy_load" to
> >>>> "security_policy_load" or similar? (it seems to be used by IMA,
> >>>> loadpin and zram currently)
> >>>
> >>> I don't really see how that is less ambiguous since SELinux policy is
> >>> a security policy too, but don't have any strong feelings either way.
> >>> We have the load_policy permission in the security class for loading
> >>> SELinux policy, so if we use security_policy_load here, then we'll en=
d
> >>> up with SECURITY__LOAD_POLICY and SYSTEM__SECURITY_LOAD_POLICY.
> >>> What could go wrong?
> >>
> >> Sorry, that last one would be SYSTEM__SECURITY_POLICY_LOAD to be
> >> precise, but the point remains.
> >
> > Also, it appears that this policy_load is used by non-security code as
> > well, so that's another reason to not rename it.
>
> What about "kernel_policy_load"?  It's a little weird, since 1. SELinux
> policy is of course also a policy loaded into the kernel and 2. All of
> these permission names could be prefixed with kernel (eg
> "kernel_module_load").  But still, I sympathize with Christian's concern
> that "policy" in SELinux world refers to the SELinux policy, and
> system:policy_load vs security:load_policy is wildly confusing.

I'll defer to Paul to make the final call on naming so the patch
author doesn't need to re-spin the patches endlessly.
