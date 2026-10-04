Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BFB46F494
	for <selinux@vger.kernel.org>; Sun,  4 Oct 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134367; cv=pass; b=eQXr4UuA4urnvdgKd8POfpWt20WX9brCHDfzQqyhkhjg31+2BQTJinPp5l+Ihs4gbeAGGfcQRd0/H0duaV1kyYps6msq7s6HCuKLVCgDYf390jIUAbLvj6goSOOJOI2c1ujp9lTJ4M89u1Dm6sPkhk81ujWBdep2tt6RzlNuxFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134367; c=relaxed/simple;
	bh=Xs3FYb65sS4Mlx/21+kwkOlIJXqlGZcwdZaObIOhQD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptp7e5bQDIZLl785ek4sRUkaMVTp8HhCVkuyp+btmYtVnqNEzF1oQTOu5Hdjb2vrSMg+xO9tv7Z95rCbIbgQtWpfLFbhHIwgczR8WOHenEZkGwHyD8iXOv13USo/aQj1Xgt02rJUBN8J/hhCJgzQyO6b4erU5eXOFnQprLn+VU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjrczGUU; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjrczGUU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337c7b9937so259341cf.0
        for <selinux@vger.kernel.org>; Sun, 04 Oct 2026 10:19:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791134362; cv=none;
        d=google.com; s=arc-20260327;
        b=DlJnSocYL2kmwv6QC3xYkTrs10kvPAt3we4EB9fOxVZI/0LJklRzrEPZ/evi6wLGIR
         9ZDFh84jJS5TYU/hx3PZzNP0vWLWj/EVpVw45ImmfYx4LLTXUnT/XM8d7ZJ5bvhyQNdJ
         uM4qxJSRsrzchiVD9GRkbA38tRLQVjq4EgpN296SLjGE13kNa+atQeIo8LhbJhlb7bRV
         YhlUVsX2mbU4nilmIlewCUiolcyWA2kiJWHTRcq7+7ICN7VpBh7xVspJn5VeQOuaZnLa
         xvmxhiz68xVPcJ7EN1ZQoZzKA3AkIb6dmhuxdWzOKqkkAZrEE/jbzs/A+1Rk1XaTXg8s
         T8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
        fh=KkT3xr+Kz5THTO+WUutZ7Cqyne8AuVrBpFsWgiBZCJs=;
        b=LIm4rQxjPgMQidqxo+OF0Y1C6r2jUk3uEzNNUxrvOvaZw8sjLGjqLjge2QkAhKD8QQ
         +f9a13Ah5VkZEjbi7EPyJioz2esKIr8EZy08r/v/cp9ZnD+iLTR1DCR3giyzEZi3tnNV
         Cv7spPyk6cugMzSdBdocLhSw0okK4XGKW0wfYsmj1GTaoZ7zjm8w38t4HeRR116lTvTw
         WknIV5/8jBi7LOPJeO560cX4MeqBjGO5rFipiIk8cuPC+tBRQ2t+KiVe1E0dpjh7NCyW
         XIQfXX7YMesW7POTL19Hm7PHxIfz+UDo/ZYqSwRYVrr0B3Zxe8DMbnQpqf4eiRPRFkPg
         fMJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791134362; x=1791739162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
        b=mjrczGUUQ9qIw+a6lIyMo7+v4ZR4bOTHEQIXcE52tNEmK+YCOyOhmjWJ6za+B72FiM
         btNp7NOqAX+Z9tmD2Eog/Sz6+oDJcx3oKZ2A+O6sOdgcz2pjDIuzLCUKqJU1ixe8TcqK
         JNiIgq1FZWF1dG20M2HV8J5S8mNqsuBH3gDOu1B6gd+v5RrlenqRRnKY8wh3Hw0yaWHH
         N4xTZ2MNuH+/p6LB6ZiQompDz9pRTrzalf71wvcsTnEvAGqXoZCNpzX9izbsigL3d6Hq
         aUHjjv/3GEXe5tzZJ6gHNC2Ky2p3A4nMREFq/qXO3EIkuhuTKM25AL3ArZ/b1M+N68rS
         6RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134362; x=1791739162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LB9YQVahVaEWF6zZVDiq8xpdl9rxBex8+tzU6TEVUNY=;
        b=PQU3cEJTAO2aZ+GwWbwVH22UMNAhhdSqpkKN/OJy+syGQTnelnNu8qoQgAM43e/iqF
         a67n0fGh1VoHNefALihlLBLSJ1S4eMkZI8UXSKhUObKMz070ua6bjrP1Ohe+Rjd3aAo1
         sA75kTD6SapUElCp4h4pJloCZ+MzgPD1iBCsOYqTpglfMR1o6D74WxFEZKRxLqbs6ITB
         2AaWB8Bfzcu8WlJK7V251uzDgt1m9psLt5/1j6q97hMx09lU9fbZb8YaNFoRUycuivpB
         pkYntcnyQQbFyXb9j6LXFfSVrNNL1onR7cvkWpoqEZangF60lrmkLNuvK4SUmO87XraN
         Jm2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTWVeGhC8+H0XXwuGk0mYhsm5TESIzt+ipQG0SBFuCyCbVtyob+JaNjFlKEPS4GG8DTxYlQcwk@vger.kernel.org
X-Gm-Message-State: AFuF++lpeOz7xUz2AF5L0f61YTqUUz4EsLB13R45jiDyye+NZusopCXF
	13VIlX5Tbe5vFwbK+V9kcXSLjQrUvUq1yJTKkieDvYQEX04OHxtPk0clBguCemnh/sBdnuoI3Il
	FWx0jjG13NY5Ioo0EasJU/Q86adTJcgvCIINkHEV8
X-Gm-Gg: AYBFou3vU7F7FPgWQnZDtnunUDcifBhK4MK+4BOqYImm4FfyySrS4oztfWBpnA4rpfY
	TumBZ79irKVqJF4kmKVjNWpLcK6gwsXvh2GRe9VB+D38JOFB5i4zGGNSCmoTCPnHRWF9z4KhCCO
	8DJB/1Y75uQ+KfseM26HJYqYnSn4kRr2O0mxiiDDE4HbUzeiYcUATxMNw2+Ff7XZk41nb51OD9i
	RCNZAVXodwTSJPYQfFUfzoAP6N7v3zS95/Rlxm/YsU2zD76Yt6c1S158q0BEpbuwACEQeai5Alw
	6tiUGoTC51DirX+Lc93lbyNym21K6aoMtVV8IvD4GB1Ovz8LuktlKuVEzA==
X-Received: by 2002:ac8:5e4d:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-535131e75aemr16242571cf.10.1791134361196; Sun, 04 Oct 2026
 10:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-11-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-11-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 10:19:09 -0700
X-Gm-Features: AclHuK8q5domRMZg3DAHzMyB2slG297Lp1_L7hWmlqEUWco5tu_MI_s_DzFbhWI
Message-ID: <CAJuCfpGdJM=J+6tkzid_Mu+7nevdhFaTW0E9tbKXoLmzC951Fw@mail.gmail.com>
Subject: Re: [PATCH v4 11/38] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:37=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.
>
> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  security/selinux/selinuxfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index c7d91476971c..545a6f89f9e7 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -340,6 +340,9 @@ static int sel_open_policy(struct inode *inode, struc=
t file *filp)
>         struct policy_load_memory *plm =3D NULL;
>         int rc;
>
> +       if (filp->f_mode & FMODE_WRITE)
> +               return -EACCES;
> +
>         rc =3D avc_has_perm(current_sid(), SECINITSID_SECURITY,
>                           SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL)=
;
>         if (rc)
> @@ -424,14 +427,6 @@ static const struct vm_operations_struct sel_mmap_po=
licy_ops =3D {
>
>  static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma=
)
>  {
> -       if (vma->vm_flags & VM_SHARED) {
> -               /* do not allow mprotect to make mapping writable */
> -               vm_flags_clear(vma, VM_MAYWRITE);
> -
> -               if (vma->vm_flags & VM_WRITE)
> -                       return -EACCES;
> -       }
> -
>         vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
>         vma->vm_ops =3D &sel_mmap_policy_ops;
>
>
> --
> 2.55.0
>
