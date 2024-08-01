Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39913C8F5
	for <selinux@vger.kernel.org>; Thu,  1 Aug 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521001; cv=none; b=FdgUO4EdffsE9v1lsx6/uxqez+vyvhh1A3SwIR7cXV6PRCqXIizyscH8aBIhhPn0tX5tA68TTg9yznKRz9Qtd4Rh+ROG/qii1PX39O1bD+gki8zYrWawEc7XBKrl7zvkIkq3BhtgG2G0VHauyc0tfzGA+q/XDElTvP0SrJirX48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521001; c=relaxed/simple;
	bh=PJBEJv3COrx4TPh6W+8wwwRrodLvCxtrPEEx8Nj9hxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N3LzZqhO4QRMT3NPoegqSx6RyhXx4gqxhHQ3yf13JxqbHtPFC6gUMqKwAnDVIEDN2eXXfE2027nRz09BFfe/JErdEBzz7KcVh2exYAX4lUwmYDEp7HYHVKi30qBvyHU06z4JnHADJrGHMr9Pufu/ItfkF3i/znWyHMp9jvbFvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+5fhxg5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+5fhxg5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70eae5896bcso6078811b3a.2
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2024 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722520999; x=1723125799; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJBEJv3COrx4TPh6W+8wwwRrodLvCxtrPEEx8Nj9hxY=;
        b=d+5fhxg5G/irE3AgOnXOLjdPTmi4pI2nqSDFCkcgyDypKZjlP8EUn6ZQHy/FiqpjjZ
         3Cd1AV+i+KzsmJMPAM6W7tEYzgd89fHukEKYFI/R7axnBQSljRc41rNMK+KZrs2SwqDP
         Vt8yUw7B1h4cM0BW9PqE5VHmFJbDFPtXM9LQ6P6Llcc6GslCIIYIPZ4MplPjsLED8CfB
         ut7OhjNYpnCGagEZ1LtT71mqj1V/Ruaiia14TjU5D1tEV5KPtPs4kzWWTOU6+bB4hqRw
         PZKZfc4pS4w4WuSPZKSf9psZTFUf/T0z+u2mZ4qzrgs8ePnb6NCBkmeWU4nlCcyaCjAG
         i7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520999; x=1723125799;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJBEJv3COrx4TPh6W+8wwwRrodLvCxtrPEEx8Nj9hxY=;
        b=JWBDO3nZcWZ5/4pf1n+lcEMmfohTuM+fk+l3Fa9tJ3ZYN7ojjzOC92iXvav9mFPVeu
         1LrSNI+s9AfHU5dcUHyiXAzYXBBNbFygafp+o0I+ScW5lQbgF69TN0CblUrMsX3ZHwIU
         kkfq6el7d35QIaRrJxkXB2ehK7t86DhsXhpP6+IXmR8B59sGfrz0ZMQFB/y3X4x0rvfD
         cwZQVVaU0QgMrpfIa2NtBhjHh6IixDN/sTaikGd0Yyw1c1cVn2CeIPbh4jL4TjthhT9W
         y+aBbEnm3FNW9jfoHE/a5rJqm3kKiOc5PE/DBTUCEfvcgVLJg4syjPsv5i9bNIztN3Nc
         Oxqw==
X-Forwarded-Encrypted: i=1; AJvYcCVvCPFnn25VlZ0dFxKFArT7vMnduj+rqFppUR4w6Wv7ECg1H/GdbyL3KDu94Uo69CnkDl0upJEchupFWJ1A672E2IUmJxDusA==
X-Gm-Message-State: AOJu0YywO+9DsebZOobukfquptxYWyYrBsddzRy1W6QVN1d2Qeoj3bDc
	pFeS70mfn+9TEpCszolLdTKEn7SbnHFiji8FMl2rejvMT8iCvCeA5TJOy8Yk5nseOq+fWcOtFWT
	7LxgwVMMzJBWgiNCTNQEDUk9+8TisZA==
X-Google-Smtp-Source: AGHT+IHfh6Qn/8QsaDgLLcpOtpCXNvTHgyiqC2KtEfF3HmS96qryt48RXfX+GKEK6sCJ5j2qQgEe7e2jaGnNabazTiA=
X-Received: by 2002:a17:90a:5e04:b0:2c9:e44:fb98 with SMTP id
 98e67ed59e1d1-2cff955208cmr320836a91.37.1722520999205; Thu, 01 Aug 2024
 07:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Aug 2024 10:03:08 -0400
Message-ID: <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 9:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 1, 2024 at 8:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Given the recent discussion of the SELinux namespaces patches, I
> > re-based the working-selinuxns branch of my selinux-kernel fork on top
> > of the dev branch. This required first reverting commit e67b79850fcc
> > ("selinux: stop passing selinux_state pointers and their offspring")
> > which I had created at Linus' request some time ago to avoid the
> > extraneous overhead associated with passing those pointers when there
> > could only be one selinux_state structure. Due to the number of
> > changes, both substantive and coding style related, since the last
> > re-base in 2020, there were numerous conflicts that required manual
> > resolution. I also checked the coding style of each patch with Paul's
> > scripts and fixed any issues introduced by the patches along the way.
> >
> > The rebase can be found at:
> > https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
> >
> > It boots, passes the selinux-testsuite (including the NFS tests), and
> > passes the following
> > trivial exercising of the unshare mechanism:
> > $ sudo bash
> > # echo 1 > /sys/fs/selinux/unshare
> > # unshare -m -n
> > # umount /sys/fs/selinux
> > # mount -t selinuxfs none /sys/fs/selinux
> > # id
> > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dkernel
> > # getenforce
> > Permissive
> > # load_policy
> > # id
> > uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dsystem_u:system_=
r:kernel_t:s0
> >
> > All the same caveats apply - this is still not safe to use and has
> > many unresolved issues as noted in the patch descriptions.
>
> Also, note that as before, this branch does NOT include the original
> patches to support per-namespace superblock and inode security
> structures. Given the known problems with those patches and recent
> discussions, we likely don't want them anyway, but for reference they
> can still be found here:
> https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d4a837f=
32c63bdfcc0b70342cdd55d
> https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd0e10e7=
5b6aa5da2ed9841df6ef2f6
>
> Without those patches, ls -Z will show as unlabeled any files whose
> inodes were already in-core at the time of the creation of the new
> SELinux namespace because their inode security structures will have
> SIDs that do not exist in the new namespace's SID table.
>
> An alternative approach proposed by Huawei to my original patches can
> be found here:
> https://lore.kernel.org/selinux/20220216125206.20975-1-igor.baranov@huawe=
i.com/#r
>
> However, those patches also seem to have quite a few unresolved issues.

Actually, re-reading that thread inspired me to take one of the ideas
suggested by Huawei, so I just pushed up one change on top of my
working-selinuxns branch to support saving the SELinux namespace in
the inode security blob and re-initializing it when an inode is
accessed by a process in a different SELinux namespace. This at least
allows ls -Z to correctly show the security contexts of files even
when they are already in-core.
There still remain many issues though to resolve...
