Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C915CD49
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501932; cv=none; b=IrvbMbptc7/oL0RzctR/UAoqp/jvVk3KYZUFjMmk1zE9jacope2wptyRHCl/LpjH9XsGN9jxyRjOKTV7N9NplwvEglof1LlM1IOCvfs1e+N3Lk8a0b9URZ3ImYoay53hokYyBOUlSLkwKOxHXLILzbymmNNtTL/KNyZBNAuzDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501932; c=relaxed/simple;
	bh=O/wMv7I0pOFjoS92bloX84bmdKeQeiXeMMkYV7Xg8jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFoeyIHHy2G94JtXUdSbnL4J6YLP6KxXrjNI9TCcTpfBGK1+dray7IZnT5XglUUhqZBJO7oNGldYev2JavrvMIvvzgx8wJka6TQYeqGHUPgIpy0CF5XY6cTX/7vMVJKLyBn1iswJpjECAwmonSzsZm295VVfiNGxAQQVRBjlxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiCCNS0h; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiCCNS0h"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea24595bccso60675a12.2
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2024 12:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728501930; x=1729106730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/wMv7I0pOFjoS92bloX84bmdKeQeiXeMMkYV7Xg8jI=;
        b=kiCCNS0h+Wm8oHW56ipIEDf3lr3HpCLO0OkksEBzY3nnjnCWvm6pWoujxkSUZq1WXR
         9cp+CTrh2MwqERL3kNPYRPgtLz1xuIRtUHegoXDMN51KLDXSCr6ZIZBDcNpDfw9N5ni4
         oWZjmOrpiIRsZkjnuNeXPW/3dUCHRR45/gFpZGT5R2Tx0F5Y+5gsFCVbYyHI8UOS7+20
         Ox+m84DIGmqiDGvxx8pquPBi1lXSYCotbPk2LWNJgGp/rGSyGkWow4ysdoErxkDS5BiA
         TcxUtHsDKMrcuN6Ende+mVk+65+OUKdtJvJhpQnz5qfBMFvqDsK7ALxFML9aIBxQWRWa
         2A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728501930; x=1729106730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/wMv7I0pOFjoS92bloX84bmdKeQeiXeMMkYV7Xg8jI=;
        b=FWK1rPymVVKoCKfLr4u1kTANp2c6wo8AqOJeY7g6f1d6jC8/Agefh+mWzwPck3xEOL
         b81GwX9YhEuCK/MdrNuADNrcH13Xn1mgnrR/37x58FZ02+cB2TPYH2EWmDja+6T34z3O
         TNBskW2Is5wE9GlcoYWl4gPJEcaoKJAdooeI/zAbDPuMWQATtIGRPeN0/DYc6OUfpZJr
         943C+m/PrvJT1zOWKtb2PQgHwozWmS1JjzF7b82XX25TusImE7ndLVjEUw7nEaUA9f6v
         uSbciVi0S4BAG34v20+QtR2c0RxfXsQw/XL7EG3Q9AYh+t6+B+oWV2biQ9TPKvl1d+pG
         gDww==
X-Gm-Message-State: AOJu0Yx2cAMXCEq170UeJuy+UMagueDZQxXFaBTKvha2lYlsYI+BUQp4
	0csPDxRopsKLwqXCWxT/EN/ia0WhK2Ydq2Qu65A5wFmq00qenQ8Fnr2qS3MV4Upm0lIV71XrhJW
	Mh2diSGFsX43vIlpoEuMTn6WJ67Q=
X-Google-Smtp-Source: AGHT+IGw+l6LTgFgPnNs+hD7ZJtWsc/tjiowpucmec8s0l5TRIkqOb+nGmIgvZMIICH8CZvc6IBreXKjxJuhlVaDUio=
X-Received: by 2002:a05:6a21:4d8c:b0:1cf:6baf:61c0 with SMTP id
 adf61e73a8af0-1d8a3c490e1mr5011198637.44.1728501929821; Wed, 09 Oct 2024
 12:25:29 -0700 (PDT)
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
 <CAEjxPJ5duopAZs2tf5yK+w9-p_UB8ijAHoQXtWDMYJ9keiyRbA@mail.gmail.com>
 <CAEjxPJ4S9Z1WOpcDNJ5t4vCuHM4DqAr2jLscSiPJrARr6QPJfA@mail.gmail.com>
 <CAEjxPJ7vMQ6SBVXUjfG+3XvHdkCvSO=fBwftFdt9kTfLrPzr_Q@mail.gmail.com> <CAEjxPJ6Kg4P8DBhG_JZj_U61PwyJF0jVJXX3QsLMrduR7RzrPg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Kg4P8DBhG_JZj_U61PwyJF0jVJXX3QsLMrduR7RzrPg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 9 Oct 2024 15:25:18 -0400
Message-ID: <CAEjxPJ6PevN1XCyqsC2gT3mXt4h78ed_=AiZBT+Q_oanx2DRdA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:57=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Oct 9, 2024 at 9:09=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Oct 8, 2024 at 9:32=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Re-based again on top of latest selinux/dev to resolve the conflicts
> > > with the just-merged patches and to update the new netlink xperm
> > > support for SELinux namespaces. Passes the selinux-testsuite includin=
g
> > > the (not yet merged) nlmsg tests in both the init SELinux namespace
> > > and a child SELinux namespace (modulo the labeled IPSEC tests and wit=
h
> > > the init SELinux namespace permissive for testing the child or
> > > modifying the init namespace policy to permit it to run all the tests
> > > in the child context). Functionally, this is nearly complete as far a=
s
> > > SELinux-only changes go (not including the corresponding work needed
> > > to namespace audit and if desired/necessary, to allow namespacing of
> > > the labeled IPSEC hooks), modulo any bugs that get discovered in
> > > trying to create real containers with their own SELinux namespaces an=
d
> > > different combinations of policies between the host OS and the
> > > containers.
> > >
> > > My remaining ToDo list is as follows, but this is a good point for
> > > others to provide feedback or experiment with the functionality or
> > > propose their favorite container runtime for the next stages of
> > > prototyping. If it would help spark feedback, I could post the curren=
t
> > > set of kernel patches to the list.
> > >
> > > - Test creation/use of SELinux namespaces from actual containers with
> > > different policies from the host OS. This may require patching a
> > > container runtime to add support for unsharing the SELinux namespace
> > > and unmounting the old selinuxfs prior to starting the container init=
.
> > > Combinations to test: No policy loaded on host, policy loaded in
> > > container e.g. Fedora on Ubuntu; host with newer base policy than
> > > container e.g. RHEL/Rocky 8/9 on Fedora; container with newer base
> > > policy than host e.g. Fedora on RHEL/Rocky 8/9; host and container
> > > with different upstream policy sources e.g. Ubuntu on Fedora; Android
> > > container on Linux host OS.
> >
> > To help get this started, I created a patch for libselinux to provide
> > a selinux_unshare() API that unshares the SELinux namespace (hiding
> > the current messy internal details of the existing kernel interface
> > and also dealing with various situations under which it might be
> > called by container runtimes with selinuxfs already mounted, bind
> > mounted read-only, or not mounted at all) along with a sample
> > unshareselinux utility that shows how to use it, and a patch for
> > systemd-nspawn to show how it might be called from a container runtime
> > to unshare the SELinux namespace during container creation. These can
> > be found the selinuxns branches of my selinux userspace and systemd
> > forks at:
> > https://github.com/stephensmalley/selinux/tree/selinuxns
> > and
> > https://github.com/stephensmalley/systemd/tree/selinuxns
> > respectively.
> >
> > While the patches appear to work correctly (i.e. you end up with a new
> > SELinux namespace, after which you can mount a new selinuxfs that is
> > private to your namespace, load a policy, set enforcing mode, etc),
> > unfortunately it appears that systemd doesn't just do the Right Thing
> > automatically when it is invoked as a container init after unsharing
> > the SELinux namespace, i.e. it does not proceed to call the SELinux
> > setup functionality so it never tries to mount selinuxfs and load a
> > policy within the container. Unsurprising but it does mean that
> > someone will need to modify it to do so in this case while ensuring
> > that this doesn't break existing setups without the SELinux namespace
> > functionality.
>
> Pushed up a further commit to the branch on my fork of systemd to have
> it call the SELinux setup + init functions if invoked from
> systemd-nspawn with the SELinux namespace unshared. The existing
> systemd was skipping setup/init of all of the MAC modules if running
> in a container, which was understandable absent namespace support. My
> current patch (just to allow further progress) only relaxes that
> constraint for SELinux and only if launched via systemd-nspawn with
> the --selinux-namespace option; this would of course be generalized
> further if/when we get around to upstreaming it. With that change and
> installing the modified systemd into the container root filesystem, I
> can start a container via systemd-nspawn with the --selinux-namespace
> option and have it unshare the SELinux namespace, load policy from the
> container's root, and set its enforcing mode. At present, if the
> container is configured to be enforcing, the container will fail due
> to denials in the child SELinux namespace arising from the following:
> - systemd creates a regular tmpfs mount for the container /dev, so at
> least some of the /dev nodes are not correctly labeled at startup.
> This can likely be fixed through some combination of policy and
> perhaps performing a restorecon("/dev") after first loading policy.
> - Certain /proc/sys files in the container are labeled with
> "unlabeled_t" for some reason, likely due to being accessed n the
> namespace before it loads a policy and not getting initialized
> afterward. Similarly could be fixed via a restorecon("/proc") after
> policy load if we can't solve it kernel-side.

Sorry, obviously can't do a restorecon of /proc so that's not an option.
I suspect that the existing selinux_complete_init() walk of
uninitialized superblocks and their inodes after first policy load
isn't getting done properly for child SELinux namespaces; will have to
look into that on the kernel side.

> - sendto permission denied from kernel_t and from init_t to
> unconfined_t:unix_dgram_socket; this is likely the container sending
> to a socket in the parent namespace.
>
> There are no doubt more beyond these. However, in permissive (with the
> parent/init namespace still enforcing), the container did come up
> fully and sees SELinux as enabled.
