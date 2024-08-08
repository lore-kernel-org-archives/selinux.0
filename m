Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7718B48A
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118368; cv=none; b=q4PNtEQToyPRx7Bhp9bm7ovp1Jsr1q7keX7bdUB3gdpwMYTuvPEtek3ofprYhuOWjos2SO7fl0WfBM9NatV4eqPOv1E8SYdk7V5Kc03Y67e2SgmUep1Gbwc/4YrAVpyw2SQRSYoKq0ZI4z/VPFaC6luE5UZ40v8tL5T0ciSjfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118368; c=relaxed/simple;
	bh=u/PXaxhafsb4Fj1dTTqodHafGIuUStqW29PRjFSDxU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XRfng2HYbxx3M1kn1KfOowadBeAn83lwXmU1Je5Q6JsGTTawQCjv3n4bJnX+1PYKxxnj8skzcdmBvsnJVpt1A8Pu8Zc/w/p/dXiDwWzvSOTZo7xg4c6FBIbEfIuB6Aq3wX3AAcWOd5miOcyO5mPJGTWUYcddRttJPSMuxaDU0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9cZdjV0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9cZdjV0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so1433039a91.0
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723118366; x=1723723166; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/PXaxhafsb4Fj1dTTqodHafGIuUStqW29PRjFSDxU8=;
        b=j9cZdjV0mgq9SYp8p9ZlSJCQ6LQ3bJk1bR4xyMiQaL86dNIQ9IYGIrYOvqP933uR4/
         4sj2O4BySeXlUvQlVbkyNBUtiJi49H209iDZzwzMzUA9ORN508TZJ4lUdcJgWX+fmUEI
         yshwbw4uar5e5MBiByliAIadSAj68gEaISPTrNXyiWqLS5CMJY2+Ws/mQk3GYLmKEfZv
         gC5DICqe/3nZIdxbTnC+8uGxuaQ9G/y9l2bboKNl6kRxRZ76DbajXLFxAep6JA+fwvdX
         7wgtFsMIN1dNed/XmvvO7KWzf6zrhE7nI3mzuNrUXrRyjI82suOEcUyKh/MiBNAYaxyj
         c48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723118366; x=1723723166;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/PXaxhafsb4Fj1dTTqodHafGIuUStqW29PRjFSDxU8=;
        b=L33gRidqXPMKNwpLeVBf6pBeqmwZRP1B+s6p8PPSqI+TRMWnk+ipNW666DjAv4lqdC
         B8L/EpZetxTLEDrlh2pVFkN3aYtUHqJLqmG1bwBfjMWG6hGzQGIMOWDaRG98a8q8/Sus
         +2YqpBhiUC3Z9k6Txim53VBPl2FaS6wsarTQERMML45w3x7F9414phev9rp5m+xj8ZlB
         ODVo7WfG6pY9fUzTzhG1hMdU352QN4yP4wL66YOI/LUpateRiUzx6NVFJcIkxBVsiB5U
         69AuBhQFLIjvhSSsiNo8Kkn56qG5dgC542FwSt8QHIDcLdkt7/qIETN+W03gdD73OfzO
         Iupg==
X-Forwarded-Encrypted: i=1; AJvYcCWR4QtJ65nu08S57nyD8PRw9sr4iRLcyFyWTMg15TU2K/eXu6ca75pHRa0d5m5a3o7JUNSe9yaoJi+S+AoT7mi+kpW7QHzNdQ==
X-Gm-Message-State: AOJu0Yy8xFaZmVUlAr8Mx75RrakrxmRz0jw/sQapW7myDm5HJhBk0dvr
	HKf+q8ihPCudjhiSpKW/WP7QNnhUL3wchFV27U0Daiy5SuTdAvPJTzJN8RHPKm4PgYBSrApQgEV
	oPrbnMP3D+EN9cyC6UL+3zmks2AkwIw==
X-Google-Smtp-Source: AGHT+IGQRKQeJaQKXWcL5d3dLOP22rv0wvMldNMEGcZ/8VLzBIK9aARSYJrkmGWev6AVgn2YUvMWIkgZoN0iyR388Ko=
X-Received: by 2002:a17:90a:cb95:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2d1c4b9a1d4mr2398959a91.6.1723118365791; Thu, 08 Aug 2024
 04:59:25 -0700 (PDT)
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
 <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com> <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Aug 2024 07:59:14 -0400
Message-ID: <CAEjxPJ7C41QdEgAFYVdTyZE=TjGq+pyzCmy7BbHMss7=njvJmg@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 1:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 6, 2024 at 12:56=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > With these changes applied, the following sequence works to
> > demonstrate creating a new SELinux namespace:
> > # Ask to unshare SELinux namespace on next exec
> > $ echo 1 > /sys/fs/selinux/unshare
> > # Unshare the mount and network namespaces too.
> > # This is required in order to create our own selinuxfs mount for the
> > # new namespace and to isolate our own SELinux netlink socket.
> > $ unshare -m -n
> > # Mount our own selinuxfs instance for our new SELinux namespace
> > $ mount -t selinuxfs none /sys/fs/selinux
> > # Load a policy into our SELinux namespace
> > $ load_policy
> > # Create a shell in the unconfined user/role/domain
> > $ runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bas=
h
> > $ setenforce 1
> > $ id
> > uid=3D0(root) gid=3D0(root) groups=3D0(root)
> > context=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> >
> > NB This new namespace is NOT currently confined by its parent. And
> > there remain many unresolved issues.
>
> A couple of additional changes pushed, one to fix a bug in the inode
> handling and another to introduce support for revalidating superblock
> SIDs and updating them as needed for the namespace. With these
> changes, the selinux-testsuite filesystem-related tests appear to pass
> within a new SELinux namespace. Other tests vary - some pass, some
> fail, some hang.

I think before we proceed further with the SELinux namespaces support,
we need to decide on how we are going to handle SIDs since that has a
significant impact on the approach. There are (at least) two options:
1) SIDs are maintained per-namespace; this is the current approach in
the patch series since the existing SELinux SID table (sidtab) is
actually a mapping from SIDs to security context structures, not
strings (with the exception of undefined contexts with the deferred
mapping support), where the structures contain the policy indices for
the relevant user/role/type/level.
2) SIDs are maintained globally, e.g. we introduce a new SID table
outside of the security server that maps SIDs to security context
strings (hence policy-independent). This would be more akin to Smack's
known label list that is also used to assign SIDs, and would provide a
stable pointer for context strings that could be cached in the inode
security blobs without needing to maintain per-inode copies of the
context strings.

I started with approach #1 because that was how the existing SID table
works within SELinux. However, approach #2 has a number of advantages:
- It matches the LSM hook interface handling of secids, which assume
that secids are global identifiers and allows kernel data structures
outside of LSM to cache and pass secids back into the LSM later, e.g.
for audit and networking.
- It avoids the need to revalidate and re-map SIDs in the object
security blobs prior to each use since they would be global,
eliminating the complexity associated with
__inode_security_revalidate(), sbsec_revalidate(), and doing the same
for all the remaining object security blobs.
- It would remove the need to instantiate the network SID caches
(netif, netnode, netport) per-namespace.
- It would potentially allow for a global AVC (currently
per-namespace) aside from the question of how to handle the policy
seqno and when to flush the AVC (e.g. introduce a global policy seqno
that is incremented on any reload in any namespace?).

Given these advantages, I am inclined to switch to approach #2. Thoughts?
