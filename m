Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFC1BDA90
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517310; cv=none; b=qscKfLEKSf8yVec2Fc3TH20HHNzW7QVjWgQbSnaJFG2SCH6zA/otdjScDJU6EvCaWD0fyrhpzx/AbldwpIYREO5v/YW8bmrz8TebqqFY9prHAh0KtJAMw28i1M7Sf5VR/YPRAsTBlTLRGyzu5db/zufr3+xIIWm6PGLjXKUXsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517310; c=relaxed/simple;
	bh=zDjYbPQAdS7n2OYiSC4fDL94rGzIDph0kxE3CiDtJCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ABkTtzdsN2a+hjMCM7nuZJrWxvooXEOhnG9VWwo1aResL4qCFN+Bh7y51orbdTKuDAQ1Vfj3+RyXwoESbBQD4CBefakl8TOpXzfs55B3SMlLop6A6Uucjw/L9g55pN3upAhtCoo9EfiRVxRW0wCvkPQD6HwS+WDp/kgGnWFHIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoYbrbVx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoYbrbVx"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3777983a12.3
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722517308; x=1723122108; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDjYbPQAdS7n2OYiSC4fDL94rGzIDph0kxE3CiDtJCM=;
        b=HoYbrbVx8Jt18OYz0IPb3NWdU/XGCNDIeIChqwPYL1MbLMMf8bOokuzTjhvYspSncN
         k/+1zrh/yhMtkbj80WeEPFQbDVxQVowRhUYgWxOsLzf81pfE/ABysOv5jv2IqYoaE8x+
         GyTJfKBVgDfl/SUzboEwiLJD2I0llKbCij1XpT2sggM0h2OJh235ShwTUH2GE9EEQ4Y5
         ZXvoYGmQBDs0V1oLkjrT2TlfDMEpMMWcqJ0N2Jb07faAqDNVN85j4xXEUlBoz5ktWiuR
         j2XgFzOixS58jQc9IFcm/8zUfCySoPTZeW4RL6R3AIKyI5B2t+0K4eTzfqb+nnTzExKG
         ynvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517308; x=1723122108;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDjYbPQAdS7n2OYiSC4fDL94rGzIDph0kxE3CiDtJCM=;
        b=XaM3kQS7tM+J78H8bg3TsNYpYYwHCw6m1fC3gNAdnm6j+Hb/VJYi7+SkmO1/KkUYUf
         wMNs6lnyhlHzfpdG+pyZth03DEQfZ61934l+o9bLo6nEevkLlQb4kkNb+M2KVd0IkztS
         7fMFCsAVz1jR9aqR3REeyglu8NBqx/ZNcFMu+3EXrl7aHsVatCbvneu6BCQx6ta20OQk
         p9X/CUyAc7oTjUGPuStaiRUpRgHcCakoYUh3XovYXYuBkAkLtAuWEn3MjN6in9J6TK7x
         QZ9FYU2jTm+LngtqFzk5vG49DX7uCr44fUBI5YlyJg8DYGrkH7JQW2U5qY2mY764a4Y1
         2pNg==
X-Forwarded-Encrypted: i=1; AJvYcCWnFHaKD68nCXR7SXeFy9me5CXL65L71XVuYMuJZh2KIm9dgwEl1VkRlsqCUsm92+JksKawts28R74sjet0cPpJxP3lpzy5aw==
X-Gm-Message-State: AOJu0YwbvHmCFWhMqWrmkfqqyIju/IWNWFgt+1aa+uRE/Xd1nfkkIeEe
	U4Wx2hSeMSI6q9XAgvoyR4WPll3JGhmgBcRhYp1IzmJEkIKkxChJCKtJjUYQP0lHbKvwJ1ZSb5z
	ggErxD+qUIu1vgjVRqPYp31usD+aB8OMo
X-Google-Smtp-Source: AGHT+IEWrcnDUcb4wlJnyYF9fI0Ea5u3I0gnbXz6liU4S+nCOzYZWI4WuO0spMxIuvAxkjTT+IUYbTAQt9nZeJR9WOM=
X-Received: by 2002:a17:90a:8982:b0:2cf:7388:ad9e with SMTP id
 98e67ed59e1d1-2cff93d5a95mr103505a91.2.1722517307921; Thu, 01 Aug 2024
 06:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Aug 2024 09:01:36 -0400
Message-ID: <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Given the recent discussion of the SELinux namespaces patches, I
> re-based the working-selinuxns branch of my selinux-kernel fork on top
> of the dev branch. This required first reverting commit e67b79850fcc
> ("selinux: stop passing selinux_state pointers and their offspring")
> which I had created at Linus' request some time ago to avoid the
> extraneous overhead associated with passing those pointers when there
> could only be one selinux_state structure. Due to the number of
> changes, both substantive and coding style related, since the last
> re-base in 2020, there were numerous conflicts that required manual
> resolution. I also checked the coding style of each patch with Paul's
> scripts and fixed any issues introduced by the patches along the way.
>
> The rebase can be found at:
> https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
>
> It boots, passes the selinux-testsuite (including the NFS tests), and
> passes the following
> trivial exercising of the unshare mechanism:
> $ sudo bash
> # echo 1 > /sys/fs/selinux/unshare
> # unshare -m -n
> # umount /sys/fs/selinux
> # mount -t selinuxfs none /sys/fs/selinux
> # id
> uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> # getenforce
> Permissive
> # load_policy
> # id
> uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem_u:system_r:=
kernel_t:s0
>
> All the same caveats apply - this is still not safe to use and has
> many unresolved issues as noted in the patch descriptions.

Also, note that as before, this branch does NOT include the original
patches to support per-namespace superblock and inode security
structures. Given the known problems with those patches and recent
discussions, we likely don't want them anyway, but for reference they
can still be found here:
https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d4a837f32=
c63bdfcc0b70342cdd55d
https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd0e10e75b=
6aa5da2ed9841df6ef2f6

Without those patches, ls -Z will show as unlabeled any files whose
inodes were already in-core at the time of the creation of the new
SELinux namespace because their inode security structures will have
SIDs that do not exist in the new namespace's SID table.

An alternative approach proposed by Huawei to my original patches can
be found here:
https://lore.kernel.org/selinux/20220216125206.20975-1-igor.baranov@huawei.=
com/#r

However, those patches also seem to have quite a few unresolved issues.
