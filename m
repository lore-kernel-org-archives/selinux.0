Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956092;
	b=znZW27mOHUTHmcOP8lnm7A2bPWfRzZDEBLCDZmLFSPLo/9EWZTIEDipXldPLYQ68f7BK
	 5wz+hMgsw4cdMzgkWG99wT/ERyNkshAMNjd++aEDWY9H+UV2QmKN7OpMmA0jpvRzO7yf8
	 llE49xO174Kk7b6uQyNMmC0rDCbCsw5b7evyLjQ0ZLhSh8QlRhfCGhFHQnoEKlI0fYO1y
	 4dykPlI2zgb5pCug1LMecB+RjLcBoB3Ik0BWhjL6O35DOvWPubzBbhJKn+X8jdAHUHSQa
	 dFY5DiUUS7s4tQaR8lErS4q1saTIqW1m4lPa8BScv6bRHGAE7yUyKPiu9ztAJJ2f4yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
	b=3/2jGzxxWFltWxFOt7fd3sbjwV+tgq/ibAzbBqGsywzF714QOqBpDSDrkThnxXyKRDRy
	 GI6MPUQQDfohOHdpvHl4ScIdOnhUmeQ9CXDr3nMzVQJ8cKXkEScC8E4C4r6q63JGVJzbl
	 Iwv/gVIYv4hx/d8D72OaI6f7ieF68RBTBa8DIQdHUCpv+DnaGrC8uwXVvzIh/eDzC8P4Y
	 fjFB2Uk3Z+W+TnZwWNxgMy62D6yM62QC9z5Gk+/3UgW+Cgy+CTQWIXNRBHCf+jSgVAXRd
	 58TWw1mP6dOlQTQ9twJuXHzZTS1uI0D9c2RW6InoRESEeUU05NJQVKfoX0nOeYZZFXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=UtNCGZpE;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB622606A882
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 22:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB622606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=UtNCGZpE
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ec396c93dso3193146d6.1
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794956091; x=1795560891; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
        b=UtNCGZpERg95VgV31TLB6SKqg3O5IY7S5liFSjgST8jxLuBTyzR7elX/LO4B+17kMt
         emUhFzAJ523PtXBWTKI4rJMkk8L8iAvXpxzY9TD8MMNsDMv1FPwo0jiVBLw0TxZJzSRm
         M5cRQRyRj7aHzh2YUb3Vb/bnEnakXFrgtav82xnixUcrNWbKQWH1k3udT/v1VIasKqLO
         uTKsS5k+9nPtBkkZasSNBsAuQHTcOe42csFt9XQI85jVgcm952Uo/h8/s94MGZwEY4QT
         dXQU1KnqOHAYC64PjxxQG6jfuYnQpsTsPvjaGwD16PnS2iNvHPZBi8Zn6I1XhQdylkcD
         T2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956091; x=1795560891;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
        b=ecG74M1/a1GoA6Q/bGnz9gZZz5ZpRbf6MI/AcfQlohE88qcYfL+AVrJiLUn1Qp4fpj
         sEJuTcVzp80wMvmEwZDy4WuStUpkz+mq3tyvqkzZrs/jnPZs9SMPLTjLnOm70t9ZI7lf
         GDduf/fFPELt2PK8HwIiTPhcuwhCxTyeTRbb70Vck+uXtHwacXImq1naHyY5F77S5pQ8
         dbmE+pV4W+DITiONo6PX5Z5Cbaj6Em68d+83K7K9MxlMZvvy10vH0cgUHJy/5agHgTjX
         U5I/bfkQhnF3bYymTeMcGBpHHUNvgVxXNaRBQQEGH+VKjFDlmmUSN2jjNXjb5qzrh/Q+
         SryA==
X-Forwarded-Encrypted: i=1; AL+hErFtt7lGTyHjIpvPc9aYJi1RnwxTTcZVutxgbzDz/UNhmZ56sNxiaNdwlI6h9MmWyUYGXo76OLd8@vger.kernel.org
X-Gm-Message-State: APuU4Z9MA8DeHvWM8USwRe9y+6D4zIky+SeCnzNcC4BTK67uG5k7DCCc
	pg8+V8WUg/B/CSCMxHzqRScKfqT2fxgg6PuWM9Zln0sTUJeD0vOYhUIbhCST0LWcFw==
X-Gm-Gg: AYBFou02FWbS7l9ZKAai4CHY0YR29RcgCSteBETAkxcNz2hu51QLWKTlFaq2a+ewXqN
	TaZ6LI7EmXDJwrj7tdjzJA4PYWJRcKhmgtgWN+gMWto1O5QDjcBpOBpBWe0GUkDs5GFWejSe6mT
	ZwoP+7Eqxw2Vpj/OMUKG7blAYrAYGi2kxO/hg2ZTqfziOu+FZK9O80NbwPcdmdwHPyGpHWMasUz
	m2lQvAwcnRrtAPslijcdjYuy/c7IOTd0jRfG9zXALGdOLGKi7hIm5hXcBadMCT7jgVWi5U+zRta
	Y7g6Iy/abVZGBdesPme5VH8IPlSiiRqynwNKm1p7awStx86hYJn45wwy+jDnZ81icNrjbdXrubC
	bFCfUw6Y4bTa9OthdwE3sKOFYZDBrmxSE+LQoVuQE9Abps0OfdllZ8k77lQ9absrqv4AorRaiBy
	YsxIL/vhV2piVDpHTvSHXEb3YKbarELm9rRCnpaLpRvWlA/G/A+rOvMZCLOeEy2Jc8r7dCX9WTd
	3p1fSb9SIcCKxNdT07l8efP/d9wC/BsQp+Rv6HTlE0OVUUpRmX9pGunl3/je6DFiMMxFViX6CB2
	h/ncCitwBDuoJQzL6peuJmGGEDScKT5X+TWrMtL1wJeeNiRwH4tyLQWIUiUREjEOV4NdAOqU7d1
	j9NbVDfSwicdqtqPuHOSa53e4HJlDs6lv2A9PvdnDURlctOkigjA=
X-Received: by 2002:a05:622a:1647:b0:535:92a6:22db with SMTP id d75a77b69052e-55d5a36e150mr14373911cf.1.1794956090990;
        Tue, 17 Nov 2026 14:54:50 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58fea01dsm7818061cf.8.2026.11.17.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:54:49 -0800 (PST)
Date: Tue, 17 Nov 2026 17:54:48 -0500
Message-ID: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>
Cc: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>

On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> accept a charge_fd field that, when set, causes the allocation to be
> charged to an arbitrary process's cgroup rather than the caller's.
> 
> Charging is currently limited to the caller's own memcg subtree unless
> the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing.
> A process holding it, along with a dma-heap device node or a dma-buf
> fd can charge unlimited memory to any other process's cgroup, potentially
> exhausting that cgroup's limit and triggering OOM kills independent of
> the victim's own activity or privileges.
> 
> Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> when charge_fd refers to another process. The hook receives
> the credentials of the allocating process (from) and the credentials
> of the process whose cgroup will be charged (to), giving security
> modules a controlled enforcement point for cross-cgroup objcg
> attribution policy.
> 
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  7 +++++++
>  mm/memcontrol.c               | 11 +++++++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 34 insertions(+)

...

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 03cd90d5e623..2e6fcbe14d43 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -60,6 +60,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
> +#include <linux/security.h>
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cgroup *memcg)
>  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  {
>  	struct cgroup_subsys_state *css;
> +	const struct cred *tcred;
>  	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  	struct task_struct *task;
>  	unsigned int pidfd_flags;
> +	int ret;
>  
>  	if (mem_cgroup_disabled())
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  		if (IS_ERR(task))
>  			return ERR_CAST(task);
>  
> +		tcred = get_task_cred(task);
> +		ret = security_memcg_charge_task(current_cred(), tcred);

Do you ever envision this "from" cred being something other than
current_cred()?  If the answer is "no", we might want to consider changing
the LSM hook slightly to help prevent misuse in the future:

  int security_current_memcg_charge_task(const struct cred *tcred);

> +		put_cred(tcred);
> +		if (ret) {
> +			put_task_struct(task);
> +			return ERR_PTR(ret);
> +		}
> +
>  		rcu_read_lock();
>  		css = task_css(task, memory_cgrp_id);
>  		put_task_struct(task);

--
paul-moore.com
