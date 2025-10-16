Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA2186284
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623517; cv=none; b=Iyb8n0+0oscAax2du6p89jQHsF9liAMjgYCZKJvhvAxUp8HssHRiO31hROf6TU2DAVBEOXMNCEmUgYYQNek5O/WchhpObbZXaIRhMnyWypFwEPm47HajpAWbyyCJAXdr9avb+b3SLXeN/F/tXmy7n8p8CfuTungtXrKY36Zrws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623517; c=relaxed/simple;
	bh=kiIjqOgmcZWHioyY59M9oltsD2+SjqBHb5ZjUnGdmgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2E05roP7YPTQ4zwbeKMwENDE6pBL7Eoc138csLnU6ZZb+HK1Cs4df19jt51n+IneXdpsoKBhaLWiDwD+rF4ZGTyr4R5PXkr8LQfpJPmAGeyYUtl+X0sGm4jRMTFLKC4n7AouDWFb+TwYJ7YCEUSHuEa4Lpt34JYrKIokx8YD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1eGfkdS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1eGfkdS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so850003b3a.0
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760623514; x=1761228314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulnwp41U1+A0HF+wwi+uQ0+tbMyK/WTny4LEDbP00Ds=;
        b=N1eGfkdSMHcIv4ToBP8m9qYlX8ZUQXFfx3YXK+Y1NHWzXgx1aa2kvIngbOxhh8217f
         lDOnuyM6KrLd931W4zDtT8JYzw8hYfrTMp9NoAihKs1ZqHvpjxuiifgBCUxMvlqH7SuU
         sTcn25DB3mp3njlCxwk5y+z1zgJZfOCs46Zz214KlPmtxDINZKYbfBHI2g6DzSnnwIjf
         RQcXxBb2taCEJ/tEml+F3xLtFAhcQtZr0jsmUWPPkbIAgerBR0to618lzm3PPBcwS8Sj
         yk4ig9Wf0o1GNew2oX9Rwy9Cr/jWssmC97ey+FFZYzt75G2gRLqPn8LHDGWtWCWXzJnI
         C5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760623514; x=1761228314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulnwp41U1+A0HF+wwi+uQ0+tbMyK/WTny4LEDbP00Ds=;
        b=DYAQyyrhdHPhbizgq3gEEIhtqNJwYe5s510rElkVkfY+u8F+RnEKEZEt1XlXAlwh09
         8hXmEz06VUqpvTI/dAAgCZ6U3RdUznCz05YYKxS9+l/y6kdoiovsX3RPvZLKLRkggJ+4
         cyz2zlTiZ4YnRUT7O/NkHanC1mCroxIb8NjzUekgCDImIaofhO8qOf9FL7siveT4xtjS
         K3F/xWMz4lz/BdHS7CiGqBK8vYNAa8E83avYXv3W7WoSU3bzgLnf0PTGEq5PLhIGjt7a
         golv6Y5gIGnSyIZfCWMZWkdyYT0ZWzu5RMpIWbFJO5IA7yiFQgCor9bJuvhe5i2xgXTq
         JIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOPMwvd1DugPm5dZwXPN3fS4F3+lygdz3jyuYOtCCPSeRRZC8LGwYEOuyxBwQQuB8cnf1n5TH9@vger.kernel.org
X-Gm-Message-State: AOJu0YwOl0Y4pCIsqZFyt6LAPbuziGC+mQFyBK7RsQSUTILVGslLPZSG
	OdeSLNS4O7KZzy2hwOpn1nQtRSO1uElaKAgl4VtCe/rvImGe+1gdWsS2zX7Sqs3Y1SATI7pFXM/
	g3dr4OB5dmzJLgfqrVgCqEV24moFmiCU=
X-Gm-Gg: ASbGncsRc0fcSHsQgvpWh+pOZ6nbQVQH485kuoXNZ0QpIakyRJ7MYDQUtzardLgddZh
	wxlZXjCrDCp0zFv2gz4GTTjxHkfSVUUFQ6BMYVv9zF7ouiTEb1q6Ga+fdeffX2/mm/B7z6/7Pqc
	v/8F8EhreRLLQsrdZ1Z0zNUegGZ/Su56sg1guzL5zhIBwcp8LVqZRsiEptmWmTR3Tfk+P1pOcce
	hTaPhXzUadgxE4KaHYVD77EwR/CmqPmp61IxwlUuV0129vW1fdvx0GYPTbQ
X-Google-Smtp-Source: AGHT+IHtS1/GOZbfEvBQs7rJVE/wpPXPA9J774IRQTdmV3RSZgOW5m+xGj4HCJnaKG392adbcrrpm/JYZmNnBrVGzaQ=
X-Received: by 2002:a05:6a21:329f:b0:2b9:6b0b:66be with SMTP id
 adf61e73a8af0-334a78fbd57mr465129637.14.1760623513415; Thu, 16 Oct 2025
 07:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008234613.2150-1-ericsu@linux.microsoft.com> <9f91729c4030890ebd10a6faa1009589@paul-moore.com>
In-Reply-To: <9f91729c4030890ebd10a6faa1009589@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 16 Oct 2025 10:05:02 -0400
X-Gm-Features: AS18NWDA9zYJ8OpoYTIKWFNG8OFkEwl7iQkTV4kknnyxiF-I68Ijb4lAp4096Cg
Message-ID: <CAEjxPJ4SdB1xEM2zNwAW9hgdh7QqbCEOewjaR0t61QnKNKyw3Q@mail.gmail.com>
Subject: Re: [PATCH v5] SELinux: Add support for BPF token access control
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Oct  8, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> >
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to
> > an unprivileged process:
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
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
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
> > Changes in v4:
> > - Added initialization of creator_sid in selinux_sb_alloc_security
> > - Enabled handling of creator_sid in selinux_cmp_sb_context and
> >   selinux_sb_clone_mnt_opts
> > - Minor updates based on review comments
> >
> > Changes in v5:
> > - Moved to dev-staging branch instead of main
> > - Added implementation of selinux_bpf_token_capable which is originally
> >   from Daniel's patch
> >   https://lore.kernel.org/selinux/20250801154637.143931-1-danieldurning=
.work@gmail.com/
> >
> >  security/selinux/hooks.c                   | 116 ++++++++++++++++++++-
> >  security/selinux/include/classmap.h        |   2 +-
> >  security/selinux/include/objsec.h          |   2 +
> >  security/selinux/include/policycap.h       |   1 +
> >  security/selinux/include/policycap_names.h |   1 +
> >  security/selinux/include/security.h        |   6 ++
> >  6 files changed, 125 insertions(+), 3 deletions(-)
>
> FYI, I had to apply a surprising amount of merge fixups due to the
> allocator changes that went up to Linus during the merge window; I've
> never seen git put put patch hunks in such odd places before ...
>
> I fixed up several long lines too (lines > 80 chars).
>
> I also gave credit to Daniel in the commit description with the following
> text:
>
>     Credit to Daniel Durning <danieldurning.work@gmail.com> for his work =
on
>     the selinux_bpf_token_capable() implementation.
>
> ... but I have some questions about the BPF token capability hook, see be=
low.
>
> > +static int selinux_bpf_token_capable(const struct bpf_token *token, in=
t cap)
> > +{
> > +     u16 sclass;
> > +     struct bpf_security_struct *bpfsec =3D token->security;
> > +     u32 sid =3D bpfsec->sid;
> > +     u32 av =3D CAP_TO_MASK(cap);
> > +
> > +     switch (CAP_TO_INDEX(cap)) {
> > +     case 0:
> > +             sclass =3D SECCLASS_CAP_USERNS;
> > +             break;
> > +     case 1:
> > +             sclass =3D SECCLASS_CAP2_USERNS;
> > +             break;
>
> This assumes that this call will always be made in a non-init userns,
> I'd rather see us handle arbitrary user namespaces, see
> bpf_token_capable() for hints.

Is that possible? bpf_token_create() explicitly disallows creating a
BPF token in the init_user_ns.

> This is especially important if we consider that the capability being
> checked doesn't necessarily belong to the current task, but rather the
> token, which was very likely created in a userns closer to the init ns,
> more on this below.
>
> > +     default:
> > +             pr_err("SELinux:  out of range capability %d\n", cap);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return avc_has_perm(sid, sid, sclass, av, NULL);
> > +}
>
> This is surely a copy-n-paste from selinux_capable(), which is a very
> sensible thing to do, however I do wonder if the special nature of the
> BPF tokens warrants a change in the subj/obj.
>
> For a normal capability permission check, it makes sense for the subject
> and object to be the same as the process/subject isn't operating on
> anything other than itself, it's simply attempting to assert a capability
> that it has been assigned.
>
> However, I don't believe it is quite as simple for the BPF token
> capability check.  In this case the current process isn't asking if it
> can assert a capability assigned to itself, it is asking if it can assert
> a capability assigned to the token.  Due to this I'm wondering if we
> should change the subject to the current task, leaving the object
> as the token:
>
>   selinux_bpf_token_capable(...)
>   {
>     struct bpf_security_struct *bpfsec =3D token->security
>     bool initns =3D (token->userns =3D=3D &init_user_ns);
>     u32 av =3D CAP_TO_MASK(cap);
>     u16 sclass;
>
>     switch (CAP_TO_INDEX(cap)) {
>     case 0:
>         sclass =3D initns ? SECCLASS_CAPABILITY : SECCCLASS_CAP_USERNS;
>         break;
>     ...
>     }
>
>     return avc_has_perm(current_sid(), bpfsec->sid, sclass, av, NULL);

My understanding, which could be wrong, is that this hook is called
outside of process context (or at least outside of the context of
either process involved - token creator or token user) since it can be
called during any eBPF program and hence we can only use information
from the token, not the current process, for our permission checks. We
could perhaps pre-compute the capability access vectors at token
creation time and cache them for later checking instead.

>   }
>
> Thoughts?
>
> --
> paul-moore.com
