Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935C3FF1
	for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371002; cv=none; b=G31WPapNcpeKrc1uESJC/zr20/TAjKHG47H89rdtwr33VIQ6wHDOScr3JvN4cbwycPlMM5uLDRFMQOB+i9THbaLxgj9kUA7d4XG+SntuyZko29h91jrGyfbAWnLAOIP0UMDCiJOYWcSJ2UhEozV9++LmQjgatqSEUk2zA2lVUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371002; c=relaxed/simple;
	bh=/xuQgToQMCg5yztKOYteZNiQ3BqX525tCJJsnBjdnok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESoJX+OqwQj/Gd2yabK/vU+CK9Y/rJUr53LwUUWVjzGRDOYhFr8Xs1TpGehWijanluVpumh5KAj6gH1eNiAlQMTiyavb6FuWp5K0SgF8//KQh4aQJ7uUt9vbBfORt85NKjBFqpTpchNn4BStH0VPR5qiw8fPnmnEK757/HQIH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efyVDJNM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efyVDJNM"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068a7c9286so12501965ad.1
        for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727371001; x=1727975801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xuQgToQMCg5yztKOYteZNiQ3BqX525tCJJsnBjdnok=;
        b=efyVDJNMuSqfp+IHMFu7T6nVMB2hHyb6QYyDeqQkynYraGcb9aIbt/I6pD96n3jtSe
         Bgw0l6kI/P3a45zdByP43n2+gElDGXiymtf4686JeYluui8Vny0Ic9qva2soCFj/gHh0
         KzxID+UXcJbct9WpeBeAPTi9STt4AoTLRFfSJBKWOQz4rEgIEeHpO3oox0PXT3naFk2z
         2SwhlpQA87sKznStNDP304+yIZTxDt17lLcDBuZZs15+SlcMH5hGes4mhrNPZzQL2naF
         gTLFKr6oDPW/hW4L9Semz3roMXZRoUQFl7WgTwcmrwOVxETYx/Qdyx/Fi26ioZqpZPGa
         5ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727371001; x=1727975801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xuQgToQMCg5yztKOYteZNiQ3BqX525tCJJsnBjdnok=;
        b=dgL9x06/VhWPyzXeJPy0/HxW/TITswXMwpipNwKDv3wy4qqJfpl15OaHJt1S1IImlU
         hvUPJBVdU+vKxpwA8OeJZbUf7WkwgvKIyJ1NSiCcCF1SRJkYS2lB9/+XgwNi74GzVCY7
         aYTemMdOFhOrgsgb/3EQ9I9OeZU19jIuPoqbHlbwme43M59k3YuiPl7RfHO7ENhLafeJ
         wIJrH6pKBEU/hkjSEQGwwkxeUqhcX9KLAcpcHjZvFC71HF5IP2qlCYeK6bnWdOzNY7EK
         SAvE1xSDIZ5xtKjWv+EpcNby5jeYWbgYh2YLEyfB5e47fE4aqBfdEVMpzzR/+U2IYsSS
         A4Fg==
X-Gm-Message-State: AOJu0YynW8jPGm2GacS4W3kskKDxOImUJQG09evWW/T0PMWIsT3Ta+8d
	lmGk+8QsBS4RGQn+m7edkyN2fIAN0BlFMno5qyKtNXjD7UYA5R8hQ3Ht/5wZtjDn9C3/EeH66AS
	FSiwuwHTK29G+OffNQMs2QNwX2O97hw==
X-Google-Smtp-Source: AGHT+IH/Uxbr/GgO5ZP5Wm0qWegx80Edxz4r4+Io82zeweVZ2NLSdrzUO2MkUEElKoVGjeJ7sE0WPKr3ujc+rYQEqlk=
X-Received: by 2002:a17:903:1252:b0:201:fd52:d4f0 with SMTP id
 d9443c01a7336-20b37bded26mr6383415ad.47.1727371000795; Thu, 26 Sep 2024
 10:16:40 -0700 (PDT)
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
 <CAEjxPJ7Qp9Q4RUYH8vb-xQOe0=YsN=nbyM-4FV6hvYzZwKX5Og@mail.gmail.com> <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Opxv+HU6cbAfKNT=ZXnUZ=0Ac8ZM5fQj=wnO_JPy-zw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 26 Sep 2024 13:16:29 -0400
Message-ID: <CAEjxPJ7Zpw9i6OXZ-Kz=WXVuCaas5TOtxCAmK-rxGDhm1-zwDg@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> As I've been converting the permission checks to use namespace-aware
> helpers, I've noted policy capabilities (as in network_peer_controls,
> open_perms, extended_socket_class, always_check_network, etc) as a
> case that isn't cleanly handled by my current approach. At present,
> the hook functions are just checking the value of the policy
> capability in the current SELinux namespace to decide which branch of
> the hook function to follow, and then within whichever branch is
> selected, each permission check that is converted to using
> namespace-aware helpers is checking permissions against the current
> and all ancestor namespaces.
>
> So for example, if the current namespace enables open permission, then
> it will check open permission against the current namespace and all
> ancestors, irrespective of whether the ancestor enabled that
> capability or not. Similarly, if the current namespace disables open
> permission, then it will NOT check open permission against any
> namespaces, even if the ancestors enabled it.
>
> Lifting the logic to iterate through all of the namespaces up into
> each hook function is possible but rather painful. That said, it may
> be unavoidable if we want to support different policy capability
> settings between child namespaces and their ancestors, or prevent
> child namespaces from effectively disabling certain checks by
> disabling those capabilities.
>
> If I were to go down that route, then I would also need to resolve how
> to handle the non-permission checking logic in each hook across
> multiple namespaces, e.g. labeling logic. Currently it is just
> assigning SIDs/contexts to objects based on the current namespace,
> then checking permissions against all namespaces with that
> SID/context. But if each hook function has its body wrapped with the
> same loop that currently exists inside the namespace-aware permission
> checking functions to iterate through the namespaces, then we would
> actually end up with multiple SIDs/contexts computed and need to
> decide which one to use (or special case that part of the body to skip
> doing so for anything but the first/current namespace).
>
> Thoughts?

On 2nd thought, for hooks that don't depend on policy capabilities, I
think the current approach is fine, and works for the majority of the
hooks.

For the subset of hooks that depend on policy capabilities, I will
lift the logic where needed to ensure that we apply the right checks
in each namespace based on that namespace's enabled policy
capabilities.

Labeling logic will still be based on the current SELinux namespace at
the point where the kernel object is first created/instantiated, but
permissions to that label will be checked in the current and ancestor
namespaces. There are some potential gotchas there, e.g. a child
namespace could load a policy that labels all objects it
creates/instantiates with a context to which it has access, even
overriding file xattrs by specifying something other than fs_use_xattr
in its policy for the filesystem type.

Some of the policy capabilities have effects other than changing which
permissions are checked, e.g. extended_socket_class alters what
security class is set in the security blob and later used in
permission checks, so if a socket is created with that disabled in one
namespace and accessed in another namespace, the permission checks
might not be on the "correct" security class for the other namespace.
Other policy capabilities affect labeling, e.g. cgroup_seclabel,
genfs_seclabel_symlinks, userspace_initial_context, which likewise
could lead to an object created and labeled in one namespace
triggering permission checks against the "wrong" label if accessed in
another namespace.
