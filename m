Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1E1AC448
	for <selinux@vger.kernel.org>; Wed, 11 Sep 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082727; cv=none; b=cQ4KybdPEowawz2Q+oEm9uzXyVN+bNyHGopaVWVYnq9sQUuH7/B/yKhLJRmjpz0f6Xwbsy6YpUWIE2e1vdnB9gkoge/zYEQuA1h9A6X4nhNON49ZOKZD2X/bav8cTMQFvv5L5aaPSs7oKp0VkXX+bVWUMrsNRHQZUat4Jebz1F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082727; c=relaxed/simple;
	bh=HrZLd3RN0GwN/78EJgAmhruA3Xu/RgTFqnGqUDR1rPE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=dwTuF4Kj6I03Sxj5CBX/TVyrsiAKi55S+N544xWwZN90m7sPa6kqUAoxLBcmCcpsNjM0lM5RM8ysMTatFct1myzrEm/9KOfj9obKccLjWCPWufs5MQFXyky1nMsXKtIOFWp0h2ToU2D1MBk/qnLS7GCTHY1eOK4aaL3USFnhpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=edFmD4ZI; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="edFmD4ZI"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6daf1c4aa86so1506587b3.3
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2024 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726082724; x=1726687524; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Z6UsGUgmAOGOWhylt9cmoaDPhfVrxzzh+/nc/iNDCs=;
        b=edFmD4ZIi2QzZ9xKXPttxnZ7pkiUrOQb98Ll23vGx0cG0VQbnf4Gn1h9a1UCQIx8WW
         5x9ZWxo17hdRG4CQbI2QXdyzCY69n6RpBPZCcC6OK2q50A9sSGsZ93LQ1szzHS64TrSw
         txaSfkyhYEJD9jWGDcxPXCYlvm33TsInJjqcaF7j558KgJAeH803Jkv5JeB3EXm9WX2m
         DqATYjgUOPVLkhVlPYt7sT46AIiLZ4BCIDFVJ/g5BUMxaKvpBafKe2y+xf99un6Y4FML
         xmJ73TXP9jC/6oH+bPDumV4SDEllFbbAOt+RmIVpVPe380pJGCMOHKtZ4PhMoUjsTiVf
         86IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726082724; x=1726687524;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Z6UsGUgmAOGOWhylt9cmoaDPhfVrxzzh+/nc/iNDCs=;
        b=QddgXwYLwRzlOThayg8+UG2fmRvJrUL9+7QJMbNIBNAV0YdVFfMkPl6mYDuqul8ghm
         sJGXsKB06UDbnRFl2lcd8IhxJuRL4Hm+/Iq+zgDnY05waR/lwmR9YmgkUnQG2OaeRu/V
         3rUPa4UBjNkjFyafJCJIjPOn0MMtC9j2AeSzVZas+jXWK/WzKqfTkeqJzoPQiC40MmWg
         IIB6i/j1Eom2fyAzECT+lRguDLRWfkilu+td7U77OTSnTqHbKFZsXkmN9ThR+i7u4hwN
         S5/BY3vlra9oYdBkrMjgoaeCskWJvs/l3OVd/Egy9LizmBYGo7XGrqQ5bFvGhI2y79/H
         ssZA==
X-Forwarded-Encrypted: i=1; AJvYcCXi/lLGPVPYPdlW/cAsZRXJusyAWllPCj3Oo5jmk7/wJ0E0ys1xdxRFolOkZtY7zjomp4rDreaj@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3Q4TOdF9Ug9Sywg9u7JZsRFGJf+/awUaw4YjzkTBbSBNG/Ag
	FuQue1uKA2XDSDvT096GFp7tUT4oJHpL6SYmpehy/DCF+LfE7IFMQq0dBn/VVw==
X-Google-Smtp-Source: AGHT+IFkpbPJq05z0xbEnFKw/+pa+VTPJtHFKWJRJ+/l+ZOUBsHmgm9u2WgYRTG9kj+EXNiUvcOAUA==
X-Received: by 2002:a05:690c:dcb:b0:62c:e939:2ffe with SMTP id 00721157ae682-6dbb6aef38fmr7336257b3.7.1726082724071;
        Wed, 11 Sep 2024 12:25:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a0368esm457164085a.93.2024.09.11.12.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:25:23 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:25:23 -0400
Message-ID: <abd932461647a78bd20694855fe2e60d@paul-moore.com>
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
Subject: Re: [PATCH v2] selinux: Add netlink xperm support
References: <20240910013535.3680953-1-tweek@google.com>
In-Reply-To: <20240910013535.3680953-1-tweek@google.com>

On Sep  9, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
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
> The class NETLINK_GENERIC is excluded from using this extended
> permission because the nlmsg_type field is referencing the family id
> which is dynamically associated.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Signed-off-by: Bram Bonné <brambonne@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: Reorder classmap.h to keep the new permission "nlmsg" at the end.
> 
>  security/selinux/hooks.c                   | 56 +++++++++++++---
>  security/selinux/include/classmap.h        |  8 +--
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  security/selinux/nlmsgtab.c                | 21 ++++++
>  security/selinux/ss/avtab.h                |  5 +-
>  security/selinux/ss/services.c             | 78 ++++++++++++----------
>  8 files changed, 125 insertions(+), 51 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 400eca4ad0fb..d1ef898a8481 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5964,7 +5992,17 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>  
>  		rc = selinux_nlmsg_lookup(sclass, nlh->nlmsg_type, &perm);
>  		if (rc == 0) {
> -			rc = sock_has_perm(sk, perm);
> +			/* For Generic Netlink, nlmsg_type is mapped to the
> +			 * family id which is dynamically assigned.
> +			 * Ignore extended permissions for this type.
> +			 */
> +			if (selinux_policycap_netlink_xperm() &&
> +				(sclass != SECCLASS_NETLINK_GENERIC_SOCKET)) {
> +				rc = nlmsg_sock_has_extended_perms(
> +					sk, perm, nlh->nlmsg_type);
> +			} else {
> +				rc = sock_has_perm(sk, perm);
> +			}

I agree with your approach of ignoring xperms on generic netlink sockets,
it seems like the only sane thing we can do, but aren't we always going
to fail a SECCLASS_NETLINK_GENERIC_SOCKET check here?  It looks like
selinux_nlmsg_lookup() is going to return -ENOENT in the case of
SECCLASS_NETLINK_GENERIC_SOCKET which means we never hit this chunk of
code if we are checking a genetlink socket.  If selinux_nlmsg_lookup()
returns zero, I believe we only need to check if the policy capability
is enabled before doing the xperm processing.

... or am I missing something?

Of course if selinux_nlmsg_lookup() were to gain generic netlink support
then the check would be necessary, but I don't see how we could ever
properly support generic netlink using our current mechanisms so I doubt
this is something we really need to worry about.

>  			if (rc)
>  				return rc;
>  		} else if (rc == -EINVAL) {

--
paul-moore.com
