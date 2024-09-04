Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56487E1
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409113; cv=none; b=hH3mr+I2MyIHEwExUX1TZRxs7EwukMgL2XtfhtGEUal8UdPpCz4ow5B7dpGm3LQpLCKdtrVy9Y4KoBcWeNcw4Us4NjBrdl3LRve/asmE95w/jjBPyFC13p3hMrJ0r9TBxDonxOM4P0AbmlDvEHN9vvKAzoetXM2VA2ZJl1d1FkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409113; c=relaxed/simple;
	bh=I15BAxDBUTieWy0IZOhhAk7ed0bPxi+spKKsUPhhz08=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=F+sJ/DvARsZ5DbGitXy01QpVUa1d0DspuZAl+5W0GnWzCCqTXVBcIcH1TuJfL2RFVS/I6Y6fXrN1hsC2TDqLSXbP7ZMyXhdpmuLr7lmki0PI6YdtbvA8kl+18UseM4NyWiKLjb2hOKhNN6hfBIeEyZZyzDMYVIpC9RzVQCXGA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CbVC1616; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CbVC1616"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso30823326d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Sep 2024 17:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725409109; x=1726013909; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ctskL29EfLAIjmAHt2I735/optYRiZRhKdp9ltI34F8=;
        b=CbVC1616GTFrLT1zAw2firYrSNh0M0SPwXVNQZ11//LhwuQH9hc9DuBpjDyOVo8CtK
         hZKHdTRBZhQVrgBRcx5sv/LasrK7PYesidlY1/mLh89QM2PMRO1iUGSIAodiSXYpcJNZ
         O86Di1daXES5wlfdY3UGDgy3NcslX/61UamGNH7BLuBX0j9mOLk4ZlQa4uY/Aj/4EMEH
         apZSC78VwGaCQFAt8xpDcoIQXdekTKczxdw1zFNFmKyVAsAdiBcrZJjy+f6FT8Zq3Zpb
         LVPCPL+dzYjjgHTS0LMt6eez4lDvzLw+wky0g0jD9n0fkakB3iaEFLnetHJdMIuxqu0p
         uARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409109; x=1726013909;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctskL29EfLAIjmAHt2I735/optYRiZRhKdp9ltI34F8=;
        b=C59T2WSOAsZci6ufQZ7dy+GhaseAV6X13YbF7XwSmO0UJ7NNmrDb2KaHyBLIow/cjt
         OP2nzaNPDtxoroX28fFVBqPv/AaTuBQQ+dVwtgOowJ5wlNDwx+sGgZvimy2TMXoq5We2
         jjqHHbmkOzcupcLfPjcbbSorVe3QkqRTcmRbwh+mMHrDLTY1LkSZSkMzIhk2N0P96i6L
         Wco/vMRzYAbSLCtWGJ9a2i2k9dOJ1ECuICY6lEAi93Q4G/Yp7YR9S5e1PK/liz+Ytf5S
         L4nyn2uojilzFPoC09SAZc5XcR/yleNbWz2tcTRWi21CKFj+NhCBI9V3Ouv2ydaz64uP
         DQcg==
X-Forwarded-Encrypted: i=1; AJvYcCVMd0EPOZFBXCOLGreCqBVCJjqn/vio1uGY2LnB5zClQxf7QMzP3DhtNnwkg7+jAwz6STUElfRM@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJQARe62VFjrDK3YDIacwIYt2mU78eG5lnkToI+1aCxzFV8to
	NcgKlREz9Ugw1HdtiNy+9ScN5smds9FicG5+YWOwm40OX7IEdRdhK3nHDXqGGw==
X-Google-Smtp-Source: AGHT+IFYJX0OQDlnuyOuBDrX8gGL7waDJfZYhEV62tEOWfBsBjGK1AKaf/72ZP06vAhwNwcLxyT9Jg==
X-Received: by 2002:a05:6214:4a06:b0:6c5:dc7:577c with SMTP id 6a1803df08f44-6c50dc75934mr51075426d6.2.1725409109526;
        Tue, 03 Sep 2024 17:18:29 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5122edbfdsm10390956d6.108.2024.09.03.17.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:18:29 -0700 (PDT)
Date: Tue, 03 Sep 2024 20:18:28 -0400
Message-ID: <0a6ba6a6dbd423b56801b84b01fa8c41@paul-moore.com>
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
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, apparmor@lists.ubuntu.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/13] LSM: Add the lsmblob data structure.
References: <20240830003411.16818-2-casey@schaufler-ca.com>
In-Reply-To: <20240830003411.16818-2-casey@schaufler-ca.com>

On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> When more than one security module is exporting data to audit and
> networking sub-systems a single 32 bit integer is no longer
> sufficient to represent the data. Add a structure to be used instead.
> 
> The lsmblob structure definition is intended to keep the LSM
> specific information private to the individual security modules.
> The module specific information is included in a new set of
> header files under include/lsm. Each security module is allowed
> to define the information included for its use in the lsmblob.
> SELinux includes a u32 secid. Smack includes a pointer into its
> global label list. The conditional compilation based on feature
> inclusion is contained in the include/lsm files.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: apparmor@lists.ubuntu.com
> Cc: bpf@vger.kernel.org
> Cc: selinux@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>  include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>  include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>  include/linux/lsm/smack.h    | 17 +++++++++++++++++
>  include/linux/security.h     | 20 ++++++++++++++++++++
>  5 files changed, 86 insertions(+)
>  create mode 100644 include/linux/lsm/apparmor.h
>  create mode 100644 include/linux/lsm/bpf.h
>  create mode 100644 include/linux/lsm/selinux.h
>  create mode 100644 include/linux/lsm/smack.h

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1390f1efb4f0..0057a22137e8 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -34,6 +34,10 @@
>  #include <linux/sockptr.h>
>  #include <linux/bpf.h>
>  #include <uapi/linux/lsm.h>
> +#include <linux/lsm/selinux.h>
> +#include <linux/lsm/smack.h>
> +#include <linux/lsm/apparmor.h>
> +#include <linux/lsm/bpf.h>
>  
>  struct linux_binprm;
>  struct cred;
> @@ -140,6 +144,22 @@ enum lockdown_reason {
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> +/* scaffolding */
> +struct lsmblob_scaffold {
> +	u32 secid;
> +};
> +
> +/*
> + * Data exported by the security modules
> + */
> +struct lsmblob {
> +	struct lsmblob_selinux selinux;
> +	struct lsmblob_smack smack;
> +	struct lsmblob_apparmor apparmor;
> +	struct lsmblob_bpf bpf;
> +	struct lsmblob_scaffold scaffold;
> +};

Warning, top shelf bikeshedding follows ...

I believe that historically when we've talked about the "LSM blob" we've
usually been referring to the opaque buffers used to store LSM state that
we attach to a number of kernel structs using the `void *security` field.

At least that is what I think of when I read "struct lsmblob", and I'd
like to get ahead of the potential confusion while we still can.

Casey, I'm sure you're priority is simply getting this merged and you
likely care very little about the name (as long as it isn't too horrible),
but what about "lsm_ref"?  Other ideas are most definitely welcome.

I'm not going to comment on all the other related occurrences in the
patchset, but all the "XXX_lsmblob_XXX" functions should be adjusted based
on what we name the struct, e.g. "XXX_lsmref_XXX".

--
paul-moore.com
