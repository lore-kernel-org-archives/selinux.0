Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793978372;
	b=sLDzuKSqEVSurTF51bh+DUtRnt5PItomR+FNMcUeeOwefGZA95teTgIutyKwosISWhlc
	 NlhPSt/xKt2HRxu6MMG0LdvABsvuljYgVjtW4VxRG8qKXAp+5VFMvzgr0wrml9WoCM3Yb
	 i05mnX+C8hSgalZP4zs9tAD1yOieaIPFA2o4eA0hc5S02iQfyEGaTF55fMq+BDOc5RruY
	 fR1kqah8ZIfqGX+iv+zxQ/HyxENSNoS1vUbM6PKyMZJ6/MODK+jFdglC954zNtdrmDpr5
	 W7AgvPjal6CwvgpzKwNiGjmh3JPuD+R3KoFYxJzV11QkkNC4sBLII1JYOiI/jL4l25A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978372;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
	b=qbsSVHXkEktG1xYurQtkHP5tpsyHbBWk1M6p7vnhzNrrhAwUXACqylaV+C14ZMD+ouol
	 Po2dBG/V9KVOe4mRzewdox+/AlVkI/O2T40UAXrUNlC5vTKPxEb6YjRwSssjgFSVDikxq
	 /+QTkkM8qz+lfBqTjCd2AnagGsg0WMp3rySFR+3hu4T0NnzX8dEqYW8OeJ9Xa+CxMCwiW
	 ZpSP20eo1yVYf7TwqYdnl8UjqCysezJOv/WINfRJvIj+rNHaoe9cAFZDRuOMsAo9ACvyF
	 ZBQHZED16YejhJ3jeXQZDFpIY2ukGKNJlbEU8lSqU4kOanPjzajTB7TgGt5LiRgag1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FT7zgTVS;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="E6IAk/4+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB7606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 15:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CAB7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FT7zgTVS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=E6IAk/4+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793978371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
	b=FT7zgTVSoSYON4QZfpOs7GP8lX3BPKnSG4vHu7ejNt12UcmbZpqSNGwpc0dHhcPYuqi5ym
	7ReurwQZh54hCxYAkvZWk9zMdrrhoXl4B2gdHmOYHLnw/IctHkOlVOS5Bo7qnAzs7zXSP/
	CCWhp0k7R8ETtNEBeLrjMG1fW8Z1QBI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-E5Xa4LeyPLmUxfxlHlPzTA-1; Fri, 06 Nov 2026 10:19:28 -0500
X-MC-Unique: E5Xa4LeyPLmUxfxlHlPzTA-1
X-Mimecast-MFC-AGG-ID: E5Xa4LeyPLmUxfxlHlPzTA_1793978368
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4dab94dc3e7so1199885b6e.0
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 07:19:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793978368; cv=none;
        d=google.com; s=arc-20260327;
        b=gfr4Z0N7/bvwY661J9vyOHh5VY4nn910ee2mqBxB7sjuCm0+FdA4yVvOCDHcfJyVMf
         5moXVlDrCTpKeLeEF8rg8q+sfaL0WOvi6gFVArFa8IX8mCBmOJOQTSAhEjPbJbXPrKmO
         hhecnNjeQnd7bJCjqpGPkA+su+W0azHDdvxJ742En8qAkQJresPBzihHKS+p3/o/2x+e
         K0nW+5639Gc8q+BFt57pc6unq9x+ImIHnxshKwfBvV94/7tPdgz0q1nNqR65IhiPKg4S
         VWujBU6T0Zmk7fN6JifgoVoxlZ+dzPXOffgqmMtPgBopJ36Js1zVIGvULQo8O3NdRlhI
         vOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
        fh=71hbraNW1yn7BB0Ed5Z5nyT+SJ1NVuTMZlrd4YVpd8E=;
        b=AcpfhaiolGY0UlFW7C6atP5SunGG+1qe/oZsgR7+R6M/pcHhntV1GIUTErIhpcEcK9
         j/VrgTE2VWnFDSU+s7VeZg5MEcRegq66qQsVSPoBgj6uK0JjTVJFH56GUBlZQ/yiVM6+
         eneH0pd6otT7ELwhzYKT/j1YP6WNF1qo4Vi7dFWJo2NWzcT/Au5KIfQMrth0BaT/dONU
         3T0yL6Neo3ktSjefPK4P9SD+Iqkw8jIOrhlX/eNs+Fq0lSbNDqTcUQnQTj3IXqvG5sdW
         k78xrYbyZujl7Yni0zqq/tpesP/AHN1M0Cv4OIt9br+GIsq1b6PWn7/RSGFHG3wV7aJ/
         husg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793978368; x=1794583168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
        b=E6IAk/4+pN7broiB71kiWgK1nFV07P5F2bt+lSmuenNxuQap58AMe89CkVgfaNlXMi
         qVSbAnOUmezq8r/uPa6k4aAPqc5xEAN7lO2QAaG/nWZhmmq87LiPWlhA9us3wTnHpwXO
         7Ody7VmpZMJilYCIIr8SPLTw4vzyTjslLJsBT817VykbCv0h0RXLbtk+x2s5arfGOVt3
         yTdARkgD2DNM3/3Fuyayz2myRUU8vIpHJ1ecIKzZQ1t2yBzX/7kBqAG/2+0saFay0u0w
         8NJpJtC6Bbdo8Pgo/sX7JmILwzx+Dldci0vCGPiwgrUDR1NwTIG9Ff+G7Z8v3E3KHGDK
         76og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978368; x=1794583168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
        b=dn4VEnt7VKPOvWcIqA/AdeIEdCLS1MJNpmSOMm8G5t3aN4Tl6LJbJoIgonmJGlZodW
         Gr3N5yncBkQuWfe3Z6ueJNuNbXJV5hTKXJxswbUJSDorIUwdi/rM2N95QLk3Co4uqlNZ
         qTI04aTfR5fHraKInuixEaYF4Ba8V3AYSRDqQLTpdyhsRFtk58hmAtuIFtKLHy+2+w8B
         7k7jKvaJs37qsqUwQzzxYxIcjvych9cmzDWN11hLDB77aC1gs9Ei4n4r+CxpexkAtsu8
         Zc88+fkSnX5/E5qWG58HJU21z4jHKFYrigsab8Dl9iw7zai/X+hyXhetdXuu49pbdWDL
         kESg==
X-Forwarded-Encrypted: i=1; AKwUvBzbHsFNiP1i4JFQ3yEcNb2QrXtfZFV7NazlCp524WQkMKwYXZ7wFyBExl7Zg57e8R2XE4bNhmFJ@vger.kernel.org
X-Gm-Message-State: APuU4Z/GCVWGY5Zb1CGogA/AKvuh6B9/xOqSLTl//BZp7DUBTax98u+Y
	3MSz/uCl/FcKD1FQS1buamTzpGbDaqoOIVj2I7pUAu5kcr1g7RcTTvhOv0zF/VQ0v+5fzaQF53o
	lW851s787oawIo2/EYCL+5Whmv94KBktZJpM7Q8Xc4zB2vnDJ650vZ8jwCU1fGTh892wmtDhMF4
	2PzwWRrxDblSJb2fDlch2oPFjuPWnNzcAQMQ==
X-Gm-Gg: AYBFou0AR5fjMEKDANY43FBXvIFehJhk1I0plbItb/d0DTvs3sQVQzucoZ+PqAN0qU0
	5Zg4EUjLX2B99gA/mVmexeVUvi9yO7s1ESDM5rC8YWfNFRfYD8XJH6CLbd+adkXBnF6EGdJsydg
	+rMm13LTAfzFPUdS5idofX1Z6Jp6RczVoSyHfHA0F2h4Xv4BOS/0aJdqRG
X-Received: by 2002:a05:6808:6413:b0:4e9:3412:14ac with SMTP id 5614622812f47-567e10ac541mr2034235b6e.33.1793978367791;
        Fri, 06 Nov 2026 07:19:27 -0800 (PST)
X-Received: by 2002:a05:6808:6413:b0:4e9:3412:14ac with SMTP id
 5614622812f47-567e10ac541mr2034200b6e.33.1793978367246; Fri, 06 Nov 2026
 07:19:27 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com> <sashiko-outbox-198921@kernel.org>
In-Reply-To: <sashiko-outbox-198921@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 6 Nov 2026 16:19:15 +0100
X-Gm-Features: AclHuK_9kd4-vi33h14qEUizW5VOTBDWrh0Qg0FV14Te6uxs8q7OXuaFrYepPH8
Message-ID: <CADSE00LW0+EwEg8OBXUzZSkAu1-X=ofX5Dirq0+gbTTBUho6_w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] selinux: Restrict cross-cgroup dma-buf charging
To: sashiko-reviews@lists.linux.dev
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
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 12:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selinux: one-off dma_buf class instead of general cgroup acces=
s control model
> --
>
> commit 675e985fff50ea6716b8c00023a75c07ff345a6f
> Author: Albert Esteve <aesteve@redhat.com>
>
> selinux: Restrict cross-cgroup dma-buf charging
>
> This commit implements the selinux_dma_buf_charge_task() hook and adds a
> new dma_buf object class with a charge_task permission in SELinux to
> restrict cross-cgroup dma-buf memory charging.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 30776b0107f29..8f39d91eabc97 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2204,6 +2204,12 @@ static int selinux_capable(const struct cred *cr=
ed, struct user_namespace *ns,
> >       return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_=
ns);
> >  }
> >
> > +static int selinux_dma_buf_charge_task(const struct cred *from, const =
struct cred *to)
> > +{
> > +     return avc_has_perm(cred_sid(from), cred_sid(to),
> > +                         SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL)=
;
> > +}
> > +
> >  static int selinux_quotactl(int cmds, int type, int id, const struct s=
uper_block *sb)
> >  {
> >       const struct cred *cred =3D current_cred();
>
> [ ... ]
>
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 90cb61b164256..b4ebedc6e4240 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >       { "user_namespace", { "create", NULL } },
> >       { "memfd_file",
> >         { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } }=
,
> > +     { "dma_buf", { "charge_task", NULL } },
>
> [Severity: Medium]
> As reported by Paul Moore on RFC [1], adding a one-off SELinux object cla=
ss
> and permission for a specific subsystem's cgroup charging (previously
> dma_heap with charge_to, now dma_buf with charge_task in secclass_map[]
> and selinux_dma_buf_charge_task(), along with charge_cgroup in a later
> patch in this series) introduces a narrow, subsystem-specific policy clas=
s
> rather than a general cgroup and resource access control model for SELinu=
x.
>
> Although resolving the target memcg from charge_fd moved into generic
> memcontrol code in mem_cgroup_get_from_fd(), the SELinux hook in
> selinux_dma_buf_charge_task() and class definition in secclass_map[] stil=
l
> define a dma-buf-specific class instead of a broader cgroup access contro=
l
> abstraction.
>
> Should this permission check be designed around a general cgroup or resou=
rce
> SELinux object class rather than a one-off dma_buf class?
>
> [1] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore=
.com

I held off on this so the core charging proposal could settle first,
and then refine the LSM side later / in a separate series depending on
the feedback.

For v5 I'm adding a capability baseline in mem_cgroup_get_from_fd()
following a Sashiko report, so that charging a memcg outside the
caller's own subtree requires CAP_SYS_RESOURCE. With that in place the
LSM hooks no longer act as the only check, they add finer-grained
policy on top of it. Also, unlike the RFC, they are now called from
generic memcg code rather than dma-buf code, so I should have renamed
them (and plan to) to security_memcg_charge_{task,cgroup}().

Regarding the broader cgroup model, as far as I can tell, existing
cgroup control points are kernfs file operations, which SELinux
already covers. The only non-file operations taking a cgroup fd (i.e.,
BPF attach and perf cgroup events) use their own subsystem classes.
Since remote charging in this series consumes the target cgroup's
resources, checking against the cgroup's label (as patch 7 already
does) sounds like a good fit.

So to Sashiko remark and Paul's comment, rather than a dma-buf
specific class, would something like a "cgroup" class with a
"charge_to" permission for the cgroupfd path, and a process (process2
really) permission for the pidfd path, be an acceptable first step,
with the class growing as other non-file control points come up? I'm
happy to adjust the naming or structure to what works best.

BR,
Albert




>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_20230=
123_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D6
>

