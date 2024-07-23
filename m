Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CA157E91
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755458; cv=none; b=DgzWpgy0KIyRIuo0ZUDrTTVr9UeDYZPVLCu8CJT8T4VFw7LckvH3ymRCdmWV6VgtULckfobwxWtzHDfWkv56aU6LJ8bXKGyGjuv0ETuZ9pJk6hOjBS1UzaKOfcE9TWtFuzC//9jbzCGf6bOBhndjvDspWdqrvj9krzkFvBDC8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755458; c=relaxed/simple;
	bh=rG3UZ0rAT61PFZJar1vejIsx8bd4XRQQGiBbdMgsOBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmWEo+Hoq29qko0hgTY6aHNn5GGj4+yYFvUFpRarfd83ud3Ysr1XGSxkESjn4IP3s2q7i3RKp4/3UfdqJbDyYNoBxfnlBrf6Zu2GyC8Xk1mv+cZiTSJjJfQUh8oBDizCCNydR1e83B+QFdNhWQ3s+UQLAbLWjUdC7lHeP2HqPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUEpUvWd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUEpUvWd"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e7b121be30so594885a12.1
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721755456; x=1722360256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqYeS9ADmNJHvdR46W8e6uNkAMYsswA7i1Hf9pFCTgg=;
        b=VUEpUvWdHnbzkvfDV7zNxsPNR7B60dsHWzYPDDeo8DoJgUUyU/K5DfN71TjIGQ0KWv
         1EBaOoMb+QhOpZFedEAJvVrpevRgeiM2ZGGfQQ2W/yKLk0/Nc2ChIoFfrxaI4TarYFeu
         26OiSAPqvo8V5lRvqOKFTVvZ2ekkCYXqxswSqOA0GjNdB0B8pTagElXvYbgcvWkOZb1/
         GS0uwgN9KZqMP1OVFV2UFlRpoWCj4RVmVWgL/NJhA09AK8NaG5zn8FVYmtDZsyTfgHKM
         mETSJtFUrlCkOrTxPE7jlCmIGOaDlOUIez7tyZ79fh7i772vxRqWYltOh2KYP7ORlTQK
         hJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755456; x=1722360256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqYeS9ADmNJHvdR46W8e6uNkAMYsswA7i1Hf9pFCTgg=;
        b=mBF+gpahR86ox3+QCBCtyO9fETtTEqo0KiFbV+yHIlTjBLIPjOCqG6nEanwegXAAv4
         1bVERm0stOR+6FCnKqlGUxVSeFD43gFyvGj5soh3RujdSxboNkzVaAzIxeR4t9WM4gjo
         3W73qp1w9px7crUn4cbxhfSSsuM6l1MiEqyU0nNmDOb8AyhXOc7HulsKcreVmNbisxWO
         PVt8QJhkn00H1HqITKXjdYcbwnnAEZH3d1r3g1ZDE2wcPDaIs9IWXNHSUKe6ha+cjlQR
         Fd9MW5RfA7x2u+cgXGJOXYwkkYyojia6FQQocUPR8l0CoZ/L2q7jgaRTMbeU4NTTnj9n
         NiDg==
X-Gm-Message-State: AOJu0YzzffYKZLQwWOCqIilcstXXO8/6/Oi+sO/9UCK12TorAg8K6oSR
	B6K4Zz4Seeu5v8eed3WUp6LcwU9dHN4XgWbqO+4DgmYq81hMJfykWfjgnho/ANNXwWXGQyCkHRI
	eAfK964oDR+yvHArNMyIQIeIzxs1qUQ==
X-Google-Smtp-Source: AGHT+IHkAUEnnkSI7qE6/3pw5rj1ubWS3xzAmzdoibRdw/rIsr+J7pcYvMuu2Hb2abN8iODwt137dBugiZipDPDCp+g=
X-Received: by 2002:a17:90b:1983:b0:2c9:6aae:ac08 with SMTP id
 98e67ed59e1d1-2cdae32c8d9mr429322a91.17.1721755455600; Tue, 23 Jul 2024
 10:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa2d6136-20b7-4d05-bde1-499849450d54@redhat.com>
 <20240723125850.1228121-1-vmojzis@redhat.com> <CAEjxPJ7QLHNE1MJ1xj7Fprq6BPdfEAcC5P5711xJ7Ljp+aeFsQ@mail.gmail.com>
 <5e9144dc-1003-428f-986a-5cdf820dd165@redhat.com>
In-Reply-To: <5e9144dc-1003-428f-986a-5cdf820dd165@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jul 2024 13:24:04 -0400
Message-ID: <CAEjxPJ5WQBWi0WH_yeXw+MfUKzd0k6QZOKzx8V9QyD_g2ODJjw@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:54=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
>
>
> On 7/23/24 16:56, Stephen Smalley wrote:
> > On Tue, Jul 23, 2024 at 9:09=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com>=
 wrote:
> >> Make sure that file context (all parts) and ownership of
> >> files/directories in policy store does not change no matter which user
> >> and under which context executes policy rebuild.
> >>
> >> Fixes:
> >>    # semodule -B
> >>    # ls -lZ  /etc/selinux/targeted/contexts/files
> >>
> >> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397=
 Jul 11 09:57 file_contexts
> >> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470=
 Jul 11 09:57 file_contexts.bin
> >> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704=
 Jul 11 09:57 file_contexts.homedirs
> >> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289=
 Jul 11 09:57 file_contexts.homedirs.bin
> >>
> >>    SELinux user changed from system_u to the user used to execute semo=
dule
> >>
> >>    # capsh --user=3Dtestuser --caps=3D"cap_dac_override,cap_chown+eip"=
 --addamb=3Dcap_dac_override,cap_chown -- -c "semodule -B"
> >>    # ls -lZ  /etc/selinux/targeted/contexts/files
> >>
> >> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s=
0 421397 Jul 19 09:10 file_contexts
> >> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s=
0 593470 Jul 19 09:10 file_contexts.bin
> >> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s=
0  14704 Jul 19 09:10 file_contexts.homedirs
> >> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s=
0  20289 Jul 19 09:10 file_contexts.homedirs.bin
> >>
> >>    Both file context and ownership changed -- causes remote login
> >>    failures and other issues in some scenarios.
> >>
> >> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >> ---
> >> @@ -3018,3 +3028,21 @@ int semanage_nc_sort(semanage_handle_t * sh, co=
nst char *buf, size_t buf_len,
> >>
> >>          return 0;
> >>   }
> >> +
> >> +/* Make sure the file context and ownership of files in the policy
> >> + * store does not change */
> >> +void semanage_setfiles(const char *path){
> >> +       struct stat sb;
> >> +
> >> +       /* Fix the user and role portions of the context, ignore error=
s
> >> +        * since this is not a critical operation */
> >> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX |=
 SELINUX_RESTORECON_IGNORE_NOENTRY);
> >> +
> >> +       /* Make sure "path" is owned by root */
> >> +       if (geteuid() !=3D 0 || getegid() !=3D 0)
> >> +               /* Skip files with the SUID or SGID bit set -- abuse p=
rotection */
> >> +               if ((stat(path, &sb) =3D=3D -1) ||
> >> +                   (S_ISREG(sb.st_mode) && (sb.st_mode & (S_ISUID | S=
_ISGID))))
> >> +                               return;
> >> +               chown(path, 0, 0);
> >> +}
> > Did you consider the fd =3D open(path, O_PATH); fstat(fd, &sb); ...
> > fchown(fd, 0, 0); pattern to avoid a race between the check and chown
> > (e.g. link changed from one file to another in between)?
> >
>
> Briefly, the code would be a bit less readable (interweaving writing
> file content and ownership/labeling) and we'd still need the current
> approach for any file created by another binary (e.g. sefcontext_compile)=
.

Not sure I understand that last part - why can't you do the same
open(path, O_PATH); fstat(fd, &sb); ... fchown(fd, 0, 0); for files
created by a helper program - just do it in the parent after the child
exits?

> I'll rewrite it if you prefer that approach, but do you expect such
> races to be common? The whole ownership issue already seems like a
> corner-case.

Shrug. That sort of race has been exploited in the past to relabel or
chown a file of your choosing by switching out one symlink for another
at the last minute but admittedly we are doing the restorecon by path
so your code is consistent.
No big deal to me either way.
