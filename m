Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953D13AD32
	for <selinux@vger.kernel.org>; Wed,  7 Aug 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050164; cv=none; b=N/fqk/xFAxIAJW3yMtGgNBWIs1xS68egVi6i92IJEyE5SPUIsUXSAsTx+PzfeWw2+FMMpfPYUqF6w/TepZbVTZMVh/abWTZTVpfQzgMALdp7T6uWTZgQe60D/rQP8TlHr5IW9RhaqhAt3U1pqXAd8Qk2X3hGpqaxj9E3cuwEmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050164; c=relaxed/simple;
	bh=qopxdNKe4LC0/1iAcMZl9EV2Fq0MLKp9bLbWQ9c6W2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=O4wGy0t8XXPVGrs/lRmZm0a4OhJWAq8IRL/dfXL+DqSNBE41aSH/Zg3H+/zsn1KR0kOC1g+OX7MSagoYrUX273cSQGVyX8c8lGqO40PCNr91K1FereCT1uejseRMxxZiPkCK7pRWHCZeu3lprd7UwcobsZutzA9p4pu+U8FNSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCT+JmzH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCT+JmzH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso41707a12.1
        for <selinux@vger.kernel.org>; Wed, 07 Aug 2024 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723050162; x=1723654962; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qopxdNKe4LC0/1iAcMZl9EV2Fq0MLKp9bLbWQ9c6W2w=;
        b=lCT+JmzHJxcwjp3WGqdxzvyaZm0MhcneYoKSIjQJE9rtjsQQKmnRruU8U/qguokHmB
         8Uk01rjVQU0ds6PonUH8s3nYxLLIiZ4NdqDRH/axWltVHvrDz7oL6wov/169xOr37ZV5
         xeumd5er58v5QmArJ+fadTA2RWW8jTlCZBMm9rdxvEJzH4AhxB2JSJ44j+vjAu2J7Y2v
         k0y8ZvF+7vCuIQnqOQHJt7rgJfFkJCIdlyZjDQACUe4a6PwTv1bafjBRQjtZNAY5Dtsu
         +V6Jmdt6ZcTKEKScQIFpBnNjP9Om4++qPgPgN9Qy3tb46mnAl3VoJ/kPxYHrov3c0Sc4
         98iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723050162; x=1723654962;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qopxdNKe4LC0/1iAcMZl9EV2Fq0MLKp9bLbWQ9c6W2w=;
        b=NwNYoaZIlvNiJzVzBln23cEAYVqIe8QN4QD23eKQcPBi3TWroo9o+w6eriu7D09yV6
         NmqwgjbydDZeM1OUpgU+GhP6Fe1Gu0o3/DY4l2bVclklfaauhl6siOsVbQzz6c+nZ/lb
         yhosyCRLOCKq4dxyeYtyYqMluqbInYwWC1FcKDZswELAbwasgZ+QAPHqkDlnOyZYxcwR
         luhka2P2yQOaVQNzwUegkw55mPeVPFHrjAb4HKewt4rGNviFlY+kVzKrXIuHo+IUfYXF
         8gXTgYwldJD+uyXZtU16XkzqtSkA+LTdkDscqIHdk9f3NxAI6BVou1JvqqKymV8Ry+ZE
         Kuiw==
X-Forwarded-Encrypted: i=1; AJvYcCWOJzkcZJpu7Wvt7BxbHOdVBwEhZC98bU+oi5EdVPEa8H07UbA1yjEb44EqbNw03osYSL887a5usWlA18F2VM1AiwXh8EVtNQ==
X-Gm-Message-State: AOJu0YxRKWtlaMNET4ZK0AuMuqmxW4mYYTn6sFyFo6zRhLdps6Zglgzh
	Hcvax+JLWF8mwGlexshTFKiSTvy+aLXJFvP6IsvbUaOnVeTIWCosJ0WaQ3f594jXwKlbW/nACtB
	tBDdABFnvwpt9u/P9Qi7ykXozmefT1w==
X-Google-Smtp-Source: AGHT+IFySMNagrokq/XdaRbxdB5w2fqHnLMD6tr5wWcm7KKgR5Ff8O/gr8Y/s2fNWDUGpqp/tYALrXixshUHkSvixts=
X-Received: by 2002:a17:90b:3ccb:b0:2c8:f3b7:ec45 with SMTP id
 98e67ed59e1d1-2cff95823edmr21473467a91.36.1723050162296; Wed, 07 Aug 2024
 10:02:42 -0700 (PDT)
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
 <CAEjxPJ5a1KzSjB31gcqWqJW_zdy8OCmwKKGYwCivvFG4Jvncyg@mail.gmail.com> <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6WupdxzSkh54NLJkZoH=Umayj8+HrX5TmbAXvVYzgPfw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Aug 2024 13:02:30 -0400
Message-ID: <CAEjxPJ7iL11xSVs4gxhMPSCtVmYEqfgQQmBpVNAVXV7UG=P3nw@mail.gmail.com>
Subject: Re: SELinux namespaces re-base
To: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> With these changes applied, the following sequence works to
> demonstrate creating a new SELinux namespace:
> # Ask to unshare SELinux namespace on next exec
> $ echo 1 > /sys/fs/selinux/unshare
> # Unshare the mount and network namespaces too.
> # This is required in order to create our own selinuxfs mount for the
> # new namespace and to isolate our own SELinux netlink socket.
> $ unshare -m -n
> # Mount our own selinuxfs instance for our new SELinux namespace
> $ mount -t selinuxfs none /sys/fs/selinux
> # Load a policy into our SELinux namespace
> $ load_policy
> # Create a shell in the unconfined user/role/domain
> $ runcon unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash
> $ setenforce 1
> $ id
> uid=3D0(root) gid=3D0(root) groups=3D0(root)
> context=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>
> NB This new namespace is NOT currently confined by its parent. And
> there remain many unresolved issues.

A couple of additional changes pushed, one to fix a bug in the inode
handling and another to introduce support for revalidating superblock
SIDs and updating them as needed for the namespace. With these
changes, the selinux-testsuite filesystem-related tests appear to pass
within a new SELinux namespace. Other tests vary - some pass, some
fail, some hang.
