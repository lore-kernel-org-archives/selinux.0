Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966483D7D70
	for <selinux@vger.kernel.org>; Fri,  8 May 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271048; cv=pass; b=M/+rXINGZOWHzsrAid+s5xF8r5driDsBvjryQDCoLljS0lLW8rdxIu0OI7ie5drk/L6LkE/rDHgTkzTLFUBX9wWBIEbK8dwtjWqQP2Pf4BggNoI8LSJtxJfqgihdf+jYoP/lwkmmOYCB9J8pK7AKmHR+EgrhvErid5wqLPmrHaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271048; c=relaxed/simple;
	bh=TFrVhtXRzGaWgGBXsdmPjdMWa4luc0ZPlbhrFgpSi0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQqH+RqO+aLipMzzjiPJWvHL7J98XNvdElT82ptk20z+3WPmUYfbp4wQcouFdfj8VgAEsRJFHTJ2VMcm3DZ423vJLdUiCwfgmbe1+xLJw+XDx8J7BQwuPMxbh5F26OMZmSU8zOrl5ElJmOWrCm4b84b+0SEXZ9QQGSytRO3kN20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dilxkrhk; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dilxkrhk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso1595839a91.2
        for <selinux@vger.kernel.org>; Fri, 08 May 2026 13:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271047; cv=none;
        d=google.com; s=arc-20240605;
        b=eULI1NEbnDfncjYZboDSMuGWogGGr9FcQYKNQDVvnKwMRhfnHd6oZn/9WYy2cFxBK6
         6Fyjke0ZNZATwFrF6cG+yMJEeZE/49hoZXwZwwVpF9KhcwYJtD5Blx9g+gYwaJfwJA3B
         IkHStnGZISOl1Y4KT3rxvkP7URq/IFTwY1k83us1LPkxHN0EtTOUWdxz0Xmd+r8Y3JDO
         o0L94RVP0OQPoNv8gKsmhLo21a5c1MPteZiMnTNh1Wlf/kxtbRqa6CU4MFdrR2Y4YXgP
         Zda1epG90lVXismn1bh37fHE0lSziAw1zZFMbzVC+RY0hNb9LLFngtFuyEgXHd88G0lI
         ZxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        fh=jG8BA0Yd8bZ/j1wrbXCpkGAGoC4cxFegb9LmwtfPp9I=;
        b=VjhmLFUgkGuyAAchAvIU3HjTXyJ9angEO38c4V/MOf2mpOy2kPJEgfd79QYO/TLREC
         QG/+2+7FOaJr+GeYR/7s7ZpfbmIHm5B+kQVuBZYbJygtAEEW2GJNL4EzkM4SWjJ63xsH
         2/67UTYUrZns55G8aWTLDrlwXjAzTJjySqBJQFPqwSBR4SxygzqP2nNBlXZmkvwsut+M
         mNIMaQbEt3cRI8Gb28MEFaHm3pjXgs0s2d9scf7xNRqlUCo7jl5SmailhAIcZZmam2QE
         iELvjM2SZuQUKrChTWLCOGekYXmcWvajKi7nT5kzg6iKzOtDZfPiJvp8MyI+VnH0Myd0
         fdQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778271047; x=1778875847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        b=DilxkrhkAC0uzjjPyGt0+4VO4px4J2U/CkzkF2kqx27AeLOR08LHs5M3UWt2Kvvquo
         fMVYkhrJSw4aaKmdrPFCDeBTD2AHlTFEgj3YRXdyMqmCrQQfG7VgO/izsfsJ0ZymU7bb
         zJz4aDeqeyFHYcqlJDbqh9mdzu1gX/Ig/C6s3Ag51ph3iAEo07QUkIjSPcO0MZ/jL118
         wDyKByZuiGPjFI7X47aK5YlQUBYb1AbSNy0h/1vexTm3tXxZVG9nzk7sCCnrw3Bif39+
         pjedrbaWmIYZ/9st1s2dXfCj+9M+6KQ6eoxgjWIIJq0UHQo8gABcnLG241siBBnikFbe
         Asug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271047; x=1778875847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        b=nBFBX8+jJi6GhVG+WmDPYbo29tHGMm4aMTeLaX/QUj/ZJyxt02s68Oz9vzLDGXtdzk
         VxXvJiWtJUnWWEgs/JuufscGgsw9Gdi/reuXtQ9k45FYPM5rXmpidWDfP5vIsfCu4wkz
         Bzj4I1mz8u+I+WkWywy/imdp1REujZS2aZ84NbKwy+6vVZYPpIeOh3aPhTpNxD+7DxOj
         gKpV4AxyMDNmY7cfTz5bt63unG85ATLBJgS/TslW43ILh4T8C+tE6uwcz82HEm+gh9sL
         PrnQYqxfGmTqr5ThugUqdpjhAQ/xQJ8cIpXEk6vm8BqflHcY8AfaUfZJogru+o1iN+ty
         G9EA==
X-Forwarded-Encrypted: i=1; AFNElJ9r83c2WGV9nNMt6Eu0RPPsFo5m7ucINGXEsFVo/f8G/tp1Gcw4+kT0e2YX7WcsEUqxCeh7fFYs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34BDxFzAcNt7icSoNGINzV87xyZfPUCUlvLSzrw1t2TVC2LU8
	Nv8Dgcs7WxnLMekvWHHWUsxFqptQTZRiZiUAeecpdmMEZTNZsnKz8sju4nFtUrwH4as/efBtWKp
	1uXnJb/AiGMVx0V56oj33gdrDzA/OIDmrDTuyj5g3
X-Gm-Gg: Acq92OFMBjm7wqV0FMdTpooUkVBUIV4oKA5Fg5IvnqfMplO5Ay4z1F1nluLOOCtr6BL
	43Vq+HzG78DYYmzJ6iYRrAQHRzFmPS3Wq8amOpJD+e27Ux6Cryg1WhWHK3aLFBbvKu/gmzQoJop
	gAiHEO/KNRZAlKiAoZ5kJr6VlkAxwDGMqPraPSFq8DN7yeNM9qOVULxpxxEQ8tKZX3Wv1SCcpAL
	hUKFWcD3Odm/y9TLOtJPhhRMEX6EGe7x9qpPLzYWt4JrmQkTylTurIJ0bmkn+EqGoqlgDenqZxZ
	7DEw9vxfL/mAWsjJBw==
X-Received: by 2002:a17:90a:509:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36603ad3f55mr6058264a91.25.1778271046680; Fri, 08 May 2026
 13:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
In-Reply-To: <20260430000315.918964-2-song@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 May 2026 16:10:34 -0400
X-Gm-Features: AVHnY4JzYJuAYc9q9BmVnJzCXV6FuyRu5-uJafEtOUSW60YQOAJP4PpQpgO2G2Y
Message-ID: <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Add six new LSM hooks for mount operations:
>
> - mount_bind(from, to, recurse): bind mount with pre-resolved
>   struct path for source and destination.
> - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
>   mount options are parsed. The flags and data parameters carry the
>   original mount(2) flags and data for LSMs that need them (AppArmor,
>   Tomoyo).
> - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
>   called after mount options are parsed into the fs_context.
> - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
>   (MS_REMOUNT|MS_BIND path).
> - mount_move(from, to): move mount with pre-resolved paths.
> - mount_change_type(mp, ms_flags): propagation type changes.
>
> These replace the monolithic security_sb_mount() which conflates
> multiple distinct operations into a single hook, and suffers from
> TOCTOU issues where LSMs re-resolve string-based dev_name via
> kern_path().
>
> The mount_move hook is added alongside the existing move_mount hook.
> During the transition, LSMs register for both hooks. The move_mount
> hook will be removed once all LSMs have been converted.
>
> Some LSMs, such as apparmor and tomoyo, audit the original input passed
> in the mount syscall. To keep the same behavior, argument data and flags
> are passed in do_* functions. These can be removed if these LSMs no
> longer need these information.
>
> All new hooks are registered as sleepable BPF LSM hooks.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux=
 only
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namespace.c                |  35 ++++++++++--
>  include/linux/lsm_hook_defs.h |  12 ++++
>  include/linux/security.h      |  50 +++++++++++++++++
>  kernel/bpf/bpf_lsm.c          |   7 +++
>  security/security.c           | 101 ++++++++++++++++++++++++++++++++++
>  5 files changed, 199 insertions(+), 6 deletions(-)

...

> @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *pa=
th, const char *old_name)
>         if (err)
>                 return err;
>
> +       err =3D security_mount_move(&old_path, path);
> +       if (err)
> +               return err;
> +
>         return do_move_mount(&old_path, path, 0);
>  }

While the security_sb_mount() hook calls into do_move_mount_old(), the
security_move_mount() hook calls into do_mount_mount().  As you remove
both of these LSM hooks in patch 7/7, should we consider moving the
new security_mount_move() into do_move_mount()?  If not, how do we
ensure that we don't lose coverage when removing the
security_move_mount() hook, or can you explain why it is not needed?

--=20
paul-moore.com
