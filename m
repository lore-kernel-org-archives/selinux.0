Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19E1865FC
	for <selinux@vger.kernel.org>; Mon,  7 Oct 2024 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331320; cv=none; b=b28JLQgK+XAiOzEwx3KvkMkBH3m8FaN2Gtm7ued8e5GZFj0/ejlb2xEut1MgPhJQFKOPkO2av9U81dgfcA+uSoQEfOe6/3lLxUeA8oUwOT5K+55AIaCsRNEZLu4EpuflOSC2c9L2Fxnopx2BewDbI1dii0Ta1kVYWdDdNttQBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331320; c=relaxed/simple;
	bh=F2tFp8LKNsLO+0UQoDGikzZjlbGkFHsxfsPKVPpev4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nqy+8NPtWNQZA9J44rNxLnaQn9bT8Abv6fpyi+Lk+o7FJW8NynpcH6rCU9GBnV/xDfIwER2d2Qc5F5X0KeILVAGY8wZd0H9W7AazsBq10/XKhIaJE62nabPIQhWK61mJ/PEhF70FECXIXrwTVN409PN4dOjNMH4S0svpwoZ19ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4jycnr8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4jycnr8"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so3456839a91.3
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2024 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728331318; x=1728936118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO4OvQNGw0d8U/J65IRPpl1MkPhwakfP4HRCyEuw1ZI=;
        b=C4jycnr8+ObIzH6bQdaYug3B0nIiLhz2zzpOcyfNW5ib6WKjo1BcXFkyHcoG7u6cQi
         z5KvvmCA5krLcBtKBGLt1FYoVrBVXyRw/1mTjeSBQkhH4EwA9UI8qon7qYA5R9GqQ8xL
         6ykvs9ILbEfO+6Yjx+pxowN/QOde4S5jGSZOml+nV4J5J55o4/NNH5FrKb3LIVEcYNWz
         BI5VH+DBd3tseiWW7WtPfkpOfLWWL2ZfWhg116R7djjAXbmUjqb6hscuRIArtmfdSlEz
         1Q+Z2rWELxn3PnT8bd+dB469TzT5Qydn7GisoJBUrmMM8X7658UcVcyl2YgBVW22sQEd
         VCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728331318; x=1728936118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO4OvQNGw0d8U/J65IRPpl1MkPhwakfP4HRCyEuw1ZI=;
        b=B6XaB5cOfp1P46IuXQ7fzR0N+i7oj3SxKr0rtp7RTTA1Y+EXHdZlBghum/GOgmyfFG
         MW7Ts9MZQqn68igaXp8q9BFP5XX6PwGdJQJgo/jx+nA0YZIcD+Qn4MkgU82pKWFGTkPF
         kHScRRaRzhVFiH0MaaXvU5S9qsL5PJ2Oac7fy9Z2u8oo9W77/BfEUzLWP7kqn1knIqS4
         jrxISu8PgCaIvoL6CW/yzJ/1AwMqHPCRsFP4dHNmYfDa9+0nb85EtZ4CgxDwhU/zaOvg
         uTGWcogCm0udtJhLWugTwbGDb7DBV48m2RqmGzdF1zwAaeU6CVBZ1bNJjUJye7O1Bfpv
         yJIA==
X-Gm-Message-State: AOJu0Yw8J0GkPDedCMM1j//E/qwiAvtBDfmmdjXI+p2xtdse8KhSakjv
	m8BTqG7PL8c0Ju3rFeDYTchH97xyW65EBsx/IsPVVCXRw/EvVDU8DSsODOkj0ILYGYA0qV5i5XD
	r4kHQeJdIhkdVpj3bCHlr3yllisA=
X-Google-Smtp-Source: AGHT+IETUubHPfxhAW5k3icjn0TtFK3GTqQS5+GAzD+LKaIrT0bgLkkjGzeYeriMHIH7/O6g6/YCji76hda6bx5XahE=
X-Received: by 2002:a17:90b:3891:b0:2d8:e3f3:fd66 with SMTP id
 98e67ed59e1d1-2e1e636c2f7mr13768392a91.34.1728331317705; Mon, 07 Oct 2024
 13:01:57 -0700 (PDT)
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
 <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
 <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
 <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
 <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
 <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com>
 <CAEjxPJ4RbypeHbdpWPXGRstDAWWiEv+-dCWXc1aAO+zpkxnkEg@mail.gmail.com>
 <CAEjxPJ5Co0P1sVYmAiD0WnquNv8XOMAyi09GCW3jTPqsvZEsGQ@mail.gmail.com> <CAEjxPJ66z5x9AB7wT_SaOCjw+UY6DseMnmjqiMi93063xZ3t-w@mail.gmail.com>
In-Reply-To: <CAEjxPJ66z5x9AB7wT_SaOCjw+UY6DseMnmjqiMi93063xZ3t-w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Oct 2024 16:01:46 -0400
Message-ID: <CAEjxPJ5duopAZs2tf5yK+w9-p_UB8ijAHoQXtWDMYJ9keiyRbA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:11=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 3, 2024 at 2:29=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Oct 3, 2024 at 1:04=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Based on our discussion at the last project meeting, I removed the
> > > requirement to unshare the network namespace when unsharing the
> > > SELinux namespace by adding a check in selnl_notify() to only send th=
e
> > > SELinux netlink notifications to the init network namespace if the
> > > triggering process is in the init SELinux namespace. Hence, the
> > > creator of a child SELinux namespace can either choose to unshare the
> > > network namespace if they want to receive such netlink notifications
> > > (in which case they will be sent to that child network namespace
> > > only), or they can just use the SELinux status page exported by
> > > /sys/fs/selinux/status, which is the default in libselinux for kernel=
s
> > > that support it.
> > >
> > > With that change, I can now run all of the selinux-testsuite tests
> > > successfully from a child SELinux namespace except for two labeled
> > > IPSEC tests each for inet_socket/tcp, inet_socket/udp, and
> > > inet_socket/mptcp. To fully pass the other tests, I had to also put
> > > the parent namespace into permissive mode to avoid certain failures
> > > due to MCS constraints in the base policy that can't be overridden vi=
a
> > > the test policy. The remaining labeled IPSEC test failures are likely
> > > due to the fact that the xfrm hooks are not passed a sock structure o=
r
> > > anything else from which I can obtain the appropriate SELinux
> > > namespace to use so they are hardcoded to use the init SELinux
> > > namespace and even when it is permissive, there are hardcoded SID
> > > comparisons in those hooks that are likely failing.
> > >
> > > I also introduced configurable limits for the maximum number of
> > > SELinux namespaces and for the maximum depth to which they can be
> > > nested. The default values of each can be controlled via Kconfig
> > > options, which default to 65535 and 32 respectively (matching user
> > > namespaces), and can be further adjusted via /sys/fs/selinux/maxns an=
d
> > > /sys/fs/selinux/maxnsdepth respectively but only from the init SELinu=
x
> > > namespace (child namespaces can read but not modify them). A simple
> > > pair of test scripts to recursively create SELinux namespaces
> > > correctly failed when it hit the maxnsdepth and lowering the maxns
> > > value correctly prevented exceeding that number of total namespaces.
> > > These tests however exposed a couple of reference counting bugs in th=
e
> > > code (one for SELinux namespaces, one for the parent cred that we
> > > cache in the task security blob for use in checks on the parent
> > > namespace), which are now also fixed.
> > >
> > > I have completed converting all of the permission checks to use the
> > > namespace-aware helpers or annotated them with comments indicating
> > > when it is correct to only check against the current SELinux
> > > namespace. For some of the checks, it is debatable as to which helper
> > > should be used, so we may need to revisit some of these based on
> > > experience.
> > >
> > > What remains to be done:
> > > 1. Maybe rework how policy capabilities are being checked/used to
> > > correctly support child namespaces with different policy capabilities
> > > from the parent. I can do this for some simple cases by lifting the
> > > logic to walk the namespaces up into the hook function itself and
> > > checking the policy capability value in each namespace, but many
> > > (most?) of the policy capabilities don't lend themselves to this
> > > approach. For example, extended_socket_class enables finer-grained
> > > socket security classes, but this is checked and applied when the
> > > socket security blob is initialized, not at permission check time.
> > > Unless we want to move the mapping logic to every permission check, I
> > > am not sure what can be done there. Similarly, a number of policy
> > > capabilities control labeling behaviors rather than permission checks=
,
> > > and since we are no longer trying to support per-namespace object
> > > SIDs/contexts, only one namespace's policy can be applied that label
> > > will then be used for all subsequent checks even in the other
> > > namespaces.
> > >
> > > 2. Decide if any further hardening of selinuxfs is required to safely
> > > permit usage by potentially untrusted / less trusted processes in
> > > child namespaces. There has already been a lot of work to harden e.g.
> > > the policy loading logic against ill-formed policies and such, so not
> > > sure if there is much to do here, but noting it. I would like to get
> > > rid of /sys/fs/selinux/user altogether so possibly making it
> > > inaccessible in child namespaces would be a good first step.
> > >
> > > 3. Optimize the implementation for the single SELinux namespace case,
> > > reducing and/or eliminating the overhead introduced by the SELinux
> > > namespace support for that common case. Lots of work to do here, help
> > > welcome. Also would appreciate guidance on current benchmarking
> > > practices since it has been a while since I've had to do that.
> > >
> > > 4. Revisit the userspace API for unsharing the SELinux namespace
> > > if/when the rest is ready. Currently just "echo 1 >
> > > /sys/fs/selinux/unshare" (followed by the other necessary steps for
> > > unsharing the mount namespace, unmounting the parent's selinuxfs,
> > > mounting a new selinuxfs for the child, loading a policy, and setting
> > > enforcing mode). Options would include adding a CLONE_SECURITY flag t=
o
> > > unshare/clone that could be implemented by any/all LSMs via a call to
> > > a new (stacked) LSM hook function, or one or more new LSM system call=
s
> > > to do the same, or just keeping it the way it is via selinuxfs.
> > >
> > > Experimentation is welcome, particularly for more complex cases, e.g.
> > > where the host policy and the child policy differ (no policy loaded o=
n
> > > host, policy in child; policy loaded on host, no policy in child; hos=
t
> > > policy from one distribution/release; child from another, etc). Be
> > > aware however that since the permission checks are applied to the
> > > current namespace and its ancestors, the parent namespace may deny
> > > something that would be allowed in the child, especially if the child
> > > is using contexts that are unknown to the parent's policy (which will
> > > be treated as unlabeled for those checks in the parent). Also be awar=
e
> > > that since we are no longer trying to support per-namespace object
> > > SIDs/contexts, any object first instantiated in the parent namespace
> > > will be labeled according to its policy, not the child's policy.
> > >
> > > The tree can be found at:
> > > https://github.com/stephensmalley/selinux-kernel/tree/working-selinux=
ns
> > >
> > > It may be re-based or changed at any time.
> > > To experiment, after building and booting this kernel, do the followi=
ng:
> > > # Create root shell
> > > sudo bash
> > > # Unshare SELinux namespace
> > > echo 1 > /sys/fs/selinux/unshare
> > > id # Context is now "init" or "kernel" in child; ps -eZ from parent
> > > will still show original context
> > > # Unshare mount namespace and mount new selinuxfs for child SELinux n=
amespace
> > > unshare -m
> > > umount /sys/fs/selinux
> > > mount -t selinuxfs none /sys/fs/selinux
> > > # Load a policy into the child SELinux namespace, parent unaffected
> > > load_policy
> > > id # Context is now kernel_generic_helper_t on Fedora due to a defaul=
t
> > > transition in its policy
> > > # Switch to a suitable security context before trying to go enforcing
> > > runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bas=
h
> > > # Switch child to enforcing, checking that you didn't get killed once=
 enforcing
> > > echo $$
> > > setenforce 1
> > > echo $$
> > > # Do stuff in child, run testsuite (switch parent to permissive first
> > > to avoid denials from it), etc.
> >
> > Oops, I see that the selinux tree re-based to 6.12-rc1, so now
> > updating my branch to that.
> > There are conflicts so it may take a little bit.
>
> Wasn't too bad. Now re-based on 6.12-rc1.

Re-based again on latest selinux/dev, and pushed a few more changes:
- selinux: make open_perms namespace-aware; demonstrates how to
integrate the namespace-based checking with the open_perms policy
capability so that we only check file open permission in namespaces
that enable the capability in their policy. That was the easy case;
the rest of the policy capabilities are less clear on how to resolve
as per my earlier description.
-   selinux: split cred_ssid_has_perm() into two cases; alters how the
namespace-based checking is applied to socket and SysV IPC checks
based on some testing
-  selinux: set initial SID context for init to "kernel" in global SID
table; fixes what would be a userspace compatibility problem for init
in child namespaces by duplicating what we were already doing in the
security server's per-policy SID table.

In addition to running the testsuite in a child SELinux namespace as
before, I also launched a RHEL9 UBI container, manually unshared the
SELinux namespace in a shell within it, and loaded the RHEL9 policy
into the child namespace to simulate what we would ultimately want the
container runtime to do. That motivated the latter two changes above.
Not quite ready to put that into enforcing mode due to some denials
between container processes and host resources (like the inherited
open fds) but a step forward.
I think to better understand what else is needed, it would help to
prototype modifications to a container runtime to unshare the SELinux
namespace (just using the current /sys/fs/selinux/unshare interface
for now) before launching the container init, and see if the container
init does the right thing (i.e. concludes that SELinux doesn't yet
have a policy loaded based on /proc/self/attr/current=3D=3D"kernel",
mounts its own /sys/fs/selinux private to its namespace, and loads its
policy into it). Thoughts on what the easiest container runtime to
patch in this way would be, or anyone want to try?
