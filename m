Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA13CB2FA
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238920; cv=none; b=l8eBYXLtaIpnPqndqJQf6SMbMfemhQ8zdQjCGm6c7BOfmQPjNwJ2/MQ84VkwpwukFb6Up/dR33xl7o+vhepH2XgRbEq2SmuY2s/4UTbFx0uh2PqTdC4DBz+SbRhaJCBnzqG2aRE5OiLem1b/OZmBf+1b6Hr4tRvWyRaO4XHZtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238920; c=relaxed/simple;
	bh=uWW3GfZkGp+lrAWSyuTcF5Zh9hE2jXE38Cfkjb1RSLU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Gc9fjwnPfAQHehe53bOS55lIV9drJRyPhQBXYEcwL/ef25L27C4k7BKZ4pFusM8zRkwVhMSjOaIPHsfdk1QEezRpbKx5sXyEqOOmgiR5a8Zeq66ys/7U11Zp6gcbo/eg7w2a9tnrP6xM8VsHR8eO8mwUDNpw0VRXwTQKebnsY94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LopdPcmo; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LopdPcmo"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92c7a0a701aso541077985a.3
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784238917; x=1784843717; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hamHHJXfASh+6XcrqxU1lBmvfcJaMCZ67kq55CEfGa4=;
        b=LopdPcmoRurptvM5M2R5CGRt66yyrgl20/08udhEDom6qsvRSZpdY/2KR0Gnf9Kadz
         5JGCamoHhCXi57n/rQSVn887IDLcOT01EOnEATWq4Vb98jXXaev1p0R8SKbQzSkEL1Sx
         8pV9zwVQXhLzKezJiLvD2yayqlf7sTsjsjdrWC5A3vA5aM1aYiuBNb2IBqdifJzfjM0r
         WPEvo/dUCr8G+aP0NsFIDdzK6UOFtUu3aIOMMBpNFrWM08NoDVLkPIPOS+Nfa78pqTYu
         yYnD71U4V0Dxerd2XIRZPek5ZfEDXSvX94Nn4HH3EtIlpqEqoxfyr39QpqjBXaFRUowo
         KsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784238917; x=1784843717;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hamHHJXfASh+6XcrqxU1lBmvfcJaMCZ67kq55CEfGa4=;
        b=onGw7mHTJxYcpxXwgGB4YFGswEgcOPGdActUvqJlyndtecakbrhEpnkxS/faPLmXI3
         Tf7jMZdPZQw4dS1MCbcyjmMKhX60pBUC5Yjnanw7VQr3cctpC1NwaaPS6rC9NVBUHRSz
         SVtMmMaSPzfRXyVtci6nCEMRmiJTJttKG9F1kak8cQ4liW+jh4yQ5tuodRbh8ZhjgUj5
         y8nVMx2nGlb6S51oZR9qwyqrfexVJk+5BYvDiEwo7fucGdzPRSautwsKHCNgjqqnydkj
         mAe5JnLsx/nWTZp/JjgZyJTQ+G2dnSc4YSKUiSZXxA55KdDSI/6+9i0lLmLT4QYJBsC6
         DlIg==
X-Forwarded-Encrypted: i=1; AHgh+RqLzYPWNFSkiKuhBtKH//SXucWDtBMSPaTffQWeCqf+VMKUdxdrVle5EB0SrzJNe2xeWsQaB98r@vger.kernel.org
X-Gm-Message-State: AOJu0YzbgFzPHRHAr63XpUbUix79fkif/QYWlfZm/cdZrECSM2vzNmVh
	kx1J+nO2js7n7LVLrP9Ym1R+c0b7LzMD4MdwdsOXPpCsMGjZN5NvH2H4Z7oHrpm0Sg==
X-Gm-Gg: AfdE7cnXmg+eoqp8N8ueT4Hij8pQ8kBSPgPMLi/O/tUvjUgG2luDlzCQE336VvX6M+i
	GlzvlTgXKcwNiFzezqEKlZ2PylgXZZgwUM8uDQv4Icy+ab+q5L57hedsxk2ELwsV4eNMDWtgdeg
	0KAVYOUMYzcC7lBQTi1PQbOaEoRE/KK6O9g1B4iFEua3VzovlibpLcQ8wav7FvcXKe+tMVyyvNP
	HUibgOUxN0ahVR9EjdPnEIsA0Dn3ZPNInonOtmCsH8lb6mYLV9gMWnj2vIer2CF7JzpvZXKiuUT
	LGDucvsQccw7nISFBM9ix5ijf2+MIc9xFN+Vead3U4iZw1H/VWZfLpJzOlLkA21m8Q0/8+5Ce4x
	9fo/GMg8QQ9Gbx7dZahpsHvY/uiBqQg+umkssvLn8PQQWRngKH/1biz9RKuv096iSfRdJ3Z0Wvj
	eiHWvd18BqzOQqlAKdgSDOjfT0fA1GySCTfA8PlrxVhVI24Z4=
X-Received: by 2002:a05:620a:372b:b0:92e:c118:18df with SMTP id af79cd13be357-93083dedef6mr1775888085a.86.1784238917538;
        Thu, 16 Jul 2026 14:55:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm2097959785a.11.2026.07.16.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:55:15 -0700 (PDT)
Date: Thu, 16 Jul 2026 17:55:15 -0400
Message-ID: <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260715_1900/pstg-lib:20260715_1853/pstg-pwork:20260715_1900
From: Paul Moore <paul@paul-moore.com>
To: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, David Windsor <dwindsor@gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic  inode labeling
References: <20260708000956.46138-3-dwindsor@gmail.com>
In-Reply-To: <20260708000956.46138-3-dwindsor@gmail.com>

On Jul  7, 2026 David Windsor <dwindsor@gmail.com> wrote:
> 
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using security_lsmxattr_add().
> The hook now passes its xattr state as a single struct lsm_xattrs
> object, which the kfunc takes directly.
> 
> This kfunc is only callable from inode_init_security; the verifier
> rejects attempts to call it elsewhere.
> 
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
> 
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..ad0025f2264a 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -11,7 +11,9 @@
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
>  #include <linux/mm.h>
> +#include <linux/security.h>
>  #include <linux/xattr.h>
> +#include <uapi/linux/lsm.h>
>  
>  __bpf_kfunc_start_defs();
>  
> @@ -374,6 +376,39 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
>  	return d_real_inode(dentry);
>  }
>  
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +				     const char *name__str,
> +				     const struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	const void *value;
> +	u32 value_len;
> +
> +	if (!name__str)
> +		return -EINVAL;
> +	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +		return -EPERM;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	return security_lsmxattr_add(xattrs, LSM_ID_BPF, name__str, value,
> +				     value_len);
> +}

I'm sorry David, now that I'm seeing this function again, especially
with the LSM specific bits extracted into a LSM function, this absolutely
belongs somewhere under security/.  It's only callable from within a
BPF LSM callback and all it does outside of some BPF pointer boilerplate
is call right back into a LSM helper function.

If the BPF maintainers aren't willing to accept that, then we will all
need to find another way.

>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -385,6 +420,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
> -- 
> 2.53.0

--
paul-moore.com
