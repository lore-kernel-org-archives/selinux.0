Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF3356770
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733579; cv=pass; b=Kmz6oxOwcY6QkWparRRlCj0q0JXlLnDmgWfReu10PoOyl8DhB1P8Zbpjf7BRhzznPI5HfIC/hsUeoRiFgjOV3qwkUFqT+JZ2SMKWkpHNmXOGWiIph5zUAz4Ociz+tjIsDt5xendqntt7gT4aEen6dfLxOz34P0UC+T3FG8nYt1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733579; c=relaxed/simple;
	bh=FXgNGZaCn31j4DBFtwd2epYk6bSzjHMX2Rpy2w/abkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCjzfR3ewywgxCZRN7/vr3QebXjstJ7R0FLA6n1GABOUQtHdn+9XPhFamtaFkIqMmIKlA3CAhQFprEvbBqJB7HtKFbAeCnUeYu2JKA0a7hIK0/39BO4Uk5VD06Df92sGn/R2Bd0gGcJE72AkhmMuaxmmtH78asq7j6WH8CP5SVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X7eLh0g6; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X7eLh0g6"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1dedso1504701a12.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 18:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790733577; cv=none;
        d=google.com; s=arc-20260327;
        b=cfcWLLQnqrVsH3JqBsx6HtrzZ+y3LZnYC1QhfahxIyTQF60c97f7q4qKLkSop0WUIP
         obo2MwCvi+937ySbhJrlPXfyCPx47R8J5DqHo74ViOreKQ48WWor1D3ZftFMDKsywAl5
         Tuxi2UMkpBGZPRdVhUhae21xCv001xDQjRsfSAWg04hrEHoyYMPQ/2J10XU4Xe2DO1tG
         1NDR/V7Dk3CpuNKvh5e62pwjTn4Hj1zKtsMFc2q2+PfDMh7VmXdkOtyhn5oUcmvKENhc
         MWnGZwdy+Lp9BB3iHzsP1YnF418f+xmf97I/xxxujO5OBBGSjCWRYkqpvVqyFz8UdbBU
         MG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PnKCgafJWQup5yHqx8hEqqKmbcy4exuf0d3rn3nhwcg=;
        fh=bDk+gd2OGncLT7Yb4J2WBsUpg8yoVBGSdPE52CqE3eI=;
        b=QGRHOIcbsyi+sERpkD32C/XdfqS33nl0ud/Xsvg9o8mdodXk7KugLtF04sfL2J6bhr
         DSvl/4ry0yvBpI4a4RxIX/yYJSz0GgIwzkX1ic2EZeY9ugM6V3+XdfxclDQCHnGcGlPX
         SvEwXaCSWH1wDqkpzHRYaBf4pu9ou1jCazzqV2cu0hTTybeQAu++9aQbfGNdsIrWbJ6m
         NnjXTtfpOvEuCwGpTKoFUkhtdQU1dln05T+QeIdmKyLrh7xgVqa/I5qQULW8g6NXGt+q
         lhKgChY6KUjarucL+TQA9eU2pBQ/I0IyG0uVy+Tm3Xae0YL9pdq/fBc3L6TmgYXHGcMB
         TBtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790733577; x=1791338377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PnKCgafJWQup5yHqx8hEqqKmbcy4exuf0d3rn3nhwcg=;
        b=X7eLh0g610HC9TjKiGsm7RAztKALAn1wRZMgcZNfwl/Wql3mNxk/P4cHH+h1LTgI/i
         yjXacBqSa+i30aa6P2+1EqWcsDjbmME+ocJqVniynfR3e0+PZdhPOosFnADxD1zgWFPo
         HOsQcCSIG7rGxAIMFlcOeBJHeIRfzPrACPtqXYqRWVEwp09vbL2Dc2bY5TwjFp2RrRKf
         OJ2CjUw6B1L2R10zIMeOTZZeD7sVQwzT4/DXOUZvVSyLcwH64wbmUU+tY1+5sg0Voza4
         cBldzefBKChfQzEHS2x1EmZqbO6HXedm6hvSvQ8JMTIfByS4O6S7rnssoha9LkUr/r3G
         XpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790733577; x=1791338377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PnKCgafJWQup5yHqx8hEqqKmbcy4exuf0d3rn3nhwcg=;
        b=Zvd3EIlkOzC75mE7Rut/pYwgFAgM3Ro7dXNtxzxEVcSuqJgFdK1pi1zqcBIRAdotCw
         XX/iXtvS4h/HIndkvXRYcV9tL9Z0NVN0EeEEcSHNIzRqKJ3iRPT6IChV4gVEHB+rh3ju
         BGMAe06X0FVLcFCpl11eFH2LXlFMFcm6PPCLc/15qDW0aoI3VCF/JfHea+9LHaTyR8XG
         wwCW1AYUhsbpcTbyPfl/NM6ztyOFf9vcnQCIfXaVHpY8aEsR1RsjLvNl6DYxHujJ/REu
         IdiimCHhNoLjXYqZ/HTdu++znzK/PfKUzqQMuZFdKfRjB8nt2sRhEUt4VcJL4+YohSA/
         Eeuw==
X-Forwarded-Encrypted: i=1; AKwUvBy12oXMJhXcBOmxz2ZC1K9inajF2UOGx31T2UkWzowN6dzmwGzaK6SGmwXj6erVz1DhX7XdnsDr@vger.kernel.org
X-Gm-Message-State: AFuF++l3WFSfzxwu7sGHDb1rX1hXGLD1juteAtuyyvM7huflY2SeyPb0
	8rIHLUgT63avBF9uJhRd24SHslH5B7z3Ky6J3zOMeSgn8whcvDb3DypWBztnOGKKbp+xb4w9eEN
	Ct3+QHXO1m/klpZyQqq3P1yDAz8OMtDYCLVx6NHt4
X-Gm-Gg: AYBFou0OAMlwdiEBoyJmzAjG2lnPJD5sP2IlB+1eMgdv4SFemrWuZ3B4f+DiJ6g5D3l
	WdCb0sk2nQ8yUb+3sH4MNMnTfDxJnpGqhdhrNV4DdEnSxc7H5mYC6LgWQEIRfYNiwQBM8UdLvYo
	GQIco6kegQb6Dj9VNk/tFlaxscChOdMcFrNDCVCGaocHXM3tsqaJ/WDPaot3gmqRJ+CyMR23ktA
	/tOpl31Nt/Krwe0ixstormSmKY0k/8bIlZWm8WGQRI7MQ2GIdaQ7e/3R8NWASJAkb4kk22F2VZe
	bCXpmZD1qZwssLQA5Om6wSTac5WcnnEHn81HJKMieATj1wHkF3uBiudXmhbeIn/mP95Xh9TVWLs
	ZCYayvlWgUBY=
X-Received: by 2002:a05:6300:220d:b0:3cd:9f99:3381 with SMTP id
 adf61e73a8af0-3de94905417mr1019217637.0.1790733577321; Tue, 29 Sep 2026
 18:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com> <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
In-Reply-To: <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 21:59:25 -0400
X-Gm-Features: AclHuK_v-UBDTipntnTunBskRxQtvMO6S21KmUc_dfH5j9vuCr9SBVNXz7dBt-U
Message-ID: <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com>
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 9:58=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > added a security blob to struct ns_common and allocates it from
> > __ns_common_init(). Most initial namespaces (init_user_ns,
> > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > however set up statically via NS_COMMON_INIT() and never pass through
> > __ns_common_init(), so their ns_security pointer is left NULL for the
> > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > dereferences its slice on one of those namespaces (for example from
> > the namespace_install hook when a task setns()'s back into an initial
> > namespace) will fault.
> >
> > Allocate the blob and run the namespace_init hook for each of these
> > namespaces at the end of security_init(), after all ordered LSMs have
> > registered their hooks, so every LSM sees the initial namespaces the
> > same way it sees init_net (which is initialized at runtime via
> > ns_common_init(&init_net) from net_ns_init() immediately after
> > security_init()) and does not need to special-case them in its own
> > ->init() callback.
> >
> > Provide a ns_common_init_security() helper in kernel/nscommon.c so
> > that the list of statically-defined initial namespaces and their
> > Kconfig guards live next to the rest of the ns_common
> > infrastructure. init_net is intentionally excluded: pre-initializing
> > it here would leak once __ns_common_init() clears ns_security and
> > re-allocates.
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
>
> Seems good to me,
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
>
> I'm waiting for Paul and then I would pick this into namespace-7.4.misc.

Since we already have the other LSM/namespace patches in lsm/dev I'd
prefer to merge this patch into lsm/dev so it is we have the core
LSM/namespace patches rooted in one branch.  Going forward we can
stick with the topic branch approach.

Are we all okay with that for this patch?

--=20
paul-moore.com
