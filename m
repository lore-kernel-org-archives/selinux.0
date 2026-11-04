Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793830884;
	b=33MXUTNWdS9Xr19G1eZ0FE2NkuFbYpRGEFnpcj58P1UjFvyefI9HTwCgig7czgTa8Svg
	 w0KQcCrlinJgTVtQCDw4Xgzs87XzxLG3Ez+VHfcmNYPXhVhHARnPKUr+vAJ29I0dTEeVp
	 K0grWI9PK3xiqHuGTXeliyrL2qHJTBogl3iS/Q5UCa/782+5Z2JCztFZae2GQZ07xtihB
	 3E4gTbPFdCa+bmT13z10S49qCL7AVG6gcYq721OQ3KEiCEiMAqeWesI7tBv5DhXHZCBP5
	 6A1vCYiyeE0VlyNsYODmdVNh/j84reIY00qZDuFRUMR3RYQEC1M+Jzv+aRFHTmaouwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
	b=fSSzw04hMfe8iTVOMw6G4MrB4l9olwLNJXxS1B3yfHsKF0tHXf5/WtvxPojNfAbf4gVy
	 NRIFA3FFH5gpRfK2FjMA10Jk5TZPrt7ZM1Mr5G6aWqThagh/DRt12SU0Sre8KXq0EUeUn
	 p88smt/7aGhLooR7dULAc6jY0ojBCQKi7Ym1W8y7sLhM7iADWjJDzkKSwtJS7HAMTOiQq
	 VTtkqKG4hoHRXPWgNaYdmwP14L0LAPx638Q0oiFnE3D5Ln/C7FuZ9T7Bjn3ZWQIWDFNqv
	 iATxdQg/wGRL7dy7kWlUJNg7V/1RXZTBoPYuAPd3fUyHA9LyHwPQBPE5p8c5Nco/cbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=EwbACUWh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B5606E834
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 22:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A86B5606E834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=EwbACUWh
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso730012a91.0
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 14:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793830883; cv=none;
        d=google.com; s=arc-20260327;
        b=oZFdhRrxTnDq4eEmV3KmrSVhw2r4fF8NcxMeP3EFNqLG00+BpK8uuTXWpE37SVIaFn
         yxJmE7BMAhTesz/ffdhqheWkQ1bbrwC/ScG/fGvnkbhQKtx8YU3MaAfYWCVfgFfdVo9x
         XCj6u1tEuAGYYViSh/ICyrzLg+K18dN6tqFEcDjipxOdj7wR0oVISLYuK07xCEwKnr/C
         lz+XJ4T/CH1njtX6zUJ0LdXSkv5f80XCYaV4eiSLLf9ijYTmKwBe8gjcxTmZsAgfnC1A
         FaPwH3QC8BzbL9+hGQVRHg35IpYGKUqgYABGKK0u8JufKXoAeL8dEUWEb1wrdXqJET0a
         V36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
        fh=xkPXp88SICkEXD7jOHAGoEB18q9nOFe/cXK5FhxJyUs=;
        b=KyZ4O3OFOk2fg8DmoAdCpAA58Y488LisKJv3UGC2xKhMZLR6+HrhlfwSzLr5197IXT
         JwQg0wd9n4d1AWe27+AeFDptQJODiGOKco7LrHt8s6mnJCah4B+aiFdHpPT9x+t997Tw
         9XSC8ylvvoxwcj0Q8HeofdpVEKUJGGp51AcEaE6+R4VVUsqqcqG/wVqCVSoPfIkEsksH
         76j28rF1gNCfmro5GuDtVyKXrv+V4bisGopelKNbmkdcsqGrdcrwxI2795abGLixfS5K
         +eo/hQhyn0GBNsxamsJto4QubnqC6jmWSZeIUFGIEavRoqSwHG29cEHpyU3tNj35AM17
         zYjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793830883; x=1794435683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
        b=EwbACUWh/ILFz9HQIvFu0Z5/9U+Ll2wTb4c5C2ojq2TV+gEhLFLnyn4y0Zai2GqGlm
         /MgYagyd58nnbjUOJ6Tn72s23vRbFBp0GrIJCTUVnoKN6Is1WQs/+VQJhU5RcYtvS6u/
         JXxxf71qFUOVPKibUcANVu+EzxvOdEQY4CoAA7q1vFUFO8IZBjh8pa57u6wkCYaTGZ4F
         EoXn2DSTIjbuRxFZFJ/Fq6tO0O4GjboBcYpYX27MMtgA2szoYdkFFStk+bfcUpOv0PNW
         oib9lAUSpgacm4txxkostDDgImlBXxnN+hhzaEguOWR5J52J9z0wiJkrsZ6tqNVjagk8
         C5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830883; x=1794435683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
        b=RRfRJFfm72jszbT4Y3JD+PJeyDgQwVZIjlK9t3XgME2TuWvxhfUCExFmKFoJDSXyfX
         /8gg1Y3/zSHaV0aiSHnmTiDZ2aweZ2TXYWJsRJGGz/0OmK25055UNZyjJy8qywVIkbhb
         CdYet3RqAqp371vYamy/ry4Xyc8zLw/VY1VRqw8uVnJOHm7XYTkX32JVVMcFXnTvEVOJ
         c/m0hSCi8xyyaHqChEw2RnXyWkPnpLAZbbnIqmTFsQgMzxpxgylHJb7QDlyLE5oqp7iT
         nvWSKQC7Z2d2I/BZnNlm3PvPQO0vFD+oprVSC8eYmERha9x0C8x3oRtWx1qabSoRVMdz
         6hlg==
X-Forwarded-Encrypted: i=1; AKwUvBymXJxWkF5c5v5CawdhrSuk7bqU1lOTGo7tBAmctI64BK+jOjTU6ypmOgRBbsb2pOhEFkNtAt16@vger.kernel.org
X-Gm-Message-State: APuU4Z8p7JTbEKnvkMJkd1Vjw4wUnJ5S9ejJn3YfmeFbK87HeU3+zKe2
	WamsviANF1LHKuV7SF00sjcDY4wGcr9ETsqCSCxfMtmeq7koO9qKcsaMtnfLYV1NZdi3gt769+M
	VBCjbVWsVxQfKSfMik6BgOmViSU4Mp4jorOqfVetv67KmSsEnVRRKQh5H
X-Gm-Gg: AYBFou1vYOLnWVpJiLT/97s9OrZm/i/Frr4j2x79vy5Ikyg8CdAEY1odKlS01YnBO9b
	jo/0ShNcHJayWIMN1EHDILUv4BclpGjuETHAlfx9DIH14dkZ27MSbABOXV85dy8a2pHRHpi0yMT
	jE0GEyruWwMFWdcyM21N4xE0Yu7gKg+Sdg+N6hKwJyh7FJVn9FIdY2xsHzip8HgI8wVhR0E3q72
	mu08wI/yTyCjWQLc8pbVHMGyeVQgKxUnX5eHHA8W+3LGYQBtaMY+5Zzg5gjGULd8j69ykExwrny
	4Zy/rmeS7BS6kFwpnZcINNOw8PQ2+vG1UIiOZvz3TaQeBKGlBN8IZ504sAzc1hqfbvv0vvSOXFS
	yfFyEjB4EqgD4hbkYnLY35XzR7pX8MQ/JFzfsipvpEi74c4SUcsMiwHRMSnLdAfSTNcvG
X-Received: by 2002:a17:90b:184c:b0:3ac:80dc:f40a with SMTP id
 98e67ed59e1d1-3ae897ccf87mr13484262a91.16.1793830882894; Wed, 04 Nov 2026
 14:21:22 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
 <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
 <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com> <CAEjxPJ7w-8J37OjPUNzLzofbPezq41yK_GtsZJxRDNbDRZnw+A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7w-8J37OjPUNzLzofbPezq41yK_GtsZJxRDNbDRZnw+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Nov 2026 17:21:10 -0500
X-Gm-Features: AclHuK8oAOcmQr9QeNcZUG9DLGm0Kon1y4YmBx18Q9hBBgLq5tR5otd_ITe4khY
Message-ID: <CAHC9VhTugsLKwxQaREShdP-7+Dc=ndSRQxAAuJGu+tJkFoTQfA@mail.gmail.com>
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Sep 29, 2026 at 9:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Sep 25, 2026 at 9:58=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> > > > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > > added a security blob to struct ns_common and allocates it from
> > > > __ns_common_init(). Most initial namespaces (init_user_ns,
> > > > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > > > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > > > however set up statically via NS_COMMON_INIT() and never pass throu=
gh
> > > > __ns_common_init(), so their ns_security pointer is left NULL for t=
he
> > > > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > > > dereferences its slice on one of those namespaces (for example from
> > > > the namespace_install hook when a task setns()'s back into an initi=
al
> > > > namespace) will fault.
> > > >
> > > > Allocate the blob and run the namespace_init hook for each of these
> > > > namespaces at the end of security_init(), after all ordered LSMs ha=
ve
> > > > registered their hooks, so every LSM sees the initial namespaces th=
e
> > > > same way it sees init_net (which is initialized at runtime via
> > > > ns_common_init(&init_net) from net_ns_init() immediately after
> > > > security_init()) and does not need to special-case them in its own
> > > > ->init() callback.
> > > >
> > > > Provide a ns_common_init_security() helper in kernel/nscommon.c so
> > > > that the list of statically-defined initial namespaces and their
> > > > Kconfig guards live next to the rest of the ns_common
> > > > infrastructure. init_net is intentionally excluded: pre-initializin=
g
> > > > it here would leak once __ns_common_init() clears ns_security and
> > > > re-allocates.
> > > >
> > > > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > >
> > > Seems good to me,
> > > Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > >
> > > I'm waiting for Paul and then I would pick this into namespace-7.4.mi=
sc.
> >
> > Since we already have the other LSM/namespace patches in lsm/dev I'd
> > prefer to merge this patch into lsm/dev so it is we have the core
> > LSM/namespace patches rooted in one branch.  Going forward we can
> > stick with the topic branch approach.
> >
> > Are we all okay with that for this patch?
>
> That's fine with me.

With the v7.4 changes now in Linus' tree, it doesn't matter much to me
where this lands; if Christian insists this go up to Linus via him,
that's fine with me (my signoff is in the branch below).  However, in
the interest in getting this into linux-next sooner rather than later,
I've merged this into lsm/topic-7.5-01-lsm_init_ns_alloc branch and
will plan to send this up to Linus during the v7.5 merge window unless
someone screams foul.

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=3Dto=
pic-7.5-01-lsm_init_ns_alloc

--=20
paul-moore.com
