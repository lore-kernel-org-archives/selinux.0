Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5591BAEF6
	for <selinux@vger.kernel.org>; Wed, 11 Sep 2024 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085597; cv=none; b=RyTgaEDvcDRxlIAT2dKyfnYhhR/kcDInxax3d8hvIowAIzR7NjD4yniwc0N0aFI7T1wr7px+4pR0uuxzuCoOoCMEIwnwcndeK33eN3o2EyKiUvKX3bQQN/F9Xi4JpvPpj56s21R69LKTfSIBGnnSXet2mY0jZOND8xqSH9D9sWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085597; c=relaxed/simple;
	bh=5C3mMjAv3gZ5oXBUXogsbLgJJmCEKrLyr6OU69VssoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlryoymDMF7X5gaiskLdQXTQzllFhiH2069/siCyqfhhZXWnPDUMEvhKwvlycIhngekLnDrwhsX2aKeHyfyzLPcKElZXn9FJg4J6jeSV1UlfZ0D36s3aQdjES+ovbNz4Ex+18bt0Fz7eu0Jns0TNKSm/NK2C/g24n+XkDgvwZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH60sBfL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH60sBfL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so175917a91.0
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2024 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726085595; x=1726690395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C3mMjAv3gZ5oXBUXogsbLgJJmCEKrLyr6OU69VssoE=;
        b=TH60sBfLCtI8u9isTcrggIoFbO9bkUIb1mKSlsA65QcyvmCfI56wV8/dgvGztibPz/
         EapO+vEuMxElcCS+5zAZBa7h5Qh4Ytxbbmi9hJoKfjBm6XPgOCNvjrLd+cqZ4lTktkKt
         TIXc05TYxkFwzrMAdy9EgJtSnjxKxyy8RpiNEI3Mznny5WDA1YywJt+3Wu4It/gPM3M3
         j3Q4H5we6nwrCmW0/x81/fgEtOkL3WhiyuhGr8FXJVlRMAE9UrYxsR4aEdkk/IUytNem
         x/MDxg4/ogInUFy95pKXYluyGHNgIOHZqkgM5WudO2/0iujz4JLHbiGpk1n+LbUd6SyR
         fsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085595; x=1726690395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C3mMjAv3gZ5oXBUXogsbLgJJmCEKrLyr6OU69VssoE=;
        b=nHumU/o7SIedoYv9JqhVYfQeRR4OtMTea713NDV4BY0+iZzHHNoC8ySdCpJ/iZTev0
         ylK66/zCpZtBTc8bArLVI9J/wLVtQjalwm7TTdn7byiqP+hoA4pKMxL/ypg4itlIo3Pa
         OzcrthUuBMQkcsodrI2A4btKKEZJlaIUotlJ16b2b1gHgDQze/srQp0A6XzZJEud4QVr
         b0UL77goKMggQhCjHvxUrKporhirMWOai1gbDFlrtc4KSPIM1E65Ecwq1H7L3sbIqW6I
         6XTowfBgua7QHMZ+Aqu+R6s2Kpc4PhDzYkrx3pRWfnLEYzr02/4QYejDzBmLN3eqVb4C
         AReA==
X-Gm-Message-State: AOJu0Yz3aMrBRpXxGBCp669i1Sp1LRl0VISTXbVJ87CKJG66MOdtVIC2
	NtPbRgeA57DtzMAUS3BPOOhBK4BmUayOCjRyNMm8W4XeaUwUrn0ooPGQ2ekV2PoDy/j5mo9mUPH
	yWlzZmvxsht2GN7cKiBwtC9IoUhs=
X-Google-Smtp-Source: AGHT+IHeEsmCoznJZfEcwXHPI7JK/Y0mWcEuXEXYal1qe2r0M5VxwaCHLo3PlQcRyEMTnE20aGpasyEurIuBlTdjWIY=
X-Received: by 2002:a17:90a:9606:b0:2d3:c0ea:72b3 with SMTP id
 98e67ed59e1d1-2dba00826fcmr423437a91.34.1726085594864; Wed, 11 Sep 2024
 13:13:14 -0700 (PDT)
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
In-Reply-To: <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Sep 2024 16:13:03 -0400
Message-ID: <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 3:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> I finally got everything that requires global SIDs to use the new
> global SID table, now available in my branch,
> https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
>
> This proved to be more involved than I had anticipated; there are a
> number of subtleties in our handling of contexts and NetLabel was
> caching SIDs in two locations, one of which is read outside the
> security server (hence, required a global SID) and the other one is
> only directly read/written inside the security server (hence, can be
> mapped to/from global SIDs at the security server interface).
>
> With these changes, I could drop the changes for revalidating and
> updating inode, superblock, and open file SIDs per-namespace, so those
> have been dropped from the branch although still available in a
> working-selinuxns-beforeglobalsids branch for reference.
>
> The SELinux testsuite passes, including NFS tests, in the initial
> SELinux namespace, and everything except for the
> socket/networking-related and mac_admin tests pass in a child SELinux
> namespace. The socket/networking-related test failures are
> unsurprising, partly due to needing to also unshare the network
> namespace to avoid the SELinux netlink notifications from confusing
> the initial namespace's AVC (wrong/out-of-order policy seqno) and
> partly due to the fact that we do not yet have a way to associate the
> SELinux namespace for use in hooks that occur outside of process
> context. The mac_admin test failures are likewise unsurprising
> (getting/setting unmapped context values); I had similar issues with
> those tests even in the initial namespace before making some further
> specialized changes; I will see if I can get that to work properly in
> the child namespace too.
>
> Going back to the list of known issues to resolve and omitting the
> ones resolved by having global SIDs, we are left with the following:
>
> 1. Updating hook functions called outside of process context, e.g.
> task_kill, send_sigiotask, network input/forward, to use the correct
> SELinux namespace instead of using the current one; this requires
> storing a pointer to the SELinux namespace in some relevant data
> structure from which we can fetch it in those hook functions, e.g. the
> file or socket security blobs.

Pushed a revised commit to address the lingering mac_admin test
failure and added a new commit for #1 above, fixing the hooks called
outside of process context to use the correct SELinux namespace with
the exception of a couple xfrm hooks that don't appear to have ready
access to any object from which I can obtain the SELinux namespace
(e.g. no sock structure, just the xfrm and flow structures with no
place to save a namespace for later reference AFAICT).

I can now successfully run all of the selinux-testsuite except for the
inet_socket, sctp, and extended_socket_class tests from within a child
SELinux namespace created as per the instructions at the end of the
email. The extended_socket_class tests only fail on one test (creating
an AF_BLUETOOTH socket) with an "Address family not supported by
protocol" error that I suspect is merely due to running within a
non-init network namespace too (to avoid confusing the parent SELinux
namespace with netlink SELinux notifications from the child; failing
to unshare network namespace caused userspace policy enforcers to go
crazy when they received a policy seqno greater than their own
namespace's policy seqno). Similarly, most if not all of the inet and
sctp failures appear to be due to running in a separate network
namespace; netlabelctl falls over immediately with an error during
initialization.

Next up is tackling #2 below.

> 2. Updating the SELinux hook functions to check permissions against
> all ancestor namespaces rather than just the current one, and consider
> introducing a top-level global AVC to avoid the need to check against
> each per-namespace AVC on every check.
>
> 3. Providing a way to restrict or bound nesting of SELinux namespaces,
> particularly given the resource usage associated with loading a policy
> per-namespace and having a per-namespace AVC, sidtab, etc.
>
> 4. Hardening the policy loading code and other selinuxfs interfaces to
> support potentially unprivileged usage by child namespaces.
>
> 5. Optimizing the namespace support, global SID table, etc to avoid
> imposing significant overheads especially for the case where there is
> only a single namespace since that will likely remain the common case.
>
> Reminder on usage for anyone who wants to play with it:
> # Unshare the SELinux namespace
> echo 1 > /sys/fs/selinux/unshare
> # Unshare the mount and network namespaces
> # Required so that we can have our own private selinuxfs mount and
> # so that we can have our own private NETLINK_SELINUX socket.
> unshare -m -n
> # Unmount the parent namespace's selinuxfs and mount our new one.
> umount /sys/fs/selinux
> mount -t selinuxfs none /sys/fs/selinux
> # Load a policy into our namespace
> load_policy
> # Switch to a safe context
> runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
> # Go enforcing
> setenforce 1
