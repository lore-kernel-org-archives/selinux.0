Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BDEAC7
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023540; cv=none; b=qisJA16eo3gv5BBd1ltmuAfn25WUWSX1wc4vxVkDLVTnXsCQTo/0OP6sUAVQQ3zcCHC6YPLSMBPdLKU3zJ3bEPnvVsGOJKvkbXslHq71egO3FQY4QHZFbpXFbc3ZY7ahwSaRbfPCDe3zeNAlB7bqM+r5rigntCk+vFQIj5he2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023540; c=relaxed/simple;
	bh=kTESJIjnLh2iUzZrS5nNXmn45E/2gzWxb2HO4dTbt80=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=bmAeTw9U1cvT8HR51ncHucuHLUImf3Z7lQQyTdE1LsOv0MsYo8Dkuw2n8dxIIqFHT46TTV+dfo7zfCPQhIHZUsjw4Weczxe1PQA29E2VHH3g6V2BiDnrEEcgkkBUElwK9YaTZ9LCBrf+2Szan8DFt7fzqvhaJ9k1n70N3cR250o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CidJe68b; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CidJe68b"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78bd7d306d6so196214085a.1
        for <selinux@vger.kernel.org>; Mon, 01 Apr 2024 19:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712023537; x=1712628337; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=673vxTCBsMoin/XyLHaXT7ifjDYyGSKEp4ZoPOVVSIw=;
        b=CidJe68b2KDfMsaMNvLlrXKbCAhDD8poawKG4EjYuusHXUun9UgO/PvDscTstZsa3F
         PsVDGeVw7wL+dHzbrk3c3FLLadJhIN3VLcPDmL3EPgaWl2vjeQCTsuZrilRdK35z7LEP
         SYtl51ykVnkvvx2sO+ZO+AAUlw7+ifMiqctquTRxXJb2ITry7qHVwKRoGZFZTJR0JeRX
         K9zKb1RlB3NXA1q3BCxN6KMXZ+R4xUOvtbQCe2Mk5fjdOmavNpFhFG4kOQxI58jzH5s0
         d6TeE9Lrld8+2V8DsV4wOeOWd+fYJaBgAwXyJSEzUS71zCfpA9jgVwd8as8I9zuD/OVj
         U7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712023537; x=1712628337;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=673vxTCBsMoin/XyLHaXT7ifjDYyGSKEp4ZoPOVVSIw=;
        b=RlhqcgrR40rylvfyVB0BcGk6u2UaQV/yAa1EaVgYEAgKmA1aZ5PDBUjAGwWAIjZxCn
         XQBTkuLC0LNysBZNWomEWuOAvWvMXJcTXhFrY80feXdThtXEfWZ2x6mbU66WP1J7UPDe
         GOGdZPdxrESj/WbvXbvUhpHz7asDP9w3g+zuLenGjnAI5z87cTW2idVkSBw0v4j1/ppg
         dRvNbHFaZ9QYCi1qP11ejtocYcAUBQ05y/STTiuPY4+/ig+MndH37InU8sb+ioObvd8F
         GmxSlOLMq6L3fNPTyb5BBDxhmIbFDcJ6SBP/gFm8wvVymnXH57apJkhCuAlnRlLimxLF
         U0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUm0ecPS9o+6XEjH+xvLeSFV5Xyehnrrwj7llVrDw0OObccNpfGvXyPjJEbHPFLWWp1thlq0f8ECUSZakh3juvt9whG4O5nuA==
X-Gm-Message-State: AOJu0YwtU5qR5c/8UpaTjyCreVxC9jHOmGclrxeowuZu/6vdaT0+7Nz1
	ERH4V6ZQb5fDeBSr65IdoyC8qYZnTqIlkEI88mrZMpDsSpfk/dDUXaFPhm858w==
X-Google-Smtp-Source: AGHT+IHyWlw0kULPIY1VAwRk0ivgLnWEgDEkbUR9Ndffc5TB+QQGY3DooRe001Kn40blj523YwmQ5w==
X-Received: by 2002:a05:620a:6403:b0:78b:d152:703f with SMTP id pz3-20020a05620a640300b0078bd152703fmr15859894qkn.21.1712023537502;
        Mon, 01 Apr 2024 19:05:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id a5-20020a05620a02e500b0078bdce0acecsm1816630qko.80.2024.04.01.19.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 19:05:36 -0700 (PDT)
Date: Mon, 01 Apr 2024 22:05:36 -0400
Message-ID: <c5bd8689343995e38ff90368013dd80c@paul-moore.com>
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
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] selinux: avoid dereference of garbage after mount failure
References: <20240328191658.210221-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240328191658.210221-1-cgoettsche@seltendoof.de>

On Mar 28, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> In case kern_mount() fails and returns an error pointer return in the
> error branch instead of continuing and dereferencing the error pointer.
> 
> While on it drop the never read static variable selinuxfs_mount.
> 
> Fixes: 0619f0f5e36f ("selinux: wrap selinuxfs state")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index d18581d741e8..7e9aa5d151b4 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2125,7 +2125,6 @@ static struct file_system_type sel_fs_type = {
>  	.kill_sb	= sel_kill_sb,
>  };
>  
> -static struct vfsmount *selinuxfs_mount __ro_after_init;
>  struct path selinux_null __ro_after_init;
>  
>  static int __init init_sel_fs(void)
> @@ -2147,18 +2146,21 @@ static int __init init_sel_fs(void)
>  		return err;
>  	}
>  
> -	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
> -	if (IS_ERR(selinuxfs_mount)) {
> +	selinux_null.mnt = kern_mount(&sel_fs_type);
> +	if (IS_ERR(selinux_null.mnt)) {
>  		pr_err("selinuxfs:  could not mount!\n");
> -		err = PTR_ERR(selinuxfs_mount);
> -		selinuxfs_mount = NULL;
> +		err = PTR_ERR(selinux_null.mnt);
> +		selinux_null.mnt = NULL;
> +		return err;
>  	}
> +
>  	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
>  						&null_name);
>  	if (IS_ERR(selinux_null.dentry)) {
>  		pr_err("selinuxfs:  could not lookup null!\n");
>  		err = PTR_ERR(selinux_null.dentry);
>  		selinux_null.dentry = NULL;
> +		return err;

Casey's correct in that we probably don't need this, but it does harden
the source a bit against future changes so it isn't entirely a bad
thing.  If nothing else, some new kernel dev will get excited writing a
oneliner several years from now that removes the redundant return; I'm
getting exited about the patch just thinking about it.

Anyway, thanks for noticing this and submitting a patch Christian,
beyond the above nitpick, everything looks good to me.  I'm going to
merge this into selinux/stable-6.9 with a stable marking and assuming
all goes well I'll send this up to Linus in a few days.

Thanks!

>  	}
>  
>  	return err;
> -- 
> 2.43.0

--
paul-moore.com
