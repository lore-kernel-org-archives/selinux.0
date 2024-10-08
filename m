Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4C197A65
	for <selinux@vger.kernel.org>; Tue,  8 Oct 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394378; cv=none; b=Gp97Cu8BUG+/lFbfZZ8+aXOCjgr/V7iiijgkEUhAXNpjRikGSpCCVqMi9SdoPb9/rGj1+xnkIgdJZUgz7ay5NOjdbn8vbfepkHgekgGuvsY1Dk2ga4e1VsY564Y4zBhlfcDK5EY9m3CNHVvxygUNrFMAZJ62g44vNeYpOptR404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394378; c=relaxed/simple;
	bh=6qIwC9GE63sX8nZ7Y3VaWkeZNdvjdVvBz1j8S4R0Bqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUpTQqGXQx9bGtfhnFEE87GUN+TRc8iedmU6xj3Ru5CyBAYx867BCZS1UO9zoxeYGGy48ncNlDeuZ2WRNGmWVPjyX+K/svmYoAaTRWClWFxp8wD25UUAZgbFA0xd6VFjx610izB4ibSWZiazINIujh/BnbTnUkMaM3pmE+CcOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfyEi/Cj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfyEi/Cj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b49ee353cso52520975ad.2
        for <selinux@vger.kernel.org>; Tue, 08 Oct 2024 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394376; x=1728999176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA//GU87UaDaKcGH6WkILjiSYN4h2JY04YeQxOZlOz0=;
        b=DfyEi/CjwPCN/YYjibB0Qww3Vcwj8imb3RzqyZlBqykTWtsKZjMvm3kdB94+xmNuq8
         eCvNUg3901fDHHg+vF4HHMOvrImSqlqwOX8BmTO7qsEB6eL7ycA2rDsl5NHK7Fz2b9gM
         f7JPZ2UxGSZs+cXC3wlS5I07ZuE7u3kqeuON2yfg9EYVzLKomisVnCoU3++c2EdTYGCE
         ZBxDd0cWfqDLyTpF8O9SBSWRC/Asb0uJcyTDIQOCqFl9juiuIDp8+AbhQ7lGmdsR1Rcq
         CEqSBPqaOpaG+FJAEqNRt0it+Aw090Ql7y6S4n2UNrgWGZHAT90xfko824gP74T8r3o3
         evlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394376; x=1728999176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA//GU87UaDaKcGH6WkILjiSYN4h2JY04YeQxOZlOz0=;
        b=xDFnNyPxSZIsI0xLD+nLa8t+ONrnW05lZSzCyl19Mxyp5SM3G7ebaVidrY1stMp0d6
         RUrgngRSSjZE8AaM/x0q2/Hgfu+6GuGPFOYihaV+oUGXAzc+UAnK/LHI+cnA3fg8TLAC
         vLzAhTiASISnwfBLR8xFgSGf27sCD6Y9l02xWFvylFNcXHTA0Wqdphm1VTWOcVqufQ6M
         +L0tnBZKSDRr/FUMh8YkxWLL5B+h7lJcSGaCX/B73IbuLKefCfaJezsCMgwwSnThN+vG
         wejOsqu0EjJG66a3NJXM5nSGYsLuzrsiwUZHrsC1FO8yzHlJuPjN57moGtmTRfFas6b+
         9ZtQ==
X-Gm-Message-State: AOJu0YxVDUAMDcZzx8vFX0t93ur6Fx0JEiVGfxKrTpP50R8whmAJrGRR
	P2hKehFblH9RHrd75mhjd7rhKvl04FEWrq4Hjy7pVEh4uJgV9F96+1Q6q3PfwJOLK9p+wyOY5ch
	58m+HRqEcOtnmSbIqDAwfTuPHrxk=
X-Google-Smtp-Source: AGHT+IHnXirLDK9uGFsh6SOg1+/bYCsL+PW9olcMwibbIt1JlMqioqkRmQHLcBmcc5zh8+I3YNUpbe/MNirW2c742is=
X-Received: by 2002:a17:90a:cb10:b0:2e2:9522:278f with SMTP id
 98e67ed59e1d1-2e295222a70mr517304a91.32.1728394375987; Tue, 08 Oct 2024
 06:32:55 -0700 (PDT)
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
 <CAEjxPJ66z5x9AB7wT_SaOCjw+UY6DseMnmjqiMi93063xZ3t-w@mail.gmail.com> <CAEjxPJ5duopAZs2tf5yK+w9-p_UB8ijAHoQXtWDMYJ9keiyRbA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5duopAZs2tf5yK+w9-p_UB8ijAHoQXtWDMYJ9keiyRbA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 8 Oct 2024 09:32:44 -0400
Message-ID: <CAEjxPJ4S9Z1WOpcDNJ5t4vCuHM4DqAr2jLscSiPJrARr6QPJfA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:01=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Re-based again on latest selinux/dev, and pushed a few more changes:
> - selinux: make open_perms namespace-aware; demonstrates how to
> integrate the namespace-based checking with the open_perms policy
> capability so that we only check file open permission in namespaces
> that enable the capability in their policy. That was the easy case;
> the rest of the policy capabilities are less clear on how to resolve
> as per my earlier description.
> -   selinux: split cred_ssid_has_perm() into two cases; alters how the
> namespace-based checking is applied to socket and SysV IPC checks
> based on some testing
> -  selinux: set initial SID context for init to "kernel" in global SID
> table; fixes what would be a userspace compatibility problem for init
> in child namespaces by duplicating what we were already doing in the
> security server's per-policy SID table.
>
> In addition to running the testsuite in a child SELinux namespace as
> before, I also launched a RHEL9 UBI container, manually unshared the
> SELinux namespace in a shell within it, and loaded the RHEL9 policy
> into the child namespace to simulate what we would ultimately want the
> container runtime to do. That motivated the latter two changes above.
> Not quite ready to put that into enforcing mode due to some denials
> between container processes and host resources (like the inherited
> open fds) but a step forward.
> I think to better understand what else is needed, it would help to
> prototype modifications to a container runtime to unshare the SELinux
> namespace (just using the current /sys/fs/selinux/unshare interface
> for now) before launching the container init, and see if the container
> init does the right thing (i.e. concludes that SELinux doesn't yet
> have a policy loaded based on /proc/self/attr/current=3D=3D"kernel",
> mounts its own /sys/fs/selinux private to its namespace, and loads its
> policy into it). Thoughts on what the easiest container runtime to
> patch in this way would be, or anyone want to try?

Re-based again on top of latest selinux/dev to resolve the conflicts
with the just-merged patches and to update the new netlink xperm
support for SELinux namespaces. Passes the selinux-testsuite including
the (not yet merged) nlmsg tests in both the init SELinux namespace
and a child SELinux namespace (modulo the labeled IPSEC tests and with
the init SELinux namespace permissive for testing the child or
modifying the init namespace policy to permit it to run all the tests
in the child context). Functionally, this is nearly complete as far as
SELinux-only changes go (not including the corresponding work needed
to namespace audit and if desired/necessary, to allow namespacing of
the labeled IPSEC hooks), modulo any bugs that get discovered in
trying to create real containers with their own SELinux namespaces and
different combinations of policies between the host OS and the
containers.

My remaining ToDo list is as follows, but this is a good point for
others to provide feedback or experiment with the functionality or
propose their favorite container runtime for the next stages of
prototyping. If it would help spark feedback, I could post the current
set of kernel patches to the list.

- Test creation/use of SELinux namespaces from actual containers with
different policies from the host OS. This may require patching a
container runtime to add support for unsharing the SELinux namespace
and unmounting the old selinuxfs prior to starting the container init.
Combinations to test: No policy loaded on host, policy loaded in
container e.g. Fedora on Ubuntu; host with newer base policy than
container e.g. RHEL/Rocky 8/9 on Fedora; container with newer base
policy than host e.g. Fedora on RHEL/Rocky 8/9; host and container
with different upstream policy sources e.g. Ubuntu on Fedora; Android
container on Linux host OS.

- Rework how policy capabilities are being checked/used to correctly
support child namespaces with different policy capabilities from the
parent. This has already been done for the open_perms capability by
lifting the logic to walk the namespaces up into the hook function
itself and checking the policy capability value in each namespace, but
many (most?) of the policy capabilities don't lend themselves to this
approach. For example, extended_socket_class enables finer-grained
socket security classes, but this is checked and applied when the
socket security blob is initialized, not at permission check time.
Unless we want to move the mapping logic to every permission check, I
am not sure what can be done there. One option would be to
force-enable the same policy capabilities in the child namespace as in
the parent to avoid conflicts but this would limit the ability to use
differing policies. Similarly, a number of policy capabilities control
labeling behaviors rather than permission checks, and since we are no
longer trying to support per-namespace object SIDs/contexts, only one
namespace's policy can be applied that label will then be used for all
subsequent checks even in the other namespaces.

- Decide if any further hardening of selinuxfs is required to safely
permit usage by potentially untrusted / less trusted processes in
child namespaces. There has already been a lot of work to harden e.g.
the policy loading logic against ill-formed policies and such, so not
sure if there is much to do here, but noting it as a possible area to
audit for safety.

- Ensure that we are correctly handling peer and packet labels when
they cross SELinux namespaces, for some definition thereof, both wrt
permission checking and wrt the peer/packet labels that are exposed to
userspace via getsockopt(SO_PEERSEC), recvmsg() SCM_SECURITY, etc.

- Optimize the implementation for the single SELinux namespace case,
reducing and/or eliminating the overhead introduced by the SELinux
namespace support for that common case. Lots of work to do here, help
welcome. Also would appreciate guidance on current Linux kernel
benchmarking best practices since it has been a while since I've had
to do that.

- Re-test with KASAN and with KCSAN enabled to confirm that the
namespace patches haven't introduced any memory errors or race
conditions; I have tested with each of these in the past successfully
but don't keep them enabled generally because they make everything
very slow. And you can't have them both enabled together at runtime
AFAICT.

- Revisit the userspace API for unsharing the SELinux namespace
if/when the rest is ready. Currently just "echo 1 >
/sys/fs/selinux/unshare" (followed by the other necessary steps for
unsharing the mount namespace, unmounting the parent's selinuxfs,
mounting a new selinuxfs for the child, loading a policy, and setting
enforcing mode). Options would include adding a CLONE_SECURITY flag to
unshare/clone that could be implemented by any/all LSMs via a call to
a new (stacked) LSM hook function, or one or more new LSM system calls
to do the same, or just keeping it the way it is via selinuxfs.

- Upstream the kernel support.

- Figure out how to combine the use of SELinux namespaces with Red
Hat's current model of isolating and confining containers as a whole
via SELinux on the host OS. This is complicated by the fact that we
are only supporting a single inode SID/context per inode (gave up on
per-namespace inode SID/contexts, see the earlier mailing list
discussions), and Red Hat's current model uses context mounts to
assign a single security context to all the inodes used by the
container. Possibly introduce a new kind of context=3D mount that is
namespace-aware, i.e. only apply the context mount when in the outer
namespace but use the inode xattrs inside the child namespace.

- Integrate and upstream userspace support into appropriate container
runtimes, e.g. systemd-nspawn, crun/runc, podman, docker, k8s, etc.
