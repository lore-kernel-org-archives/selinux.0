Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABCF219CA2
	for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654699; cv=none; b=HtRJR03inWNeC9K19yzPA4hu1e7FqcjFBi9YlVrXiGLY2HYogSSf4u5I3JSvlhosg0aIi64y5XXJnJ0CntWQ41FpEX2ayBIKNQ3JldEy1VJMvl+7om2pPRNFg3DOGUOKkNAN4tYy0cZDHUZ3/cBihGR3y4zDG+eh4Py6VNHTF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654699; c=relaxed/simple;
	bh=FfbjgelyOf0h5duszNEH+n5952uEx4YGt8HEAndJmKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNsfd0pGMrLhJsGbTXt0y95HrO7U7y6MI2lO/Ee6aXeyJGJgCdnPZjx4SMX+ChCb0eFvsPpbyltvGru5U72cVU2kDRIAtV5oL6bC+1hBSfcAMu+Jf0dAMpHz6iV864Ou6yxEAE6kJTc9snxdYlNM83sDx8rJJdU6oOfYJa5c9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZNVUrrB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZNVUrrB"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71df1fe11c1so1707387b3a.2
        for <selinux@vger.kernel.org>; Fri, 11 Oct 2024 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728654697; x=1729259497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfbjgelyOf0h5duszNEH+n5952uEx4YGt8HEAndJmKI=;
        b=XZNVUrrB8fTblNaVicZatbsxSFFR1A1Z/oC4aZXXk66dN5p/e2QedYyVHwhOo7OGsA
         BAbr8kfOYahRZBj6rexkqs+t43RVnNXNgqenRwX3SBaGzufknRxGuAgs1e80Yi9khCqk
         CC2PbtS1FyWCflyi20LLgcXBY8jZ8hq2L6ifGTN+/8akAF4UaxkcQAupSW/VJDmWcRF3
         +HsRS7L4UTDCd2poB4ce4L2hHuL41oR1YZNLzOGOFuKVC2KaPe63jxTpS7YwJkQVNCls
         4gUGO0Rz2lJOepVWXw+LudDuYk7fAYL5qvS82PZ6qIX+sEXHuhQr4S33yVCmk/fJDrXZ
         ovMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728654697; x=1729259497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfbjgelyOf0h5duszNEH+n5952uEx4YGt8HEAndJmKI=;
        b=GNHnlAPDT8OJecHrlVyCNxhWPcB7J/IzUtIa6iw8nV0ALIRJDoAUF/VfDIMHbDy/qt
         b8HsWjchoZ+X6nErBzw66PV9x1f1WRthgrO1SSldb59lDunsU36SrohQqJGZ7YGbWDcg
         uywPN+eUHh5LaJhtaCX4Q5dxsoutKPKLrWVAmn7w7S2tUh9X8mon9Dt6RYaIFvK2ZdkG
         cL/uKXhiFRyFjAduIaNs/nONnlRd15PCL2WoY6hILirL4LIVP6HHmskz6f5AJhlMhMbl
         p3lls+Y+zxuwbxXq6s6FJH8NHOJV76jav18rNQdFiSzTckFTqQqOIihEAov2vSUX9eBJ
         tCEQ==
X-Gm-Message-State: AOJu0Yx3zIob73Ic5DY4NConqG9qgbB0Lg4N8Eyu8Rg669em/wdYB5sT
	UuDd1a2hXHqO17eTSiND03y/BTHLQMz6egScivpXRXyyHi/kmQardn+9jwSc7QNN+a6NtjHUKPN
	2QcOO+euw6zqym3xmsKARcd+O6vI=
X-Google-Smtp-Source: AGHT+IHj3/xNLnzppWHE9G55nyV1GXNR7ffTFpi0ZVv5u0UnsXqKL27JxfLo8Mak9hkcYnvUnC4fQtwRiWrq+36OsR8=
X-Received: by 2002:a05:6a21:3511:b0:1d8:ae07:c02 with SMTP id
 adf61e73a8af0-1d8bcfc38cbmr3488178637.47.1728654696956; Fri, 11 Oct 2024
 06:51:36 -0700 (PDT)
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
 <CAEjxPJ7vMQ6SBVXUjfG+3XvHdkCvSO=fBwftFdt9kTfLrPzr_Q@mail.gmail.com>
 <CAEjxPJ6Kg4P8DBhG_JZj_U61PwyJF0jVJXX3QsLMrduR7RzrPg@mail.gmail.com>
 <CAEjxPJ6PevN1XCyqsC2gT3mXt4h78ed_=AiZBT+Q_oanx2DRdA@mail.gmail.com> <CAEjxPJ59ypVNV=oeYAgqZhdB+CQacjtgribCorXuoODe0JXnxw@mail.gmail.com>
In-Reply-To: <CAEjxPJ59ypVNV=oeYAgqZhdB+CQacjtgribCorXuoODe0JXnxw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Oct 2024 09:51:25 -0400
Message-ID: <CAEjxPJ7Pv_OHiYspdpWHiaEkH0XBQpThn6+ZiuycR-0k-4e_yA@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Oct 9, 2024 at 3:25=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Oct 9, 2024 at 1:57=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Oct 9, 2024 at 9:09=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Tue, Oct 8, 2024 at 9:32=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > Re-based again on top of latest selinux/dev to resolve the confli=
cts
> > > > > with the just-merged patches and to update the new netlink xperm
> > > > > support for SELinux namespaces. Passes the selinux-testsuite incl=
uding
> > > > > the (not yet merged) nlmsg tests in both the init SELinux namespa=
ce
> > > > > and a child SELinux namespace (modulo the labeled IPSEC tests and=
 with
> > > > > the init SELinux namespace permissive for testing the child or
> > > > > modifying the init namespace policy to permit it to run all the t=
ests
> > > > > in the child context). Functionally, this is nearly complete as f=
ar as
> > > > > SELinux-only changes go (not including the corresponding work nee=
ded
> > > > > to namespace audit and if desired/necessary, to allow namespacing=
 of
> > > > > the labeled IPSEC hooks), modulo any bugs that get discovered in
> > > > > trying to create real containers with their own SELinux namespace=
s and
> > > > > different combinations of policies between the host OS and the
> > > > > containers.
> > > > >
> > > > > My remaining ToDo list is as follows, but this is a good point fo=
r
> > > > > others to provide feedback or experiment with the functionality o=
r
> > > > > propose their favorite container runtime for the next stages of
> > > > > prototyping. If it would help spark feedback, I could post the cu=
rrent
> > > > > set of kernel patches to the list.
> > > > >
> > > > > - Test creation/use of SELinux namespaces from actual containers =
with
> > > > > different policies from the host OS. This may require patching a
> > > > > container runtime to add support for unsharing the SELinux namesp=
ace
> > > > > and unmounting the old selinuxfs prior to starting the container =
init.
> > > > > Combinations to test: No policy loaded on host, policy loaded in
> > > > > container e.g. Fedora on Ubuntu; host with newer base policy than
> > > > > container e.g. RHEL/Rocky 8/9 on Fedora; container with newer bas=
e
> > > > > policy than host e.g. Fedora on RHEL/Rocky 8/9; host and containe=
r
> > > > > with different upstream policy sources e.g. Ubuntu on Fedora; And=
roid
> > > > > container on Linux host OS.
> > > >
> > > > To help get this started, I created a patch for libselinux to provi=
de
> > > > a selinux_unshare() API that unshares the SELinux namespace (hiding
> > > > the current messy internal details of the existing kernel interface
> > > > and also dealing with various situations under which it might be
> > > > called by container runtimes with selinuxfs already mounted, bind
> > > > mounted read-only, or not mounted at all) along with a sample
> > > > unshareselinux utility that shows how to use it, and a patch for
> > > > systemd-nspawn to show how it might be called from a container runt=
ime
> > > > to unshare the SELinux namespace during container creation. These c=
an
> > > > be found the selinuxns branches of my selinux userspace and systemd
> > > > forks at:
> > > > https://github.com/stephensmalley/selinux/tree/selinuxns
> > > > and
> > > > https://github.com/stephensmalley/systemd/tree/selinuxns
> > > > respectively.
> > > >
> > > > While the patches appear to work correctly (i.e. you end up with a =
new
> > > > SELinux namespace, after which you can mount a new selinuxfs that i=
s
> > > > private to your namespace, load a policy, set enforcing mode, etc),
> > > > unfortunately it appears that systemd doesn't just do the Right Thi=
ng
> > > > automatically when it is invoked as a container init after unsharin=
g
> > > > the SELinux namespace, i.e. it does not proceed to call the SELinux
> > > > setup functionality so it never tries to mount selinuxfs and load a
> > > > policy within the container. Unsurprising but it does mean that
> > > > someone will need to modify it to do so in this case while ensuring
> > > > that this doesn't break existing setups without the SELinux namespa=
ce
> > > > functionality.
> > >
> > > Pushed up a further commit to the branch on my fork of systemd to hav=
e
> > > it call the SELinux setup + init functions if invoked from
> > > systemd-nspawn with the SELinux namespace unshared. The existing
> > > systemd was skipping setup/init of all of the MAC modules if running
> > > in a container, which was understandable absent namespace support. My
> > > current patch (just to allow further progress) only relaxes that
> > > constraint for SELinux and only if launched via systemd-nspawn with
> > > the --selinux-namespace option; this would of course be generalized
> > > further if/when we get around to upstreaming it. With that change and
> > > installing the modified systemd into the container root filesystem, I
> > > can start a container via systemd-nspawn with the --selinux-namespace
> > > option and have it unshare the SELinux namespace, load policy from th=
e
> > > container's root, and set its enforcing mode. At present, if the
> > > container is configured to be enforcing, the container will fail due
> > > to denials in the child SELinux namespace arising from the following:
> > > - systemd creates a regular tmpfs mount for the container /dev, so at
> > > least some of the /dev nodes are not correctly labeled at startup.
> > > This can likely be fixed through some combination of policy and
> > > perhaps performing a restorecon("/dev") after first loading policy.
> > > - Certain /proc/sys files in the container are labeled with
> > > "unlabeled_t" for some reason, likely due to being accessed n the
> > > namespace before it loads a policy and not getting initialized
> > > afterward. Similarly could be fixed via a restorecon("/proc") after
> > > policy load if we can't solve it kernel-side.
> >
> > Sorry, obviously can't do a restorecon of /proc so that's not an option=
.
> > I suspect that the existing selinux_complete_init() walk of
> > uninitialized superblocks and their inodes after first policy load
> > isn't getting done properly for child SELinux namespaces; will have to
> > look into that on the kernel side.
>
> Yes, that was the issue. Fixed with another commit pushed up to the
> working-selinuxns branch of my selinux-kernel fork. So the /proc
> labeling is fixed within the container. Still have the other denials
> to address but those might all be userspace or policy fixes.

Ok, I confirmed that the remaining denials are due to multiple tmpfs
mounts and a socket created by systemd-nspawn during setup of the
container that are then used by the container at runtime, and I
confirmed that allowing those permissions in the container policy
enables a Fedora container to boot in enforcing mode with its own
SELinux namespace on a Fedora host in enforcing mode. Ultimately we
will want the container runtime (systemd-nspawn in this case) to
properly label those tmpfs mounts and the socket but that's just a
matter of further userspace changes to systemd-nspawn.

Still lots to do to allow more interesting combinations but I'll leave
it there for a bit and see if anyone is actually interested in this
besides me...
