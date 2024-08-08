Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505E1494CF
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150423; cv=none; b=N6CKWZJURZcyxz8y4S91nBhaqRXwb99yeOKOMpHtp01WwlwX7/p1YcKSgATylUrNA9ZVMnAq/6S8uOyUJcybhc7nGZB+UeXylnQoubVdz0F4kGyXtZr+hYzVweXE4HUZvo8bldMiWcU7FSQwS+/Gye2kRVWbuSCWs8Ebf7pon5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150423; c=relaxed/simple;
	bh=2OcgmFMB489Vtzl+6sNJK4cp79crmFdII6pj9QIpY18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFWXeNT7CsNLIV8Y5hhqLc/GReZNO7jl5GivUB8PBeP4hrZfidcQVrTuwq5jk0Ya6QWsVkIQGYpO8TThWvPS8EMarLEuMLQIICtR4zQ7CA6rw7Xy3zFSj3ujvKd0DOgEC1Uz4zakfCmhbSM5BTY6FAb153NoFOn+E+Gh5kYb7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HmyaPCHz; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HmyaPCHz"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6694b50a937so15252117b3.0
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723150421; x=1723755221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEmHeScdpG+Uljlkman0gGJU9lk4Ln33GVAlqjv+nm4=;
        b=HmyaPCHzi0kfz725xACmocyNIrc9JNu1J56s3IBf/qUWz4HoamdcI70Abl7PfVHzuf
         M/8cn7TiX49hFAwWxeL6tX+8gYOJ+MqbHgYcZtDvOC/0MQYbcDEhdyoSAwbMav9wIar2
         M6wl1dF5kgut3SIQoVYZ4CU755TK8GLhLQBfhy2y2dN4b22L3/+sMNh0mXoRSv7J/KUO
         7zYfdOoHr4anN+EomaQmogePghUqb9cSNILG8PE7/ShbXk3Z/o3Z3+aTqHbzbT6a9owa
         9lV1ZKwRg1kayU1M32Am5J9Eu3VnqpieSo2Fh/z1K9usRi6w54BeipHx+cjjc/EEeoRj
         Qsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150421; x=1723755221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEmHeScdpG+Uljlkman0gGJU9lk4Ln33GVAlqjv+nm4=;
        b=oql/yV15k0jBj79Z4NB3FwWpt1J9pjcrlcz8ShnMiWoZDtbHuaA/MJQ6O8Obg0k2ea
         4++IQDDiPugVzseLkIGxj8KHUjhHHunkxKooaa14/qqEmOyJXQhs0VgkI0XZgM2K8AaN
         JYfzeEHBj+HOe0ylQiottykT5bsLJ8GD/6V+0jVBdoghlelQPcxE1uDAE3i2EfsUzVLF
         OwOtgdU0F7D7hbkxSibT2jyKVWQ7s0YCPXIz6U2g2CP19+WTpLSnwlGP7xnxIu61h3pM
         xG1QJrayTGfgNa/eDuclSb0J9EWYDtc6XsMKNyfdKROE3c9/aUFVCEypVsDlr3Pel3gb
         z+FA==
X-Gm-Message-State: AOJu0Yytx0t6F5MbYgYWlDxmljazeOe7drdjTxKZpHUSZjcHFndBqt7N
	e/QA0nk2lubQegq0IhTP/hj4XYmNZP7wpe/J6DTkkPEz9s5gnnxsWYfkrrf7yuSEqj8YRKl5UeE
	u/+yXg08bmq0W/SsiXZICodGJ+t0E3CYuXaxWIxF8ySOlADg=
X-Google-Smtp-Source: AGHT+IEW9/1rWdubAZlyVi0kvOF8Ya35nOz7cAds3Mdd5gr2wSWrcpbsSPCCcw8JcAgC3y3lENjy9UfDdtzs+84KphI=
X-Received: by 2002:a05:690c:2e09:b0:615:1ad2:1102 with SMTP id
 00721157ae682-69bf7d074d4mr31724677b3.11.1723150420843; Thu, 08 Aug 2024
 13:53:40 -0700 (PDT)
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
 <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com> <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 16:53:30 -0400
Message-ID: <CAHC9VhRDF0DBAWM-=ynks1=Zm5LcQYq0_4xfQy4pKvHfW6FoBg@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 7, 2024 at 1:02=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Aug 6, 2024 at 12:56=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > With these changes applied, the following sequence works to
> > > demonstrate creating a new SELinux namespace:
> > > # Ask to unshare SELinux namespace on next exec
> > > $ echo 1 > /sys/fs/selinux/unshare
> > > # Unshare the mount and network namespaces too.
> > > # This is required in order to create our own selinuxfs mount for the
> > > # new namespace and to isolate our own SELinux netlink socket.
> > > $ unshare -m -n
> > > # Mount our own selinuxfs instance for our new SELinux namespace
> > > $ mount -t selinuxfs none /sys/fs/selinux
> > > # Load a policy into our SELinux namespace
> > > $ load_policy
> > > # Create a shell in the unconfined user/role/domain
> > > $ runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/b=
ash
> > > $ setenforce 1
> > > $ id
> > > uid=3D0(root) gid=3D0(root) groups=3D0(root)
> > > context=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > >
> > > NB This new namespace is NOT currently confined by its parent. And
> > > there remain many unresolved issues.
> >
> > A couple of additional changes pushed, one to fix a bug in the inode
> > handling and another to introduce support for revalidating superblock
> > SIDs and updating them as needed for the namespace. With these
> > changes, the selinux-testsuite filesystem-related tests appear to pass
> > within a new SELinux namespace. Other tests vary - some pass, some
> > fail, some hang.
>
> I think before we proceed further with the SELinux namespaces support,
> we need to decide on how we are going to handle SIDs since that has a
> significant impact on the approach. There are (at least) two options:
> 1) SIDs are maintained per-namespace; this is the current approach in
> the patch series since the existing SELinux SID table (sidtab) is
> actually a mapping from SIDs to security context structures, not
> strings (with the exception of undefined contexts with the deferred
> mapping support), where the structures contain the policy indices for
> the relevant user/role/type/level.
> 2) SIDs are maintained globally, e.g. we introduce a new SID table
> outside of the security server that maps SIDs to security context
> strings (hence policy-independent). This would be more akin to Smack's
> known label list that is also used to assign SIDs, and would provide a
> stable pointer for context strings that could be cached in the inode
> security blobs without needing to maintain per-inode copies of the
> context strings.
>
> I started with approach #1 because that was how the existing SID table
> works within SELinux. However, approach #2 has a number of advantages:
> - It matches the LSM hook interface handling of secids, which assume
> that secids are global identifiers and allows kernel data structures
> outside of LSM to cache and pass secids back into the LSM later, e.g.
> for audit and networking.
> - It avoids the need to revalidate and re-map SIDs in the object
> security blobs prior to each use since they would be global,
> eliminating the complexity associated with
> __inode_security_revalidate(), sbsec_revalidate(), and doing the same
> for all the remaining object security blobs.
> - It would remove the need to instantiate the network SID caches
> (netif, netnode, netport) per-namespace.
> - It would potentially allow for a global AVC (currently
> per-namespace) aside from the question of how to handle the policy
> seqno and when to flush the AVC (e.g. introduce a global policy seqno
> that is incremented on any reload in any namespace?).
>
> Given these advantages, I am inclined to switch to approach #2. Thoughts?

I agree.  I gave this some thought when I was thinking about how to
handle persistent storage and I think adopting option #2 (global SIDs)
would help simplify things significantly.

--=20
paul-moore.com
