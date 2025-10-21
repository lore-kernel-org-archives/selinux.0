Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712311F099C
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063790; cv=none; b=u0Btf8Fq9thAk3PK/xrulrjxsxbMkb4icKDZCtcSsg6n05U0YxjHij7g/gf+PcDSGfrxllgz3RrY9CIoo/jTweUIbN5ZiphF3WGVCzY4Qlo9eLLK0v0EHNV+8qGqkkTUeYikm+gwE4W2p4DenEFXIrjaJlRB/guzsFDYDs6a8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063790; c=relaxed/simple;
	bh=ioFG2QaGQxwz5gnpyd7wKdUTHVMhLAfWcPTQKhiPDj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfvmpX2YktuJ0Qc1ayPms5sr2PjsxRcu1l2nUt1nAvpkqSe+qBGrnOKdsdq5KEJyPhQlX852sHNYgrKg0Goa64ONub5h4jaTc3idmZm2XxbmFdXsFdtmCrxYEq5Bo6ZVl1SH3O8eCb2CcncInhDs2REjYgSpASWUWKvTztkmlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PIzC92+N; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PIzC92+N"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b4739538so5444116a91.3
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761063788; x=1761668588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko+Kc8EOpLWbTMFL12IdldJO27v4hHa56bAgcQaqoNs=;
        b=PIzC92+NAcRrYYvOCcZ5zh179YtDgPKe7MKBk7CoapOyIg4BBBAzBlR/LJlFyxb0Mq
         nYW5837NRRpXxTIEPbJBngIrWSHtNcWwYBsYWunuEGNLgJfHzqdaVv9qqb+45pnLxCNi
         K26JiyGTv6humd543ucN0thQnxaZ0r1MhKH+BLqmJ9T8jFVofv3yRPprn4pYc4sBAQKw
         NcREaUPtuPZnWOibV/FM3XuFU7NSwPs2xlt1D33o0ahRZGhz8wJtmPrAGh5KTzAmeSet
         RUkEdZkCrhKSYYxr4AOckza20b52/4uJqoj5kV+AKl3a1l2vSM3wqZ1YyxChjjT5Cdpm
         4NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063788; x=1761668588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko+Kc8EOpLWbTMFL12IdldJO27v4hHa56bAgcQaqoNs=;
        b=agkvI3fcSKLrmo4nei6xQXDuUfObDXcMa5BkJjVCXagCLp4oVyLMS5he2a45gr7zcG
         X9T017fVnETFQOI+GZR1dIppGY6FmT7sEXDKmxo5AB+OJGoiqf2E+naKjI/Ow+uXy+Dj
         dEk99PkRzOHGIY40/QCVeGGWsip4+SKJ9EsxMvo1XPkbxDOyfG9KpuljOBynh+jPgZUH
         HaiUAlho9lNSJ8IoLF6y/I5B5kfcyMsy9W1H4yxNmYNy5OTRiFj337ZYMYwHLQSrtSwp
         AMPUVOcP50/4TLTmpoDzbWfBAPoB56ieoYNAtovny1HaYQfS9lx4DVDKyClP2c/SXZhx
         nokA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbJIdhWUXF5LysKNb+QfMCq2ahywaPKnb/O8Hy2NQ3PuWanSs+6F78vJfq4H9dWDLaUP1G/T+@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0Ry7HnWJ3qJXtOKmZ/l6gaPNL/s0p5SzZZ316eVkaXlSOEIg
	VRf5rHX2xCKOtPPlN5BGCp0XPUspHabuM4rkV7TZsSkbMcU0pOrkf1uAR30fHWw0izWDVt+GVZ1
	hk3OhEtoHDkPZsJ1jtVDGbFBIgbGOF0vuV9s3ZZf0
X-Gm-Gg: ASbGncsAKX8MHn8f3wOK+UmP0QGOXlMBlrNEbeTT9S6LLZamw02XQJTBLZWIhabtooM
	mfpHsLzuwUpMr+FSfZYALBpE6eLzFjEN1lvnFjnxdD4A7p02TELTdVBOrnAtDiTt2t/8LTucCGU
	X2U2LfZnCo07tAdgULc0xEBy0U5mWIBBo/t2AjzqXcz5DJJ3igt/cJDhxeltJa07wCNJyk9It9i
	yHmp/qtxe5aPdJglQFjKgX6aDXHsjDNNycBWB1UQVlFzutWlvjoiDcBdp3Jqq8JJ3HZxco=
X-Google-Smtp-Source: AGHT+IGt4Lzi4mhp1MfH5jF+IcHXWUOccQlOFd9tFKs5S9MlSna+BmR7SWJIKFfxQoQ0qSxgAqL9kA7McL4N2dVYx68=
X-Received: by 2002:a17:90b:180e:b0:32e:73fd:81a3 with SMTP id
 98e67ed59e1d1-33bcf93dfbdmr27922336a91.33.1761063787525; Tue, 21 Oct 2025
 09:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021122758.2659513-1-omosnace@redhat.com>
In-Reply-To: <20251021122758.2659513-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Oct 2025 12:22:56 -0400
X-Gm-Features: AS18NWB5lQV6vOb0FNBV3MhIGbNUH6yZO81tIZnwRE8GRrrg4_dPsp5GczFYtAw
Message-ID: <CAHC9VhTf51hZ=r=hNpeHGU3FBAC-Y3yB6FmsQq_hKq4WUihRBQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/bpf: do not audit capability check in do_jit()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	"Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:28=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The failure of this check only results in a security mitigation being
> applied, slightly affecting performance of the compiled BPF program. It
> doesn't result in a failed syscall, an thus auditing a failed LSM
> permission check for it is unwanted. For example with SELinux, it causes
> a denial to be reported for confined processes running as root, which
> tends to be flagged as a problem to be fixed in the policy. Yet
> dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
> desirable, as it would allow/silence also other checks - either going
> against the principle of least privilege or making debugging potentially
> harder.
>
> Fix it by changing it from capable() to ns_capable_noaudit(), which
> instructs the LSMs to not audit the resulting denials.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369326
> Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on e=
xit")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v1: https://lore.kernel.org/selinux/20250806143105.915748-1-omosnace@redh=
at.com/
> Changes in v2:
>  - just silence the audit records instead of switching to bpf_capable()
>
>  arch/x86/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
