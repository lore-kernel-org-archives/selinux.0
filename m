Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EA334C1D
	for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390237; cv=none; b=qgoCdEE1CuL4bcjrRM3A13bNNGu28gLB3StxpbWsgyDHUShDK7xYakRt346DTpL6d1Z6Fe1loPFUg05z50K9BomDabhgJWf6uql5KrOr2+gKdSVlEOxOGBlUHwM0FCMX4SkyozcilMMmuj3nyQA7BtXNGNdbN+68PUjoeAFzAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390237; c=relaxed/simple;
	bh=6NuU1TaKKlGMlP3B+lllJeXPWIW53S2nsAu1WDF10i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGL1HKgWFl1N2k3epZ5Y1oRGXN10i6d3791JBCO9WM6syCk+kVtRTeS7G0Jkp/fl2sHbZEfqMDJQijlILNmQAmnZF6wxNrXbZzpwVQcCDxA5EyLZCyAY44y37wAmuo448bBDqC1UpmeKRHEPPZzb/rx7Q5JmIM/83Sz9seCPkR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk7c96Wp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk7c96Wp"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so3101544a91.2
        for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763390235; x=1763995035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu/yE6ia84zmqVhbXQnJS/8J/nmh7PcLwqeIWJSCJZw=;
        b=Jk7c96Wp53kgutOVOKbTLn8SwQP/5T2+Qx4KrkQ1bP/96q2fnyxq/kJQg+vVzWX1lk
         znd5gJXqE+7mDhjMisa3K+Z5y7YqvfIDKPGbVFzVyMsJ2Tpr5MetzwHi3n2YCKiiZxfz
         UEv0gIC16p0zvj4ahWAZk3EqzHPuHLStdfQZMzqJipG0rMyNNVOLPetyBWMbzv7ninc9
         S0WF09r4Qj21N0JxEYp3gDkt0ZQk4juPPUpq/XV3MxUMAZMzzC3sMZb3/AcrDAyz0LJC
         wlqCTx66zlKfGKG91oSaXDzhcjAs8azJ2iZkR/8EptpW/Hx2Rc8cPmX58CDwSYO80sC8
         /HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763390235; x=1763995035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vu/yE6ia84zmqVhbXQnJS/8J/nmh7PcLwqeIWJSCJZw=;
        b=jdyNKra6IqFq8p6WdOEfdM8/IOdsN/Laweo+Pa/S1wpaznYysfo/1hp8KvGrKacY4z
         XlyxxV1OgMKefOFo8vX5k6rrrgu6m2Kzv5B9+VvwugPqoxmwu1P2ato0RW5h5Nq8t2kv
         R8/BvpbbBlTny8MI1eAhwVGuejRIUULMgnRuhD728FkyD9VvUSUOhB0YwIJS/PFfiQfn
         7QdgFWQvHhSWaAFvgp4np2WlZwCBB3tuZgOIZSQt4rIH1UlvUC34IVC8rfWpdfwbAI17
         nlFYAy6R+VNtTY+9z7fbzMPmvq87S0MHkvVrLMQfGzCXHKc571XMaKhh4/POoD7j3yrj
         KJew==
X-Gm-Message-State: AOJu0Yz1w3PYCjwhH1D9JjMs4/aSexfMqZcmMY+LN19oEF30DuIqhDAO
	5+Uoi0s+3HHlSWAdfP1QI++IQ1J/+Bsx1H1LnAuKOPVuYvpP8PtQXavBw1xvWI0SDsmfDZ4YEdw
	2SJoH2v3vOonR6K17TAmGAu0BGTEOQE4=
X-Gm-Gg: ASbGncuXrfiG7dNt05AAS63Sgnc3unFiSp9gFhdcYAi7UpU1uC/Ph6oBe60XbK9Lv0w
	p7mcXc8u9XsCwyU+PYMo0MGG9lUik+5Ra+MET6wKcNKFz0OMoXWPhHRBJ+zgTF+0Ep6kCTWyU5V
	qzGmFIVFo3ZlW4jk7DEWEQxFtIqhq/ovNm/LppefRRYm9yyFnIIbbokvaJKjohgkK6hHIW1FHH+
	LpXv3fpvvl+bYj8VS4dDYPIYmy0QlGGeuBaDvj4f8+Mlk2MTsvRJWf2mb7RB7bqq8mI0sQ=
X-Google-Smtp-Source: AGHT+IGA4lO3G/PMP5VB5l1H1GWQwrAgq7sQvuCrBc/XxpUAU0k3T4TYZvQ9ybNLsd5n7G3vEchEWEStDlU/hWsxG+c=
X-Received: by 2002:a17:90b:38ca:b0:340:c151:2d66 with SMTP id
 98e67ed59e1d1-343fa638ef3mr12030299a91.30.1763390234628; Mon, 17 Nov 2025
 06:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116205208.734-1-ericsu@linux.microsoft.com>
In-Reply-To: <20251116205208.734-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Nov 2025 09:37:03 -0500
X-Gm-Features: AWmQ_bnMnCpP-ChUgTO6pSn_xdUIUqT6rBTGdOZbRfGJAkSai9R7IxM9Gc8bybE
Message-ID: <CAEjxPJ7s8vS_Spt-9wabztTeh-3j+uX6auSEecHZh6RfkPpQHg@mail.gmail.com>
Subject: Re: [PATCH v6] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 3:52=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> BPF token support was introduced to allow a privileged process to delegat=
e
> limited BPF functionality=E2=80=94such as map creation and program loadin=
g=E2=80=94to
> an unprivileged process:
>   https://lore.kernel.org/linux-security-module/20231130185229.2688956-1-=
andrii@kernel.org/
>
> This patch adds SELinux support for controlling BPF token access. With
> this change, SELinux policies can now enforce constraints on BPF token
> usage based on both the delegating (privileged) process and the recipient
> (unprivileged) process.
>
> Supported operations currently include:
>   - map_create
>   - prog_load
>
> High-level workflow:
>   1. An unprivileged process creates a VFS context via `fsopen()` and
>      obtains a file descriptor.
>   2. This descriptor is passed to a privileged process, which configures
>      BPF token delegation options and mounts a BPF filesystem.
>   3. SELinux records the `creator_sid` of the privileged process during
>      mount setup.
>   4. The unprivileged process then uses this BPF fs mount to create a
>      token and attach it to subsequent BPF syscalls.
>   5. During verification of `map_create` and `prog_load`, SELinux uses
>      `creator_sid` and the current SID to check policy permissions via:
>        avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
>                     BPF__MAP_CREATE, NULL);
>
> The implementation introduces two new permissions:
>   - map_create_as
>   - prog_load_as
>
> At token creation time, SELinux verifies that the current process has the
> appropriate `*_as` permission (depending on the `allowed_cmds` value in
> the bpf_token) to act on behalf of the `creator_sid`.
>
> Example SELinux policy:
>   allow test_bpf_t self:bpf {
>       map_create map_read map_write prog_load prog_run
>       map_create_as prog_load_as
>   };
>
> Additionally, a new policy capability bpf_token_perms is added to ensure
> backward compatibility. If disabled, previous behavior ((checks based on
> current process SID)) is preserved.
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> ---
> Changes in v2:
> - Fixed bug in selinux_bpffs_creator_sid(u32 fd) where it retrieved
>   creator_sid from wrong file descriptor
> - Removed unnecessary checks for null, per review comments from
>   the first patch
>
> Changes in v3:
> - Removed check for 'sid =3D=3D SECSID_NULL' in selinux_bpf_token_create =
and
>   allow it to fall through to the permission checks which will fail as
>   access denied to unlabeled_t
>
> Changes in v4:
> - Added initialization of creator_sid in selinux_sb_alloc_security
> - Enabled handling of creator_sid in selinux_cmp_sb_context and
>   selinux_sb_clone_mnt_opts
> - Minor updates based on review comments
>
> Changes in v5:
> - Moved to dev-staging branch instead of main
> - Added implementation of selinux_bpf_token_capable which is originally
>   from Daniel's patch
>   https://lore.kernel.org/selinux/20250801154637.143931-1-danieldurning.w=
ork@gmail.com/
>
> Changes in v6:
> - Moved changes to main branch
> - Updated bpf_token_capable to use grantor_sid as object in permission
>   check

> +static int selinux_bpf_token_capable(const struct bpf_token *token, int =
cap)
> +{
> +       u16 sclass;
> +       struct bpf_security_struct *bpfsec =3D token->security;
> +       bool initns =3D (token->userns =3D=3D &init_user_ns);
> +       u32 av =3D CAP_TO_MASK(cap);
> +
> +       switch (CAP_TO_INDEX(cap)) {
> +       case 0:
> +               sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_US=
ERNS;
> +               break;
> +       case 1:
> +               sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2_U=
SERNS;
> +               break;
> +       default:
> +               pr_err("SELinux:  out of range capability %d\n", cap);
> +               return -EINVAL;
> +       }
> +
> +       return avc_has_perm(bpfsec->sid, bpfsec->grantor_sid, sclass, av,=
 NULL);

1. There is a 3rd possible SID that could have been used here if this
is always called in process context, i.e. current_sid().
Do we care? What is the typical relationship among the three SIDs,
e.g. will two of the three be the same in the common case?
2. Do you have a test case that exercises success and failure of this check=
?

> +}
>  #endif
>
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
