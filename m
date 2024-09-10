Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE35208A5
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995642; cv=none; b=IWdXEfgEJwSc43E+5ZBZDjF3J4sSytMUy8IDkNpJcU5CykAze00yMzqxLrUbIDR6pZNmhqlg1GBi03xQkHYgeAUocptpNKHXIKjb7leG1chUpo2uSFLVvNRjxqx4KCfvd8HY6d4tqEmqxqeZW5z3qT9xzZAODI3JZFnPedaCWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995642; c=relaxed/simple;
	bh=ZMy9pqkS7FYKucfnDhT7McFdxeVnDTwU2nyP3yUc0bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhJW17ge5YugL4G3yL1dYuAPddRw4/KioFFDYjt3GMIE0AH2Y9gG/yguKzLGeUixlGvWfV0GFqk7NqsotBtvyhILWHRy+L5vEE8X/jtuzyGfgXJX8ZLwV+08zhSvDaLL/Cx5WVfrSZQesFZpZTTY5Ek+WmmL9kcZKebu60tXBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTpsoHR5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTpsoHR5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053f6b8201so56837005ad.2
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725995640; x=1726600440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMy9pqkS7FYKucfnDhT7McFdxeVnDTwU2nyP3yUc0bU=;
        b=eTpsoHR5CoLJ/uBjnUdYOyUYW1JrhqMO4wa5m6gKx9Kl7fwf+kJMRe4v2ys4twGaOH
         VEI6L+2ihgUN3Keo7VXYNBv4cy93B843GsftEBhtVacbiLFQAAzemspytUt/z778VZxr
         ml6FIkKAFUYfg+M2cereOFTnU/8M5jzaxgNCvsCMKOEM1UcIs2+zUIc1YbTeVi+9tQSN
         EPE+7bS+ae5edhkQGdBbeRzholeFU54tUhToY4a1tK09u3kYH2+KGj7nL/Uc+taXgBis
         lSValJaLijukaNQXqHrLeXEnmIiTqKZF//OH+4j+Y/GaXbEluCHLRaVY7nPa33sW8qe9
         CtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995640; x=1726600440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMy9pqkS7FYKucfnDhT7McFdxeVnDTwU2nyP3yUc0bU=;
        b=v5BknvehjvzERS5meVYoD0siZwyOXtiZYgzeJJYd6OhelXzAyVBgBy3z4323HrV10J
         9Z6hG31fRi10rka/Ttt3ebk07aY313TeUq/toKP8DH+oO1+hVtc1olH9KH3m4nIDfzY1
         T/NXyyDMQd1RzoHtRVec5NCozXMcLLrjKqCZhYhD1ApFne9Pr47jnIIfyYECzhmP1Cm8
         fqxFnnteQwVIii5WnlEMgusuVRe4JOe0OscV6H5neLPUnsqQYu8S41s7dX2UNi+Hpbz0
         wY4QPpWlGWT91vPPqvZPl4nNhYRq9AyIj1ZD3K0IK/icqv4H5YMIF576sBTiadWhAF+b
         QYlw==
X-Gm-Message-State: AOJu0YxckwJ59xm6JUdNeK8nvfJc9XDDlRoHGQHAGdl2S91w3E65ZBu1
	dm9PGc1RKis2i3cmCL5VU8iEqCxNedlDOestCueDabrF1qSxW0gduJhx21jq1zhgj5xatKxtfHO
	zFasXmP6+n7qQwen1S1+zh7zQKd7BY0Ul
X-Google-Smtp-Source: AGHT+IFWcO28x65KHC9qhkveEs4ymAyqMhZ9nJIccX59tJYG7hCWRzBiuSFMJwowttRaRYWqXUlKFlSY/9hKXrEapVE=
X-Received: by 2002:a17:903:24f:b0:203:a046:c666 with SMTP id
 d9443c01a7336-2074c4b35f5mr29109395ad.3.1725995639948; Tue, 10 Sep 2024
 12:13:59 -0700 (PDT)
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
In-Reply-To: <CAEjxPJ6vyDjmwxEpwnb+JYKiWXYFo5g_suZiUZb6L+aepHxZiA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Sep 2024 15:13:48 -0400
Message-ID: <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 10:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> For those following along, I have pushed a commit that introduces a
> global SID table [1].
> It does not yet change any code to start using this global SID table,
> so that's next.
> Rather than introduce yet another data structure, I reused the
> existing SID table structures and code.
> For the global SID table, we only use the SID and the context str, len
> fields for all entries.
> If we later decide to optimize the global SID table more specifically,
> that can be done easily enough.

I finally got everything that requires global SIDs to use the new
global SID table, now available in my branch,
https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns

This proved to be more involved than I had anticipated; there are a
number of subtleties in our handling of contexts and NetLabel was
caching SIDs in two locations, one of which is read outside the
security server (hence, required a global SID) and the other one is
only directly read/written inside the security server (hence, can be
mapped to/from global SIDs at the security server interface).

With these changes, I could drop the changes for revalidating and
updating inode, superblock, and open file SIDs per-namespace, so those
have been dropped from the branch although still available in a
working-selinuxns-beforeglobalsids branch for reference.

The SELinux testsuite passes, including NFS tests, in the initial
SELinux namespace, and everything except for the
socket/networking-related and mac_admin tests pass in a child SELinux
namespace. The socket/networking-related test failures are
unsurprising, partly due to needing to also unshare the network
namespace to avoid the SELinux netlink notifications from confusing
the initial namespace's AVC (wrong/out-of-order policy seqno) and
partly due to the fact that we do not yet have a way to associate the
SELinux namespace for use in hooks that occur outside of process
context. The mac_admin test failures are likewise unsurprising
(getting/setting unmapped context values); I had similar issues with
those tests even in the initial namespace before making some further
specialized changes; I will see if I can get that to work properly in
the child namespace too.

Going back to the list of known issues to resolve and omitting the
ones resolved by having global SIDs, we are left with the following:

1. Updating hook functions called outside of process context, e.g.
task_kill, send_sigiotask, network input/forward, to use the correct
SELinux namespace instead of using the current one; this requires
storing a pointer to the SELinux namespace in some relevant data
structure from which we can fetch it in those hook functions, e.g. the
file or socket security blobs.

2. Updating the SELinux hook functions to check permissions against
all ancestor namespaces rather than just the current one, and consider
introducing a top-level global AVC to avoid the need to check against
each per-namespace AVC on every check.

3. Providing a way to restrict or bound nesting of SELinux namespaces,
particularly given the resource usage associated with loading a policy
per-namespace and having a per-namespace AVC, sidtab, etc.

4. Hardening the policy loading code and other selinuxfs interfaces to
support potentially unprivileged usage by child namespaces.

5. Optimizing the namespace support, global SID table, etc to avoid
imposing significant overheads especially for the case where there is
only a single namespace since that will likely remain the common case.

Reminder on usage for anyone who wants to play with it:
# Unshare the SELinux namespace
echo 1 > /sys/fs/selinux/unshare
# Unshare the mount and network namespaces
# Required so that we can have our own private selinuxfs mount and
# so that we can have our own private NETLINK_SELINUX socket.
unshare -m -n
# Unmount the parent namespace's selinuxfs and mount our new one.
umount /sys/fs/selinux
mount -t selinuxfs none /sys/fs/selinux
# Load a policy into our namespace
load_policy
# Switch to a safe context
runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
# Go enforcing
setenforce 1
