Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61621586F6
	for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488172; cv=none; b=fn/kLFTh6lAwizYEsQgHUo39MBQduGXIWTcBzWsjI8Hhhhm/0/vE6e5oQKThvTatDAeQLS13cA3YyswFfMBODOQbBqGKtxh3cxgY2Albvb2iO5gbbKN7uN3/d+iMWJYiiFWHt4Hy4K/a4qw61pZACKiEtYj9+PgN8gP0sxfxZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488172; c=relaxed/simple;
	bh=sZ9Uq82f087L2oja5FVAPEnEXpHICCi0ymEju+UxGuI=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=HCHprQQ0T9/hSJKelEV6KIsuiongdqgpyQllNmWOnL+Gr1dve58zwzaYUBDcXsWrwkeP+tQ7sVi1CDDcg6aYzqTD0Y302Id8XxzxTAeMkntIIKTuTlS9WHakOPfCAAfTC65UExyRIGD12hge0SezQqgPDZopigLW1t6Rsd5S5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUS4Vr57; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUS4Vr57"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so464478466b.0
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726488169; x=1727092969; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DqTMdZhxR5vRkt8HUyzRwECZt+WbkP+JpSJX2xf0T7E=;
        b=dUS4Vr57jrV7Jld/QeI2ZNCSOX+e5v8S+e9Qj70Z3VvEM09KXF6nsJygi5SFax/RA+
         64ZRikdsjimQLWOknZJhoOE6WWcN+5TedW4oMPUZfhVFOZCdOd1TFbXDEYU7mlSk5GfE
         sNuTa+xNWatWE7+1imae+aMCQMeO+XBN41c/QyAt70Uv2BOlNXGMsjINYlkaM7sRAFdw
         ZuUkWwFRbxlZyexUNMkSZsMGC8Pk117uTVGU6dQsPdBhQywjUCrJjn3NqrkgzM5JHqlp
         vfRQEbII0uupzPTS/zaes1Gd+jp3N5eU2aKPZZaInd+gTFXwsZEN+gsrJN6hqoWvC8ud
         yCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726488169; x=1727092969;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqTMdZhxR5vRkt8HUyzRwECZt+WbkP+JpSJX2xf0T7E=;
        b=s+cKwWQ5bX1wemLO9/2N1NSWhfhWCQcZPMUoKL1c57cuZzD8EvA0svxcU9CzCA4Loz
         Wk+QtYWtfKEQMZEzQObQIvKfqblSYdtVqk/BTHbrWTrPyy0VBw2Qb54Q4f+XM0Egp+H6
         KEWhu82cdOOtt1Vi+WaYPYanFqRWsP+Ep+4UbgDJ8mdkXASDaQvMM8jp92BXdE7ZdLCK
         l++3ivj1nLn3IRcpKqeGCRun8sJxJjCxuPWbVyeYIwLb928ruNVbNBld6NS7k90kdxsC
         4oI0Hcrx1cGQaA8nGLjobRwfM9d8UesChb5CUHcK4s/VZjR/8GI7WOooHwR6iJRzPtYA
         6j9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaLDPfgkbJj6C7bHB1DDYa2a7C3aO3hG8+4IsmueRGZmNRJ/huwcmgMvjYxwd1++neNnBrf+hm@vger.kernel.org
X-Gm-Message-State: AOJu0YxFp2He4VusWwinuTTWA3ThyC+gr1y2NU4/iAEHxU7q4Lggp4iR
	MqK65bp4MYPJ+TVY+i+NAyWZ7+9FsiFzUKl7i6NUTX1/2v20jr5e6G07oR7cwQ==
X-Google-Smtp-Source: AGHT+IGfB2gani05/bokNJ2Z2f8C2aEo04AYrsp/sL5YamB+obpoV+Gc9MMUrVmccPG2VtInGPGqrg==
X-Received: by 2002:a17:906:d7dd:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a902944e611mr1394277966b.24.1726488167987;
        Mon, 16 Sep 2024 05:02:47 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4971sm306814066b.90.2024.09.16.05.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:02:47 -0700 (PDT)
Date: Mon, 16 Sep 2024 08:02:45 -0400
Message-ID: <34803d945f405dc2e4e798cdaf057994@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, stephen.smalley.work@gmail.com, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Subject: Re: [PATCH v3] selinux: Add netlink xperm support
References: <20240912014503.835759-1-tweek@google.com>
In-Reply-To: <20240912014503.835759-1-tweek@google.com>

On Sep 11, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> Reuse the existing extended permissions infrastructure to support
> policies based on the netlink message types.
> 
> A new policy capability "netlink_xperm" is introduced. When disabled,
> the previous behaviour is preserved. That is, netlink_send will rely on
> the permission mappings defined in nlmsgtab.c (e.g, nlmsg_read for
> RTM_GETADDR on NETLINK_ROUTE). When enabled, the mappings are ignored
> and the generic "nlmsg" permission is used instead.
> 
> The new "nlmsg" permission is an extended permission. The 16 bits of the
> extended permission are mapped to the nlmsg_type field.
> 
> Example policy on Android, preventing regular apps from accessing the
> device's MAC address and ARP table, but allowing this access to
> privileged apps, looks as follows:
> 
> allow netdomain self:netlink_route_socket {
> 	create read getattr write setattr lock append connect getopt
> 	setopt shutdown nlmsg
> };
> allowxperm netdomain self:netlink_route_socket nlmsg ~{
> 	RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
> allowxperm priv_app self:netlink_route_socket nlmsg {
> 	RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
> 
> The constants in the example above (e.g., RTM_GETLINK) are explicitly
> defined in the policy.
> 
> It is possible to generate policies to support kernels that may or
> may not have the capability enabled by generating a rule for each
> scenario. For instance:
> 
> allow domain self:netlink_audit_socket nlmsg_read;
> allow domain self:netlink_audit_socket nlmsg;
> allowxperm domain self:netlink_audit_socket nlmsg { AUDIT_GET };
> 
> The approach of defining a new permission ("nlmsg") instead of relying
> on the existing permissions (e.g., "nlmsg_read", "nlmsg_readpriv" or
> "nlmsg_tty_audit") has been preferred because:
>   1. This is similar to the other extended permission ("ioctl");
>   2. With the new extended permission, the coarse-grained mapping is not
>      necessary anymore. It could eventually be removed, which would be
>      impossible if the extended permission was defined below these.
>   3. Having a single extra extended permission considerably simplifies
>      the implementation here and in libselinux.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Bram Bonné <brambonne@google.com>
> ---
> v3:
>   - Remove condition on SECCLASS_NETLINK_GENERIC_SOCKET in
>     selinux_netlink_send.
>   - Remove comment in selinux_netlink_send.
>   - Add comment in selinux_nlmsg_lookup.
>   - Update commit message.
> v2: Reorder classmap.h to keep the new permission "nlmsg" at the end.
> 
>  security/selinux/hooks.c                   | 51 +++++++++++---
>  security/selinux/include/classmap.h        |  8 +--
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  security/selinux/nlmsgtab.c                | 27 ++++++++
>  security/selinux/ss/avtab.h                |  5 +-
>  security/selinux/ss/services.c             | 78 ++++++++++++----------
>  8 files changed, 126 insertions(+), 51 deletions(-)

Looks good to me, thanks for the revision.  We're in the merge window
right now so I'm going to merge this into selinux/dev-staging now and
I'll move it into selinux/dev after -rc1 is released.

--
paul-moore.com
