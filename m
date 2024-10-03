Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED261AB6D8
	for <selinux@vger.kernel.org>; Thu,  3 Oct 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986304; cv=none; b=t7mJ2gF+vtDCRAgmGrdCJDDxOUcNxY68Kph7taG76T3QGXfmdQoDhD02va81N/e/gJ+gyHAalAArCDpvxbtif06FNpsAUvt1EqxuFjh7zYdta4oBvjK01eaaDPVuQ3SrlrG+Icbx95yE9pth/WKSR/ncVEsB7eqyVbe48yyScZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986304; c=relaxed/simple;
	bh=t/Q6zs9U6Y2OkcbzA5fMA33TDeUV2717oveHc8WbKMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzPoNnOGPNef6N7cjMI07tBkMM3S1qt2KwB1dbMq3qNuIwIryX4EQTjUP26FLrJ1itvYSl5LYvC+UXyB20tgZJ8wV1AL2IovhYvdqICC+YT8EqWgW/Q+N4O1HZf2K5eCAsYelhFXPUP9aX+CNxn2XUx4NasKyOwRTPWbQr9Ev/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nq33oUCd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq33oUCd"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so1229525a91.2
        for <selinux@vger.kernel.org>; Thu, 03 Oct 2024 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727986302; x=1728591102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/Q6zs9U6Y2OkcbzA5fMA33TDeUV2717oveHc8WbKMA=;
        b=Nq33oUCdc5K03uQip2SwRTB+85PzcICyXnNY+lyVgxq1HC2ChNuJEzlzmlzV1fuEEK
         K4nivbz1kV3hK9QGZ+EutvU+T9FARg20mZb6UvrPFJC3ygdqtCCSueATdYMslShy1vLJ
         i9rHGrxaEeNJKyfpYtl52jxBjSo3Hvf3S2H3FBYzcA0FyztMQnynBdnkh08OXxAbFKBz
         kRT3nR3PFDcDM/tJFisaVgoR/nspIOpYmexav3S5QkcWwTpeiAmwN0ClnUhvw8fH5K9L
         qlL6yj1QxXc5saNCn5CLzRZOiZ5VjLhxDscWAl0eauCvsLCiiKBRJNE9rJPwPzD7ifYA
         rCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986302; x=1728591102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/Q6zs9U6Y2OkcbzA5fMA33TDeUV2717oveHc8WbKMA=;
        b=jIvMxFH8MarnVzIaUsngv8g+3ucbnTkIacrYi3vZNInckOi/nJ5uUmHccgnYOAZ9IC
         J9klviBifCZ0/pGsiAOQzeOqVhKtXopBhsDj/qsPd8s7fBFE+c2XVSImLBalEzDp1y3q
         Ks+LKQ2AN2CKtFPCWfr8l8SgSFDbQoF+EuYpcm6gHhIWJ/BMVcZPk0Wq9otxKhaj8Fiw
         rSbUPusIBqGttEj6BbaUhmew65lqQ/VdNB+JYZHA9SL0NL/b1qp9/019zYOW9a2kWujs
         o0Ak3IIP3uc9rFBC+Q/YAWPPxeTuBBljb7rOG0hq6pvo+vC6so/CsOe6y+VMeuDL3Ro9
         Dxpg==
X-Gm-Message-State: AOJu0Yzsd7K5qHpnr4sozGn2X9v/2FJRdw8FlY0zmK2Zyi8+ZRLJXTx2
	BSsYP/bLHCHI+8/qMl3cU16Qqi0dLSwiLgc423GcjFrY2YnjYS/V76C2UwVqqGJ4qPBW4I6YaVl
	+lYf9SFu4mfNT+SrSC5B4WhUn9UE=
X-Google-Smtp-Source: AGHT+IGna3eR7g9jqI4Q251Y2eAfSbMUfVCWulFBlC+zs6r1xqxwAN/WkBJzwz1dvLVCeSUWraAARNvnHFiuEygV0L0=
X-Received: by 2002:a17:90b:4a4c:b0:2da:61e1:1597 with SMTP id
 98e67ed59e1d1-2e1e636f476mr341350a91.36.1727986302253; Thu, 03 Oct 2024
 13:11:42 -0700 (PDT)
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
 <CAEjxPJ4RbypeHbdpWPXGRstDAWWiEv+-dCWXc1aAO+zpkxnkEg@mail.gmail.com> <CAEjxPJ5Co0P1sVYmAiD0WnquNv8XOMAyi09GCW3jTPqsvZEsGQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Co0P1sVYmAiD0WnquNv8XOMAyi09GCW3jTPqsvZEsGQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Oct 2024 16:11:30 -0400
Message-ID: <CAEjxPJ66z5x9AB7wT_SaOCjw+UY6DseMnmjqiMi93063xZ3t-w@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 2:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Oct 3, 2024 at 1:04=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Based on our discussion at the last project meeting, I removed the
> > requirement to unshare the network namespace when unsharing the
> > SELinux namespace by adding a check in selnl_notify() to only send the
> > SELinux netlink notifications to the init network namespace if the
> > triggering process is in the init SELinux namespace. Hence, the
> > creator of a child SELinux namespace can either choose to unshare the
> > network namespace if they want to receive such netlink notifications
> > (in which case they will be sent to that child network namespace
> > only), or they can just use the SELinux status page exported by
> > /sys/fs/selinux/status, which is the default in libselinux for kernels
> > that support it.
> >
> > With that change, I can now run all of the selinux-testsuite tests
> > successfully from a child SELinux namespace except for two labeled
> > IPSEC tests each for inet_socket/tcp, inet_socket/udp, and
> > inet_socket/mptcp. To fully pass the other tests, I had to also put
> > the parent namespace into permissive mode to avoid certain failures
> > due to MCS constraints in the base policy that can't be overridden via
> > the test policy. The remaining labeled IPSEC test failures are likely
> > due to the fact that the xfrm hooks are not passed a sock structure or
> > anything else from which I can obtain the appropriate SELinux
> > namespace to use so they are hardcoded to use the init SELinux
> > namespace and even when it is permissive, there are hardcoded SID
> > comparisons in those hooks that are likely failing.
> >
> > I also introduced configurable limits for the maximum number of
> > SELinux namespaces and for the maximum depth to which they can be
> > nested. The default values of each can be controlled via Kconfig
> > options, which default to 65535 and 32 respectively (matching user
> > namespaces), and can be further adjusted via /sys/fs/selinux/maxns and
> > /sys/fs/selinux/maxnsdepth respectively but only from the init SELinux
> > namespace (child namespaces can read but not modify them). A simple
> > pair of test scripts to recursively create SELinux namespaces
> > correctly failed when it hit the maxnsdepth and lowering the maxns
> > value correctly prevented exceeding that number of total namespaces.
> > These tests however exposed a couple of reference counting bugs in the
> > code (one for SELinux namespaces, one for the parent cred that we
> > cache in the task security blob for use in checks on the parent
> > namespace), which are now also fixed.
> >
> > I have completed converting all of the permission checks to use the
> > namespace-aware helpers or annotated them with comments indicating
> > when it is correct to only check against the current SELinux
> > namespace. For some of the checks, it is debatable as to which helper
> > should be used, so we may need to revisit some of these based on
> > experience.
> >
> > What remains to be done:
> > 1. Maybe rework how policy capabilities are being checked/used to
> > correctly support child namespaces with different policy capabilities
> > from the parent. I can do this for some simple cases by lifting the
> > logic to walk the namespaces up into the hook function itself and
> > checking the policy capability value in each namespace, but many
> > (most?) of the policy capabilities don't lend themselves to this
> > approach. For example, extended_socket_class enables finer-grained
> > socket security classes, but this is checked and applied when the
> > socket security blob is initialized, not at permission check time.
> > Unless we want to move the mapping logic to every permission check, I
> > am not sure what can be done there. Similarly, a number of policy
> > capabilities control labeling behaviors rather than permission checks,
> > and since we are no longer trying to support per-namespace object
> > SIDs/contexts, only one namespace's policy can be applied that label
> > will then be used for all subsequent checks even in the other
> > namespaces.
> >
> > 2. Decide if any further hardening of selinuxfs is required to safely
> > permit usage by potentially untrusted / less trusted processes in
> > child namespaces. There has already been a lot of work to harden e.g.
> > the policy loading logic against ill-formed policies and such, so not
> > sure if there is much to do here, but noting it. I would like to get
> > rid of /sys/fs/selinux/user altogether so possibly making it
> > inaccessible in child namespaces would be a good first step.
> >
> > 3. Optimize the implementation for the single SELinux namespace case,
> > reducing and/or eliminating the overhead introduced by the SELinux
> > namespace support for that common case. Lots of work to do here, help
> > welcome. Also would appreciate guidance on current benchmarking
> > practices since it has been a while since I've had to do that.
> >
> > 4. Revisit the userspace API for unsharing the SELinux namespace
> > if/when the rest is ready. Currently just "echo 1 >
> > /sys/fs/selinux/unshare" (followed by the other necessary steps for
> > unsharing the mount namespace, unmounting the parent's selinuxfs,
> > mounting a new selinuxfs for the child, loading a policy, and setting
> > enforcing mode). Options would include adding a CLONE_SECURITY flag to
> > unshare/clone that could be implemented by any/all LSMs via a call to
> > a new (stacked) LSM hook function, or one or more new LSM system calls
> > to do the same, or just keeping it the way it is via selinuxfs.
> >
> > Experimentation is welcome, particularly for more complex cases, e.g.
> > where the host policy and the child policy differ (no policy loaded on
> > host, policy in child; policy loaded on host, no policy in child; host
> > policy from one distribution/release; child from another, etc). Be
> > aware however that since the permission checks are applied to the
> > current namespace and its ancestors, the parent namespace may deny
> > something that would be allowed in the child, especially if the child
> > is using contexts that are unknown to the parent's policy (which will
> > be treated as unlabeled for those checks in the parent). Also be aware
> > that since we are no longer trying to support per-namespace object
> > SIDs/contexts, any object first instantiated in the parent namespace
> > will be labeled according to its policy, not the child's policy.
> >
> > The tree can be found at:
> > https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
> >
> > It may be re-based or changed at any time.
> > To experiment, after building and booting this kernel, do the following=
:
> > # Create root shell
> > sudo bash
> > # Unshare SELinux namespace
> > echo 1 > /sys/fs/selinux/unshare
> > id # Context is now "init" or "kernel" in child; ps -eZ from parent
> > will still show original context
> > # Unshare mount namespace and mount new selinuxfs for child SELinux nam=
espace
> > unshare -m
> > umount /sys/fs/selinux
> > mount -t selinuxfs none /sys/fs/selinux
> > # Load a policy into the child SELinux namespace, parent unaffected
> > load_policy
> > id # Context is now kernel_generic_helper_t on Fedora due to a default
> > transition in its policy
> > # Switch to a suitable security context before trying to go enforcing
> > runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
> > # Switch child to enforcing, checking that you didn't get killed once e=
nforcing
> > echo $$
> > setenforce 1
> > echo $$
> > # Do stuff in child, run testsuite (switch parent to permissive first
> > to avoid denials from it), etc.
>
> Oops, I see that the selinux tree re-based to 6.12-rc1, so now
> updating my branch to that.
> There are conflicts so it may take a little bit.

Wasn't too bad. Now re-based on 6.12-rc1.
