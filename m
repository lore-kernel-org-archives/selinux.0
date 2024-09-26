Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D022EF4
	for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356512; cv=none; b=JTwr2g3z2Bg4uE4jutX9Pj0eNnjAUAuVbfZ+mdCRSlv/zUsVSqXjrvn6B3i6WrNTJJTQuQ7FaPUIqlWF2uLljOfZZTU5nOrH9GULuyoKjAGrgm9rbZsEiwwnikQUmK4Hk/5wzNcxnKJO36n6na0axqzNj+BeQaDAMwJbj7v9cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356512; c=relaxed/simple;
	bh=Fz4AveoCgNGSqICopIEuHfzFC4VWJoBgpJvqtwbVfMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U09gKeM6a+gCpY/rqVpLVYp7fh5MWg5yQL2vqCtvB98LqEmHcU8EnqxcppQM9180Nnspm6gUtB3TWaOgTPLLgzzcUmyl/HCxN8nIoLgZXqrR9pjBLThfI222MX2yjYvOkGjEBcfKJnve4bM2c4Okik7nqvdMv2aiXT1HHUSbVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpCnT4s0; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpCnT4s0"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db54269325so722035a12.2
        for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727356509; x=1727961309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYClKDP6VNFRp2YwKC/pbeN0hJPXkIpwnxoOga76ujo=;
        b=EpCnT4s0Idl+6LmXrrBZOLq++g5hQk/NL9893CDhXNf9G5q95HNPUdL5aho1eytQy7
         O1eJKmQLWcjsrr0oDzA4M6s4fuDMXBgCkduJXnRyB/MgkVik+hyZAnB9IYx8K8g+w03e
         UKEGFuIc+Eta1ZaNUJSC9BOGCVUzM0nPAKrMqoeKjh99SdKbIvrSLEXnj6ggy2VD/Woc
         o5by1GX/j5r85l5kD8pj0gk18Wqd+4KLno7EI/0o5SYJTDKz7ZwZiXyOUFexLPbA1EZ8
         4eUgc3UmQxPlSn7+n5vIb5DZjs4kJIip2+JPiC4tRIa2NnMbzEmKhC6ypZWQi7up/9m7
         xKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356509; x=1727961309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYClKDP6VNFRp2YwKC/pbeN0hJPXkIpwnxoOga76ujo=;
        b=f8sSbZ9gBuXeKDyoyvWvE3q+sIPuzzP54qO3NgLkA4y+ESN4IQqwXmvRFtszTDquWk
         ikCVCW56VFLRtMsM3saqYXAH71OpEDGHyCT1yoWLRJzXH5mD+4F3+Rt5XaC4FbuXUqzW
         KiynhNIFO77L+mQsmzXhA9xN1yfw3aZu4qq38Xx+ecq2VN9j5JW8sNZcDgIYpzyJDhF5
         fD8EF6hXrF1EpmBCmZ+ek9IkC14VB/dKVdey6CparCpkBAxOwuStIhtVWZR+cDWeMBGn
         /E5mOkdefdEYqum5GUcrw6F6PAD472bqMbarEqOPsPirFNUlHxpphvRiuA4vO6T+nklh
         0ZBg==
X-Gm-Message-State: AOJu0YxsnoS+aGfWodp9hVJrcjIWnrNWsGGuoXsqBXTMwrQeZcsZG6lN
	c3M1dXGlkkWRCfFLr4BZ1XwbR64uNvQlOj2ACF6UThbFPNn5JU8p2DB3KH59efx/j9AIn6CGIDL
	mVMa33Lf0t+8SI3XX+hC0Dxu20WzJkw==
X-Google-Smtp-Source: AGHT+IFfXIl1SxerzC96DoAC88utWjajYcL2fVmRquMp++C4RTUVYBJ6Jk/g98zqEimRzABVHOXjMJZ7V4ojHI21Mto=
X-Received: by 2002:a17:90a:c241:b0:2e0:80e8:a319 with SMTP id
 98e67ed59e1d1-2e080e8a4a1mr5107255a91.34.1727356508481; Thu, 26 Sep 2024
 06:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ46KJCUXqgq==pmEMW9yYJSRnWkGrSrxBAfMELPRYUdXQ@mail.gmail.com>
 <CAEjxPJ7WUzN=0Yv4POgPVHPG1wEjNn=-Tb53NiuMpWf+bEuF-w@mail.gmail.com>
 <CAEjxPJ758jx7X5Tauz=xQXsmWcZhx_V7AkU=PtsH6S3S9CUCbw@mail.gmail.com>
 <CAEjxPJ50ADVSOys58eYUktv4sjYYnEDroxA9Wnt6HiY9ySk=gg@mail.gmail.com>
 <CAEjxPJ6QsYR-Kj8k0C=54cix8rdpBsCphDV5_QnjGONDuOm+ew@mail.gmail.com>
 <CAEjxPJ6p3oD99_aTEeSCx6FMob7BH8-2vxdoT69c8sw11oHuEA@mail.gmail.com>
 <CAEjxPJ5jup5o9piVPuA97_radSzvshpnRB1CdBde8sV3ZXVc2Q@mail.gmail.com>
 <CAEjxPJ7UtCjQw=v1--6ZWXo-bbkndGbwfXhcT8RkX_cddjCqkQ@mail.gmail.com>
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com>
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
 <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
 <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
 <9aa53afd-efd8-4552-8239-14f99ff7a1b1@schaufler-ca.com> <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
 <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
 <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com> <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 26 Sep 2024 09:14:57 -0400
Message-ID: <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 11, 2024 at 4:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > Next up is tackling #2 below.
> >
> > > 2. Updating the SELinux hook functions to check permissions against
> > > all ancestor namespaces rather than just the current one, and conside=
r
> > > introducing a top-level global AVC to avoid the need to check against
> > > each per-namespace AVC on every check.
>
> I've now pushed another commit that introduces new permission checking
> functions that are namespace-aware and started converting some of the
> hook functions to use them, beginning with checks between a cred and a
> target task, e.g. selinux_task_kill().  With this change, I verified
> that a process in a child namespace could NOT violate the policy of
> the parent when sending signals. There remains a lot of work to
> convert the rest of the permission checks to do the same. Reproducing
> this particular case can be done as follows:
>
> # Temporarily switch to permissive to allow the following runcon to work
> sudo setenforce 0
> # Switch to a confined user
> runcon staff_u:staff_r:staff_t:s0-s0:c0.c1023 /bin/bash
> # Switch back to enforcing mode
> sudo setenforce 1
> # Become root, still as a staff user/role/domain
> sudo bash
> # Unshare SELinux namespace
> echo 1 > /sys/fs/selinux/unshare
> # Unshare mount and network namespaces for selinuxfs and
> NETLINK_SELINUX isolation
> unshare -m -n
> # Unmount the parent's selinuxfs and mount our own private instance
> umount /sys/fs/selinux
> mount -t selinuxfs none /sys/fs/selinux
> # Load a policy into our namespace, prior to this we don't have one
> load_policy
> # Switch to unconfined in our namespace
> runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
> # Check enforcing mode in our namespace, should be permissive still
> getenforce
> # Try to kill a process running unconfined in the parent namespace
> # Get a PID from a ps -eZ from a shell in the parent namespace not here.
> kill <pid-of-unconfined-process-in-parent>
> # Should get Permission denied due to parent denying access.
>
> Next step is to introduce additional namespace-aware permission
> checking functions that take things other than just cred-to-task and
> convert additional permission checks in the hook functions to use
> them.

As I've been converting the permission checks to use namespace-aware
helpers, I've noted policy capabilities (as in network_peer_controls,
open_perms, extended_socket_class, always_check_network, etc) as a
case that isn't cleanly handled by my current approach. At present,
the hook functions are just checking the value of the policy
capability in the current SELinux namespace to decide which branch of
the hook function to follow, and then within whichever branch is
selected, each permission check that is converted to using
namespace-aware helpers is checking permissions against the current
and all ancestor namespaces.

So for example, if the current namespace enables open permission, then
it will check open permission against the current namespace and all
ancestors, irrespective of whether the ancestor enabled that
capability or not. Similarly, if the current namespace disables open
permission, then it will NOT check open permission against any
namespaces, even if the ancestors enabled it.

Lifting the logic to iterate through all of the namespaces up into
each hook function is possible but rather painful. That said, it may
be unavoidable if we want to support different policy capability
settings between child namespaces and their ancestors, or prevent
child namespaces from effectively disabling certain checks by
disabling those capabilities.

If I were to go down that route, then I would also need to resolve how
to handle the non-permission checking logic in each hook across
multiple namespaces, e.g. labeling logic. Currently it is just
assigning SIDs/contexts to objects based on the current namespace,
then checking permissions against all namespaces with that
SID/context. But if each hook function has its body wrapped with the
same loop that currently exists inside the namespace-aware permission
checking functions to iterate through the namespaces, then we would
actually end up with multiple SIDs/contexts computed and need to
decide which one to use (or special case that part of the body to skip
doing so for anything but the first/current namespace).

Thoughts?
