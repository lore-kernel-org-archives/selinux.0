Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71B379C31
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946483; cv=pass; b=GMAh/Y1ci2D0i8WI5OOIgjngyKDZvCEhMnKSA4MCwlA8at6pMEFUX+lzgEnNrtg2m/2fpcw35rXMhOP5/+YOs1ZuZ+ZIlA71tL1QC40NkzWyos89a71PzK7YdVnOyPg+SBYUSCg2eqM3+IKbzAZGgSfBZO5cs6jg9ZihrssAnew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946483; c=relaxed/simple;
	bh=YrHz8YZ43CxSfARfvrAgifJB6HE6igo+tpoQ1A+WQNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh+sxZKWNwqKYj8l27ukG6f9jlXY7AGUfnCTO8AWmT1GWdHsPfTJ0rYeD9jfEpDD45/Ixc3FcdDP97QMm2+ze/yicgGS6WSOTvBE+Ia1CS1wEKMDzMrCaZuTBBf+RgVG5MLgdb+xGX/PVR8GLxq5s2XilyexRjOPLQ/ZT64bFZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oe0D4n6h; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe0D4n6h"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f29ec73064so7677646d6.1
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 15:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946481; cv=none;
        d=google.com; s=arc-20260327;
        b=g2OdTTjZX1mbOKJ5A9rAwF3cqwH2LmkCeTqZdE/Si8kNxodzhuDzaUPp9NIzmxPb1F
         2EW/o5PDGQKi0CvuxIyV9YoaXlCD0lF5AeRVPbAg7VFsC/ZDtjl5SS8EDhu48+OwRL9W
         HooTldhM82xm1lS6A/WYot7U28s7CvwD96jYZ3I0PonIYTUiTwhA2yp2rKhJwmNpxnku
         0MYPCdlG0DBBOKSFMjJcJ/ln22QMmn8CnGwxnhXfsF71BANFSyExYA1b/6EauVV6F2BT
         44HMyCnlwVaFlRmEOBVLRMeHqSNPjqxk+77mWVkWi9TLpNS6DqGFeGYWmmpD+Dp/eQVq
         vL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdFRIxxhmjTBAY4g/1wOYGYHr9cH8lfvdG8YM/zsTzo=;
        fh=xFXwMammshtiA1st+JKr5RKiTYQ6X9/eRG0eM8oal7Q=;
        b=O23Lsfr9P84p2uyZjMquNcOii3KE8YrOZSqDDLZUrPEgXj4rG42Io2KbULfJEZ5OsZ
         juJvUadL9mTzKtyUDMQIWWRTQ1RZB1QvLM2zLdWiS4KyRq3SER1xCvHQNstozv8gIoLY
         o6tv/NV5ZnzmHXJ7JhmWoLJa6rDJNLaqGbWa1qzyrJ5LV8kpMLNYnuAk0AhCJtpn0A/9
         lhHwmoUWKgjtTDLD9s84rtXZhhKNcrNUv4zMJqbEKLCSJPS+pwezHNBE79TuYLS7Xj7/
         n9WY5dEPO5of2gl5nJ0AD2O0DlRsSnpiK6sCqSGuV+N4QvEYnNQEHvXHFaa4qHlDtboF
         65ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946481; x=1783551281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdFRIxxhmjTBAY4g/1wOYGYHr9cH8lfvdG8YM/zsTzo=;
        b=oe0D4n6hhppkiuohBMlsVwdoy+x6uP2UpPjgSx00nukU2I5NpdT6+DerAhcWZhs7aG
         FS4+SdR697SwCb6zjN5Tu6ksC4Dto92B5VlZX3VITT+Fko0bpl4/LOBOU3VPW60hOXPA
         RRrre8RBxmnO+upfTpkSqgb9MvP4qPAXT2WXWP8oOUx/CjG4RDQRhwD9/AGP8u5QwSa2
         ylYd24ruCGEoAgOuXhYjbOynmq3WMlMzH2IU1ZQX1wXrqtOeW7LO3xeDagvHHicyLI3A
         /zGc6CPl0F0ixLzuJK27Gqk3gH7vT1mX2fmYAaEq6cGhQtfK7yKTk5UHqZJcx9IdmWeP
         XQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946481; x=1783551281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdFRIxxhmjTBAY4g/1wOYGYHr9cH8lfvdG8YM/zsTzo=;
        b=ThDcBay8i1s+mIdIpz+TORIlM5BbCT9VOQ2xKLyN8CB2WwI8rISLRFTa+XqNhP5bQB
         WmRrfx2Otqk2xxDAhUy8/sZZnyze1lL4+1Z0hvcaDC8r7ki2m0qxUTo+lqBtJ5e/FOvD
         JKXd679me2Jh5hvgYeWwEcVl15kOaUBIyb49X7fUbG05UoWbTwywf2gWWANA4W0O0Llr
         gxs5wdUoAi0Cw4LmKpMfV6YzR8BOMzmGKPeBuuWsa3cL6nm1G5N0anWnzoNBQNl5BaB5
         Ln3u6RQek4X1v/InnkxeyffqkMZNUjbrFW3cfJ3atHpdQmd3Pu4s242HLvaBlB/zLdUB
         3PHg==
X-Forwarded-Encrypted: i=1; AHgh+RqVv33bbmTgYE64bAfFYtB/uPpCl8RfdceHzuExv8U/0ZJ7BnZzcGrK6Ddi73lDgKNTRVwTsiW3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/l5EPe/6EgcWYOjLxNT4H2NjW8pAjw7MCXs3YQb5gQmyOjtLf
	b1q33LX/4ruQAZ2eb8eT1Z4kXL8DJQ+55awK80FTsE+XdSlQ2Zmw8f6x/xuN/0WClT6/7MRlECe
	LT7iH01lvwjEeYpVfnB0sMkosfDvZDWM=
X-Gm-Gg: AfdE7cmYUkCSg/ywtSug6Xvqx1uBI+dpr1wZw4Fz+CHAKL5pvJR1n2chn5uzSjXSrkW
	XgThJPHIcd7igbKb37U1zVMe9gkDLmxsgF/SpG93PLSz9z19VfIex/HRfFbJWgJn4kwbTFga5HV
	NEgvY9vzWhcTlLmErXER9IXKFshue2sgRJU9Ggf9amOfHW6KkroPZtLWFnEhMCSRl0z/XmU6CdL
	xGA61p/skjh/KBMaH+xu+bftVWv5LjRu4l89CHUbNeQekcyE6SKD7GWFyUE/nP7Wf9lU5GhPxwK
	752paw6QjJOhbtpGvzeZHGiYIDg=
X-Received: by 2002:a05:6214:5703:b0:8c4:edb4:a44a with SMTP id
 6a1803df08f44-8f3c73b6003mr55971746d6.23.1782946481604; Wed, 01 Jul 2026
 15:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <20260630185420.96A6B1F000E9@smtp.kernel.org>
In-Reply-To: <20260630185420.96A6B1F000E9@smtp.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:54:29 -0400
X-Gm-Features: AVVi8CfjKMOaPkHqrop8tSk9s7QdUaQXIvtbHpp2DcyirtgW-I3jIDr4KPnWk_s
Message-ID: <CAEXv5_iqNay39fp_2jJjxWUpfzBtfiUgpfo5-TYysrLMGEfNGw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 2:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [ ... ]
> > @@ -385,6 +463,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE=
)
> >  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
>
> [Severity: High]
> Does marking this kfunc as sleepable create a risk of deadlocks?
>
> Since the kfunc is only callable from the inode_init_security hook, marki=
ng
> the hook as sleepable allows BPF programs to trigger page faults
> (e.g., via bpf_copy_from_user). When a file is created (e.g., ext4_create=
),
> the filesystem acquires a transaction handle before invoking the hook. If=
 the
> BPF program triggers a page fault, it will attempt to take mmap_read_lock=
.
>
> Concurrently, another thread doing a write page fault (or mmap/mprotect)
> might acquire mmap_lock and attempt to start a transaction (e.g., in
> ext4_page_mkwrite), which blocks on the transaction handle held by the fi=
rst
> process. This creates an AB-BA deadlock between the filesystem transactio=
n and
> mmap_lock.
>

This is real. We can eliminate the deadlock by removing KF_SLEEPABLE,
which is fine here once we change the single allocation made by this
function to GFP_NOWAIT.


> >  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> >
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> [ ... ]
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 564071a92d7d2..1c3f84a924203 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -315,6 +315,7 @@ BTF_ID(func, bpf_lsm_inode_create)
> >  BTF_ID(func, bpf_lsm_inode_free_security)
> >  BTF_ID(func, bpf_lsm_inode_getattr)
> >  BTF_ID(func, bpf_lsm_inode_getxattr)
> > +BTF_ID(func, bpf_lsm_inode_init_security)
>
> [Severity: High]
> Is it safe to add bpf_lsm_inode_init_security to the sleepable hooks list=
?
>
> As mentioned above, marking this hook as sleepable permits BPF programs t=
o
> take page faults from within a filesystem transaction, which violates
> filesystem locking rules and can freeze filesystem operations.
>
> >  BTF_ID(func, bpf_lsm_inode_mknod)
> >  BTF_ID(func, bpf_lsm_inode_need_killpriv)
> >  BTF_ID(func, bpf_lsm_inode_post_setxattr)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630183956.28=
1293-1-dwindsor@gmail.com?part=3D2
