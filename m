Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3073F107F
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879452; cv=none; b=bMEVyw2b5rbV6GrGVJUYjnN3cspKU4upaVfgaw+XvF65QrIyCrcYWkF51ZqnRamzjaC2XuoVGIHMwlk0bF2LiunuhaLDScOG1lPPBuuLrogcKXWwqsgrxFjUJznarme3/+68PLrZE6d0vQM2fMfgKuieHrZUfpGYrGXUJ7dMkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879452; c=relaxed/simple;
	bh=NFG1n41lVJCrqXWncd4MldYqy9CGGkGjSMKD/ApclJM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KhlmWFJ5hQxJok2sulmzBWZ37MlhQJRMJO1+IRgT/Yrjb35ljmn8qNeNF/VZP7I3ws2TBBAjydooCTlM16Z3GBRhhz1fQ71sCBfZ86FqHRCDi6R+0Vg7X1njQm0rx63Oe6bsY2wnuc14DHo6W36TPXovWAQC/a7sdxhKxwHk30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DiexHerO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DiexHerO"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9390a2c8909so26091485a.0
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787879449; x=1788484249; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DqRGrR0heNmSPrtTW9+v9FKZZ7RwzxehXvY0MCzvxnw=;
        b=DiexHerO6+IFexSx6JA9an3k0XR2yhU62zhjz0PIvuFDUeoTTa7PZx2vVbdtp+2Z+z
         fc4/yiZkz88x+eA0bilvSLbQdQxku2hqt4Ux3oQ5feErrmumPEYW3wmV/eQBfe9H9pes
         eqhf0xDOkQR1MnNJEiEcdmlv+jiEkVtHG559KcdmkmqYb+5BIMgRvvc/FFNAE35xFpbJ
         xq5Xu7O3xZCNR+cu3iAw5LM66zHF0LGlOrjrNQ8ibx0WvKtE7KwaQFE8LCd4Xe+f8M8b
         Sr0Mx40iQRVtzFiLMhx9gxctNXDlX6yCP+vfYVWHbxjsSNA2WdBvVLLv5AcMBCBp31rk
         PZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879449; x=1788484249;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqRGrR0heNmSPrtTW9+v9FKZZ7RwzxehXvY0MCzvxnw=;
        b=L/FJi4YeXkZZDWIuJUWIj5fdAE31gfdLZZHQD3NMklajCaIj4BJmjHkb5Pb8WPHDZr
         ttaldaL+BeS/xdd8LXYFbsGeQMmjvl0kR0ObzVj7dll64s62FbyAlscDjcaDk1ILiCO+
         k6HBrvFiu0UZBK7Yi48lF1xSW5IKHic5vYZAXS+kPEYJER0JarHYHu94scKNXqrsNaty
         fEc+TaxyLcloBmnvfUV2sM5ucKpiZT0P6hiZ7VSlt0dqb2KOXE3XmT22P92k5mSbj94R
         RtwJqxO9/fGMERLfb27RsWMq6hHd//7dqLE/AMBpbzRBtkuPk78+71Ncw8X3Mid962YC
         4eQg==
X-Forwarded-Encrypted: i=1; AHgh+RptJReLadM5Oy1VQ3TNthyqb3LNuGXNg2CwcC1UWlyvXWd81m2ogmTzpcMSH630yzSFdvVeGAyv@vger.kernel.org
X-Gm-Message-State: AFuF++kN3CCk167i41RIGdP8ZF7gx+jS0MAdYnDpCWT1skM7CQxCuB3n
	YPuw16SBm3WhN+Z5ArF1IFWAm+GQDYjoZlN7CRzSp6G2fMx2ydSk/untkVSxbWV1eg==
X-Gm-Gg: AR+sD12gq49+srKJ7YHIVgdy764ciSipDAfK3NYQ574wls/4kTHzHHkJ9Brpc/cvhI3
	geEyLtmZ6ojdvluwpCxfjeQ2FbuYBl8AIa+raCnGzSCxv6MypU86JYZqXxoY4n7tdknK/91uhvE
	iEbvWT+u2u/Gp+8MonENbCce2C+XgMdllVKYbDtQXvCReNjmbZRE1HsMlEQ6L1/7SwuWWegbUW/
	8XLWEmDmxK9wXc+kRvEWRh2CKaacThurb2bxmcbrKVkFpAdA6WIA2771tYTTHaei63/Lcd9W3za
	En962k3nfV33iNKhGxg1oENdKBruiomhZaWP0NB/rOg6M0Yo5PX9LnI2PBkx9MLQPhs7U87Hzan
	zmghuAJ/j6JT4Yn2o17S2+l0mIR6+SzGtXFVf9UZw4q0adzwMf7r5OrMmZG/v1b5VA7xpPzJ2KN
	ZN7Tql4jnbd8cHe4RLY1EhYdXt0LDzQ1J91cybyTkppNcrW2aIf0JrvLoUtcJbvnX4Z2o81tdiB
	VJA/i8VKn1AJTaFd/vqam3Na3esOJ5Zs7VYPRLtgiK5
X-Received: by 2002:a05:620a:290a:b0:934:9524:2e89 with SMTP id af79cd13be357-93913809957mr300256985a.13.1787879448634;
        Thu, 27 Aug 2026 18:10:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391725670dsm34787285a.19.2026.08.27.18.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:10:47 -0700 (PDT)
Date: Thu, 27 Aug 2026 21:10:46 -0400
Message-ID: <de5f1c2fb1ccbb92beda6906e23ac457@paul-moore.com>
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
To: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE  introspection
References: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>

On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> 
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
> 
> This closes a hole in code integrity enforcement that Project Zero has used
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containing
> a kernel exploit.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/hooks.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..2c2c60e9e0fe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,6 +2157,27 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
>  			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>  
> +/*
> + * Decide whether it should be possible to read non-readable VMAs and write
> + * non-writable VMAs via /proc/self/mem.
> + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
> + * triggers on accesses that are not visible to selinux_ptrace_access_check()
> + * because of the introspection exceptions in may_access_mm() and
> + * __ptrace_may_access().
> + *
> + * This allows a process to overwrite read-only code in its own address space.
> + *
> + * Creating an audit record on denial doesn't make sense here, since we can't
> + * tell whether FOLL_FORCE matters for the accessed VMAs.
> + */
> +static int selinux_mem_foll_force_opened_by_owner(const struct cred *subject)
> +{
> +	struct av_decision avd;
> +	u32 sid = cred_sid(subject);
> +
> +	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
> +}

I realize not all of the SELinux hook callbacks use proper kdoc comments,
but I'm trying to fix that.  If you could make this a kdoc function header
comment I would appreciate it.

--
paul-moore.com
