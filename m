Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48844A0907
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378384; cv=none; b=RxB1L1aaxJOvIUoSl1Oxw/MNifLcioY2TAZriJhcSjGRPirjvJA/FBg91KaItrCo7Qn4CuFyUl4omEYu30OEt3l5osltHeR7oM+5FP6/dpWj5zAt12VKJt0WC/K0TOexw/7aCMEWdMtO3QRXL7I3WEltcEwNaq9RLCYFrTP862M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378384; c=relaxed/simple;
	bh=9o4I5IA0N0Vyww8diDTSS7y0DUXc7GHjj/9ATFxbFds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdgDlpAHPAx5S8FnF99oa8v8CSwjiF+8ws+cf25iD+GtOsgIo9zE03My+N17dGONyik+zNseWj2l6pKtksh5Lbky77KDjfqJ1wr7roKN6eSwnxb0GWxc/qkBK3iYFPBFkrM6s7VTu4tUrQhBBcTJgHGsQcpOhXp+W7mmx/6jVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=gGQJ/txS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="gGQJ/txS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b056d58f2aso12778887b3.2
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1791378374; x=1791983174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXOlnv8Mnbf+lGsmRijGuS/+ytbYDupF+ie7vEad2RE=;
        b=gGQJ/txSflR4n9uSCqbmG8KAS3Cqv/NIaZLfBY2buqdJwycDzHOFOxltgTk9nYmeQa
         RfY8l+AoBkti2MO1IhMHyigaOTW6In+Y/SVTKBr/3binqW8BMCyAP0rqimve3b5dhAHB
         O3AHrNui8gMw4NNvPg+3FZvls/vGUQ893d3us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791378374; x=1791983174;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXOlnv8Mnbf+lGsmRijGuS/+ytbYDupF+ie7vEad2RE=;
        b=aEMagcI4aTmV5/MSPJBdW5zrH+SsFabQ5bQpdbUiW4k0nC8vn294hlDoCR5oJyqAF8
         RmnGxt+phTvd8qqnM+hK6bQf2BYWsjZAN9nDohQhU8A7oquWiM0Ffi526NcfNqtVKb4B
         6Iergpgr0AzPwGnIFz0HNQvB3VMqCLwsvsx5DyynWCLIq9W4UiPfSGSGxy+JbN2/4Dij
         +HHZRC+WAJpsPNZ8CQFDYThTD7aeto2lLnDtJaEQqBVVbWfPSg9eVv7xe4DKKFo5x6G4
         i+RXEufIi0M0OZCsGkjAWWm0mAOcMm77H/jBvPlzq3fLSfv3yHU5+ypP9URGIhyJ9uPo
         kTuw==
X-Forwarded-Encrypted: i=1; AKwUvByIOqLhVwmfA0/+X/pnim9uV4mFu73ddoJiKf3/uxtrYy49yk5N3g4wGWUxs17a+7uPFgnPqfek@vger.kernel.org
X-Gm-Message-State: AFq9FYKh+b6amDH2+gP29vPkFq2+JmSW6SwSMsE3vh51z9+oZyALOeeQ
	GraChX6idV3ptk/HlB317O1Vdz2brxrvotGxfDMhhrZUiyphOmhORgW+7wUitRWVcA==
X-Gm-Gg: AYBFou2DF4eJC4AIjJ5AXEO4gBISdaP7XuO0jThRSkCK3RQfsq5QgZpEyndOazNYnu5
	n4CeTsbpPc/20AULH7773S57O94mH1kmTPzV+Lp8QQzwHF+WjDwe/XRZh2RZTZ7mpB2Ub8oBtHx
	Yx9aZ2mKEZtGCGxIS50GrADmWC62GpZtlZT9SpYs507AADO4ZLAZo4tfo4dBB2jCOvq+pvJkh7l
	u/Lk5N8QFphoLXQLWZK8FSbhKqv3EUw9WMrqEBuH5ZIhsvX+kctdECjb36yYMrMZCSL/gnD14dJ
	d06SIsHOcS1XzMfHrAhGr/QWdAjqT5dVEMQmU7rnLNfU7fkHpFnjPcq43XBsWWhyE44lzqL8oWC
	ZubyJx9gtwaBSpspe0rYQZfRv77R+N9X01dS+WKuQdYXdhgsjeRgRH6sJAoWQ+DvJXLjBVujmDF
	/5TTB9Ihr0M7k4xy/kBdVsarY/Xg9MurAqHEZ8umOFd55TGdRVTXX/E3V0geTcwqWN5qAaGlx6O
	oQ6Sl3REjRRydXjEsNq0XhvP5j6HWXg6p3BIKBi/Fo=
X-Received: by 2002:a05:690c:5705:b0:873:5bb2:6c31 with SMTP id 00721157ae682-8b05b1170e8mr11068287b3.56.1791378374073;
        Wed, 07 Oct 2026 06:06:14 -0700 (PDT)
Received: from ?IPV6:2601:145:c282:5650:1bef:dc06:8ab2:b604? ([2601:145:c282:5650:1bef:dc06:8ab2:b604])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996cb9f4csm19757816d6.12.2026.10.07.06.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:06:12 -0700 (PDT)
Message-ID: <37badcb1-92f7-4289-a965-5fccec5638c4@ieee.org>
Date: Wed, 7 Oct 2026 09:06:09 -0400
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH userspace 09/17] libsepol: add policy properties API
 and public constants
To: jan janasek <jjanasek@redhat.com>, selinux@vger.kernel.org
Cc: Juraj Marcin <juraj@jurajmarcin.com>
References: <20261006130215.128405-1-jjanasek@redhat.com>
 <20261006130215.128405-10-jjanasek@redhat.com>
Content-Language: en-US
From: "Christopher J. PeBenito" <pebenito@ieee.org>
In-Reply-To: <20261006130215.128405-10-jjanasek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 9:02 AM, jan janasek wrote:
> Add sepol/constants.h re-exporting AVTAB_*, OCON_*,
> SECURITY_FS_USE_*, and related policydb constants under an SEPOL_
> namespace (with unprefixed aliases guarded to avoid redefinition
> conflicts for callers that also include internal headers), so
> consumers no longer need policydb/avtab.h or policydb/services.h just
> for these values.
>
> Add opaque-policydb properties: sepol_policydb_mls_enabled(),
> sepol_policydb_compat_net(), sepol_policydb_set_permissive_flags(),
> and sepol_policydb_rebuild_attr_map() for maintaining the type
> attribute map after modifying type/attribute membership.
>
> Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> Assisted-by: LLM Cursor
> Signed-off-by: Jan Janasek <jjanasek@redhat.com>
> ---
>   libsepol/include/sepol/constants.h         | 231 +++++++++++++++++++++
>   libsepol/include/sepol/policydb.h          |  29 +++
>   libsepol/include/sepol/policydb/avtab.h    |  33 +--
>   libsepol/include/sepol/policydb/policydb.h |  68 +-----
>   libsepol/include/sepol/policydb/services.h |  19 +-
>   libsepol/src/policydb_public.c             | 203 ++++++++++++++++++
>   6 files changed, 486 insertions(+), 97 deletions(-)
>   create mode 100644 libsepol/include/sepol/constants.h
[...]
> diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
> index 98357ee4..967bce3d 100644
> --- a/libsepol/include/sepol/policydb.h
> +++ b/libsepol/include/sepol/policydb.h
> @@ -87,6 +87,11 @@ extern int sepol_policydb_set_typevers(sepol_policydb_t *p, unsigned int type);
>    */
>   extern int sepol_policydb_set_vers(sepol_policydb_t *p, unsigned int vers);
>   
> +/*
> + * Get the policy version.
> + */
> +extern unsigned int sepol_policydb_get_vers(const sepol_policydb_t *p);
> +
>   /* Set how to handle unknown class/perms. */
>   #define SEPOL_DENY_UNKNOWN 0
>   #define SEPOL_REJECT_UNKNOWN 2
> @@ -94,12 +99,19 @@ extern int sepol_policydb_set_vers(sepol_policydb_t *p, unsigned int vers);
>   extern int sepol_policydb_set_handle_unknown(sepol_policydb_t *p,
>   					     unsigned int handle_unknown);
>   
> +/* Get how to handle unknown class/perms. */
> +extern unsigned int
> +sepol_policydb_get_handle_unknown(const sepol_policydb_t *p);
> +
>   /* Set the target platform */
>   #define SEPOL_TARGET_SELINUX 0
>   #define SEPOL_TARGET_XEN 1
>   extern int sepol_policydb_set_target_platform(sepol_policydb_t *p,
>   					      int target_platform);
>   
> +/* Get the target platform. */
> +extern int sepol_policydb_get_target_platform(const sepol_policydb_t *p);
> +
>   /*
>    * Optimize the policy by removing redundant rules.
>    */
> @@ -148,6 +160,23 @@ extern int sepol_policydb_mls_enabled(const sepol_policydb_t *p);
>    */
>   extern int sepol_policydb_compat_net(const sepol_policydb_t *p);
>   
> +/*
> + * Set permissive flags on types marked as permissive in the policy.
> + * Must be called after policy load to enable permissive type enforcement.
> + */
> +extern int sepol_policydb_set_permissive_flags(sepol_handle_t *handle,
> +					       sepol_policydb_t *p);
> +
> +/*
> + * Rebuild the type attribute mapping. Call after modifying type attributes
> + * to ensure consistency.
> + *
> + * On out-of-memory, returns -1; the map may be only partially rebuilt in
> + * that case, but the policydb is left in a self-consistent, usable state.
> + */
> +extern int sepol_policydb_rebuild_attr_map(sepol_handle_t *handle,
> +					   sepol_policydb_t *p);
> +

I'd suggest a single public function that calls functions like these 
two, e.g. a function to initialize policy queries. Otherwise it exposes 
internal details that users don't need to be aware of.


-- 
Chris PeBenito

