Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024552550AF
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571504; cv=none; b=Sk7UcgK7/6FNr0HDbLdyQUO+pps6R5nZsQ+iqj48l4NL9MlHxlK59K67RDyBoB5JjfFEe47iAXV163y+YkNfFqH0lxGZWc2VPmBZwFmEANvUpvJHcZvQukUgiaDF2dmWtWKYwpccv9fpbnHblfKhfmkEQu8BJf0D3G2fphZoLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571504; c=relaxed/simple;
	bh=Rq9PRfmzEd8pFqhaLXWm0uXpL3e7gMIf0DgvFhVkaWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHo6gHtasImgocQVpbfRGTfCjkV+Hx6rCavaXOMc35LHy4jIX2io6YQq+RADBr74uGo+ZFwaccIggzdnpSXuZxhvIsPYPdeUf5CCCqpaMF7NJD+ufH7aYnOOVBZckcCf44WOxZiJhXsh90ozGaM9dx0NVd7Ylz0UDo2R8WbLfrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m44kp1ml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m44kp1ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEAAC2BCC6
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774571503;
	bh=Rq9PRfmzEd8pFqhaLXWm0uXpL3e7gMIf0DgvFhVkaWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m44kp1ml6ZzZCF2mP4NRV8O+p0uCknzwbQG766UIeEUoyNS8mQ94+mByRMpyn9H1u
	 wLKyykBQvhQftw6ELGCy6BRZXP/sNsaoMccP1kaMMy8WZvxmT6vgQzQqziNx11HmIB
	 6AjVJoFzmcOylF4B4KZSklI7R3MsD2ETngqUBZlacZGLi7USdANQauY2MBd7sbyN+M
	 zhcAhWU0ZRsOZlbgmdR/QVbm7OXUenUct3Hkv8hGk62lqiZ53aVKlFABCNHCiu/TTl
	 OiqdhhhgP7dMpzeFiQr7WovoOAiI1mU4LM6DHWYxygEd/LhQbtia27NuZYUROXULbQ
	 ZL1pumFNKFWag==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfcb045909so209772485a.0
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2026 17:31:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1vgivuNhq9zQsUvA6Y1eOGxH5AkgviVs6iWmyZqBPX8HDe0vxczyGd6i4A/tSBYPZmlvfcyBO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YqddFnWRD2HvrJxV6dUlNVkqjMejqJVoOc36xBijpE4SAvW7
	d9nXGrJoDTkkMe9Y20mu2JqqWrA/4rk3XDxlpjXYKllCmJsSyKbXet1135aOJfekwU9Vf2YT9L/
	gC9qNCa4+hpZ4MWM6GJ+HfQQXvxdPDn4=
X-Received: by 2002:a05:620a:1726:b0:8cd:c011:dfc1 with SMTP id
 af79cd13be357-8d01c5bdfd7mr70062485a.5.1774571502563; Thu, 26 Mar 2026
 17:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org>
In-Reply-To: <20260318184400.3502908-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 26 Mar 2026 17:31:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
X-Gm-Features: AQROBzDtNk75hP_VA5ya8WelxQdCIDh8Ucqh_5CNwOEcbULbEq8x6UohK-ggrLE
Message-ID: <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
Subject: Re: [PATCH 0/7] lsm: Replace security_sb_mount with granular mount hooks
To: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, paul@paul-moore.com, 
	john.johansen@canonical.com, mic@digikod.net
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, gnoack@google.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, herton@canonical.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks, especially SELinux, AppArmor, and LandLock maintainers,

Could you please share your comments on this set? AFAICT, there are
no functional changes (other than fixing TOCTOU) to existing LSMs.
If there are no issues with these changes, can we land the set in 7.1
kernels?

Thanks,
Song

On Wed, Mar 18, 2026 at 11:44=E2=80=AFAM Song Liu <song@kernel.org> wrote:
[...]

> All existing LSM behaviors are preserved:
>   AppArmor: same policy matching, TOCTOU fixed for bind/move
>   SELinux:  same permission checks (FILE__MOUNTON, FILESYSTEM__REMOUNT)
>   Landlock: same deny-all for sandboxed processes
>   Tomoyo:   same policy matching, TOCTOU fixed for bind/move, unused
>             data_page parameter removed
>
>
> This work is inspired by earlier discussions:
>
> [1] https://lore.kernel.org/bpf/20251127005011.1872209-1-song@kernel.org/
> [2] https://lore.kernel.org/linux-security-module/20250708230504.3994335-=
1-song@kernel.org/
>
>
> Song Liu (7):
>   lsm: Add granular mount hooks to replace security_sb_mount
>   apparmor: Remove redundant MS_MGC_MSK stripping in apparmor_sb_mount
>   apparmor: Convert from sb_mount to granular mount hooks
>   selinux: Convert from sb_mount to granular mount hooks
>   landlock: Convert from sb_mount to granular mount hooks
>   tomoyo: Convert from sb_mount to granular mount hooks
>   lsm: Remove security_sb_mount and security_move_mount
