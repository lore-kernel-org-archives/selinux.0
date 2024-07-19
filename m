Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC3B644
	for <selinux@vger.kernel.org>; Fri, 19 Jul 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354887; cv=none; b=tChMrYQx5EXLpL0IoATFTNqVkss2xjj5+4IbVbvrAtR0oYGnr6AHuYejB/EEbl1ilW02TAjOMQjQB/NfBtUcWKeODOQiyKAALq2eLHbDtvrNu04E+isBlhsYnkFurnO0xxTpNy34OJEolhkBSQT4ATm5LkcDxOG1VJj1bYjTPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354887; c=relaxed/simple;
	bh=+jANaNZ1uHYDfjV0wEeG5sQYqdgRrNtGRZ39cOP++f4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=T43Je5izcg+1hD55iiT+1R+bzMlVEsHeT1wyYqJDbEaxlDXv/AJpAd3t1I1fuVz7djzjgIvt8ffLuQM0KUbRq6qwpLB4RA00vguHxaBz7CxpnQ7WCtjzWjntPvID7El7bhs8RvyjvJV20hb2K7db5bDRTW0YFZurW09SSdO/2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z5IJkzsp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z5IJkzsp"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so8355146d6.1
        for <selinux@vger.kernel.org>; Thu, 18 Jul 2024 19:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354882; x=1721959682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpUClzeR8WUAL/85YFkQrfnDMzFYM1Y27FAQCvWcN9Q=;
        b=Z5IJkzspjONUQy+7giNPV4aDWSsOissdYpbaeSMvt0Z/gCiSH7XXZjWpGE6JtjVHDQ
         UWA6acGP/+mktE1QmyJqL5Y9preDcRLimxsfvVDUkxmjkc/nTDhoE8f5LX3KLJn8HebB
         HARxX68tUmx5EX8lYQovIn7tJtMfuEyiUgBz4BDCSxCAwXvhURj7i/nl4f+rYh8N1B0E
         yT59fE6qtA54t9YB3eHlxtNWRTPqJ863KpWtFN1mdy9A+jrPCxnUCfKCN/0+bhKlbxpv
         ucrPHMb9WWtz9ZxV/OdXnzovCs5FnzUOXGNX7a0dJ+9agEioXNbHaC556heDk/9kBafW
         tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354882; x=1721959682;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpUClzeR8WUAL/85YFkQrfnDMzFYM1Y27FAQCvWcN9Q=;
        b=uRj408Je5R0WD7epmYRiYyNvOoD9QwgLGAenEF+JTSNW0gIL1kZcRV/QFDf6cGvZDN
         E8SRu8Y1WIiNzMGHp2KYIC6PgoTVCG+WceFIuKFG3nmj5CJooxtv/llUq6dcGjJ5LONJ
         ZVH7GNhe5XpzF2FfnUkf5+OU9ylag+f6rP9o/TuwUB4W8iQue+s414GbJogRao6ZwyHe
         ZYH1rc8UkdRokjajR4pEBzhWjzxkpk5Q+hSP5ZT9tGq5Z6kxo1JoiA+dHOwJlLWqNXA0
         cNcQohOiOs30BESTFnqOWJ9rp78m9iM6rZwBfqW4vgow1qXK4YAa9+nStumPT9RACM57
         td5w==
X-Forwarded-Encrypted: i=1; AJvYcCVsKvIIi00Uxk22vCGLFKWa6A+Z8WpWQIA7NE+F2uJ5G4kZ6jloYPzoAsVwP+BSzUGxMADo9NGoPxq94KHALVqSSfHpL2OfsA==
X-Gm-Message-State: AOJu0YyodjkHlXRMpeQgzJZWGkZAm6hlHVoFqjLGraLMcyKrLSZ1hAZn
	FcImt/TclFXpP3R+QGOmScGPtxp/e8qJFlRIC7HpUr7fN47++f5gye8NObfTSQ==
X-Google-Smtp-Source: AGHT+IHEUtiYsL4YugJiIyZ94uYFP7Pn9ZMTuclQ82/x8BDKHK0utglqJt/CxhW41ZG/NKpa0e+C4Q==
X-Received: by 2002:a0c:eb83:0:b0:6b2:a68e:6cf5 with SMTP id 6a1803df08f44-6b79cbe7860mr83634476d6.5.1721354882351;
        Thu, 18 Jul 2024 19:08:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acaf3bc3sm1717036d6.125.2024.07.18.19.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:01 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:01 -0400
Message-ID: <bae9304f6fd9ac9536f709a990085119@paul-moore.com>
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
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 3/20] lsm: Refactor return value of LSM hook  inode_getsecurity
References: <20240711111908.3817636-4-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-4-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook inode_getsecurity to 0 or a negative error code.
> 
> Before:
> - Hook inode_getsecurity returns size of buffer on success or a
>   negative error code on failure.
> 
> After:
> - Hook inode_getsecurity returns 0 on success or a negative error
>   code on failure. An output parameter @len is introduced to hold
>   the buffer size on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/xattr.c                    | 19 ++++++++++---------
>  include/linux/lsm_hook_defs.h |  3 ++-
>  include/linux/security.h      | 12 ++++++------
>  security/commoncap.c          |  9 ++++++---
>  security/security.c           | 11 ++++++-----
>  security/selinux/hooks.c      | 16 ++++++----------
>  security/smack/smack_lsm.c    | 14 +++++++-------
>  7 files changed, 43 insertions(+), 41 deletions(-)

Aside from Simon's concern over variable types, I saw a few other issues
when looking at this patch (below).

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 17d6188d22cf..ff82e2ab6f8f 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -485,7 +485,10 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
>  	}
>  out_free:
>  	kfree(tmpbuf);
> -	return size;
> +	if (size < 0)
> +		return size;
> +	*len = size;
> +	return 0;
>  }

We should do a better job converting cap_inode_getsecurity(), create a
new local variable, e.g. 'int error', and use it to store and return the
error code instead of reusing @size.  I understand that what you've done
is easier, but I'd prefer to see it done properly.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9cd5a8f1f6a3..70792bba24d9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3407,7 +3407,7 @@ static int selinux_path_notify(const struct path *path, u64 mask,
>   */
>  static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
>  				     struct inode *inode, const char *name,
> -				     void **buffer, bool alloc)
> +				     bool alloc, void **buffer, u32 *len)
>  {
>  	u32 size;
>  	int error;
> @@ -3440,14 +3440,14 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
>  						&context, &size);
>  	if (error)
>  		return error;
> -	error = size;
> +	*len = size;

Depending on how you choose to resolve the variable type issue, you may
be able to pass @len directly to security_sid_to_context().

>  	if (alloc) {
>  		*buffer = context;
>  		goto out_nofree;
>  	}
>  	kfree(context);
>  out_nofree:
> -	return error;
> +	return 0;
>  }


--
paul-moore.com
