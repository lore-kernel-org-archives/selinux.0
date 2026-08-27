Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928231E85B
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866604; cv=none; b=lJnmjJlBERu3S4L3qb3sonjuXKY69HKN3DvPUrL8hHVElLEhHtqNat4TZXbHKmFBSw0qGd2PX1nVSAva3G0xukNtTlVycrYWvRsLYBVW56aoSfFtAIkutwW2z0ZoNW5Ualjg9PRBDjG1/w7N/lgile8pD5OB6h8XQbXhZb4a4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866604; c=relaxed/simple;
	bh=HTxWs60pJeBfauZqrT7ef4kYrnauxG9yWQfa/9DFO04=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=cp3v8CH87YdjXbEVAE15sSLhaAnTaXQvjQYXqmV4LyrYTicvlPrXDmc6urgWybRhTT510jAPMewSMVAyTV8XNnWLnjOloU35Gmj6XebH9Ham+Wd4mvegL+ajYEpTAhpP/hMUd7idBArGj6LRIf6W1tIwlRDpBVbWZJWFLSWVXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cp4WlGSY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cp4WlGSY"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90cbdb54616so2172536d6.1
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787866598; x=1788471398; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYT7t3mDQRHkTvn2PV8Oo5KW/xjV9bxjgnJUZLqH+oU=;
        b=Cp4WlGSYVTI9RRbS4Eo7uBVkXweAs8qQvwM4OjL51tKnnIGZnl7lerODCCtIu+WrUZ
         qZlafdTXauvOILgfmAZ9ysrh1fQ6Zt4sIF2RmGydWVHyc/sIsNPDzioY2f5VelHt3V/v
         qw6RMbI/qNY/jC5c1GQMrBAwqfG/yodFrGeqc5OTJ+bJDxsRSH5a98fWAJ3hZ9Ai9cve
         JD2zo62vtOFjJRl+QLSks3El3lLEJHx1aZJhFS/U1gfkd2jiMw7AD2Wjk3XoDx1WSoiG
         GYBq8xr8/Cew62iQBTn5UynK8zACUiDmcUOkuMrpF9xhqVzHZRE0pc1ABdDi0PG/Yu37
         zN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787866598; x=1788471398;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYT7t3mDQRHkTvn2PV8Oo5KW/xjV9bxjgnJUZLqH+oU=;
        b=qLlONot21V5rFuVQnzGrdOmu1T71Z6Cx9++Ree8GS6Qmga8B4G28ZQOmUzLlBPy8V3
         csORInLIToDEXWiYIua8Pq+xK6Cpz9p33jDojzjATJ5uq4a8YAlthRf8+PSJUoCI/kdx
         NBmk6idmtzbT9JQ80qC+WVjIY1mTVYFzqZhi0puKfpnkfGtbwAlWzRN/ts/YblbjxVb7
         rHVaONokgrFxy/iqvdvFn8Hy5iEpASJC11nhKLWBzDbgOD80XIAbfFLYZwqI+4RK0KW3
         nTFsgSx2wgzsE9WkTnFHVlCT6KMlG2arhyuD0DZVwOenDWyhLSqXqpgovyvrD7cwDZ2F
         H/OQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQjXXoqjfH4YxIQE/mYgj+iPnhWHWBPNak6C3dpVTtppc5v7wC2h6yjBo+0KyUZ/Kg1rFPBIiU@vger.kernel.org
X-Gm-Message-State: AFuF++k5iO4jgQjj18izbE9nYuO9Ybb8ua7I0eJWkRb0BvAnSQ1K3nr4
	PZAioeqh0FadPo/Hcve+E7JVwBUpdiXs5vmQIUWKj3vtIRvmYLSm6Jl5v16K/Ms1hQ==
X-Gm-Gg: AR+sD11HJpqtHTcURsbMlSQmWk5KqsVLWGK1/+GN0FPnX7Z172oiiEl67Mf5AbINOlo
	dpBtAKej7wpuUnnSm1qHNIjnAziUq9MmGR5q8GzWbpCf669A3MZzV6zzepi/cob4KHOvQxRkAm2
	/MXHYnoMKZK2gfMD5CrO521kVJOS1PUQ+tPp91VK+zwAzMBx+1TE3EnhtGYzklC6zko3JWYGQx7
	G4QqqY2P9jik4R5NQoXlkd4gZtAhg/bLExRoWQ224O4hcte/rwR6DAlV6UmTnrTdPAr5m2hAwaw
	cG8PJDzjedug4I+ngiHEu6ZPAs1K8kT0iZE5veTCoxeeNFVDDs1ymODh7cy3itA+PoYiHIoqYAM
	yFYU7rnFLJGhtqofnktC9cejc5N7mwjQJRjXnCsFc+FGD75ctU55ug5FpW4vdh6B9mJrvC4+V6o
	uWwCGJe9BjpeYNGzl4Hu2ZYaMz1LCE0GhftSprSRwC7uQkRwIZ1wKu31grEZnSi6WGyX8FoPjO5
	k3jNAzFOkLRrkWP+zDVm0Fo5GHYp2BiUQ==
X-Received: by 2002:a05:6214:33ca:b0:8ca:f47:25ea with SMTP id 6a1803df08f44-90ce0b204b9mr37542276d6.0.1787866598325;
        Thu, 27 Aug 2026 14:36:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd700c007sm26175476d6.6.2026.08.27.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 14:36:37 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:36:36 -0400
Message-ID: <876b917a5d999b14351073aba6aece2d@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260827_1501/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: danieldurning.work@gmail.com, selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, brauner@kernel.org, mic@digikod.net
Subject: Re: [PATCH RFC v3] selinux: implement namespace_init and  namespace_install hooks
References: <20260528183828.47756-1-danieldurning.work@gmail.com>
In-Reply-To: <20260528183828.47756-1-danieldurning.work@gmail.com>

On May 28, 2026 danieldurning.work@gmail.com wrote:
> 
> Add implementations of the namespace_init and namespace_install
> hooks for SELinux. Corresponding permissions are defined for each
> hook (create and setns, respectively). Additionally, mount
> namespaces have a create_anon permission to control anonymous
> mount namespace creation separately. New security classes are
> defined for each individual namespace type to allow granularity.
> 
> In namespace_init we check the caller's SID against itself. When
> a namespace is created the SID of the caller is saved in the
> namespace security blob. This SID is checked against the caller
> in namespace_install. We fall back to SECINITSID_KERNEL if
> ns_common is pointing to an init namespace, since these are
> created before policy load and will be lacking a security blob.
> 
> Requires Christian Brauner's revised namespace LSM blob patch
> and Mickaël Salaün's v2 LSM namespace audit data patch, which are
> the first 2 patches in the series linked below.
> 
> Link: https://lore.kernel.org/linux-security-module/20260527181127.879771-2-mic@digikod.net
> Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> ---
> Changes in v2:
> - Added the create_anon permission to separately control creation
> of anonymous mount namespaces
> 
> Changes in v3:
> - Rebased onto v2 of the LSM namespace blob/audit data patches
> ---
>  security/selinux/hooks.c            | 69 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h | 12 ++++-
>  security/selinux/include/objsec.h   | 10 +++++
>  3 files changed, 90 insertions(+), 1 deletion(-)

This looks good to me with the exception of one thing (below).

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 95d0fb20d84e..94ef03b65e9a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7010,6 +7037,45 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
>  	cp->id = LSM_ID_SELINUX;
>  	return 0;
>  }
> +
> +static int selinux_namespace_init(struct ns_common *ns)
> +{
> +	struct common_audit_data ad;
> +	struct ns_security_struct *nssec = selinux_ns(ns);
> +	u16 sclass = ns_type_to_security_class(ns);
> +	u32 sid = current_sid();
> +
> +	ad.type = LSM_AUDIT_DATA_NS;
> +	ad.u.ns.ns_type = ns->ns_type;
> +	ad.u.ns.ns_id = ns->ns_id;
> +
> +	nssec->sid = sid;
> +	if (ns->inum == MNT_NS_ANON_INO)
> +		return avc_has_perm(sid, sid, sclass,
> +					MNT_NAMESPACE__CREATE_ANON, &ad);
> +
> +	return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad);
> +}
> +
> +static int selinux_namespace_install(const struct nsset *nsset,
> +				  struct ns_common *ns)
> +{
> +	struct common_audit_data ad;
> +	struct ns_security_struct *nssec = selinux_ns(ns);
> +	u16 sclass = ns_type_to_security_class(ns);
> +	u32 sid = current_sid();
> +
> +	ad.type = LSM_AUDIT_DATA_NS;
> +	ad.u.ns.ns_type = ns->ns_type;
> +	ad.u.ns.ns_id = ns->ns_id;
> +
> +	if (!nssec)
> +		return avc_has_perm(sid, SECINITSID_KERNEL, sclass,
> +					NAMESPACE__SETNS, &ad);

In which cases do we expect to see "nssec" equal to NULL?  If this is a
possibility, shouldn't we be checking for the "ns" parameter to be NULL
and not "nssec"?  I'm asking because selinux_ns() shouldn't ever return
NULL, and if the "ns" parameter has a chance of being NULL then we risk
a crash from the dereference in selinux_ns().

> +	return avc_has_perm(sid, nssec->sid, sclass, NAMESPACE__SETNS, &ad);
> +}
> +

...

> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index b19e5d978e82..ea14bfd52a3f 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -27,6 +27,7 @@
>  #include <linux/msg.h>
>  #include <net/net_namespace.h>
>  #include <linux/bpf.h>
> +#include <linux/ns_common.h>
>  #include "flask.h"
>  #include "avc.h"
>  
> @@ -182,6 +183,10 @@ struct perf_event_security_struct {
>  	u32 sid; /* SID of perf_event obj creator */
>  };
>  
> +struct ns_security_struct {
> +	u32 sid; /* SID of ns obj creator */
> +};
> +
>  extern struct lsm_blob_sizes selinux_blob_sizes;
>  static inline struct cred_security_struct *selinux_cred(const struct cred *cred)
>  {
> @@ -270,6 +275,11 @@ selinux_perf_event(void *perf_event)
>  	return perf_event + selinux_blob_sizes.lbs_perf_event;
>  }
>  
> +static inline struct ns_security_struct *selinux_ns(struct ns_common *ns)
> +{
> +	return ns->ns_security + selinux_blob_sizes.lbs_ns;
> +}
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  static inline struct bpf_security_struct *
>  selinux_bpf_map_security(struct bpf_map *map)
> -- 
> 2.53.0

--
paul-moore.com
