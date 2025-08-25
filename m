Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DF92FABE8
	for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131727; cv=none; b=cXwGnz9Ma2IU36IqneMnPSTZ7fGmQLJjxNE0e/UiA1biLRyFUJm9wVEBemtlCC/rgNN0MsaFzaQf3KKwvBSzul74K8wrCbjwRAdLeAh7ET5aOPbb7AUvp6TCcyiZqtsv3gHGUvaN6PdT0iVAYEgqEQgQe3EOhUwD1deqlEGWKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131727; c=relaxed/simple;
	bh=gzftMivDxu2zRoECJzsqe5Ub4RQrLSoau3N2kaZTT7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7cFHLbRu+P52MjzO1wrzF6pWmMdyqTZT2TsvsIgxk1mBm/DnxwMJ+8HOB+Q5O8N+qgorT8IOZqNxeRDuCAGbg2faz0RXq8TTIP+HcSz0crgzNAkllKqFVdtaYk8OifpQypQs8P8G3Tm2eIIt2EB6noKMN1Amd5NNTFZIbh43/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIbi1D8O; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIbi1D8O"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e8005bso4673254a91.3
        for <selinux@vger.kernel.org>; Mon, 25 Aug 2025 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131716; x=1756736516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGRCQGz9TpNku0pUcMRS+IChx6aMjSM7tueVsknbVGY=;
        b=KIbi1D8Oi3oelWXKaFzHRj8/sqx+/MvGvAhdSHrN6Gvx5+2ADk1ADQ2IiAQol1+VnN
         Oug+we9uF2GxzUG3KLJmVptYgG+vCwTqStYizlYOgk6frvkuD5pE/UcezaCTq2B8a88U
         Wu34ON45SEBRCM74dKHisfBDcuXZxPIkBlkBKU41J37hQy3F4hcVrBl0uIbWZ90Dp0GO
         58y/Fe8dRi90WA5wD80TVbB/12Cy3xNJcv3X0NgNVUvM66dWflCeTLaEQ2V5VwY8+LCx
         J8Lmm1yb0YDA06a8g7YA2yrpSyUzR9ZizOX+4ZtDc6hA7VASX8rWsBNmn7nVETBbOzIL
         8dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131716; x=1756736516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGRCQGz9TpNku0pUcMRS+IChx6aMjSM7tueVsknbVGY=;
        b=I9xPMfJ5fjfMhZmQA6JD2+4UW5IgXW7XIf8jYZOVeRYH+n1sfe6B9JxivQSFr7dNnp
         6VUuWRr3MoAIfE3IYA/tJ3SNj3qg9HhwJyIb6RvyYOACjmqdwDXnquKHY7bfe5qMC+E0
         UA6zTEHIqlvbjBj2iyqtKQ0fiZgIB6mzw3H409lCXk1F0CnL/PRxjv+n2cnfHJjI38k6
         2QRgYwsi0EhrOAjmgp2ml2zrBuQOyXA+sF1B7urCxRzp7XcKPpGTXI9/4mOUheF7DsG4
         xJRNKf8G1xQiFIklJVJA4xN2znaRzHnIkN2udhDVvQH9saA74frcEcl0dh6q0qeBvE8h
         +Ufg==
X-Gm-Message-State: AOJu0Yz9s6tbnt+pAJq+D+jKNLJlbgWgxA+UJ4SDoB7p4+tshn2x16sB
	3meQhJ8EW9YENxa7BXJRhz5UpFkG4zx5dsU5Vw44ii6UUqMWduytIHULjOye6Q0OkLNhuIq+Na6
	h1uj7w0gGfg9RKnZthhtwiR/BlFJwuwk=
X-Gm-Gg: ASbGncthae3GL+Mxsz0aUHQrXnCrZ1EAz0Y7yt4FlzU90tP8SqyI9Xvp0HbcLrrXpMf
	cRvA14uPrTG87bQT62qnWOqW0sBq6/fFr7JghRNzd0h9GVFsMBIdnfx8TtYqnJJSCGbP4zKykhW
	LPxk18g0k7FKentfUfWLky/pDsuofe6WNONM0hLua7fwZkx731s0KVI7wwebs1ZVMnxa1NZGuUj
	3UEtF0=
X-Google-Smtp-Source: AGHT+IHTi8DKuXcVLwQJwdUzzJ8psHeaHx75Hgf+NPVL/moUsaHjTxNcfg3t7Nng0PR9/7K4HLUvX++gjQ8KdXh62Ts=
X-Received: by 2002:a17:90b:2f47:b0:321:87fa:e1ec with SMTP id
 98e67ed59e1d1-32515ef197cmr15274158a91.34.1756131715912; Mon, 25 Aug 2025
 07:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821190312.1361-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250821190312.1361-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 25 Aug 2025 10:21:44 -0400
X-Gm-Features: Ac12FXxLYPCVCc0hjonXK5J2tUA7nzjFpLnHv8ZA-B42dNQ75ttZRpbXdpf2khg
Message-ID: <CAEjxPJ7VKyDMbkS-+LLdJY+Rcf=hcv25iPpVd63wtiOX=+pSYg@mail.gmail.com>
Subject: Re: [PATCH testsuite v3] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 3:03=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.micro=
soft.com/
>

No need to re-spin just for this, but this also depends on the
corresponding userspace patch for libsepol.

> Four new tests are added to cover both positive and negative scenarios,
> ensuring that the SELinux policy enforcement on BPF token usage behaves
> as expected.
>   - Successful map_create and prog_load when SELinux permissions are
>     granted.
>   - Enforcement of SELinux policy restrictions when access is denied.
>
> For testing purposes, you can update the base policy by manually
> modifying your base module and tweaking /usr/share/selinux/devel as
> follows:
>   sudo semodule -c -E base
>   sudo cp base.cil base.cil.orig
>   sudo sed -i "s/map_create/map_create map_create_as/" base.cil
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
>   sudo semodule -i base.cil
>   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
>   sudo semodule -i bpf_token_perms.cil
>   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
>       /usr/share/selinux/devel/include/support/all_perms.spt.orig
>   sudo sed -i "s/map_create/map_create map_create_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
>       /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base bpf_token_perms to
> undo the two module changes and restore your all_perms.spt file from
> the saved .orig file.
>
> Changes in v2:
> - Removed allow rule for 'kernel_t' in test_bpf.te which was added due
>   to a bug in the kernel
> - Cleaned up other unnecessary rules in test_bpf.te
> - Added token_test.c which was missing from previous patch
>
> Changes in v3:
> - Added original license in 'token_test.c'
> - Updated patch description to
>     - replace 'base.sil' with 'base.cil'
>     - Remove extra quotation mark in 'sudo 'sed -i "s/"map_create'
>
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> ---
>  policy/test_bpf.te     |  39 +++
>  tests/bpf/Makefile     |   5 +-
>  tests/bpf/bpf_common.h |  10 +
>  tests/bpf/bpf_test.c   |  59 +++--
>  tests/bpf/test         |  21 +-
>  tests/bpf/token_test.c | 543 +++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 658 insertions(+), 19 deletions(-)
>  create mode 100644 tests/bpf/token_test.c

If I run the tests manually ala "sudo ./tests/bpf/test", I see the
following output during the new tests:
ok 9
unexpected userns_map_create/token_create: actual -13 <=3D expected 0 (errn=
o 13)
test_callback failed. unexpected error: -22 (errno 13)
waitpid_child failed. unexpected error: 22 (errno 2)
ok 10
unexpected userns_prog_load/token_create: actual -13 <=3D expected 0 (errno=
 13)
test_callback failed. unexpected error: -22 (errno 13)
waitpid_child failed. unexpected error: 22 (errno 2)
ok 11

Generally we try to avoid/minimize spurious output from the tests for
legitimate errors, so ideally you would eliminate this noise if these
are in fact operating as intended.
