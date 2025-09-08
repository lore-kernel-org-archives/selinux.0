Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C58309DC5;
	Mon,  8 Sep 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339119; cv=none; b=MHC3W4GStCAXSoIy7hXfFvRHAt4xB//utBWNr37joZpGiwu7OLB87k0swlRrWknJ3Wu9DaNpzKweMhByEWpVQLGUWXQY2zYfYzAS2m/06ZILvsA908gxgS4SPNQMZYEUMhFo5Ej6VyJ7AjV6dHGMAH8FsGX0Hkfw0efkB3CcrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339119; c=relaxed/simple;
	bh=g/E/D7UA/19tK0saJr4gVfAQIrSTcsDc1iWgp6pOgYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0L7M4E0KxN4L64RDY5HTzax5r9zPUFwQruT8yGOk4l/iVk4N5YMK7aw4yVMDsurxSn8+H52wQsyb878axlKEBasfjx0iHBI5F9uPCVB3ckWrJF5kFT76eLWc9oUCVXlGgxNte3gW5w+O6VU6M6gqAm6+Ku5jGIxi6lXoRsD7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV6qSQrb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV6qSQrb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-327f87275d4so4333576a91.1;
        Mon, 08 Sep 2025 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757339115; x=1757943915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZAZxrD6sAjPSbMbYfAECPp+2SY/6ZH3NwCQ8sQ9hQw=;
        b=iV6qSQrbLZ49fUGZo9ikMENovSEbRSLtiDepJED9lW054Gk6PrX2nI/6HM0pGlq/LO
         pIQynO5EVaUuP/c5J2OK4V/DKkN05ulEd/1eITF7GSGyx8GzglZee48KS9vSu4SbyuaN
         f8+NtYtHUFDpoR82P4+kt6wPARRKPtZSBxYJrPjGjatpbwJU0NHnSNMLF1rOh8W0YP7x
         nsZO+hAYbyfMHYEj7hlew56rdkvM9w8gn9rwhEQuThyg8LqsHA89wIaBfIz4d9AMUbE1
         +lE2sP1lfCQh5jau+gbHPl2W6oEeHMCqZBZI47Q2c/D1zOd8UUKVDXDnS0sotHiqBPL/
         NGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339115; x=1757943915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZAZxrD6sAjPSbMbYfAECPp+2SY/6ZH3NwCQ8sQ9hQw=;
        b=hTxpwIdu6LmVeuPQOgRxGfpHDxCWLRDoDVG/zA8XG7ZBjsTdu7HeT5bnuUZCUTt9Z0
         ov4ctwDR/+Na+zx8NdFDvnEkLQxJTPeQrEW8FOvMkszwRMNR4QakJSoqXRU35mtmY0uR
         CsygigqwnBnsURoYfBmGce1be8HF1aitBdiXaRhIKYjLWACUw3weKu9NTdt5hglbKZ/r
         xQml3UOwsDhKYq3+IfRBr6KR4Vs2im4wUg5W5ZyAQW2JKj28NhhMr3VRuKojJpGkmocR
         Pbbr6V9hxn1/Y7O5mPc5j5BRX8JNhxIH6eZQOqo/nER0RqM5uHk1roG0FqPd460jiM08
         /iPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7f6JN8d6Tr1aA4C6ELU3g2kpjR8RIIDA9qsO5iV3+CtzEDiXe34s4hqIyUICnf8sSqRwOTfBl3g==@vger.kernel.org, AJvYcCXc1HuQlyJXzetvqv3QPNZqwolGhkr0md7/udhpPJQz+sybiY/D5ZoOVmAZPkWTjgoBPvDrIVHPco9hmDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSVccPff7Wm2GCRmLuOynytTjsNLOUO+oc3sDxPK+vdOQMsTb
	LHQOO9jYk9mL2uEZqQbpAUZAAc47WhapNWRyT7OuP7qGHNGwtg5KX3rNIlVzQbRVCQ0YoO4Yur9
	rX6Nq84k5J21/PizCwEyXg+zQ7s3IrhE=
X-Gm-Gg: ASbGncvhTwk6dpVDadUzhHN/aTIb1RWuP8hgw2/uyKJ65sMswu34r+s33DINrPF/fDH
	YWMkOKNQ3bMnMgvNmhY+4hQw9nzegSbMXr0Mu2qGpCv7+aZxT4uaOcrsspcxpQq0bCm58HdPaYJ
	O6xSaU6bfp4513UfHc8tO1c3p2TsY48bJDuNmF/ZTDNfqdYYU304mnfEWOqH3+Vv3LfAr7QCTXx
	gvuo4w=
X-Google-Smtp-Source: AGHT+IH+hMql/UROYfh6RyYC0bmB17kjL8kJS5jMdgerNaQxC2AHEq5Qr9n4+TUxzW5bhUtSnvEtQgJ7cA8zl4BtIOs=
X-Received: by 2002:a17:90a:c2c7:b0:32b:df87:1ede with SMTP id
 98e67ed59e1d1-32d43f18a2bmr11351380a91.12.1757339114938; Mon, 08 Sep 2025
 06:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905100454.685866-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250905100454.685866-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Sep 2025 09:45:03 -0400
X-Gm-Features: Ac12FXzmU9fZyrBddmZZsSEsnNkADcHfkm6gdk7SXf8AP5uLIoTt9u6xvhWk38k
Message-ID: <CAEjxPJ4-+WfGPLev5QU_+_NgBx68zdBBQ6x_+aonzbk4f9BNEw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, Hongru Zhang <zhanghongru@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 6:05=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.co=
m> wrote:
>
> From: Hongru Zhang <zhanghongru@xiaomi.com>
>
> On mobile device high-load situations, permission check can happen
> more than 90,000/s (8 core system). With default 512 cache nodes
> configuration, avc cache miss happens more often and occasionally
> leads to long time (>2ms) irqs off on both big and little cores,
> which decreases system real-time capability.
>
> An actual call stack is as follows:
>  =3D> avc_compute_av
>  =3D> avc_perm_nonode
>  =3D> avc_has_perm_noaudit
>  =3D> selinux_capable
>  =3D> security_capable
>  =3D> capable
>  =3D> __sched_setscheduler
>  =3D> do_sched_setscheduler
>  =3D> __arm64_sys_sched_setscheduler
>  =3D> invoke_syscall
>  =3D> el0_svc_common
>  =3D> do_el0_svc
>  =3D> el0_svc
>  =3D> el0t_64_sync_handler
>  =3D> el0t_64_sync
>
> Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
> to mitigate long time irqs off, hash conflicts make the bucket average
> length longer because of the fixed size of cache slots, leading to
> avc_search_node latency increase.
>
> Make avc cache slot size also configurable, and with fine tuning, we can
> mitigate long time irqs off with slightly avc_search_node performance
> regression.
>
> Theoretically=E2=80=8C, the main overhead is memory consumption.
>
> avc_search_node avg latency test results (about 100,000,000 times) on
> Qcom SM8750, 6.6.30-android15-8:
>
> Case 1:
> +---------+---------------------+------------------------+
> |         | no-patch (512/512)  | with-patch (512/512)   |
> +---------+---------------------+------------------------+
> | latency |        85 ns        |         87 ns          |
> +---------+---------------------+------------------------+
>
> Case 2:
> +---------+---------------------+------------------------+
> |         | no-patch (8192/512) | with-patch (8192/8192) |
> +---------+---------------------+------------------------+
> | latency |        277 ns       |         106 ns         |
> +---------+---------------------+------------------------+
>
> Case 1 shows 512 nodes configuration has ~2% performance regression
> with patch.
> Case 2 shows 8192 nodes configuration has ~61% latency benifit with
> patch.
>
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  security/selinux/avc.c                        | 68 +++++++++++++------
>  2 files changed, 50 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 747a55abf494..70dc6d659117 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6620,6 +6620,10 @@
>                         1 -- enable.
>                         Default value is 1.
>
> +       selinux_avc_cache_slots=3D [SELINUX] Set the avc cache slot size.
> +                       Format: <int> (must be >0, power of 2)
> +                       Default: 512
> +
>         serialnumber    [BUGS=3DX86-32]
>
>         sev=3Doption[,option...] [X86-64]
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 430b0e23ee00..35f5436f5da0 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -34,7 +34,7 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/avc.h>
>
> -#define AVC_CACHE_SLOTS                        512
> +int avc_cache_slots __ro_after_init =3D 512;
>  #define AVC_DEF_CACHE_THRESHOLD                512
>  #define AVC_CACHE_RECLAIM              16
>
> @@ -68,9 +68,13 @@ struct avc_xperms_node {
>         struct list_head xpd_head; /* list head of extended_perms_decisio=
n */
>  };
>
> +struct avc_slot {
> +       struct hlist_head       slot;           /* head for avc_node->lis=
t */
> +       spinlock_t              slot_lock;      /* lock for writes */
> +};
> +
>  struct avc_cache {
> -       struct hlist_head       slots[AVC_CACHE_SLOTS]; /* head for avc_n=
ode->list */
> -       spinlock_t              slots_lock[AVC_CACHE_SLOTS]; /* lock for =
writes */
> +       struct avc_slot         *slots;
>         atomic_t                lru_hint;       /* LRU hint for reclaim s=
can */
>         atomic_t                active_nodes;
>         u32                     latest_notif;   /* latest revocation noti=
fication */
> @@ -93,14 +97,34 @@ struct selinux_avc {
>
>  static struct selinux_avc selinux_avc;
>
> +static int __init set_selinux_avc_cache_slots(char *str)
> +{
> +       int val;
> +
> +       if ((kstrtoint(str, 0, &val)) || !is_power_of_2(val)) {
> +               pr_warn("Unable to set selinux_avc_cache_slots, use defau=
lt value\n");
> +               return 1;
> +       }
> +
> +       avc_cache_slots =3D val;
> +
> +       return 1;
> +}
> +__setup("selinux_avc_cache_slots=3D", set_selinux_avc_cache_slots);
> +
>  void selinux_avc_init(void)
>  {
>         int i;
>
> +       selinux_avc.avc_cache.slots =3D
> +               kmalloc_array(avc_cache_slots, sizeof(struct avc_slot), G=
FP_KERNEL);
> +       if (!selinux_avc.avc_cache.slots)
> +               panic("SELinux: No memory to alloc avc cache slots\n");
> +
>         selinux_avc.avc_cache_threshold =3D AVC_DEF_CACHE_THRESHOLD;
> -       for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {
> -               INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
> -               spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
> +       for (i =3D 0; i < avc_cache_slots; i++) {
> +               INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i].slot);
> +               spin_lock_init(&selinux_avc.avc_cache.slots[i].slot_lock)=
;
>         }
>         atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
>         atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
> @@ -124,7 +148,7 @@ static struct kmem_cache *avc_xperms_cachep __ro_afte=
r_init;
>
>  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
>  {
> -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
> +       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);

If you are making the number of buckets adjustable, you should also
change the hash function to better deal with multiple numbers of
slots.

>  }
>
>  /**
> @@ -150,8 +174,8 @@ int avc_get_hash_stats(char *page)
>
>         slots_used =3D 0;
>         max_chain_len =3D 0;
> -       for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {
> -               head =3D &selinux_avc.avc_cache.slots[i];
> +       for (i =3D 0; i < avc_cache_slots; i++) {
> +               head =3D &selinux_avc.avc_cache.slots[i].slot;
>                 if (!hlist_empty(head)) {
>                         slots_used++;
>                         chain_len =3D 0;
> @@ -167,7 +191,7 @@ int avc_get_hash_stats(char *page)
>         return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/=
%d\n"
>                          "longest chain: %d\n",
>                          atomic_read(&selinux_avc.avc_cache.active_nodes)=
,
> -                        slots_used, AVC_CACHE_SLOTS, max_chain_len);
> +                        slots_used, avc_cache_slots, max_chain_len);
>  }
>
>  /*
> @@ -463,11 +487,11 @@ static inline int avc_reclaim_node(void)
>         struct hlist_head *head;
>         spinlock_t *lock;
>
> -       for (try =3D 0, ecx =3D 0; try < AVC_CACHE_SLOTS; try++) {
> +       for (try =3D 0, ecx =3D 0; try < avc_cache_slots; try++) {
>                 hvalue =3D atomic_inc_return(&selinux_avc.avc_cache.lru_h=
int) &
> -                       (AVC_CACHE_SLOTS - 1);
> -               head =3D &selinux_avc.avc_cache.slots[hvalue];
> -               lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
> +                       (avc_cache_slots - 1);
> +               head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
> +               lock =3D &selinux_avc.avc_cache.slots[hvalue].slot_lock;
>
>                 if (!spin_trylock_irqsave(lock, flags))
>                         continue;
> @@ -524,7 +548,7 @@ static inline struct avc_node *avc_search_node(u32 ss=
id, u32 tsid, u16 tclass)
>         struct hlist_head *head;
>
>         hvalue =3D avc_hash(ssid, tsid, tclass);
> -       head =3D &selinux_avc.avc_cache.slots[hvalue];
> +       head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
>         hlist_for_each_entry_rcu(node, head, list) {
>                 if (ssid =3D=3D node->ae.ssid &&
>                     tclass =3D=3D node->ae.tclass &&
> @@ -625,8 +649,8 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass=
,
>         }
>
>         hvalue =3D avc_hash(ssid, tsid, tclass);
> -       head =3D &selinux_avc.avc_cache.slots[hvalue];
> -       lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
> +       head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
> +       lock =3D &selinux_avc.avc_cache.slots[hvalue].slot_lock;
>         spin_lock_irqsave(lock, flag);
>         hlist_for_each_entry(pos, head, list) {
>                 if (pos->ae.ssid =3D=3D ssid &&
> @@ -846,8 +870,8 @@ static int avc_update_node(u32 event, u32 perms, u8 d=
river, u8 base_perm,
>         /* Lock the target slot */
>         hvalue =3D avc_hash(ssid, tsid, tclass);
>
> -       head =3D &selinux_avc.avc_cache.slots[hvalue];
> -       lock =3D &selinux_avc.avc_cache.slots_lock[hvalue];
> +       head =3D &selinux_avc.avc_cache.slots[hvalue].slot;
> +       lock =3D &selinux_avc.avc_cache.slots[hvalue].slot_lock;
>
>         spin_lock_irqsave(lock, flag);
>
> @@ -929,9 +953,9 @@ static void avc_flush(void)
>         unsigned long flag;
>         int i;
>
> -       for (i =3D 0; i < AVC_CACHE_SLOTS; i++) {
> -               head =3D &selinux_avc.avc_cache.slots[i];
> -               lock =3D &selinux_avc.avc_cache.slots_lock[i];
> +       for (i =3D 0; i < avc_cache_slots; i++) {
> +               head =3D &selinux_avc.avc_cache.slots[i].slot;
> +               lock =3D &selinux_avc.avc_cache.slots[i].slot_lock;
>
>                 spin_lock_irqsave(lock, flag);
>                 /*
> --
> 2.43.0
>
