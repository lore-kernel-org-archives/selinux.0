Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4B33CE86
	for <selinux@vger.kernel.org>; Tue, 13 Jan 2026 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323130; cv=none; b=gOeJqwo79N9PrZ51BMFQlSpW7EE7QfHCtUzHqGRLnH8Zk/h8UGuPXeyuRzz/Ken2jjKP7qqXlkp2JcpgQCxbKULrgFU5lO7B6KbnNuVilCWsNQmTk52SAa7NvWs65z1jJs21d5iHkIx2UdcAx+7Ofwv5ZjqMpfzrWMc+lzHdEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323130; c=relaxed/simple;
	bh=Na0zErdsz8WhOd3ZHaZ/0JJR/up2UWANEni25BCe1u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXloYtFSJ0NgYkdi5e+OEfX5TSVi4u7oaYCJpvnVscWy9ilTVHeKg1f7DhKq/NlQpXAJiFmtD/wiLMQXH6A8jMBv54Q6KSXymuEtGl4vHZCJG7DCpYBeLSlf3i6NHvTD4IyvcF/XVWBssWKLpIvqzlPHgkNh/kpE5ZmhMNuqKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E/rYX8M3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E/rYX8M3"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so2598b3a.0
        for <selinux@vger.kernel.org>; Tue, 13 Jan 2026 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768323128; x=1768927928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q3pDymkB1WSFqOBAryy8ihYcfs5sLWkamagigN+vPw=;
        b=E/rYX8M3wenWl7riz9evafZuxjzZxPvkGQAF16j4WB4Mo6KrHfg5x312oJjCinv1Ab
         U8zbDlodKy/Yaci4puags4GXx4ELf9ojIloy7GpJcUI034GDLbdIahCTg0PFBX6DYaqn
         /Zi+00jIedE4GOSJb0GNcOqQKUcqlVBzfgy7DuSmTM/D6gynkmi+IHffLIbpboSdVH54
         8i9c4wBrBShCUTALHvkoJqEZ6kbSWdI7rynM1EQm6uEbGkNBgPJPqZ+nBMaV0FqNAb4v
         7YqUKt6swWOTnVpqBxP/jv9HZYFvxak0VWT2LbSYuZIR9y8bn1lUoGCIXHV5NctWTJ4s
         krOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323128; x=1768927928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Q3pDymkB1WSFqOBAryy8ihYcfs5sLWkamagigN+vPw=;
        b=lI6Nr3OguWVdOCfO0d08FQQWWNookbW2vojvnwYJhguN6IYJKtONBRLkmFIgrppAW7
         mXlmTdaDo50Pg0PzYEdooLMNH0inP8BUFxA6eZzBs3pA61nsZedoDyyT3C+/WNePHX9f
         tvU5msNSal+11xd3Wcm3cGmrN5MZTbI0Ke8mSyxrZ+EOLdBHXhstwifAR9CX24nwS7J6
         jTsMuY6Hl1KK065x5Vjwza+Wy+N3cuTbREeNbdyBm+55Hmpm1XEROdOD5kZU0vhHp6zd
         v1hs0kZ+O2SztQlcy4kDBSsJd7OK3kMGQ3XWjCvUHGtin5vrXsp3Pb6uTVez55rhNK9e
         Vt6w==
X-Forwarded-Encrypted: i=1; AJvYcCXea2q+RCPZ9j3n9zes3a9Vte68z0v+Ml4bSoE+O49j6WpKIuz/vA+vXK2Ad5VO4VddbTWNVSln@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHTAB9Q5JgKmj9i30yms1YMHQz6vdUWIxCCj+Wn6eLuDTGB6L
	q4A/hnuNsZKzzKuKX1TR6XKhZHjaFewAnYRh8WOwbTEUbXj4CvBNQSCWgi50pHQuSYvJHp0SlHb
	GrG5e/sdXxqK9o5y+L01d3ijDkoGJ54P0aERoXM/X
X-Gm-Gg: AY/fxX4pj5mIz5cqVgjPysXgFMGFvTnK48tlm5gCuorhyrdMSl2RQKX+YfpURYJrdOl
	pSxQVHXxyOL7EkkhyR00VLLSR5JQuHGCG7tyTWpfzUxPrB1UVwONUlq4v5YTKTGe9jC662ahbCR
	orAVdJa23tWJhfDqDSRjKS9qGVxsBDoFnIJ3auPTztiGhalAz2/E69Ey5+H/Q7PI7kKrJuR2uje
	XYUmH+O1XF51mV1I6AOIirXBW9GON5z8aI/nToZVHr7BdhkyYl4W9WOjHyS2L/60uqk91k=
X-Google-Smtp-Source: AGHT+IExFkOkaV/tDAVbqGHr08+3t5OX1oZ5Q/tS2lkY7MKc/zL6ADdIgq0zECFQ9xPuGKZfE2uwWtM/cCgcAgwYgwM=
X-Received: by 2002:a17:90b:48c3:b0:349:162d:ae0c with SMTP id
 98e67ed59e1d1-350fd12c546mr3306164a91.4.1768323128275; Tue, 13 Jan 2026
 08:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205024259.704-1-ericsu@linux.microsoft.com>
 <caeaa280-ffa3-415f-bf39-340f66ee45fa@linux.microsoft.com>
 <CAKrb_fG=OdXSydv0GV8XmtXv2ptfNN=U0ebht_3CTu+oe-wskA@mail.gmail.com>
 <CAHC9VhRcZb5KKT9yqrqw4odFWgiXgv_-U+KoR=qrtepE5zt-bQ@mail.gmail.com> <CAEjxPJ5oCPUAaSxoCi9DQGBrPMfXBF-qNvzpxA-+7ZRuSgHdhA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5oCPUAaSxoCi9DQGBrPMfXBF-qNvzpxA-+7ZRuSgHdhA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Jan 2026 11:51:56 -0500
X-Gm-Features: AZwV_QjT3CrmXjfU250K41y2uyj5SDgMoDrVGssG_OtQ6JfrXV6BPQLHpjk2ZL0
Message-ID: <CAHC9VhS+89Lt2SJA6+BN8CZzbOq+09hMXS2XzNwM-7TpmKJSsg@mail.gmail.com>
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 9:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jan 9, 2026 at 10:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Dec 10, 2025 at 12:37=E2=80=AFPM Daniel Durning
> > <danieldurning.work@gmail.com> wrote:
> > > On Thu, Dec 4, 2025 at 10:12=E2=80=AFPM Eric Suen <ericsu@linux.micro=
soft.com> wrote:
> > > > On 12/4/2025 6:42 PM, Eric Suen wrote:
> > > >
> > > > I need to mention that this patch is based on v6.17. Ran into few
> > > > Hyper-V VM/testing issues with the latest kernel (v6.18) that I hav=
e not
> > > > yet been able to resolve. I believe the issues are related to HYPER=
V
> > > > configs, but troubleshooting will take some time. In the meantime, =
I
> > > > would like to get this patch reviewed early.
> > > > > BPF token support was introduced to allow a privileged process to=
 delegate
> > > > > limited BPF functionality=E2=80=94such as map creation and progra=
m loading=E2=80=94to
> > > > > an unprivileged process:
> > > > >    https://lore.kernel.org/linux-security-module/20231130185229.2=
688956-1-andrii@kernel.org/
> > > > >
> > > > > This patch adds SELinux support for controlling BPF token access.=
 With
> > > > > this change, SELinux policies can now enforce constraints on BPF =
token
> > > > > usage based on both the delegating (privileged) process and the r=
ecipient
> > > > > (unprivileged) process.
> > > > >
> > > > > Supported operations currently include:
> > > > >    - map_create
> > > > >    - prog_load
> > > > >
> > > > > High-level workflow:
> > > > >    1. An unprivileged process creates a VFS context via `fsopen()=
` and
> > > > >       obtains a file descriptor.
> > > > >    2. This descriptor is passed to a privileged process, which co=
nfigures
> > > > >       BPF token delegation options and mounts a BPF filesystem.
> > > > >    3. SELinux records the `creator_sid` of the privileged process=
 during
> > > > >       mount setup.
> > > > >    4. The unprivileged process then uses this BPF fs mount to cre=
ate a
> > > > >       token and attach it to subsequent BPF syscalls.
> > > > >    5. During verification of `map_create` and `prog_load`, SELinu=
x uses
> > > > >       `creator_sid` and the current SID to check policy permissio=
ns via:
> > > > >         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> > > > >                      BPF__MAP_CREATE, NULL);
> > > > >
> > > > > The implementation introduces two new permissions:
> > > > >    - map_create_as
> > > > >    - prog_load_as
> > > > >
> > > > > At token creation time, SELinux verifies that the current process=
 has the
> > > > > appropriate `*_as` permission (depending on the `allowed_cmds` va=
lue in
> > > > > the bpf_token) to act on behalf of the `creator_sid`.
> > > > >
> > > > > Example SELinux policy:
> > > > >    allow test_bpf_t self:bpf {
> > > > >        map_create map_read map_write prog_load prog_run
> > > > >        map_create_as prog_load_as
> > > > >    };
> > > > >
> > > > > Additionally, a new policy capability bpf_token_perms is added to=
 ensure
> > > > > backward compatibility. If disabled, previous behavior ((checks b=
ased on
> > > > > current process SID)) is preserved.
> > > > >
> > > > > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> > >
> > > Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> > > Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Thanks Eric and Daniel!  The v7 revision looks pretty good to me, does
> > anyone have any other issues or concerns with this patch?
>
> No concerns but was waiting for a version based on something newer than 6=
.17.

I did a merge against selinux/dev last week to review it and while
some manual fixups were needed the fuzz wasn't too bad, I've
definitely seen worse.  Hearing no concerns, let me give the merged
commit another quick look and assuming all looks good I'll plan to
update selinux/dev later today.  I'll send a note once it is upstream
in selinux/dev and folks can double check the merge if they want.

--=20
paul-moore.com
