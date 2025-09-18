Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4B3043AC
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202593; cv=none; b=ZVvO1hwwUj97MwBiHrrOR+ClyGV4KJXJajvlkmTe04DSrfAa4HvrFavpf821HsypSxbpGExuEOI/jR53wW/vzqsU636x3V0xSFUgsmHI4wkNu1JyEc0LUwlI4HwuWNZwfbwi1Z2fbv0njUsdXNgGpdtPVuw0tbC8GIFhowipUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202593; c=relaxed/simple;
	bh=cEK0KarQd1hQZmVdUPfPHOQldZf9SX8R0ChrXqqHvMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbWcGp5OfklNLjwKy1lYgCsVSetUcFeQ8dDgbACTyM/etTIZmtI8rTBD0vTF821a8WiWiyqhWbPPdNphEo7zSYOxlEQbWo7KBS+GqF2uRLcWhIq2ouF3HO537ztD3bh0kptTcuEwzysG//e0Y2mTU7wAmNegD10ozQMLTK9lY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssh9Uzr5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssh9Uzr5"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so761331a91.1
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758202591; x=1758807391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qY6drwVd4Um/yObjB71+I48lsrprtnTk+suXfhrpLQ=;
        b=Ssh9Uzr5FAxPoosLvDQnenHwS3xXNcXfw4DKGe7Sk5G0KeNf+E9GGZLLqVjpQKfTlf
         DGBSe5yl+YltmA4S6JCpL+lm9qnOkv1+klXNQX1sUzgBCHCHbyOh7A8duNqyjxx0Zsse
         m6hB69qMtE0jghYXWSHz1GMQbQCzchv8SexQ+6NliiNU9l42GWRoBQXYCsMHrIqPiJaJ
         FcWA1Qdp8zqx2BiA3ZI0W1tG8+ORK9codwxnCDyquebJ28KQgpO9AtMHq366mCYb0D4H
         V4EtmDZ8hyDTK7dAcbF7yRIJZ+ZvVWp/ZZ/asarIkDnVOOnWgkKmYoPfI8ok+ftEFv3s
         2sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202591; x=1758807391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qY6drwVd4Um/yObjB71+I48lsrprtnTk+suXfhrpLQ=;
        b=KJd1k3eVZG446awOVe6MYATgqthlTVWycOQ0Uta+c3WvU1RTw4OEjWVilYYKzLr+mC
         01bf7opiyc7Qx3kYSEvFQIab0dGjZwm91gpQj0aX6fRX2/2gJrmoSd3HTPqN6bS4ozRc
         sPYNrlpJhBqMLIfgZjHtoi2L8leFs/ILgHCGfJ5hHFAc52nnkFQSz29E+AAIXtk+SMrY
         McgL1WjqMofffkK6xuTwPJjPMZdHyK4kqYs8UimWrj/Qxq1AfCqTWtbl/2Isqm/sjRpb
         bqxyZ5hKoyYsbjxI9hinLt9GQ9EHIpDkCyjnrOa+R+8HMDndw+uPiIYs63ENbOjZrtBJ
         Vp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLPaMveHO4gczEIp++vYoKgHso0O0GYEaIDUa38pFLFz8BPbmkDUHiS3sYN6/LjTF5MnfVPYdI@vger.kernel.org
X-Gm-Message-State: AOJu0YybdnOBx7x01+Rz/yHDxHpi1xaRNdPQqUZhWU8EkrabfFTjf1+W
	bD/714IrkhBZ/mDqmfdnt+RfRQjQeG77Ddmpxla0pdKQdieO6MYoy3gFIYBnn6yEj9+9Y1dDUxA
	4KH1TI67A1QoC04urDugnFQMWWTlWQSk=
X-Gm-Gg: ASbGncu1kwVwY2GO+jygLn+4ppxcUDX/ivKXk5bE+b2R3+kRDJvBSmCYa8ZgUnJm69y
	9bynNbaSDhegrOhAtifg313r5GCzFlK78P2x+S3pPFQCCRX5c0DBb/iBUGeBHMGiTDBZeuwMBWP
	waYjO202kSgijg/GWb4VQ26s42xokesIRmxNHknQUls/PSYXMZQUe+8atNUYkq8/R9Y00rTMZqP
	9F2SMhE1ZQAKCSRvmzlkN3BjA==
X-Google-Smtp-Source: AGHT+IEo3mBIh3T3J1Bjw6WuqPgog44RWXORjpeYDLC6TTx6Yx07GZSMKw8EtqJBykpDiE3zYZClc5Bs/4SIeH0oq/A=
X-Received: by 2002:a17:90b:358:b0:32e:8c6d:5928 with SMTP id
 98e67ed59e1d1-3305c6c7a0amr3418212a91.13.1758202590977; Thu, 18 Sep 2025
 06:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821182021.304-1-ericsu@linux.microsoft.com> <1752d2d2f04b17d4da2e40990985be51@paul-moore.com>
In-Reply-To: <1752d2d2f04b17d4da2e40990985be51@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Sep 2025 09:36:19 -0400
X-Gm-Features: AS18NWDXpa-Sx2HSKqWWiKiJZnv2ssfYPzuh1pSGogl0ZpsTOqeYH8-8skGQQFQ
Message-ID: <CAEjxPJ6qiw_T+9u_GuYgmLXShhbcG7hSt34Z9kvpiH9AQ9nmKA@mail.gmail.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Aug 21, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> >
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to an
> > unprivileged process:
> >   https://lore.kernel.org/linux-security-module/20231130185229.2688956-=
1-andrii@kernel.org/
> >
> > This patch adds SELinux support for controlling BPF token access. With
> > this change, SELinux policies can now enforce constraints on BPF token
> > usage based on both the delegating (privileged) process and the recipie=
nt
> > (unprivileged) process.
> >
> > Supported operations currently include:
> >   - map_create
> >   - prog_load
> >
> > High-level workflow:
> >   1. An unprivileged process creates a VFS context via `fsopen()` and
> >      obtains a file descriptor.
> >   2. This descriptor is passed to a privileged process, which configure=
s
> >      BPF token delegation options and mounts a BPF filesystem.
> >   3. SELinux records the `creator_sid` of the privileged process during
> >      mount setup.
> >   4. The unprivileged process then uses this BPF fs mount to create a
> >      token and attach it to subsequent BPF syscalls.
> >   5. During verification of `map_create` and `prog_load`, SELinux uses
> >      `creator_sid` and the current SID to check policy permissions via:
> >        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >                     BPF__MAP_CREATE, NULL);
> >
> > The implementation introduces two new permissions:
> >   - map_create_as
> >   - prog_load_as
> >
> > At token creation time, SELinux verifies that the current process has t=
he
> > appropriate `*_as` permission (depending on the `allowed_cmds` value in
> > the bpf_token) to act on behalf of the `creator_sid`.
> >
> > Example SELinux policy:
> >   allow test_bpf_t self:bpf {
> >       map_create map_read map_write prog_load prog_run
> >       map_create_as prog_load_as
> >   };
> >
> > Additionally, a new policy capability bpf_token_perms is added to ensur=
e
> > backward compatibility. If disabled, previous behavior ((checks based o=
n
> > current process SID)) is preserved.
> >
> > Changes in v2:
> > - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
> >   creator_sid from wrong file descriptor
> > - Removed unnecessary checks for null, per review comments from
> >   the first patch
> >
> > Changes in v3:
> > - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_creat=
e and
> >   allow it to fall through to the permission checks which will fail as
> >   access denied to unlabeled_t
> >
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e474cd7398ef..d949e9c5aa31 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -733,6 +733,8 @@ static int selinux_set_mnt_opts(struct super_block =
*sb,
> >               goto out;
> >       }
> >
> > +     sbsec->creator_sid =3D current_sid();
>
> A few things come to mind as I'm looking at the new creator_sid field.
>
> First, we should explicitly initialize @sbsec->creator_sid to
> SECINITSID_UNLABELED in selinux_sb_alloc_security() just as we do the
> other fields.  Yes, the LSM framework does some basic clearing, but this
> is safer long term and it isn't likely that superblock allocation is
> going to be common enough to where the extra assignment is going to be
> a concern.
>
> While I don't think this is an immediate issue, I think it's a good idea
> to ensure that the selinux_cmp_sb_context() function compares the
> @sbsec->creator_sid fields and only returns true/"match" if they are the
> same.

Hmm...that raises another question in my mind - what happens if
multiple processes mount bpffs filesystems currently - do they each
get their own superbock or is that shared?
If the latter, then making this part of the comparison will block
subsequent mounts by tasks with different SIDs.
But not doing something here would lead to using whoever was the last
mounter for the SID, so I agree something needs to happen.

> > @@ -7144,10 +7180,15 @@ static void selinux_bpf_prog_free(struct bpf_pr=
og *prog)
> >       kfree(bpfsec);
> >  }
> >
> > +#define bpf_token_cmd(T, C) \
> > +     ((T)->allowed_cmds & (1ULL << (C)))
> > +
> >  static int selinux_bpf_token_create(struct bpf_token *token, union bpf=
_attr *attr,
> >                                   const struct path *path)
> >  {
> >       struct bpf_security_struct *bpfsec;
> > +     u32 sid =3D selinux_bpffs_creator_sid(attr->token_create.bpffs_fd=
);
> > +     int err;
> >
> >       bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> >       if (!bpfsec)
>
> This isn't an issue with your code, and to be clear I'm not asking you
> to fix this, but more as a FYI/TODO for me (or anyone else who would
> care to do it), after the BPF token patch is merged, we should move the
> @bpfsec allocation/lifecycle-management for tokens out to the LSM
> framework so it can properly handle multiple LSMs.

This already happened in the LSM tree, just hasn't been merged to the
SELinux tree yet.
