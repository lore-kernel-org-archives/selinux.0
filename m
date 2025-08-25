Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731282ECE8A
	for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130905; cv=none; b=G9K639cAQcNKhmJTT6UPZr/BHKtSksY7YQDI7PiKOpiI5UKuqFnaer7KtHaUgSR88SG/ucNME5oLym/MBNWg3pbwBWAIc+4iotUQ4YSg8ZY36JLobTSFNMfeQ81D6VYC4uh682PHfDDIzlB1H3oQTBj7ppnUbrmdQjno2n20bl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130905; c=relaxed/simple;
	bh=chf0Y4qkGlq3ad0oQHjvKOgaLPHG/fPokA9WGs/uGVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laiohCrHVQ5+bwYnQkhfCHqL0rCPfQ/uEDvYD8F83UNmWa9QQrwITbEvnArJLCiNvT2UR6JP9EW4ODNeiDB4GDUeiapX5XGIrI8Hpt2edUIyKBLlDRtWw1vEr50CJQmWeDMdN5Xm3RB1C75qApQyYI8DwZrkrVDiCQUgGcuLl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8D2V2pk; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8D2V2pk"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47174c8e45so4262394a12.2
        for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 07:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130904; x=1756735704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzJW2ROTeAzGAsrDdQWA8NqRpSmSo27xEb1eymuax+4=;
        b=I8D2V2pkr9ClHiNzw/dfel3Y8UoHYzaZc4tORII+ftBdo3JxvtJjo1/DefSkhm3eSZ
         8ka+dIkXRJ2lQ99JH3HoyKJLHzycY73M7g4cBYdcTQvsUMRQJQpYuk+vFhLtAeNcdGA9
         csY8EEXh4TWX96Fq4vIaaNIDbEXyYo6SqY+JQvHQNEMKrL9am/BrC+vRHPimzdkuqFmJ
         UFsWjm8FjlmkxTsBCHU2cJTW7jle5Xw0iIot7+AKzAdPaAzVvdoXsqWXwwfP4tq3AYx7
         a/wJcma9GC8IyDEfLWwsFhv3hL3yChZw0+9pApjIYibTxD6ifHF08r2pmLLI9btB+m6R
         1jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130904; x=1756735704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzJW2ROTeAzGAsrDdQWA8NqRpSmSo27xEb1eymuax+4=;
        b=nqs/3cZc8t1BSNuPthyB1CPfKgnbyNtIFIJUQUkOz2nsJijo8HID8foZ+ed/oDZgBv
         TAh2q5kAouSR6I/nWRwa95aAajybEIV7zgRAvOqi9w2X6J5XjD+z0zusT+NyOX+AIILf
         C7Y1bpsiR+j9onB51sKeFiDb5K82mkkXbxsjR1YqVz2OXWVpylk7t2fSBnf2JVRcOtnj
         SNHNb1fpRvCXr02DPpPaoUtm/jKVcUa5jJQKetEMI19DgTpyuPu3yUMJk9Kg97L2B7B2
         l7py4yRHfHVoF0tobOSXwOQfrTJCP/lqaK7tt1wsvljbFCaT6mKwpv7nNqd5LeSifM3s
         l3uA==
X-Forwarded-Encrypted: i=1; AJvYcCXDqjXrUHx0rJAUAw6uvGa5lTUJJxHI5A1794gv4NHJclsxpBpRI5g1EEaJysZFfROROIGUNXqZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0N5XavfMhMcwdN4dfzfmL2qGse12+Z5DYF1fnYYlF8HFxRrdc
	N3RwbMwwIdBCo57Jh2JjJa5vpDO34tfFPopblqKjMJTVg/udy5Dw7UZg4u3UdpG35pEuvArTB2Q
	8jyZq6rKNc03K6Vn0K9CU0Eu2HJM2E5N5Kw==
X-Gm-Gg: ASbGncsVACrmUNBcwgL9yRYZcG0LUP8QG7FcS116Q24aWIqSo4HjVi5aTrq6JMUGANc
	rym+2BYwiq1F4NuhWavM2pBQuGAMf6VVFnW8AMi+ZuK47wVxyK97QK1kfXxuPBV0y6XP2bINGAz
	SmTcv2f4EqIcQEJ4pmXv7CdoKovOjhquL3dydearL9DMfY5cH3A9UK16dY+y91kuFwJfMYrm7Dg
	Xi+z+A=
X-Google-Smtp-Source: AGHT+IHW9WlLHiZlY0dpH8o3WVeOtfEGDnlWoo7eBKIXBJXZ6FuzViCObsGxhwkEV/2mPsWy175GQ2xbi+DowcKP9EA=
X-Received: by 2002:a17:902:db0c:b0:240:a430:91d with SMTP id
 d9443c01a7336-2462edee7b2mr139186515ad.10.1756130903576; Mon, 25 Aug 2025
 07:08:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821182021.304-1-ericsu@linux.microsoft.com> <CAKrb_fEx=oKncdp8Ypi5gPuyp=G7KmwUec4sbMO2OOcGEvyNHw@mail.gmail.com>
In-Reply-To: <CAKrb_fEx=oKncdp8Ypi5gPuyp=G7KmwUec4sbMO2OOcGEvyNHw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 25 Aug 2025 10:08:12 -0400
X-Gm-Features: Ac12FXzFVJ5To674Dk9bFWQm0Dk1IzEBZRr6DefKVV_Os2AQrKjGRyckn2XOG84
Message-ID: <CAEjxPJ6zHGwHpxWgLP6SjiRV4CrusbRjDkcTN_tGqK9Xn+WgXg@mail.gmail.com>
Subject: Re: [PATCH v3] SELinux: Add support for BPF token access control
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:57=E2=80=AFPM Daniel Durning
<danieldurning.work@gmail.com> wrote:
>
> On Thu, Aug 21, 2025 at 2:20=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
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
>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
