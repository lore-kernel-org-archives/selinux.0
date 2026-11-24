Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528212;
	b=BGln9+qQ3BVVASeRMMGGDyLLjgezLowkDgMd10cXBcodqgcn0uTOlLPRExIxdrdFKpUS
	 rspDCxl16/hTcZeiw3ZMPU6wwyl2Mu1oO0vCj0i13PZGzLdpLy7FaECGCgCp+i8IYxYjt
	 y1tQ4Og48bpiDwxDbcYcaj2/nsEuCSa6ngTa9qvDn/J9Nop2NOX5OUcmmoD+oT3h3CvL0
	 XsA2kIQCb3w+XDpCh7txG3moIcUyuPMGcAnDCvoPpvD8kc0zfXwYVp2BwMGYiQIbunw6r
	 opFWuP+SgietPy+jIUcJrABxDmLjyP4AStNGTkBKTHjBaLP3PhoH71aLZMOl18qJRUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
	b=p0Uiz+IMFlP2znLrmWMLiu8hYAhOeD/2LTW8Xf6UpIDr+VDVF+S0RG2TWwN4KH10IbEk
	 8mLVjjvCfbv0Tlaoq0PbBv5gwWlhsP9hfz246XcuKugRcrwEEpDFNd4UVnY//kP855V4v
	 /G7U3BR58K2XxMxrZmyQ/9/nbxGQeoZPTrxu5gg+D58JghvGZv3sED1wGvlYvyaKms8ux
	 V7J2CCiVGDnkSVx1oRrtnCBJp+IOEARW0GEIMwisyWsbUYbUjY7pvGLEZR9QyOSQimdnT
	 aBSDtU7KLWJsKrGm/3CyeJMXSQIviNiMRAHfx0yOlfT0fAB+ioDv1elzMFMUy32GCXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=A8I4Yhd3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C52606A322
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 13:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C52606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=A8I4Yhd3
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2106468f8f.1
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 05:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795528211; cv=none;
        d=google.com; s=arc-20260327;
        b=eAnOB74QvJcdseDEVQZyukdz4u6J6LWzId1S3OUWONBVvR7L4mqVcculzxtKkROLO7
         jYaybnNK88jgdpKHTuLPPrR5mzJqsXpz1BHzQFwnepb7MqNmeBF6EZGSosHjh6B8dSYm
         vF3cFQh00sWZIfPyB8kO0mPaO/3yn51+sVjBowQoJsA4mR+pwsLS/FcyHbQ5+AjZZSn4
         TLVVEm0oIaP6QmGtFvh8rdHtdZL5EmI6RSdpFzAh+R1oI13HFPnrppLxApXOtZzfHqTM
         reiqS0nduhJTPcL+YffI1VOHk0c2w6oQiDx45gfQg/Kz8Ykwm5yz3SLdTiOZCEpQea5f
         z5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        fh=sBIn0bfDIFDd2yLO6A5PSzBaKOc6WO2LR3fHdn8gvDM=;
        b=VjiHxf+XihBNmcljHT2LDXsZw78JDrIWqjGnyQujI27pr+28FVzOtb+SCJ7VNJjC8D
         c7JQ/KRu96bduV/EYyEJeLCcLKNLkNJe6svFbeltiQs7AYAZGxgs/mzh8ej89WOi9kvK
         GxhAoRaQx/R58VNauu7Cd8lSAQoHWPDzYuDV7GOXfwQ+G75FNL75hwvGCH702PMKj2E4
         mVl3UP1RYbVcxgB0XisRrmTn9FXX85gQP76+Rte/FzloH3wQkP9+Mni3opWbxKHAwbc1
         cPv9RMY7OCZWltjswoq8yiK9n13zLfE+9ra79iDQiJ/yaP3CdICcm289xqrbkdiJP9Zj
         xpGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795528211; x=1796133011; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        b=A8I4Yhd3hz3WrVqqp6QMzsDrRJ3HJpUPxahpoSPUafEcj3SFymXcsAZEIf+a8ALG0Y
         V6s6xA+Ay4lWI9NhS7nxfL6F29mbmiE0uOfCYQxnOZUS20qgiOGqYoApJy9HRpK68tu/
         HSDE3IpIQJQ4GKB5Z7mVIff3PBnaum/E2gzkgJ+jFNG6YlWz7P5hX0VEOjoFbkoF1lDn
         8Ndrqr7MabRwOciYR7MGfzUJA7NWdJsl6TU8hPnym7YlbmO7JaMnO34+0kr0IDyXTgzd
         2RYMtv2kGAXDO2iT8hQ8hVHgIcSefON4ja9k6LVugyoh7mCZfqIgxnZvX+r5RFBAMb5n
         NOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528211; x=1796133011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        b=LEZJLrrJDhMWbwT5OHiWuFHHoqypoYLP5K7sHWyY/b8+TjWvsfF3kMthJSxJT2I0v2
         GeoNErQ4L6Z3DwrkD9H/+mCWz56HsavqILSKthswPU579d+rAMc8giSwz3Ln1/sUiVG8
         Njy072RKjpHjYbS4WIRKm9BuITj7Q9tnJ/rpCNdOW6p/Vix7royC6fGEJEEIWvxw4tFW
         UcEpD3hzLvncTdTROmN68cqJdTw+7mu3AGSdJR0O6yvyoMTQMWnDHCtKqEUpbJOovAil
         OjrOQZ58jSlwRCWSpSwYgMyqcLJJZnV+DFAj51RQwvksQQwEjss3lGrLW/ae3DeiJQP+
         w+jw==
X-Forwarded-Encrypted: i=1; AL+hErEtjBha4SiYIXzHrS4xYUA3yRePXs3WcbOYE+GIpohGKZLVMCJMS/sooH9ROGa9BOT8i+mpveL/@vger.kernel.org
X-Gm-Message-State: APuU4Z92ApwwJ/lRDvmzinBh54N4rqQSk0gZL+VjxH+mvl+G/obnlI8x
	8pKtlBFCPM4ugbI3+dnoeCW3+LDKA0U9P+hc/twCF9zXpnthQThkJI4yqlD0cbSHbSQGaSz7y32
	dc9oprMrCrofZ/1q7yNtjl/IX043ieM0=
X-Gm-Gg: AZFdTZdS96rJ7csbkHEX4bLukFqcyH0fKffTbzrEPKjmup5Tq5leIPoHSAbKjHRdi+r
	Spoj+SbQVGLYsLL+1dpH2J4RQPCykKFARxY900SktESfHVjzAMwTw2v3uohvc89W7g0/5DbAoyB
	FCtGOsG4+1F/e4xv/i4BKn+Htl2ZsDV2XJ0K7WE+oxnNhHBqWZRTy9Ry4/9BeyLNvWJRu51qVu3
	s7XyH1bPvBsFcCEpu0CTqKBbGB28m4LqldHPWcQ9LBaGvKK64GIznlR78+x7gJvr3EU4kYhqPbn
	71APX+n5+eCvRKXO9WPg6fuh/SglUrJKzdJpfq5jZ5l6XoxS5bxLdk9SteVcsu8RNH5SeoFQghn
	O1Pn6sMYOAd+EANp3dHDw/qtAM+tRvf17yXRgyXn5UV7sG7CPc/+r
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb8881b9d7mr305306125e9.19.1795528210579; Tue, 24 Nov 2026
 05:50:10 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 24 Nov 2026 14:49:55 +0100
X-Gm-Features: Aa3M54qkPJ8C4GRzLQzCC_QtBShd4rpGnT89RPbtOkkrzzkAiMVQPjTTZfQmmls
Message-ID: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
>
> The security_current_memcg_charge_task() and
> security_current_memcg_charge_cgroup() hooks allow security modules to
> control which processes may charge or transfer memcg memory to another
> process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> a cgroupfd, both passed in charge_fd. Without a policy implementation,
> either hook is a no-op and the restriction is not enforced.
>
> On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> domain that holds both dma-heap access (today's only exporter that
> opts-in) and that capability, can charge memory to any cgroup outside
> its own subtree. Since the capability is all-or-nothing, SELinux
> policy cannot express which targets such a domain may charge to.
>
> Implement both selinux_memcg_charge_task() and
> selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> object class and a new charge_to permission. Both charge_fd flavours
> ultimately charge a cgroup, so one permission covers them and the
> target type keeps the distinction: for the pidfd path the target is
> the referred task's SID, as there is no cgroup object to take a label
> from; for the cgroupfd path it is the cgroup directory's inode SID,
> which comes from the genfscon entry for cgroupfs unless the directory
> is relabeled.
>
> The checks run when the charge target is resolved, before the
> CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> charge_fd target, including the caller's own subtree, so policy needs
> a rule even for self-charging. Policy authors can then grant
> cross-cgroup charging selectively, for example:
>
>   allow allocator_app_t client_app_t:cgroup charge_to;
>   allow allocator_app_t cgroup_t:cgroup charge_to;
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  security/selinux/hooks.c            | 19 +++++++++++++++++++
>  security/selinux/include/classmap.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6c4c64d6e904..76a714107ae4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>         return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>
> +static int selinux_memcg_charge_task(const struct cred *to)
> +{
> +       const struct cred *cred = current_cred();
> +
> +       return avc_has_perm(cred_sid(cred), cred_sid(to),

Small nit:
`cred_sid(current_cred())` could be simplified using `current_sid()`

> +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> +}
> +
> +static int selinux_memcg_charge_cgroup(const struct file *file)
> +{
> +       const struct cred *cred = current_cred();
> +       struct inode_security_struct *isec = inode_security(file_inode(file));
> +
> +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> +                           CGROUP__CHARGE_TO, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
>  {
>         const struct cred *cred = current_cred();
> @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>         LSM_HOOK_INIT(capget, selinux_capget),
>         LSM_HOOK_INIT(capset, selinux_capset),
>         LSM_HOOK_INIT(capable, selinux_capable),
> +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup),
>         LSM_HOOK_INIT(quotactl, selinux_quotactl),
>         LSM_HOOK_INIT(quota_on, selinux_quota_on),
>         LSM_HOOK_INIT(syslog, selinux_syslog),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b16425..1f1f2fc4d35d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "user_namespace", { "create", NULL } },
>         { "memfd_file",
>           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +       { "cgroup", { "charge_to", NULL } },
>         /* last one */ { NULL, {} }
>  };
>
>
> --
> 2.55.0
>
>
