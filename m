Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604952E7176;
	Thu, 21 Aug 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781442; cv=none; b=k5X18HrZ6mA0Y7/BGf9bT74uR8LYOh/AEBEodmE1Gga8fu6KwY9psXWsRDG5oRdRCPoWYyJAXGj3jblfNWs9yqm/f0PTTo1tusm4J2JdtiyAKgcKdbus5vx38/qea4dsbbm4Ra4PrI4SBBOsdOF/kYEPIkbvctetR5D2U7EkgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781442; c=relaxed/simple;
	bh=IQffsHkJjkPaPl5FrEI5X3ZwB3AQ4jhcAdzezNY01fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm1eyPXfRNs1gtUvKgphnUudirVpz/k27qMvyIxw0f67RPCVKNbfEyYLOz3lwsuGEVFmcwxG4IPtLKuckgZ3ysi1IaZZ6J1CuoaOi9oL4t/NvjKh7y65HlM77LzM05b9tEN4slphKgnV6foVEHdJZGqeGI7Rj1C3amvwEPysu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h45gp5bF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h45gp5bF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so780100a91.2;
        Thu, 21 Aug 2025 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755781440; x=1756386240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQffsHkJjkPaPl5FrEI5X3ZwB3AQ4jhcAdzezNY01fQ=;
        b=h45gp5bFIf2/wIECEgJxmRHAfz65bTCcjL81cxaNgjSQWMKJmsYNu7Ecxye8++LcIS
         RbIn2VOY7AUVnRTlV8otxEOD9EGkLRkYdBBqMYr2sQO7j9flSByO+U/MjNOSkYdieh3y
         jZwwgtaK3aIVCtrn2vMLJFFFPir6PhtkVNR4r5T9kL2JJyMYDu/AS4fAx891gZkRe2NW
         VF1HtHICA64DCah9tdbFZrGdnqe2H/NdKcdXn6sEWK2dgmQj6SlsrJSWyvWRauvMhT07
         bncVQFlrHAyHvdIShH801ME2kaa/rdCm11KMN+P/IKNNybN8IbXe8qO3xv3RwgzeFMiN
         7OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781440; x=1756386240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQffsHkJjkPaPl5FrEI5X3ZwB3AQ4jhcAdzezNY01fQ=;
        b=Wqrd4yianFJGthM9Arqqm70jdEKqdO9d5YhkMzlv36I0HglJSGdENOucA80+XIj6ci
         NM3m0Ls5CwwjtljMwU30x2g3q2N+g/9TnaESMt4entP6kPlyDpItPJMkGJveaYL271W8
         m420eV3SlOKIJVBobLeK/hnIhOtNfQ4KvK/qKT19SkKC2iwPReKX6EDAsMtTQ4WUSJTI
         Ksa4bMjstfWN6lTxvftQw75IrZixGFfnkwZvPQW+UahDpJwzC22URL6+fmzwt37V21Sx
         UdEnO8o1qbt/y//1XcWrtSqH8UKtT9EhQiyLcaWzwOq2MlAT22kKHwhQqRi0Sp2MX/3p
         D5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUEOOMfExY6Xee8yV4d/p948kCQ4SFt+Hx6u7t9pudwnFNh2bX7tU7mw7wzpRO6C5psT1TEdhpjuQ==@vger.kernel.org, AJvYcCWIJwu1+AOrZy9eO6XpvPAG7hgI9M4/lH97wHXGTxKxjKlycSdExh/Ub1qJmbB3yn682f8kH527dZs1zoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8wrnbH1sb1ISSCJbbP/H6hLwEc91lqpi8WTrDliGQHxOPhhN
	BQoc2Nabco5EZnmIDnB7GW96RZO4CnbvTlsxkUQPCB2czYDGtxBL3cUhY5jpfvjAQQDFFgzDtb3
	VGDn+O+q9YMwe+iO+uFatcqbzDk6AMcE=
X-Gm-Gg: ASbGnctMvRvk9cV15UUgdQp1mV2pyGu2pbpK5Wy47OYzcY5hr4htIlWsD8tn2PjNFMd
	ADBxaeLkRPzBLL8s/T/uSpP9CED47mdr00PAVLzWFYi89xrzd1UNqwFVZMSSUyQXfJWYhzMgvvn
	bvTnY+91VjIs/0LMNyYFCj14/UT/nTynYqKTLJ11dXxj0kkv3CFbbYl7yyxeA0rLSC2MPa1zboM
	+egTWo=
X-Google-Smtp-Source: AGHT+IHOjUwVveUGbP1H2bxrM5RrKXU+JZeOkQ7ZUMDMifja+D7IyxwPy44Ft2eopE0YxtdZo+taUU4v2YR39f27RMk=
X-Received: by 2002:a17:90b:5446:b0:31e:f193:1822 with SMTP id
 98e67ed59e1d1-324ed1bfa86mr3177405a91.28.1755781440315; Thu, 21 Aug 2025
 06:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820212302.2325779-1-nkapron@google.com> <CAEjxPJ4Vi9rXXkvPUoS-tjHks_6oevdkhrjvSeX_Rh5VV5gBBw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Vi9rXXkvPUoS-tjHks_6oevdkhrjvSeX_Rh5VV5gBBw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 21 Aug 2025 09:03:49 -0400
X-Gm-Features: Ac12FXyNDcrIGqyYmrQU68rMn6r9BjZGRzXSs0MDpowUWDoVliBgb9j83DE2580
Message-ID: <CAEjxPJ6iFrfVxbRM71b9G0+59L+vxNiJ1mpeXSGwuG_n+D15Lw@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 20, 2025 at 5:23=E2=80=AFPM Neill Kapron <nkapron@google.com>=
 wrote:
> >
> > This patch adds support for genfscon per-file labeling of functionfs
> > files as well as support for userspace to apply labels after new
> > functionfs endpoints are created.
> >
> > This allows for separate labels and therefore access control on a
> > per-endpoint basis. An example use case would be for the default
> > endpoint EP0 used as a restricted control endpoint, and additional
> > usb endpoints to be used by other more permissive domains.
> >
> > It should be noted that if there are multiple functionfs mounts on a
> > system, genfs file labels will apply to all mounts, and therefore will =
not
> > likely be as useful as the userspace relabeling portion of this patch -
> > the addition to selinux_is_genfs_special_handling().
> >
> > Signed-off-by: Neill Kapron <nkapron@google.com>
>
> Did you confirm that functionfs is safe wrt genfscon-based and
> userspace labeling, as per:
> https://github.com/SELinuxProject/selinux-kernel/issues/2
>
> Also as per that longstanding open issue, we'd welcome patches to
> generalize the current hardcoded list of filesystem types to
> instead lookup the filesystem type in the policy to see if it should
> support genfscon and/or userspace labeling.

Also, do we need a new policycap to conditionally enable this new
labeling behavior to avoid any regressions?
See the corresponding checks for cgroup labeling and
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#addin=
g-a-new-selinux-policy-capability
