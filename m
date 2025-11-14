Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2C185E4A
	for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133952; cv=none; b=kfD3QML25t1Y0xlRVwgAm9yT5U6Whb0tCnSl5Uvi7+0vD5+IgulLDcrct7QN5o0jaCjYJMFTDcYDKevCxexE5A+8JNUW5gCzvOmp9rLf/OvNs9p+bwyJuKXWkDej+l1nh0SG5qfQoupdwOx/D+POY7ZEXI1EZfetp09SVTpJmc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133952; c=relaxed/simple;
	bh=9rtWRbgqcB2C9l9fvjPIYhTnQd/7o12R83M1ss73ttE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvgYE3ogU9DLboPE9fvnL2J0iKcz3oD1hE7F8ObHLjkmuoT86LM/e5fw3y95/aDA4wGfNMmfLU0JsXBqLQe5pipg6OqbuP5ueZp4nH/GKc+h6/L5uUqeZlyJ3WGQ77dO0R3Gm52OO5RnxBTXjk2/uq+j0FoRFdZ4DB11sz9kqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFj+cawf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFj+cawf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2980d9b7df5so20252175ad.3
        for <selinux@vger.kernel.org>; Fri, 14 Nov 2025 07:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763133950; x=1763738750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR1JOAzbrNaMt+0TMIIkefSzZGc+7nDEtHifktvSZlg=;
        b=NFj+cawfQNzpWxDpqD+GiM4KDMPU3dp9TrzGxcyrEBP/4NnZDupGMxm9O1txEmDeTe
         WMhiNjB/yjev/MzUuKxHiKiQJYSk41gaxjCzsnjioD7pJTUudCnCfYqsK4y0jiBAiXSS
         o9aJOCrwFOOu+ze4pfI4NWpg9ckd33KHTxXsVPSLSqdwdrpmIiyMqn/4UP6RKwLuBzuq
         ns6k1mcddMoHNHQ8aHdblZk21qoeVLyTWvsZxK0Go8vCVcTxvd88ZmNZrjp3sILElv9+
         doli84NfAlqjBpTOCGhMKS86ZkaU5kt4idsWpxd86oIhfK5NQkwWnORbCjsxrQ1rY0QA
         vefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763133950; x=1763738750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR1JOAzbrNaMt+0TMIIkefSzZGc+7nDEtHifktvSZlg=;
        b=fLF+AQZLlxH7CaaDC9aNS7ZerfdvPIjmNi628obvK97TbWKXsvt02U4Y23ybZh8uNO
         gnSv1fvIIEpm/tfi6i6qNoyMZ/C1qusHftlDa/4ywgajF1fkNAvqmE6nEprzt5n6zfAH
         sr3bvVsP9EOyVWCsL2dHpkSG9U9CD3sOjSjorQPX0uYiemjC8QwFklX/x5JUF0bvfZhc
         +z/tnQKuzm0QstqC2dhugkKCP7hJVAp0HlG1DStq81ae4do8fpyeU8r4M8YHe3yf1xXB
         XIdYjIRtCO+mtDRqa1NbndsdBmw19oxpYlMe1kohw2UBQCApWaqeGt1ZGFrBMyEBIuTY
         91lg==
X-Gm-Message-State: AOJu0YwmdiU9bujHEzhZ8Ukysgp9EKSNt7qwjaW/8E+6ShCROolomr8U
	FBrC96BZm26Nwh8XLFtY4eCzZ1H2biz+6S0IS/wPB/AM93W39/B94FigSlrOpfb3NxMFFuBbKRm
	HlLw++uKAIKLQ4wz+Yvmi9aqYb1bwmlo=
X-Gm-Gg: ASbGnctBFXCCMfCNJMn+AM7BqeLVQ8pL1YDcGBaTsObiw8SKitQJz4Cg+Gt/2ga1vZl
	xZYPUVpYqT9dMJyJJZ9aqLsMDhTNKVpjE9aIm7yROtNwgZA72dTQdXPxdP5zQnNAQO+iDgUIFZK
	9MeaCqD+svWrTsDdbBWwTzK7ltEcGMX7dcz2rBp9dM1FdCtnPtYT5A+ZY08szGIPnrq+oFUqrUh
	K+qaItkrygAaDKu8THpbbC7EMTN3Xwvkwxom8NrLnkwm6LbvytOdoW4yxyQ
X-Google-Smtp-Source: AGHT+IGUqJFw6AaQqGH17zPrWbthr+jXJcIF70fg/lJqLl1phKayIQzpzWG9D9/Vi7egXiPZj1+na887xbsXvLvIbKw=
X-Received: by 2002:a17:90b:2f08:b0:32e:749d:fcb7 with SMTP id
 98e67ed59e1d1-343f9ec96c6mr3932267a91.13.1763133950085; Fri, 14 Nov 2025
 07:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <io56y7r63uyeduqe7ukx3wcjvhzfnnsxle2go5raxqy76lrn3n@edx4doao3gv3>
 <CAEjxPJ5cGzHDrsUGKCOxOUZm-0d8shoPahbZB7zVFTivujRNsw@mail.gmail.com>
 <kakoxc3dfli7fjjistybeqhf34abzqovkmq2gs4fg5sv7nviam@w36m2srscmbu>
 <CAEjxPJ5rD7Fq_t5EDoy8EYHzMhgntR+KK=3OZAAuA0V047yKWQ@mail.gmail.com>
 <CAEjxPJ744wutA3FZmA88OMyay__P0qVAYTB6RRnh=v+LiPyxJQ@mail.gmail.com> <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
In-Reply-To: <aoskc4jnsb2ivi7mgdkhxxxahwmrblzayvu7qdtpgjjnz7u7ca@6x6bz243yu4b>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Nov 2025 10:25:38 -0500
X-Gm-Features: AWmQ_bloHy7aDkXOJ4HECUpqpJZnrT6dN3QnXYEoxulb9qUN7NoP0GeyPj-DR4A
Message-ID: <CAEjxPJ4xff=wfvVpnSNuydWN4k1TX6f8GtBtWmv_Fc7yKMZaUA@mail.gmail.com>
Subject: Re: SELinux Namespace work
To: =?UTF-8?Q?Martin_Erts=C3=A5s?= <mertsas@cisco.com>
Cc: selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:15=E2=80=AFAM Martin Erts=C3=A5s <mertsas@cisco.c=
om> wrote:
> Thank you for the help so far. I have dug quite a bit into an issue with
> this together with the cgroup namespace, which is required for running
> Android in a container.
>
> What I see is that before mounting the cgroup namespace, it is labeled
> based on the new selinux namespace as expected. But when mounting the
> cgroup2 filesystem, some of the labels change to the host labels. This
> causes problems, as I on the host have the user system_u, while android
> only has u. So when I try to make a subdirectory in the new cgroup, I
> get -ENOMEM as selinux can not find a system_u user.
>
> This is what I can observe:
>
> # echo 1 > /sys/fs/selinux/unshare

Note that my current working-selinuxns branch has switched from the
/sys/fs/selinux/unshare interface to the system call-based approach
recommended by the discussion on the LSM list so at some point you may
need to switch over to using that as well. That however is not
relevant to your issue below; I am just mentioning it for your
awareness. It remains to be seen what the final upstream API will be.

> # unshare -m -n -C -p --fork /tmp/setup_namespace.sh
> [cisco:/] $ load_selinux_policy
> Loaded selinux policy. Enforcing=3D0
> load_selinux_policy-3.2# ls -lZ /sys/fs
> drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 9p
> dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 bpf
> dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 cgroup
> drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 ext4
> drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 fuse
> drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 nfs
> dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 pstore
> drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                =
  0 Nov 14 14:05 selinux

Looks like your container sysfs mount was labeled per its policy
rather than the host policy, as expected. Did you do anything special
when mounting sysfs?

> load_selinux_policy-3.2# mount -t cgroup2 none /sys/fs/cgroup
> load_selinux_policy-3.2# ls -lZ /sys/fs
> drwxr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 9p
> dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 bpf
> drwxr-xr-x    2 root     root     system_u:object_r:cgroup_t             =
  0 Nov 14 13:53 cgroup
> drwxr-xr-x    8 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 ext4
> drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 fuse
> drwxr-xr-x    3 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 nfs
> dr-xr-xr-x    2 root     root     u:object_r:sysfs:s0                    =
  0 Nov 14 14:05 pstore
> drwxr-xr-x    8 root     root     u:object_r:selinuxfs:s0                =
  0 Nov 14 14:05 selinux
> load_selinux_policy-3.2# ls -lZ /sys/fs/cgroup/
> -r--r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.controllers
> -r--r--r--    1 root     root     system_u:object_r:cgroup_t             =
  0 Nov 14 13:53 cgroup.events
> -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.freeze
> --w-------    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.kill
> -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.max.depth
> -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.max.descendants
> -rw-r--r--    1 root     root     system_u:object_r:cgroup_t             =
  0 Nov 14 13:53 cgroup.procs
> -r--r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.stat
> -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.subtree_control
> -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.threads
> -rw-r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cgroup.type
> -r--r--r--    1 root     root     u:object_r:unlabeled:s0                =
  0 Nov 14 13:53 cpu.stat

That's very odd indeed - I would expect them all to be labeled based
on either the container policy or the host policy, not a mix of the
two. cgroup2 and sysfs are both kernfs-based so I'm wondering how/why
they differ.

> load_selinux_policy-3.2# mkdir /sys/fs/cgroup/foo
> mkdir: can't create directory '/sys/fs/cgroup/foo': Cannot allocate memor=
y
> load_selinux_policy-3.2#
>
> The setup_namespace just creates a new rootfs and mounts the android
> container and selinux policy into that. And load_selinux_policy is just a=
 wrapper that loads the android selinux policy.
>
> What I have traced it down to is that when kernfs_get_tree from
> fs/kernfs/mount.c is mounting the cgroup, the superblock is reused from
> the old cgroup namespace, which also has the security context from the
> old selinux namespace. This causes the labels to be mixed as shown
> above. This doesn't seem to involve SELinux code directly, but just the
> kernfs code.
>
> Should the kernfs test function for the superblock involve checking the
> security context as well? Not sure what a proper fix for this would be?
> Or if I'm missunderstanding something and doing something fundamentally
> wrong here?

First I'd like to understand why it seems to be working for sysfs but
not cgroup2 since they are both kernfs-based. What's different between
the two?
And since you unshared the cgroup namespace, why doesn't that trigger
a new superblock creation by itself? It's better if we can avoid
introducing a special check just for SELinux/LSM here.
