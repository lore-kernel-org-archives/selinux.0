Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADA31ED83
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512005; cv=pass; b=V6g+9JJlJMuteRmwMRZVG8b12OW1BxF3kN25Cwe0hO8SoAevNdG5ZcFnKIb7Vjoq+2AmKDLl0NkJU4OIENEJs5NoNsR06USzlu/sFwuRBIJmTpTB2MPhRGP4ZZ7ZH1A9zduWNRgtSO32BIxQsSg+7dTkDSxnIMxTfQuHARZ50WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512005; c=relaxed/simple;
	bh=VuFNcnIpHKuBE9TqXe/JfxuxV9DEEfYcH5BhOui7Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEE+THOcHyMiqSiYNaX6WdEdeju5C+Ru6L3sQtFJ+ouhCUolgkeUxvJ02G3j6g3Ir3XBZUtLSbbtM8dVGcAqOjL3Fp6HfNnSkbTjEB30iKdFm0i3oCrnSeltVjSvowb6sVPMIZJBiJutOXKn4TlMcuz9bO+0bcTbi7WGpNaVnQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WlLS7APe; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WlLS7APe"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so866642a91.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512001; cv=none;
        d=google.com; s=arc-20260327;
        b=JpunMIcqIKO+x/YGluN7QDe4WzffcJ4dc7Znp7mwGK4ItrTeF4YiL/6be6uxHiOyUV
         /lI/SUuiXgyqaOSupdssM6K/6ucDcGO/k7DYCC4XIwnMmAdEZM3fIIMb8eCZic35ln5P
         S4RAr3OY7p08waj3Dbx1xXPAW7sGSJuqvx+eNBExqc3DE/N4gKR38JOL1SfiI1oz0JNa
         rVYAE0fJotjzUxWaYVxY8k0txTJD3dGO8VbR9TAcUnmB5S8r1j7D+9AjdAKRrH6+KAef
         lcFk46OCnn+X26K5/c4hKywUYAjHA08wYEgeHErZ6BaNORC9/cd9ubKsm6Kx6f1Vdstv
         fnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        fh=bZ4pvf7GX/3UJviPCxZsD1Rj9zwo+a3CfMXjJZ2oXms=;
        b=TWWDlGH85026Q+ghTTID4JVzA4BA2wgxB9VxSX3evBwx1lcQQd12K2ju8vPsh83zyh
         3DFhm3FeSQUIg+KKwMQ+NE3az9O+0xHzOBGgk/UrQ+k7PIKamIccZSMDfA6D8qzLAVW8
         6md9b2DmSR/1+g+UvMzLPgDG5H3LfXlEhDG9T3CrD1+DCmHoLNuezm2JtDNGxYTsYWqL
         PeKnQqQFhZ4nROgsDBkZMyzXRE+5ZrgAo+edLWUkKd9SFf4EauoHQu2VeDpmw9ueP2FH
         klNuplZsCZZv1x99vLjW8kKkR9/Q0rFPn2K02LmbGDd+r+kOFYwF2tUWS0piOUKqDUPE
         qhEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512001; x=1786116801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=WlLS7APeX/hA7NEpMaOEESuBOy9fewR9hgrNZhDweuEfsAh/zoyTHKGTJF9U9J5tq/
         s847tazcBtQqqpEIPCZXBYyQ3TC7humVlzydKPbO8qx9opWFdjz7TCnoMEGa4QIO2Wi+
         Ahj5xFgBiGOukwhXTPUjJYDHwXCGm1hXlbLknTbkVQvxbQqL2OkPbu3WWjJxOCfQoua4
         v0rgXyVwMwKBUiPTrtFyuoJ3JH1JQYPFRfSarLn5gtHHWLOZnhRsC/r1ro+0psVHAY3z
         /saiuR+VjYl9I0MSElkym7L/BAmicvjWjbB3CcOZUS1cwve44tpIhC2lftzsyegxt5Ww
         Z7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512001; x=1786116801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=d8NN9AD/3b9TuLwVT+DlbIMLPIk32LSFicqtaSzNWbGqxcuxFmjfjq9SdLQKyjX9Zk
         AvmeFjplmKB0wiPlHTKVXoBQNjvf5XhRA1TkUMZrJIdXG3ABTbJ3UPSs/kEWj28apOYy
         HQbdsX64TEwRCysurGsK60ujVwrx3I/J00GSGGCK3rojAx+XGaYCF6JDlDRIp/GR9vhF
         Y1VacnwHNQ8ba5EAfFnbArzYcUDO3lkYVzlmF3HU1QYDOm0oYgzwLhiH5wh0oyN7dhG2
         twc6oz6yKSUWHGEIJp9Tp4guNZYqEhEf/UW5poKRi4dbzrig9mo2QbK5s31zZ+/g1nZj
         CKKg==
X-Forwarded-Encrypted: i=1; AHgh+RqCn4seXyfTML9fCvFxu2262bweESSzAj+ZlP3R7+5lzQ8q+CzntUtWjoJpxA0LIbG7ueeNJ/6+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWA83zrZ/zZ2Hf4C6F6s3BBErJyAFHVPDPUs4cVrIqdbzOU0I3
	4PrIsLroy36dcotof2MGdDGsF6AeBzEUHXAJvf5bWc8hU5bX8iN1J8UBkihDeeXi7Owl8Wb9iID
	eFAlTizNSOJ/h0SSTFwNagpfUdtifzvAQgrUQL6Xj
X-Gm-Gg: AR+sD11y757JzGu/i5NTwVI4mjXJuMbuuebZAYBuokhSm43vX1ItU07n/vQRtAwsIzC
	B6bf20wLnvdWBdxxB7fJHDA2AKbjcv5U94p47Hxv1NlP6zbVlqgIXGeoxq20+5Xakao4ZpDOBsY
	dd84pH9dw2t2rDo+4uRDmCUHUyLVy2R1SGwMn1STXO9xpKHiu0ZAjFY7mGfQwL1j4zjZd9JGGMI
	bbikdDtKBYKjvcmRAnZL2bOg3YwdqgaXjPBctVZJPi6l186+pssKJ+uw6c6aaHaTmkOfeFu4ESI
	7RIvy/Ksg+0P428W4bqkTCChDcsfySNkKzm/mlKlPPDr
X-Received: by 2002:a17:90a:dfd0:b0:387:e0db:bc24 with SMTP id
 98e67ed59e1d1-38fbc5225dbmr287131a91.36.1785512001460; Fri, 31 Jul 2026
 08:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com> <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:33:09 -0400
X-Gm-Features: AUfX_myWZz1m6PowWXy7WcdAAbaku2QnixOSUt9yTgIUfLpwiNvXahY7xKnDbwo
Message-ID: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> >
> > Okay, it looks like there was some confusion/misunderstanding.
> >
> > My understanding of Kumar's comments was that he was referring to the
> > exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> > not necessarily the new kfunc you are proposing in this patchset.
> > Kumar is welcome to correct either one or both of us, if we read that
> > wrong :)
> >
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>
> > However, regardless of Kumar's intent, speaking as the LSM maintainer,
> > my stance on this is that the kfunc you are proposing must live in
> > security/bpf_lsm_kfuncs.c to be acceptable.
> >
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?

Nope.  That patchset has its own issues, one of which is the location
of the kfuncs outside of security/; I simply haven't had the time to
review that in full and reply.

--=20
paul-moore.com
