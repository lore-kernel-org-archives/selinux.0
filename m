Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDB158521
	for <selinux@vger.kernel.org>; Fri, 27 Sep 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448551; cv=none; b=PUP1sTIHDBZOMvdcE5f+NrVNxSmlGPqO5KAa+Dvf1XIQagVTwXG9Yt8U6JCCqE+aOrNyLXL/kbRgITrW5CrS6EArzrxyhM+JQdET40uUjCUFdqpIP0pmhPBwKnbbbn4CdTzBrRwiA53lJMWW40NbXFQGML53EoVAY9VJH0H3ZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448551; c=relaxed/simple;
	bh=OkmVzniWDUn08cODxywkXu0cV2U1zljQtlcS0yjW3sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNKTT2B8IgThPWe1rfYKfV8Mt1DaxbJZ9xHFBYcplPQhuThX9wUxKw0rJAyy1nRrvMPPxiO+9E5+xTyCg/L4Rx2GVj/g2NxfaCQLR7Kxv/OcfQKU2PWJyjzEHd7MWaT1xk1gXKS6KuXs+F6V20YGTD0DaaffHs4fi01UdydTZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRUiRK5Q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRUiRK5Q"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso1099435a91.1
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2024 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727448550; x=1728053350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkmVzniWDUn08cODxywkXu0cV2U1zljQtlcS0yjW3sU=;
        b=GRUiRK5QTEGhuNbupqgt+JDY3IFC9w56o/FmAiRMHbVxHnGSK+KT23KBMNuQ6jO0U3
         Zu4GkQ4HZP5Mm8ReGIprPRJd90LeqqbSKjA4ftIACAjB17dKvQh94tOmxmM9M3mkwGnF
         RwNIKVOiIlNvMeZa/XLsq0UjYX7kUgrby7gceaHoO6u4iDekLKze3ph99jyJ2iY5Hcpe
         qafApHykdcIFc2dgoZaB6v6gIc/3rw8VvPR6XGnDqK+GY0xnctmu8ER8nRSleHCq90SA
         Wvac2ABFthcu44uDUnDr6doqO1FlR2E6MqqT0F407Blcg1V0Xm5pIIPDHrX3y+he4Za/
         g7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727448550; x=1728053350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkmVzniWDUn08cODxywkXu0cV2U1zljQtlcS0yjW3sU=;
        b=Z8n7wXIBn01VWEIFHVAFEq24BGKvj6vh7PWs57e6A9djC3KBn5OvwZmOXcba8DkCTv
         BP27sHMrEhJXrkAh1ROuntx3pyveQeJLgIgPaZXOlB3tuhNGvnS5Omd1xQGuVOXf/aMx
         sIDhVMxWgCWbygM8DlBbNcc+MmHn6+he4O5dB5imjrxmjWyyfD0LNmyZpClF0/PM863J
         byUm88AJtFyCkGka3Lw5f96SjsVR14JUXNv2zh4gsuoe6qN/GUOPRDdmAfzHpfQlllTN
         y7nrD78jHQLTAw/IGjrP47Ow4m5v7Oqjpuv/MINQfvUlAgtgntXr3eKhw2WZa1MJaR9h
         1dKw==
X-Gm-Message-State: AOJu0YyOAx51SeW8va2jH45ypCq7SBS5ffo0MPwpjVrkntjhoWhf23FN
	sdR0fwlhu+zezngEbsObxdisPUDZOhZ69yQH11yjV4OfNpGM4nMl8GwxOYBt357LpbBqkjJgGAJ
	CMpLVLhmirVX1t2haDdGXyTQftom+gh8X
X-Google-Smtp-Source: AGHT+IFsSr/sZdzMGfqhtJNa0ulsvLXng3NR8IQ3BZKhfsMIILgATTEjqjkQykQqZlUQ5KZiJKjgxVhKQZcJlLoUQmM=
X-Received: by 2002:a17:90b:2348:b0:2d8:9fbe:6727 with SMTP id
 98e67ed59e1d1-2e0b7125df7mr5665825a91.4.1727448549478; Fri, 27 Sep 2024
 07:49:09 -0700 (PDT)
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
 <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com> <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 27 Sep 2024 10:48:58 -0400
Message-ID: <CAEjxPJ4UsFbFvuigZ+WZD0zuPQ-mY9MRQ-3+SYp_bDwBE_1z0Q@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 1:16=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 26, 2024 at 9:14=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > As I've been converting the permission checks to use namespace-aware
> > helpers, I've noted policy capabilities (as in network_peer_controls,
> > open_perms, extended_socket_class, always_check_network, etc) as a
> > case that isn't cleanly handled by my current approach. At present,
> > the hook functions are just checking the value of the policy
> > capability in the current SELinux namespace to decide which branch of
> > the hook function to follow, and then within whichever branch is
> > selected, each permission check that is converted to using
> > namespace-aware helpers is checking permissions against the current
> > and all ancestor namespaces.
> >
> > So for example, if the current namespace enables open permission, then
> > it will check open permission against the current namespace and all
> > ancestors, irrespective of whether the ancestor enabled that
> > capability or not. Similarly, if the current namespace disables open
> > permission, then it will NOT check open permission against any
> > namespaces, even if the ancestors enabled it.
> >
> > Lifting the logic to iterate through all of the namespaces up into
> > each hook function is possible but rather painful. That said, it may
> > be unavoidable if we want to support different policy capability
> > settings between child namespaces and their ancestors, or prevent
> > child namespaces from effectively disabling certain checks by
> > disabling those capabilities.
> >
> > If I were to go down that route, then I would also need to resolve how
> > to handle the non-permission checking logic in each hook across
> > multiple namespaces, e.g. labeling logic. Currently it is just
> > assigning SIDs/contexts to objects based on the current namespace,
> > then checking permissions against all namespaces with that
> > SID/context. But if each hook function has its body wrapped with the
> > same loop that currently exists inside the namespace-aware permission
> > checking functions to iterate through the namespaces, then we would
> > actually end up with multiple SIDs/contexts computed and need to
> > decide which one to use (or special case that part of the body to skip
> > doing so for anything but the first/current namespace).
> >
> > Thoughts?
>
> On 2nd thought, for hooks that don't depend on policy capabilities, I
> think the current approach is fine, and works for the majority of the
> hooks.
>
> For the subset of hooks that depend on policy capabilities, I will
> lift the logic where needed to ensure that we apply the right checks
> in each namespace based on that namespace's enabled policy
> capabilities.
>
> Labeling logic will still be based on the current SELinux namespace at
> the point where the kernel object is first created/instantiated, but
> permissions to that label will be checked in the current and ancestor
> namespaces. There are some potential gotchas there, e.g. a child
> namespace could load a policy that labels all objects it
> creates/instantiates with a context to which it has access, even
> overriding file xattrs by specifying something other than fs_use_xattr
> in its policy for the filesystem type.
>
> Some of the policy capabilities have effects other than changing which
> permissions are checked, e.g. extended_socket_class alters what
> security class is set in the security blob and later used in
> permission checks, so if a socket is created with that disabled in one
> namespace and accessed in another namespace, the permission checks
> might not be on the "correct" security class for the other namespace.
> Other policy capabilities affect labeling, e.g. cgroup_seclabel,
> genfs_seclabel_symlinks, userspace_initial_context, which likewise
> could lead to an object created and labeled in one namespace
> triggering permission checks against the "wrong" label if accessed in
> another namespace.

Since an increasing number of the testsuite tests are failing in a
child SELinux namespace due to even unconfined_t in the parent
namespace not being allowed the requisite permissions in the parent
namespace, I've created a modified version of the testsuite policy to
allow those permissions to unconfined_t and also disabled the tests
that cannot work currently due to the separate network namespace.
Those changes are on a branch of my fork of the selinux-testsuite at:
https://github.com/stephensmalley/selinux-testsuite/tree/selinuxns

With those changes, if I load the test policy into the parent
namespace (so that the test domains/types are defined and access is
allowed to unconfined_t) and then create a child namespace from an
unconfined_t shell and run the testsuite from it, all of the
(still-enabled) tests pass. I'll keep amending the test policy on that
branch with further changes as I convert additional permission checks
to be namespace-aware. Eventually we can figure out if it makes sense
to merge these into the main testsuite but that can wait until we're
ready to merge the kernel namespace support itself.
