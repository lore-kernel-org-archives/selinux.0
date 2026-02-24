Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34902E62D9
	for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960372; cv=pass; b=sDfm1+7ZqUMM/z6LbNawyTfOiiNJsM7OomV/Ls4c2S1Sp5ic0YtTaqMofRG9HRyHBdrULL9zSH6RwUgoeqRZdaqeuB1TlZL1pO8r1fA9rA4mFK3mV/o5UD+E75hpULqv9DGWxPr12AQorw/ZasthijfuNgFmJOrp9jeTx0BugKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960372; c=relaxed/simple;
	bh=Mx7EWvPLyqSJRzwqUTOqp6F3rZbh1xURjor89wXlRdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AA5c5VTR8e571lVvrTE+CFNVP1QqD9EC7oitZGgbY2y3VKaNRMlPZa7XRFGCHtUIyI3ikGXWIJi9xUyEgLl0paABX4uyZw9GfSxdOVbSHyxzdBu3HSKWKZZIAcQe/+4jQ46gvn3B/HWf2xz8aDoOTLfY+YBtVli9Aq+F/qiuRKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KhhbuuKj; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KhhbuuKj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9516a653so6201975ad.0
        for <selinux@vger.kernel.org>; Tue, 24 Feb 2026 11:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960370; cv=none;
        d=google.com; s=arc-20240605;
        b=PHndVQ6EOq6febylujBCW7GV1dWQvw98R2Ym3l1yTgRDM/wyFgH9mb502cBAeeo5bf
         wvkSSgMkjqD2KMYjBIlG2/JwMxo04qr615NxpzWan+akXAqDVPJLb2MrvlqUVSAyRaHY
         juFq3O7YWfutDuZC3SH7NB3RvfYPLUr0r020/HcQfLiT6Hvy6J1LGrR1/9Kbw+ijY/8A
         8ck4O/81MMoBn2hNzFz8v/c3UEfrGt6NBhS35fJRjZ6weye/j4zkP7TaBU7qTyiBc4V5
         ZyHY68Kfin5sOlNNpccRolO6s0j94xMVy9xYbGA5e4FYCtOuGdXXqP6DSFjJi/iTHdY5
         2+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        fh=c4uu6wV8mnH7oJR+fOuN5XgOY71cGcV/0q5MO5U5KiY=;
        b=f4CoM2mHRp5TKBw6UFTtG4BYvgg3zAU2SX4FNu7rk3CVv1+4BLY/0yAu1lF6ir+FMc
         uEWDVoKGAMGMU/7ZGishf120YlXMIbezO2nBIpycbHss3+0VGiP8if7Xa6RBtObFODjt
         GsA7s8xvWaTijPE9IX7tZ8TPuWNP0WqQLG7DVPuvu5zigdwwJdlerz5FyVqUcu8htG61
         zeWMVZNEKEDuWZ7ES5Ym01QpM6dUa4AfUMh5WQGxy0IxGCzoQ4EunKVzVigW1hPLzZ3+
         83R+wTh3k2KiZsxxgRi/3MN1w0p1mohM0wRzuGH1PmhaMlQsMd2Gbw/2ieax1/U+hVxr
         Tb1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771960370; x=1772565170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        b=KhhbuuKjR2JZaDvUwlguZ7AuuMNvsmzE4zIPHLqtgm2iz89AuXVcj8Hm/uzUNYTJpc
         4kDewaiBV/FCaeIN++4HzE1v45Gx3PptJ2DCUFJtfGrFGipyl9O9u/msqwZsFDmSbRh+
         Yyi+W8+d/Qgzh1UKgo6+hLF1RrGHLQ8HGiPvsc66YIGxomqKrxgLCXTY9BwWzeH9GlKS
         Oeqh5fBzOB99TnDnZf1EowhWVBj6VUmkQmmprTAbcZHN+gZRle9uH1aKwY+pZBPkssTQ
         V4LgTNhI3mYkzL3NWPU9S5pvZBSE/9gMjl1wL3BM5r6x3Aon9H3s1fl3dZxbCO2ioL/c
         vpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960370; x=1772565170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        b=OgXj5Y8FSloFyh1DaeJpxAdVgvhGQrwUzbiWhsLoNdT+WrXR9ufYPGWNPhBE+N584E
         vg0RfMua97U6zxySNRuL9szkTQZe9xpQNZkfG2SsSEGsUG5/F0HLS6nnT9vHY/++cnCx
         NXXYfBBKXxxIVab4lzIj8mFHr1l/rTVhqHRdnBc3C6WAc0ucF+iHQnwiuFjszTT9H0eH
         sl1Di8KgT70l6FeF81Iq+ds+LlScjETamOy5DYJTmE8vdp+6USrdUyBUZhqKyRrKVcTg
         9xXPUjC0Ml+EEwHHDSBfnIlJkPcgcr4V0urRUV0uVjc8WTzD5kV8xSJk9hUiNhACUWOE
         oRvg==
X-Forwarded-Encrypted: i=1; AJvYcCV2xJxKjukjEKBxV41zpaYngs+YLXAYKNhF5uQvC6Gn7Bb1mvv5V2NuiqO3OmvaHD3SajdfgB/s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fRXeJwH8Jwz1n/ZgRjNPD704aXWBZy4ZyHZjouLFj+wN7x+5
	b2EjO0ctV2sjNZt0W4T2EIZE6Ut1LiwoOijYVTQKlpTHmz/RzRqwqdV+32a1GpL8t80A1NnzeIB
	Mt9FYxaWkk/q0g3VMP0TiqFOOOFivbPzomU1BzOg4
X-Gm-Gg: ATEYQzxBVmNpKfXyY0VWh4zbBrhgpSxtG7fmHMFh9e4EThM4AOId6RU8hHcoubINhvV
	+Ee5EArahs7Z0YgP9L1SHruQxlmwJS73HXShvp4y8GgRUzO+IjLLJ7qCXc9mktO9HLXzJdX1qPi
	ZAhop/CI/ugRuZWRCZ+P3GofU8hhy3Sl25hGGkMA3tlTDxKKhmz9gk06ePTgfLhuEsENBwULcrw
	T8jKDJYF2kXOtMuIutU4xVbNm3U//2vfO3ILdIC6OWDD40TfhEzwnrNkuFmtnkv9XkolckYfmLS
	gaCOXKY=
X-Received: by 2002:a17:903:3850:b0:2ad:3e57:91b7 with SMTP id
 d9443c01a7336-2ad74447156mr109545555ad.16.1771960370108; Tue, 24 Feb 2026
 11:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com> <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
 <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Feb 2026 14:12:38 -0500
X-Gm-Features: AaiRm503rW9ZOS4V4zxiebdUBzdo3Pfwr2D3jQYLmSqJvm2WIFtI559N_YW2Cig
Message-ID: <CAHC9VhRmAH+mymmoEivKKNgGScUHyD-2t8t-ed+=r_mNzT5wzQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, danieldurning.work@gmail.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 9:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Feb 23, 2026 at 5:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I'm not going to argue with that, and perhaps that is a good next
> > step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
> > that drops setting the S_PRIVATE flag to see if they complain too
> > loudly.  Based on other threads, Christian is aware that we are
> > starting to look at better/proper handling of pidfds/pidfs so he may
> > be open to dropping S_PRIVATE since it doesn't really have much impact
> > outside of the LSM, but who knows; the VFS folks have been growing a
> > bit more anti-LSM as of late.
>
> Adding S_PRIVATE to pidfs inodes was originally motivated by this bug rep=
ort:
> https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.th=
elio-3990X/
> when pidfs was first introduced as its own distinct filesystem type.
> Otherwise, Fedora (and likely any other system enforcing SELinux)
> stopped working.
> So we can't unconditionally remove S_PRIVATE from pidfs inodes without br=
eaking
> existing userspace/policy. If we want to introduce controls over pidfs
> inodes and do so in a
> backward-compatible manner, we have to either move the S_PRIVATE
> handling into the
> individual LSMs ...

... just like was originally proposed.  Just do that and be done with
it; back-n-forth like this just wastes time and energy.

--=20
paul-moore.com
