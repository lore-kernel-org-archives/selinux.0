Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3A291E
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479406; cv=none; b=ZPMNLWtHHgBTvsq7EN4JY1+pBHdQplrtWJJ77FcAa4e7AsJ8UQ3MG8xMjl7K/QyWvHTPVbeG8AxndwxXhfOcSOqiwowErv1vPXblm12t2kzqbmCFa7r8GMzguFwnEwvMUaDozss1JOW3qOGONXEgYIeoGtmv5+9cqceoUOBkhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479406; c=relaxed/simple;
	bh=jJohs1e6cTJnpRDQC/jM4RxQF6u1jnNYOMT9vGyLPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMO5b+T7rzn30o6Hsj+WLAbmMifzNVWrijMjq/Qj8FbkQnyPhHkL8Plr9UhG7H5sG1jDyVriZ6R/XkQOZLQfOVcmrdBJGsZEA1NY504E9YdtqeoI1z55rugSF7KTLluLw/jnBHL1ulaXYDkBpjRIsbXP1HJMs07HS09j4ltgELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyU+3TmH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyU+3TmH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so5006342a91.1
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2024 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728479404; x=1729084204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJohs1e6cTJnpRDQC/jM4RxQF6u1jnNYOMT9vGyLPFg=;
        b=gyU+3TmHalc87FiyClAKydijWfj7GqXk8zUlJGM5qrLXXThsCL9AlRjmT3cTXxC9Jb
         6uMoXdrmOhpgs7229GT5u0FVGt257sm7fpzRilZ8aZ1QAkjrSmkX67PldIrwCweEHBLb
         JwzNpphiLMWeuzEaKJo53Ud6KR4yd8y1FAkMi0+VpwprjbsI7tlCxHEF8FYuCnvdinse
         bkJlKKIPn1gZYt051rg4M2onWaXqWvENxCV415qNeEnpcVAGFtgobMXAtKkEuTd0O2bB
         N5LT5Dt6VDTvNsJ0KnJC69YmJWDy6OuhcfGCaAoanzoyQ8EzIaBd1YwuD6+I+df/4Nng
         lpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479404; x=1729084204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJohs1e6cTJnpRDQC/jM4RxQF6u1jnNYOMT9vGyLPFg=;
        b=mXEpSznOh6L3x2iKVpbnG1bMWwmdea/Q6RR8Nbvu2Gvr1e6+pNF6AHmN8UHxfR115i
         dPGLI7hq8fRiKjk7qjXBJGryl93HUDX0BcyovDpSFvbRsFeCPhirqz4DGSfbGrP0+FfR
         17MXBESp/PAJ/UeIYBhgta9N34B1PkFntm3CtV/2UJe6bjd1Fvm2/nQ2z5KeejCKHE6O
         i/D4TTDViu2diFrpR6zx0ul/A3JLyLBNy0fmGytBsBzccYxzOH+YDLAlcL+LLsJlsRfH
         TZph85CPZrIlRxGH2fXtMTgiQ7VS4kiKBl3X4kfPjXlKtlLKgOfvQwjJxWiFmeRCpZfP
         rsZg==
X-Gm-Message-State: AOJu0YwQy9uMHhJi73/ia8Gg9T1JFhudlRDP1FWZnci8RIrwgpaudhcT
	gb8jrcZwvNkktR9aB5xSXuP8NVaX9s9S4jYLML4kOEIv7TxsRWeZkZACydKJSzs0xLM5XnzZrz/
	wIMpR1cQZ9wMgJgHTtSmqFD0N0HZicuWh
X-Google-Smtp-Source: AGHT+IHGhDooQr3huCZtfnwU8UcB/aCpHoDk254BNIdIH6gKom9ii78CAvEqjMaE3lu5NxsywlCq/Solm8whH2GzU40=
X-Received: by 2002:a17:90b:1914:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2e2bfb00f23mr569373a91.12.1728479403410; Wed, 09 Oct 2024
 06:10:03 -0700 (PDT)
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
 <CAEjxPJ5Co0P1sVYmAiD0WnquNv8XOMAyi09GCW3jTPqsvZEsGQ@mail.gmail.com>
 <CAEjxPJ66z5x9AB7wT_SaOCjw+UY6DseMnmjqiMi93063xZ3t-w@mail.gmail.com>
 <CAEjxPJ5duopAZs2tf5yK+w9-p_UB8ijAHoQXtWDMYJ9keiyRbA@mail.gmail.com> <CAEjxPJ4S9Z1WOpcDNJ5t4vCuHM4DqAr2jLscSiPJrARr6QPJfA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4S9Z1WOpcDNJ5t4vCuHM4DqAr2jLscSiPJrARr6QPJfA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 9 Oct 2024 09:09:51 -0400
Message-ID: <CAEjxPJ7vMQ6SBVXUjfG+3XvHdkCvSO=fBwftFdt9kTfLrPzr_Q@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Re-based again on top of latest selinux/dev to resolve the conflicts
> with the just-merged patches and to update the new netlink xperm
> support for SELinux namespaces. Passes the selinux-testsuite including
> the (not yet merged) nlmsg tests in both the init SELinux namespace
> and a child SELinux namespace (modulo the labeled IPSEC tests and with
> the init SELinux namespace permissive for testing the child or
> modifying the init namespace policy to permit it to run all the tests
> in the child context). Functionally, this is nearly complete as far as
> SELinux-only changes go (not including the corresponding work needed
> to namespace audit and if desired/necessary, to allow namespacing of
> the labeled IPSEC hooks), modulo any bugs that get discovered in
> trying to create real containers with their own SELinux namespaces and
> different combinations of policies between the host OS and the
> containers.
>
> My remaining ToDo list is as follows, but this is a good point for
> others to provide feedback or experiment with the functionality or
> propose their favorite container runtime for the next stages of
> prototyping. If it would help spark feedback, I could post the current
> set of kernel patches to the list.
>
> - Test creation/use of SELinux namespaces from actual containers with
> different policies from the host OS. This may require patching a
> container runtime to add support for unsharing the SELinux namespace
> and unmounting the old selinuxfs prior to starting the container init.
> Combinations to test: No policy loaded on host, policy loaded in
> container e.g. Fedora on Ubuntu; host with newer base policy than
> container e.g. RHEL/Rocky 8/9 on Fedora; container with newer base
> policy than host e.g. Fedora on RHEL/Rocky 8/9; host and container
> with different upstream policy sources e.g. Ubuntu on Fedora; Android
> container on Linux host OS.

To help get this started, I created a patch for libselinux to provide
a selinux_unshare() API that unshares the SELinux namespace (hiding
the current messy internal details of the existing kernel interface
and also dealing with various situations under which it might be
called by container runtimes with selinuxfs already mounted, bind
mounted read-only, or not mounted at all) along with a sample
unshareselinux utility that shows how to use it, and a patch for
systemd-nspawn to show how it might be called from a container runtime
to unshare the SELinux namespace during container creation. These can
be found the selinuxns branches of my selinux userspace and systemd
forks at:
https://github.com/stephensmalley/selinux/tree/selinuxns
and
https://github.com/stephensmalley/systemd/tree/selinuxns
respectively.

While the patches appear to work correctly (i.e. you end up with a new
SELinux namespace, after which you can mount a new selinuxfs that is
private to your namespace, load a policy, set enforcing mode, etc),
unfortunately it appears that systemd doesn't just do the Right Thing
automatically when it is invoked as a container init after unsharing
the SELinux namespace, i.e. it does not proceed to call the SELinux
setup functionality so it never tries to mount selinuxfs and load a
policy within the container. Unsurprising but it does mean that
someone will need to modify it to do so in this case while ensuring
that this doesn't break existing setups without the SELinux namespace
functionality.

> - Rework how policy capabilities are being checked/used to correctly
> support child namespaces with different policy capabilities from the
> parent. This has already been done for the open_perms capability by
> lifting the logic to walk the namespaces up into the hook function
> itself and checking the policy capability value in each namespace, but
> many (most?) of the policy capabilities don't lend themselves to this
> approach. For example, extended_socket_class enables finer-grained
> socket security classes, but this is checked and applied when the
> socket security blob is initialized, not at permission check time.
> Unless we want to move the mapping logic to every permission check, I
> am not sure what can be done there. One option would be to
> force-enable the same policy capabilities in the child namespace as in
> the parent to avoid conflicts but this would limit the ability to use
> differing policies. Similarly, a number of policy capabilities control
> labeling behaviors rather than permission checks, and since we are no
> longer trying to support per-namespace object SIDs/contexts, only one
> namespace's policy can be applied that label will then be used for all
> subsequent checks even in the other namespaces.
>
> - Decide if any further hardening of selinuxfs is required to safely
> permit usage by potentially untrusted / less trusted processes in
> child namespaces. There has already been a lot of work to harden e.g.
> the policy loading logic against ill-formed policies and such, so not
> sure if there is much to do here, but noting it as a possible area to
> audit for safety.
>
> - Ensure that we are correctly handling peer and packet labels when
> they cross SELinux namespaces, for some definition thereof, both wrt
> permission checking and wrt the peer/packet labels that are exposed to
> userspace via getsockopt(SO_PEERSEC), recvmsg() SCM_SECURITY, etc.
>
> - Optimize the implementation for the single SELinux namespace case,
> reducing and/or eliminating the overhead introduced by the SELinux
> namespace support for that common case. Lots of work to do here, help
> welcome. Also would appreciate guidance on current Linux kernel
> benchmarking best practices since it has been a while since I've had
> to do that.
>
> - Re-test with KASAN and with KCSAN enabled to confirm that the
> namespace patches haven't introduced any memory errors or race
> conditions; I have tested with each of these in the past successfully
> but don't keep them enabled generally because they make everything
> very slow. And you can't have them both enabled together at runtime
> AFAICT.
>
> - Revisit the userspace API for unsharing the SELinux namespace
> if/when the rest is ready. Currently just "echo 1 >
> /sys/fs/selinux/unshare" (followed by the other necessary steps for
> unsharing the mount namespace, unmounting the parent's selinuxfs,
> mounting a new selinuxfs for the child, loading a policy, and setting
> enforcing mode). Options would include adding a CLONE_SECURITY flag to
> unshare/clone that could be implemented by any/all LSMs via a call to
> a new (stacked) LSM hook function, or one or more new LSM system calls
> to do the same, or just keeping it the way it is via selinuxfs.
>
> - Upstream the kernel support.
>
> - Figure out how to combine the use of SELinux namespaces with Red
> Hat's current model of isolating and confining containers as a whole
> via SELinux on the host OS. This is complicated by the fact that we
> are only supporting a single inode SID/context per inode (gave up on
> per-namespace inode SID/contexts, see the earlier mailing list
> discussions), and Red Hat's current model uses context mounts to
> assign a single security context to all the inodes used by the
> container. Possibly introduce a new kind of context=3D mount that is
> namespace-aware, i.e. only apply the context mount when in the outer
> namespace but use the inode xattrs inside the child namespace.
>
> - Integrate and upstream userspace support into appropriate container
> runtimes, e.g. systemd-nspawn, crun/runc, podman, docker, k8s, etc.
