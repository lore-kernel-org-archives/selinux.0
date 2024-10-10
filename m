Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB11CF7B8
	for <selinux@vger.kernel.org>; Thu, 10 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570653; cv=none; b=s6zQcqQ51R3oRUANWPZ8AWdtEHd4irAWOl3StDb9nV9KZr9G30p2TqNVREyePxbFE208fkguGQ72T91Cxz/7bfkuIlKfvbEMnt4Ii00mZe/plrKJBmCfAynnKXRNpeK2kGHJzKrmAqWDIQ4ccds5m7LSQKhBqZK1nlB+SXtcoY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570653; c=relaxed/simple;
	bh=vP7pWEe47k3AaPaXf46W/4/Q8OmXRQgPyqjhlv/gjVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPk5ltn5WiT/WE9oR45buYeO5LZ7KyBrcg5gvKX3zhybG4ofygkUNSR4Jo3RtgDMta0CIlwaou5X4KG3xE3EWluMjmwNkY81I+AQ4L9ZY7Kwrc5VmZgwWaFffeu1iEf5Pl7+FMOlSINxn1a1zkPEKwMSgKvyF8WU6E1wwM1Z6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICMpZuWR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICMpZuWR"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2887c3c50so787002a91.0
        for <selinux@vger.kernel.org>; Thu, 10 Oct 2024 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728570651; x=1729175451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP7pWEe47k3AaPaXf46W/4/Q8OmXRQgPyqjhlv/gjVg=;
        b=ICMpZuWRAzWPJIoqU4m26wFo2fapw1CjWzhbWi0bzqVUMMTNqhXo3Cb7y0sel9pH/q
         t+yZfqBWXaJkkXXa9ztFsrKneZz8kv7ZdYbF1P9irB+RKikxk/9u2yyetoZ22rtL/u2J
         PWgKfzRBtHmMqVygQDyPeDPLMP9CxXDFBvpdX19D2JdQZr8AkkpXgJYRfFIYHo1Vusrj
         ZRfSrGqmGoCih5g98zHZnxyymkjhr+jO1u0iZ9vBmhIVbILo5Ocvb9p869E5qxLs1isp
         VtZEvRkN5AcRN5YfG/5EPrBl1ADbm0caURox6cLQISb2WjMI1HQbunqaMVtHMn9EfxcY
         brDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570651; x=1729175451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP7pWEe47k3AaPaXf46W/4/Q8OmXRQgPyqjhlv/gjVg=;
        b=BS2XWkyFdLida8dsuVPScJQSqoQycQwGZkyFfR7U7+0gA5hHbJnopjGDJeX7dYwo0a
         4e3/CFdTp8cXEjzXSXNpbeplU8p8lgl3Qi7Vq3YuQnso1x08wvx6k3bQ2feRdFSdBKRt
         L2u7zntiG6l+E+vGEwVH9HM2brc0uiZmuzDEJ500ijf2I3tOz38M2dnAAdBbqp++KifQ
         r9uoE0F76i8VYzhy0TD+JntaAjaqi4OPhuQYSavbXCGGo6lV9Aj361w4x7Xf6OUsNbCc
         DCisJmbEs5IAXdM4/P9+oDcT77cwg8H2JnPzw6Z90fiLbGHw4qxqwAGMVSB6ogPf0qrf
         q2DA==
X-Gm-Message-State: AOJu0YwTD1zRYI1yLS77mfR+TY/ZnltI1UGgTd3pGzHY9SclyLhRae9R
	UeAX4Hm5t9g0GBO9jkFX1TX3dPywNi45iR6pOKKnm74Gxglq0wPA4kpmsyrBp8acq3sVyB1LH3/
	lH/2IGgi8/abp85xk/MxS1eT38RLEdg==
X-Google-Smtp-Source: AGHT+IH9cxrpdtT3In4uXPmTHeYaBnKUZGbLBWflIt/1aPs/t96R5YkWE/QJJncw05EggeeDr5gjsW8fcVWzq0fMMek=
X-Received: by 2002:a17:90b:3b84:b0:2e2:e91b:f0d3 with SMTP id
 98e67ed59e1d1-2e2e91bf3b9mr391726a91.29.1728570650959; Thu, 10 Oct 2024
 07:30:50 -0700 (PDT)
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
 <CAEjxPJ6Kg4P8DBhG_JZj_U61PwyJF0jVJXX3QsLMrduR7RzrPg@mail.gmail.com> <CAEjxPJ6PevN1XCyqsC2gT3mXt4h78ed_=AiZBT+Q_oanx2DRdA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6PevN1XCyqsC2gT3mXt4h78ed_=AiZBT+Q_oanx2DRdA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 10 Oct 2024 10:30:39 -0400
Message-ID: <CAEjxPJ59ypVNV=oeYAgqZhdB+CQacjtgribCorXuoODe0JXnxw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 3:25=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Oct 9, 2024 at 1:57=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Oct 9, 2024 at 9:09=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, Oct 8, 2024 at 9:32=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > Re-based again on top of latest selinux/dev to resolve the conflict=
s
> > > > with the just-merged patches and to update the new netlink xperm
> > > > support for SELinux namespaces. Passes the selinux-testsuite includ=
ing
> > > > the (not yet merged) nlmsg tests in both the init SELinux namespace
> > > > and a child SELinux namespace (modulo the labeled IPSEC tests and w=
ith
> > > > the init SELinux namespace permissive for testing the child or
> > > > modifying the init namespace policy to permit it to run all the tes=
ts
> > > > in the child context). Functionally, this is nearly complete as far=
 as
> > > > SELinux-only changes go (not including the corresponding work neede=
d
> > > > to namespace audit and if desired/necessary, to allow namespacing o=
f
> > > > the labeled IPSEC hooks), modulo any bugs that get discovered in
> > > > trying to create real containers with their own SELinux namespaces =
and
> > > > different combinations of policies between the host OS and the
> > > > containers.
> > > >
> > > > My remaining ToDo list is as follows, but this is a good point for
> > > > others to provide feedback or experiment with the functionality or
> > > > propose their favorite container runtime for the next stages of
> > > > prototyping. If it would help spark feedback, I could post the curr=
ent
> > > > set of kernel patches to the list.
> > > >
> > > > - Test creation/use of SELinux namespaces from actual containers wi=
th
> > > > different policies from the host OS. This may require patching a
> > > > container runtime to add support for unsharing the SELinux namespac=
e
> > > > and unmounting the old selinuxfs prior to starting the container in=
it.
> > > > Combinations to test: No policy loaded on host, policy loaded in
> > > > container e.g. Fedora on Ubuntu; host with newer base policy than
> > > > container e.g. RHEL/Rocky 8/9 on Fedora; container with newer base
> > > > policy than host e.g. Fedora on RHEL/Rocky 8/9; host and container
> > > > with different upstream policy sources e.g. Ubuntu on Fedora; Andro=
id
> > > > container on Linux host OS.
> > >
> > > To help get this started, I created a patch for libselinux to provide
> > > a selinux_unshare() API that unshares the SELinux namespace (hiding
> > > the current messy internal details of the existing kernel interface
> > > and also dealing with various situations under which it might be
> > > called by container runtimes with selinuxfs already mounted, bind
> > > mounted read-only, or not mounted at all) along with a sample
> > > unshareselinux utility that shows how to use it, and a patch for
> > > systemd-nspawn to show how it might be called from a container runtim=
e
> > > to unshare the SELinux namespace during container creation. These can
> > > be found the selinuxns branches of my selinux userspace and systemd
> > > forks at:
> > > https://github.com/stephensmalley/selinux/tree/selinuxns
> > > and
> > > https://github.com/stephensmalley/systemd/tree/selinuxns
> > > respectively.
> > >
> > > While the patches appear to work correctly (i.e. you end up with a ne=
w
> > > SELinux namespace, after which you can mount a new selinuxfs that is
> > > private to your namespace, load a policy, set enforcing mode, etc),
> > > unfortunately it appears that systemd doesn't just do the Right Thing
> > > automatically when it is invoked as a container init after unsharing
> > > the SELinux namespace, i.e. it does not proceed to call the SELinux
> > > setup functionality so it never tries to mount selinuxfs and load a
> > > policy within the container. Unsurprising but it does mean that
> > > someone will need to modify it to do so in this case while ensuring
> > > that this doesn't break existing setups without the SELinux namespace
> > > functionality.
> >
> > Pushed up a further commit to the branch on my fork of systemd to have
> > it call the SELinux setup + init functions if invoked from
> > systemd-nspawn with the SELinux namespace unshared. The existing
> > systemd was skipping setup/init of all of the MAC modules if running
> > in a container, which was understandable absent namespace support. My
> > current patch (just to allow further progress) only relaxes that
> > constraint for SELinux and only if launched via systemd-nspawn with
> > the --selinux-namespace option; this would of course be generalized
> > further if/when we get around to upstreaming it. With that change and
> > installing the modified systemd into the container root filesystem, I
> > can start a container via systemd-nspawn with the --selinux-namespace
> > option and have it unshare the SELinux namespace, load policy from the
> > container's root, and set its enforcing mode. At present, if the
> > container is configured to be enforcing, the container will fail due
> > to denials in the child SELinux namespace arising from the following:
> > - systemd creates a regular tmpfs mount for the container /dev, so at
> > least some of the /dev nodes are not correctly labeled at startup.
> > This can likely be fixed through some combination of policy and
> > perhaps performing a restorecon("/dev") after first loading policy.
> > - Certain /proc/sys files in the container are labeled with
> > "unlabeled_t" for some reason, likely due to being accessed n the
> > namespace before it loads a policy and not getting initialized
> > afterward. Similarly could be fixed via a restorecon("/proc") after
> > policy load if we can't solve it kernel-side.
>
> Sorry, obviously can't do a restorecon of /proc so that's not an option.
> I suspect that the existing selinux_complete_init() walk of
> uninitialized superblocks and their inodes after first policy load
> isn't getting done properly for child SELinux namespaces; will have to
> look into that on the kernel side.

Yes, that was the issue. Fixed with another commit pushed up to the
working-selinuxns branch of my selinux-kernel fork. So the /proc
labeling is fixed within the container. Still have the other denials
to address but those might all be userspace or policy fixes.

>
> > - sendto permission denied from kernel_t and from init_t to
> > unconfined_t:unix_dgram_socket; this is likely the container sending
> > to a socket in the parent namespace.
> >
> > There are no doubt more beyond these. However, in permissive (with the
> > parent/init namespace still enforcing), the container did come up
> > fully and sees SELinux as enabled.
