Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDD10942
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962895; cv=none; b=MSYcR6AAH5twnoX6wtdzyKlIIViZwgMUpEMk3PWCUJMnuzJtlYp5jLCKr69eBINQT+6ChnjTGyiOBnRqYkFFOu+TKlwydC0q8xQYggY8ULjdybH4nVUJqwJnzRZhAaOcruTRfcqeEY9RxzraxCiCO1giGcvgYMlndRsVLYzmu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962895; c=relaxed/simple;
	bh=sBfmo7jT/1cBIFGI5idUe8hVF4sNQfYgg2egbQGoD68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8SkmihqUthHzd2JTkF1yiiD5IXIR0xxxIVL6MwMsDvjkXPeKnCtYSWcBFJiBMFOk1OxAuxV4zN2+aOptGS+WySpY6pND9yfNmgZSvC6HAtD1OVELjcWwkLtO/iEb4EnOABRbCZObLgxfo4VtQgdu3VPIPlXUJdf0VyULiLemKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAIM+2Kc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAIM+2Kc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-25caef29325so40035745ad.2
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757962893; x=1758567693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucl5o7ikC+8lk5UMDvpT5Nzb0XMrSncdOybcx0c7ZkQ=;
        b=dAIM+2Kc6mEcWdslgudpDGW3MH91N8dM7Qe0hBJeKN75rkLQ74v/XAIUSly1S8lE0Z
         vyJxLAu8PObujc5M6jYprBhQ08PSLJuS/pU4O3FlF0bTM2pTGaMc5B/2zl+B5ndGqaI5
         owx7b8jPjKcY9X4DegClbtjENQTGEKk1OK3HWKBo+BN/dL+cb7lEwPEOckh/JApggqCe
         Y91CV4ibmWcLIJych6taAjPF339FejIOEKrkcxyCH2TQNIFdk+WgpYkUd5rfjFbZuI/i
         pQNxB0ivyMgMA+Pgu0ydYr3wNq1D5DbomLDhXOT7TdcrZ4WxtSbM3irGAGJDd7P611UX
         0lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962893; x=1758567693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucl5o7ikC+8lk5UMDvpT5Nzb0XMrSncdOybcx0c7ZkQ=;
        b=cps5P6sbIFyDNeN7A9c0h9ek2cZD32fF5jIF23RoLk61ECujeKeTqLwDIO4FtVgPmt
         i0hsZyMFAC0yxgUfdp96MHaAI0RJ7nrn2GN+gefnUAGKgofCKKHkr3kbQHnR5mXRowWY
         X8zDT61mvVNocAKUTHHqsTa/7NDTVbT88C9VXhTXEV6eoD0i4F9+GF0/MuBD9VXHLw6z
         8UCfxg6GfrhX2e+4xn6ZBHPbuuIqe+mYA1CbaCPcGPrvYOMDr807YglVkFspSNZ/D934
         0hX8MU1GRDX3zfYwc3u/A7QPThVxpPN42n4erBnC1s0GyV0fgcnyKVzwhRvREI8qxh85
         crAA==
X-Gm-Message-State: AOJu0YzGRd9a+D7PHNlrbdABp0pbSd9RB1MZUhjjJQ4xphiyw9iO/cz2
	ixpXgQAqoJdTlOkWqmGf3YVpxh6HhnDmvdah1KGlEHgbvQFdj6NAHOqJk4FuP6B+sDdNBqX+f2v
	dslYFm/sfv4wZi1cL4v5ByTTyMK+a0Y9dOw==
X-Gm-Gg: ASbGnctx289zsHuFi01lvmhspAlQmb2qrWq/EZB8qBzROcYsVnbqmJ68ArebTO415Rd
	WSEBohjWiv4lhqbp8hmQ9VX6sUFJX+0kSvzcopN/Oz/US8yUNDDVvgDL0+KJNEgE3HoBdi8g1Rs
	TBhdzcJP0P+zMnOxW5FzNWVYD4ctDEnJPakWHEqWATnoVXvzV7agDblP+hV8uTAy85Z4UN9bhoc
	NBqVTs=
X-Google-Smtp-Source: AGHT+IH5O5JULar+2sNXF8Dqe2Xowy0FUXWCPoVn4ipMHeGZ+uW2EWtyAUtl0ByuOo4AuUXEVIYlc0dAoyHWIyEVvu4=
X-Received: by 2002:a17:902:cecf:b0:246:cf6a:f00f with SMTP id
 d9443c01a7336-25d2647015dmr184403415ad.31.1757962893095; Mon, 15 Sep 2025
 12:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915175456.1991-1-ericsu@linux.microsoft.com>
In-Reply-To: <20250915175456.1991-1-ericsu@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Sep 2025 15:01:21 -0400
X-Gm-Features: Ac12FXwnNbl8UzJxPhjuoGvj7mKpdpcQYJ8SI7aYHU7zDxDCHkTahRNoVD2Ov18
Message-ID: <CAEjxPJ5OgpfxiMrCVEn52P_-QPPAOn4rW2GA9XTP3JwP8UHArg@mail.gmail.com>
Subject: Re: [PATCH testsuite v6] tests/bpf: Add tests for SELinux BPF token
 access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:55=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> This patch adds new tests to verify the SELinux support for BPF token
> access control, as introduced in the corresponding kernel patch:
>   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.micro=
soft.com/
>
> Note that new tests require changes in libsepol which is covered in
>   https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.micro=
soft.com/
>
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
>   sudo sed -i.orig "s/map_create/map_create map_create_as/" base.cil
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
> Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>
> Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>

You aren't supposed to keep Acked-by, Tested-by, or Reviewed-by lines
from others if you make any changes to the patch itself since they
haven't necessarily reviewed or tested the updated version of the
patch. That said, would recommend waiting and seeing if Daniel
re-affirms his tags for you rather than re-submitting without them.

Also, one nitpick below but no need to re-submit just for it.
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> ---
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
> Changes in v4:
> - Updated 'token_test.c' to write error messages only when DEBUG
>   is defined
>
> Changes in v5:
> - Created test_bpf_token.te which gets loaded when required bpf
>   permissions (i.e. map_create_as, prog_load_as) are available, and
>   policy capability (i.e. bpf_token_perms) is defined
> - Added condition in tests/bpf/test to run new tests when policy
>   capability bpf_token_perms is defined
>
> Changes in v6:
> - Updated commit description per review feedback
> - Update comment in policy/Makefile
> - Fixed missing new line in tests/bpf/Makefile
>
>  policy/Makefile          |   7 +
>  policy/test_bpf_token.te |  42 +++
>  tests/bpf/Makefile       |   6 +-
>  tests/bpf/bpf_common.h   |  10 +
>  tests/bpf/bpf_test.c     |  59 +++--
>  tests/bpf/test           |  35 +++
>  tests/bpf/token_test.c   | 559 +++++++++++++++++++++++++++++++++++++++
>  7 files changed, 700 insertions(+), 18 deletions(-)
>  create mode 100644 policy/test_bpf_token.te
>  create mode 100644 tests/bpf/token_test.c
>

> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> index 1ae8ce9..aff51f4 100644
> --- a/tests/bpf/Makefile
> +++ b/tests/bpf/Makefile
> @@ -1,5 +1,5 @@
>  TARGETS =3D bpf_test
> -DEPS =3D bpf_common.c bpf_common.h
> +SRCS =3D bpf_test.c bpf_common.c token_test.c
>  LDLIBS +=3D -lselinux -lbpf
>
>  # export so that BPF_ENABLED entries get built correctly on local build
> @@ -14,4 +14,6 @@ clean:
>         rm -f $(TARGETS) test_sock flag *_flag
>         @set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
>
> -$(TARGETS): $(DEPS)
> +$(TARGETS): $(SRCS)
> +       $(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
> +

When you added a terminating newline for the Makefile, you also added
an extra empty line above, which is generally frowned upon. But as I
said above, no need to re-spin just for this.
