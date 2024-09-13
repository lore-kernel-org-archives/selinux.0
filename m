Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5D26289
	for <selinux@vger.kernel.org>; Fri, 13 Sep 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240757; cv=none; b=lHNa7MKff5JQbMFM/wKOCwLQxzNYGGzEKLBcwC3Ps0tz0nRDKIOZWhqeh0fjBps/01Qo46W7wQz13XCsQ+9e28FnYqLYZ+51xjR4rRPayJpdQistN73RuoCeZOWiEFNpWjuvl+xIHwlEpHcSPphlMs0wyvWwhu+s5egM7ozx8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240757; c=relaxed/simple;
	bh=yyIJQ9DxLZ1Z/Lj0AzCaQsd5AjGwgPCWJSLUuY7TZB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hltJEN/ZBSfM6AsVOFFvo2JQdLOgdWdDmZyrXvIirELGv/ZVHcfApFtaAwK5CcRewN4hyD5TD4OAU5odUXxrTOGYUd8vQpT485nH5IVPOwMTaXuvI3BrSdTRCf1QXkMPdwjyWDg0EwMP+h7JxS+PVCh//dHCpg84Tg9L9es9GKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWLjB2y5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWLjB2y5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so965883a91.2
        for <selinux@vger.kernel.org>; Fri, 13 Sep 2024 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240755; x=1726845555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM/W8JzA7cpg4Geho0v3RuxtFF4EI1uQH2wbDW3x3ds=;
        b=fWLjB2y5IOL3QskyhUfmI245HvRw3FzWjuvvPUFTTaNDchkpRCQoYUJVDw0gx+BT4o
         8ASnju5Gg6zQHP/uX88l6zFoeFCxyKTNJ7U/5SlHDvipBzYeSBFNMl1oydc3PZna7H0z
         MBXWM0aOojMJK0nGg+M0W4VxxSD2oOKz9lDCvpNFa3dLlkYxsGPFVef9Jiqt//T1sguM
         UVoskLXMmn6XefXRD8Rm7r5evAwfHhoUro+CmrcS5RpYPNpVdcDr6ChG9MOCTKHEuy3z
         WbXC5nzKTN6pkl178r2wSvDgRaC7UpZFqftlcxu8F7pJXOFKqH5EpPqfJaKkof3Q2JUW
         Cnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240755; x=1726845555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM/W8JzA7cpg4Geho0v3RuxtFF4EI1uQH2wbDW3x3ds=;
        b=xJ9mCXf5C6GoE8pIahRNIsHQBa0hWz82ghVkI3L0OVyU5uwS4eCt3e/+NUkFdir4X7
         gfcZAjLVfg0XbBOQMEITxdzaqssvquv0Smq7o7rEhzh17X3Z5QEXh/ywy6yjGjKAyBbA
         H6kwNs4yT1QAjXBZ6sT85UKVkFouGJwsneZbJRnThHgIUK+Y1ugT4Zwy0hTjaukp8zmn
         HHAAuQGMQBwQzDcwf0/lZ009jdA43A3vSe9AYiqJk+l+mZNXOrwSUXpfnrr2QplmsLOt
         fXmdTEex1PKY7UuA7sozXqXEkLoa8h+zEr46uxlifXe4siKpoVdUuEAw0gwaZJJCGyAV
         CLNQ==
X-Gm-Message-State: AOJu0YxMzj11MRYavMojIt9qnab+KF2hVcgNXF2xa+ZGzQIJxaRnBFBV
	8sF/dWZ9oi6OnfjxXK6rAIz27C2D6/POCb+6KNqzZkeh4Cn75yqrp+31OoqRz9qaA/3Q5kVMz1l
	A+TEEQzxWp/bKAjqVkiZKcECywio=
X-Google-Smtp-Source: AGHT+IFfZ5siQ+thRUWP1SVoq9hh8Otv9qFW1FiFhrnYXF4Plkqb4yyhXKpbe7b2SsQoM7DAdSmjQ+XiGtRSP07/e40=
X-Received: by 2002:a17:90a:aa0b:b0:2d8:8920:771c with SMTP id
 98e67ed59e1d1-2dbb9f3a6ccmr4075118a91.32.1726240754684; Fri, 13 Sep 2024
 08:19:14 -0700 (PDT)
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
 <CAEjxPJ4nbCuntgTvrGk4LHs+ZYjm95ZwwSwwAycWWzS9dt9Tyw@mail.gmail.com> <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
In-Reply-To: <CAEjxPJ76MdNwgXtGTgVYGKE87=7GmZywQ1GJn5Vz8jjCdVATWA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Sep 2024 11:19:03 -0400
Message-ID: <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 10, 2024 at 3:13=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> Next up is tackling #2 below.
>
> > 2. Updating the SELinux hook functions to check permissions against
> > all ancestor namespaces rather than just the current one, and consider
> > introducing a top-level global AVC to avoid the need to check against
> > each per-namespace AVC on every check.

I've now pushed another commit that introduces new permission checking
functions that are namespace-aware and started converting some of the
hook functions to use them, beginning with checks between a cred and a
target task, e.g. selinux_task_kill().  With this change, I verified
that a process in a child namespace could NOT violate the policy of
the parent when sending signals. There remains a lot of work to
convert the rest of the permission checks to do the same. Reproducing
this particular case can be done as follows:

# Temporarily switch to permissive to allow the following runcon to work
sudo setenforce 0
# Switch to a confined user
runcon staff_u:staff_r:staff_t:s0-s0:c0.c1023 /bin/bash
# Switch back to enforcing mode
sudo setenforce 1
# Become root, still as a staff user/role/domain
sudo bash
# Unshare SELinux namespace
echo 1 > /sys/fs/selinux/unshare
# Unshare mount and network namespaces for selinuxfs and
NETLINK_SELINUX isolation
unshare -m -n
# Unmount the parent's selinuxfs and mount our own private instance
umount /sys/fs/selinux
mount -t selinuxfs none /sys/fs/selinux
# Load a policy into our namespace, prior to this we don't have one
load_policy
# Switch to unconfined in our namespace
runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
# Check enforcing mode in our namespace, should be permissive still
getenforce
# Try to kill a process running unconfined in the parent namespace
# Get a PID from a ps -eZ from a shell in the parent namespace not here.
kill <pid-of-unconfined-process-in-parent>
# Should get Permission denied due to parent denying access.

Next step is to introduce additional namespace-aware permission
checking functions that take things other than just cred-to-task and
convert additional permission checks in the hook functions to use
them.
