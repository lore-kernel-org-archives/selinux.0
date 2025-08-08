Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0122258C;
	Fri,  8 Aug 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654255; cv=none; b=sCpJI9jwOS35KfSlewNOZ3VVXRIzEqql/m2psmhSHU7V/3S1sOKMSJ+6Gv7gkyamgIBm5+rscH++6xDA9hB/jnkRq+b8zRJhLgMr1ZRNC5sw2rv8U38PafSanjtUIay6SPk2r2ErEZNzJLWattOdJn2CfJD1fXarvLUnII/5+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654255; c=relaxed/simple;
	bh=exllA3Jx6HUaPakedceH9it4g83BDsncNgPqDd46eb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQPW2Tu1RDlWLH+VOwuBa3W6OCUfC/1O9ZUOEDjfvGGhRk9pzViMLWd+8/dpiztn+IiD0Qbb6BUSMExj5/4Dg4Q/+Rhe6AqNxdZZZaahBQRcOGgOoTw4MtwZArJBYBrNAyZNVupi1kQNk5uK+/TJYvQWZJNttisD9JlGcCW5Cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0SNR28J; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0SNR28J"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31ec95ad016so1835171a91.3;
        Fri, 08 Aug 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754654253; x=1755259053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPmy7TV8Otdi8h7z+/vlIcixcwuDXsOiVWvreOaDeQE=;
        b=R0SNR28JfKMJ5Rp8lP5HmMTKGt5M4xrZ2h2qBxtQGeqpndZcK/II+FEm0/5JgxVeUV
         2ISurGJpcHaPiYFwOPl2sWkTpfd0wNP8Xv4uTzFL17GMLNvYMXj4tfNUZrKx0+yinrVG
         DblcO/Iz58qU8xcmm12h+fYfXi+xdTQT8DJREoAsRIZqaA5xX0exXFRIyVk3e4uv730F
         a/Hp7TQ7dutrBW9RFUkc8Og2PjwpnYKzw4d/qblsthEO0VE7V2eX8/w0bltqgt4VyFZI
         btm/+M+HHdX7M8cYQgMfd8Pv/1H7OSls0SAJ/634rhWP+uDstvpXbFPEHU5j0TNNj7sp
         5Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654253; x=1755259053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPmy7TV8Otdi8h7z+/vlIcixcwuDXsOiVWvreOaDeQE=;
        b=s5z10H/DaSCJYbCLeHtl5cGAm7xVPhQScHpqIwCJ2Ms0bqIj5KMC+UUahux78/4/F7
         5ZVZYRT1/Ag7P1kvYNjZwEkJpTUsvs41aJ7SBtWqHr68AQ7htAKHZ8j2DcoqiPuX1LyL
         wuzfeTutlRVCZCuL27ESbOhFwmLRMlX+Kx5DhUmAbvfANzoWfu2jzBAzoILC3Rl/+eWC
         o1Tb6dzuspXmT5nslaTo0HtxYzSI9Pk74+okfX3DxD3sAvGXOqN1tOBpO3G6gV/f9ei8
         XYnH63kRMy5uUMksjzOjIrsiOhbKk6xb47r2KqfjeYgjiwWooB8HN9DPMFV5Xo30i+rh
         dvEg==
X-Forwarded-Encrypted: i=1; AJvYcCU8eaHP5RK7XqatJRVlFCJB+L8S+uLPBX0Jekb2u/+E9nI8cGLt3Hba9RCPF2+KSumBAcqAmXs8puz4672uE+sKR/dUu/Kj@vger.kernel.org, AJvYcCV4E5JTj6/mtlxIOYA0J3X//WZAsghcSbfgsmovPNMWW+p5KgnPmWj345ItEvNYjiLu6KbOObp8ww==@vger.kernel.org, AJvYcCXaBTx6qPT1kVTdPmimgeqfK9KExRwp+ZcT72oLee87ZbeVnRzWql4aSnqgBmhDCGUsji1AqBbm7/zo0U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYP3QGN71jCvUIo01Nfn9cY+1Hs3YOJ000MXN8+yzb115Tg+HT
	+eoef5w+iFF332ErWtb9iLjdNauBm/wcTlQa7BzEXMgbOK8W6WVjIMnBr2eYIvSTPcFafbGBJrx
	l/AbzyQmyUuiFR5qqEnHmX6Ce4mgAMRo=
X-Gm-Gg: ASbGncuu8AGZJR0jgoOQcQ3cCLC4YUogNMhkNYMw5odPxwpjpMRpYsLH/rTQdmyBStI
	7DmQ846LZ39V/LpqSbePxvIaBrS5F69/NCjBFGqhACc8K2N7ZxCovaj9XrU/fFDw7Y7k3mCpxlH
	W1iSdvd4VfBO1ec96xyp/KVKyCQmxYC6qAvT52IcCkhrXQ0p2QSJYi0Ls7SdGWZaKgq5IZdycUD
	reh4UY=
X-Google-Smtp-Source: AGHT+IGLy0Plqc8pj0XqKVn/tG+Xg4TWhxNzbjRb+GBKmuIFfOWvybXhxeNO32hP17A6PKMexiQOxvyLz+efX+befPA=
X-Received: by 2002:a17:90b:5866:b0:312:959:dc4f with SMTP id
 98e67ed59e1d1-321839caddemr3562952a91.5.1754654252833; Fri, 08 Aug 2025
 04:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807075745.756415-1-tweek@google.com>
In-Reply-To: <20250807075745.756415-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 8 Aug 2025 07:57:21 -0400
X-Gm-Features: Ac12FXzFkzXFEtiVUAp0b2BNfX-6piwGGTrFd0rcZB7MNDm2DLbb9e2scCpH7zA
Message-ID: <CAEjxPJ5nC7s=+Os4+9XjkzhGTyaNVrCyJgx+rz5n3baRFWVrzA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] memfd: call security_inode_init_security_anon
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, 
	Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:57=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Prior to this change, no security hooks were called at the creation of a
> memfd file. It means that, for SELinux as an example, it will receive
> the default type of the filesystem that backs the in-memory inode. In
> most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> be hugetlbfs. Both can be considered implementation details of memfd.
>
> It also means that it is not possible to differentiate between a file
> coming from memfd_create and a file coming from a standard tmpfs mount
> point.
>
> Additionally, no permission is validated at creation, which differs from
> the similar memfd_secret syscall.
>
> Call security_inode_init_security_anon during creation. This ensures
> that the file is setup similarly to other anonymous inodes. On SELinux,
> it means that the file will receive the security context of its task.
>
> The ability to limit fexecve on memfd has been of interest to avoid
> potential pitfalls where /proc/self/exe or similar would be executed
> [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> similarly to the file class. These access vectors may not make sense for
> the existing "anon_inode" class. Therefore, define and assign a new
> class "memfd_file" to support such access vectors.

To provide backward compatibility, I would anticipate that you will
need to define a new SELinux policy capability and make this change
conditional on it being enabled, see:
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#addin=
g-a-new-selinux-policy-capability
for instructions and links to examples.

Otherwise, see below.

>
> [1] https://crbug.com/1305267
> [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com=
/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  mm/memfd.c                          | 16 ++++++++++++++--
>  security/selinux/hooks.c            | 15 +++++++++++----
>  security/selinux/include/classmap.h |  2 ++
>  3 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index bbe679895ef6..13bff0e91816 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -433,6 +433,9 @@ static struct file *alloc_file(const char *name, unsi=
gned int flags)
>  {
>         unsigned int *file_seals;
>         struct file *file;
> +       struct inode *inode;
> +       int err =3D 0;
> +       const char *anon_name =3D "[memfd]";
>
>         if (flags & MFD_HUGETLB) {
>                 file =3D hugetlb_file_setup(name, 0, VM_NORESERVE,
> @@ -444,12 +447,21 @@ static struct file *alloc_file(const char *name, un=
signed int flags)
>         }
>         if (IS_ERR(file))
>                 return file;
> +
> +       inode =3D file_inode(file);
> +       err =3D security_inode_init_security_anon(inode,
> +                       LSM_ANON_INODE_MEMFD,
> +                       &QSTR(anon_name), NULL);

Since the anon_name already indicates that this is a memfd, so can't
you already distinguish these via name-based type_transition rules?
Why do we need the enum argument?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d36d5ebb6e5..49742930e706 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2367,8 +2367,8 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>         ad.u.file =3D bprm->file;
>
>         if (new_tsec->sid =3D=3D old_tsec->sid) {
> -               rc =3D avc_has_perm(old_tsec->sid, isec->sid,
> -                                 SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, =
&ad);
> +               rc =3D avc_has_perm(old_tsec->sid, isec->sid, isec->sclas=
s,
> +                                 FILE__EXECUTE_NO_TRANS, &ad);

Here and below I am a little concerned that we could end up reaching
this code on an inode with an isec->sclass that does not define the
execute_no_trans and entrypoint permissions. We should do something to
make that never happens, or check for it and always deny in that case.

>                 if (rc)
>                         return rc;
>         } else {
> @@ -2378,8 +2378,8 @@ static int selinux_bprm_creds_for_exec(struct linux=
_binprm *bprm)
>                 if (rc)
>                         return rc;
>
> -               rc =3D avc_has_perm(new_tsec->sid, isec->sid,
> -                                 SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
> +               rc =3D avc_has_perm(new_tsec->sid, isec->sid, isec->sclas=
s,
> +                                 FILE__ENTRYPOINT, &ad);
>                 if (rc)
>                         return rc;
>
> @@ -2997,6 +2997,13 @@ static int selinux_inode_init_security_anon(struct=
 inode *inode,
>
>                 isec->sclass =3D context_isec->sclass;
>                 isec->sid =3D context_isec->sid;
> +       } else if (type =3D=3D LSM_ANON_INODE_MEMFD) {
> +               isec->sclass =3D SECCLASS_MEMFD_FILE;
> +               rc =3D security_transition_sid(
> +                       sid, sid,
> +                       isec->sclass, name, &isec->sid);

Again, name-based type_transitions ought to be able to distinguish
memfd based on the name argument IIUC.
