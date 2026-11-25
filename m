Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623317;
	b=bR9cmFTAXoYAhr1iND3K8kXHvn8bmNSJSV5yOaCpTnFxC/MC5PbJci1trulkg0fGun22
	 9yBxShykQAn/CUqlQIOV85W2XTHqbvC0H7WcpV0CHhPzKfrkK/BR0Zu3wTfeLgZ7h8/th
	 zyeYqDG1wr4x5KhbvZf9Jkr0AS8KaA5nRZ49WsoSB5CIxPqqeJrY7WhDIAmba4eCYdRdu
	 5UV6jn0l4jH56S5iQ85Lr9dxHIvT+DOiE3bMcs7Y5leZhh0lDkI5kiOVn7vJfjlS8Rkyw
	 YjRPm9BZ0tgEgsBzGKx3XQhjmkXy34ek6QwtgXfIydQ6fO6KujCsgNOlBvty26ppq7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623317;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
	b=TPVHTEfjKk1C0Ud9zJCmqDZfjYKFMvsZTTHGE8J4vN3EPOQADyFUIsixbcq/AINDCY9o
	 kuUaHQiYWiWrWj9TFA01Pm/LbLGEUTEXCiPhOE/VrWEFYes3MEc2Uf0Ksu1AC2C7w3EMX
	 ZV6DkYrcR1Ylbrpjal2MgyVvDvhtc17LUmirzDqfa8IH+ah0yLrbqlDFnIH4US1Q3/lpt
	 EuGjGZWzFzBm2O1htmboSIwbJIYzmpydLdddYltOCzjHHdcqw1eaAcnXjRYxC0FrKOXJw
	 UwBvaF1bRacf+4agDegKfQQKx90EaUPuWr4L9e2oJFjqoa8VctlnGLYMBKdHbV65ySA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="i/sjixNX";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oaboe2PV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9910606A321
	for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 16:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9910606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i/sjixNX;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oaboe2PV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795623315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
	b=i/sjixNXl3r5GPHHEFkXv16gfjzbESzfNVL+ELEJP8IXgC4d6JItv2XIW99mQrRl1Ae7EN
	JpqjHWOAZU4a5Fjkiq1+rNwD7BhIuQYI6HNj5I8e93fBjbpdisUya3eIamMnAxo9zgMC4z
	OdS6ezqPxtWPhICnw+5EVyI9KbcLxNk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-ANFgUgPbPt-UawUXZAyxxQ-1; Wed, 25 Nov 2026 16:15:08 +0000
X-MC-Unique: ANFgUgPbPt-UawUXZAyxxQ-1
X-Mimecast-MFC-AGG-ID: ANFgUgPbPt-UawUXZAyxxQ_1795623308
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cbf700ddccso4379037b6e.0
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 08:15:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795623308; cv=none;
        d=google.com; s=arc-20260327;
        b=UTpNskcITBRTaZz9Jk87LwtOI/LRC4i+I305wQAB4w774uWSA+N1qxMMjkI2jU7+8o
         3JbANT3SSCQ2q4pvE17Ofb1VpIEGkgkEHcYKBNa+8+wfDVXFesuq7TLcwO1y2UEvHmaQ
         2DWsUKSuPbsTFvDpese/TUDHfW/rHKfso+sXIFa47Kts+T4l12Ka2UQi/RS2lGvfniGy
         2/dlJzoLLcKQ0m9WgceorWEStxKh8zQx+fisc0hxzv5pBtkdHE5umQcC2y9OnbRsP6NK
         vxIzRkPsinIz5nm/1vZUUDW96xwXfEb7Yh4QiMtI8Xfir+548LobQ+qon47ve49mKHqj
         hIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
        fh=y++hWClzj1+DIIf+DUKEEfrfMOGzuU1MnBpPCCmXp44=;
        b=W+yLjpJdUqeKUg8+s5zk1i96u+MH42/1EFKhJ9tHDaM7iVgH/VJ4Z+gSZ5kopZYFoT
         YG0j8rf2H9VvDofPESZLGQT5NUfsdjilgrb62RmBHwjGnIbgwFQgNpOMjDqzgVZGEpYt
         OORUPouipk7/89mpmGTvrv2czQAKCMXDOBBxEo8PDKka3sbV3i3Z/HURcLBNOfm/ZYkn
         v5SPIdFQ5zmF9E0tc0pJsfuBaA+F6hOqYzPhgjqwkWGtOxb4F3b+2ig5K9b9WqDwWqXa
         G4dL725Wf9nFTKFn3cN5oQU9H4SEgPtcBi75RmvMExtBeZjKWw5+tRCdLGYCdJO3IaZM
         QwUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795623308; x=1796228108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
        b=Oaboe2PViWEq0So+RnJIvBpWv2oUca7oKSNLSN5zUE12qFEh9X86SM5/OLsXeOXi+6
         RWkCRzvujLvMNWJImzFyaBBUfHz1maUpS0OWk2uzBZDHGMlpdEYjbxXJ2/ub48Gcp5EN
         woInw3NN9bnwKGBS9YGiETO6kydhsqpStsdrKsuPAIGandvGDLJdMi2WiWkDptm0ykgn
         nQTgHVDIisjPhEXWyy8MXTwdSBHfelPMk+Z0oAPzgzbQCKQbhYIA++VXiZ5yBcE/NYl0
         PGAVVsQAVIC5XVK6XfJv3BPY0hpI6cDWN+S2bBdFA3W9MQ73CncOjT+pWt4x5GVmWR4j
         6P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623308; x=1796228108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
        b=bGyasExSyp6Y3J+CGsps1rw4UzcNG/k4Nfp+ab6CRyO4KCNQxV93AuwOCOVDJYvYk6
         wCAspqoabW/9wrfEw2WKDCCiKnFYjFvCGkRYFEFVesTey829lZfnlMDpPK7vZTbmErV2
         uJJA4CVTQ/reRssYmmhvrFXE0hOjr6CI5aM1FvHN6S7Koaotj835JyV4VglASoHm7P9p
         pnY92ZFnO8gcvCyIdVFFUpjgJSpvYBOSlyvqpHdzD4HUWJ5eLLAoV5o8j4WN9sIRsX/O
         kQGVOpDUdLde9QlBaULJeGO5rgqbyahUr//uo2ySMwIW9hhRJcbeksvxCBSpOOGoFZZb
         YDuA==
X-Forwarded-Encrypted: i=1; AL+hErEOT5Y1z5hL2fgcz7DVRNNEw4D1nA32acO31XajrgRttEFEE2yAQeCj2ZJiUvMYhtM2FJgSYq05@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gq/hZ3/DaRm3SuyYViRjoGTha9foFJgAtzK13WWy43Bs5bU2E
	/Gq8HJ6upX6qHfNKrDq3jNa6Op7jQ7i5pejsnnV7XVYuaOuN9iYGytD9I25IUb+JIZB7hVBWs+9
	EaJosomQBt8fJQkRnxm4rHcQyIAT9PUefZJJNJiNJsb40njrkcL62p4j0rZ4BP+bDPduxWnww0p
	ZY2BhAVA7Yt8p0d18pIXPfySu/roXgVugf9Q==
X-Gm-Gg: AZFdTZfCHZxWPUZl0o8MxKbnaAxXTkzfYYgG8tJ7nDkrzfXmisch6ZpiGH/yq/hrtIA
	U8aDGPn2tJey+KbRKgA3mFRJ7uj839IqqgcJqEld4POZk7a9vtunDS5LV84A+5+Pr6gHlKbBFLG
	ve7x+NVGvwZd+/99Gg5IHIWDEeFl6/SEusRep43lMeb4Y+cDoLH3dYc+u/
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id 5614622812f47-57a0a111c93mr20349885b6e.11.1795623307704;
        Wed, 25 Nov 2026 08:15:07 -0800 (PST)
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id
 5614622812f47-57a0a111c93mr20349798b6e.11.1795623307221; Wed, 25 Nov 2026
 08:15:07 -0800 (PST)
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
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com> <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 25 Nov 2026 17:14:55 +0100
X-Gm-Features: Aa3M54qg8B1tVY9MI_hj21-3fP47U-BOsj1Lrj8qIxJDIaifgpgCHqLTs9bOP0k
Message-ID: <CADSE00JMSXm4Vi5aH=k3VgLL__EsdEZgg_PqkSkK0LQumj1SUQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
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
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
> >
> > The security_current_memcg_charge_task() and
> > security_current_memcg_charge_cgroup() hooks allow security modules to
> > control which processes may charge or transfer memcg memory to another
> > process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> > a cgroupfd, both passed in charge_fd. Without a policy implementation,
> > either hook is a no-op and the restriction is not enforced.
> >
> > On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> > domain that holds both dma-heap access (today's only exporter that
> > opts-in) and that capability, can charge memory to any cgroup outside
> > its own subtree. Since the capability is all-or-nothing, SELinux
> > policy cannot express which targets such a domain may charge to.
> >
> > Implement both selinux_memcg_charge_task() and
> > selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> > object class and a new charge_to permission. Both charge_fd flavours
> > ultimately charge a cgroup, so one permission covers them and the
> > target type keeps the distinction: for the pidfd path the target is
> > the referred task's SID, as there is no cgroup object to take a label
> > from; for the cgroupfd path it is the cgroup directory's inode SID,
> > which comes from the genfscon entry for cgroupfs unless the directory
> > is relabeled.
> >
> > The checks run when the charge target is resolved, before the
> > CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> > charge_fd target, including the caller's own subtree, so policy needs
> > a rule even for self-charging. Policy authors can then grant
> > cross-cgroup charging selectively, for example:
> >
> >   allow allocator_app_t client_app_t:cgroup charge_to;
> >   allow allocator_app_t cgroup_t:cgroup charge_to;
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  security/selinux/hooks.c            | 19 +++++++++++++++++++
> >  security/selinux/include/classmap.h |  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6c4c64d6e904..76a714107ae4 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cr=
ed, struct user_namespace *ns,
> >         return cred_has_capability(cred, cap, opts, ns =3D=3D &init_use=
r_ns);
> >  }
> >
> > +static int selinux_memcg_charge_task(const struct cred *to)
> > +{
> > +       const struct cred *cred =3D current_cred();
> > +
> > +       return avc_has_perm(cred_sid(cred), cred_sid(to),
>
> Small nit:
> `cred_sid(current_cred())` could be simplified using `current_sid()`

Nice, thanks! I will apply that for the next version.

>
> > +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> > +}
> > +
> > +static int selinux_memcg_charge_cgroup(const struct file *file)
> > +{
> > +       const struct cred *cred =3D current_cred();
> > +       struct inode_security_struct *isec =3D inode_security(file_inod=
e(file));
> > +
> > +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> > +                           CGROUP__CHARGE_TO, NULL);
> > +}
> > +
> >  static int selinux_quotactl(int cmds, int type, int id, const struct s=
uper_block *sb)
> >  {
> >         const struct cred *cred =3D current_cred();
> > @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >         LSM_HOOK_INIT(capget, selinux_capget),
> >         LSM_HOOK_INIT(capset, selinux_capset),
> >         LSM_HOOK_INIT(capable, selinux_capable),
> > +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> > +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup)=
,
> >         LSM_HOOK_INIT(quotactl, selinux_quotactl),
> >         LSM_HOOK_INIT(quota_on, selinux_quota_on),
> >         LSM_HOOK_INIT(syslog, selinux_syslog),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 90cb61b16425..1f1f2fc4d35d 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "user_namespace", { "create", NULL } },
> >         { "memfd_file",
> >           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL }=
 },
> > +       { "cgroup", { "charge_to", NULL } },
> >         /* last one */ { NULL, {} }
> >  };
> >
> >
> > --
> > 2.55.0
> >
> >
>

