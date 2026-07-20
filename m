Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AC13A244
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573156; cv=pass; b=t3OlDWJRTyNyioi3fV2P5n1UTfFvrWtWp36qTxhPm99zYSruaIs9+U7wGMof5hUG4XinM+s36os6NUCRyTFFjRszOwwoKzqo/5wHLHe5xdJz0GKDD7127AIjTxkxRnLOjLOlSn2uw9dwfmEjuuiX5WqdeTrckTB7qQsoFA8iNXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573156; c=relaxed/simple;
	bh=UDlya21JETN/qOfOjiVoFhJ244DWuk/XXgf1A1Axjy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jalh4JmQCsdjCNYZN48lmlnsxjjFF7UzfU5wmJ7bascD8jXfyg3Sz8pvVHXgZXjGODIdBxL/eT3cDuv+ibVfwiBI8PWo9K4wCDdPmDJu6Nvs0wNOa3fjLXqlNuZd97H0H8+xnOXIrG1ff1am+QXtwHSPa8LzRyHLsHXuWSYDTE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVFdcZ8f; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVFdcZ8f"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1085873a91.3
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784573154; cv=none;
        d=google.com; s=arc-20260327;
        b=n5Zx1PSC33A7eJLB8G6IfcKdYPTH7eJ6h28bnneZfXpoCb6ffD9C4wsXzkdfgd68m/
         ZOAI3WjLJfs2w88iaaMVulUbwcpL7QlBCPcnsn76m26EToqMk7/FzUi6OpKoAdEAV2UB
         ciZWEHzz/qJ4uk/1Kym3DW43fBpkhaMqCUHxDz26U9+XIeliDkQLlfH1N5sZDJcGLrV3
         xoTl+mfQCFCXK5NLLcAhdYrt5BLcfoFhLkvpTzd+UncEbq8CUAe+oBZyyc9JF0/6bCnA
         5tN9tKiQEvnWZLFbMrS6R7MysT+zPSFqaURu1++j3R79WfdpjwZDMtE3SjENkz4w5NWu
         aLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/WR2wyJmJ/ocOpnKySEo0jom2yHN93oI1AtANRQrgY=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=GmuoiApLqYrbawlPqt4ATv/6E1OMZuClqKfZlP4gRQz7tr+9AhVeOHMJyUdh2VtWii
         DP6jDSsMDX3MxMNtgddHMqXjt5KSpMwxieVTNiSawrfqyzLsuqx6gVTsf00nXDpFUTVC
         w6mm9f1VH7Po1yhDkI/CIgoDkYoTvtLygv8tXh6ks6UX92L6vLoE9TQ5kyuD+Wj6AQFi
         SGU0rvbBVBKfzpX8kw7q15DdCPxolzr1mYJxKQ+c5nIL+sY2PyEGVpQQmfC088B11XcA
         FAWwJ/CTOLETSrXim/p+EyMt5ppc0yG0BqvRatQy+WrAppwB21PRlWdjLz650OWuT54K
         s7uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573154; x=1785177954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/WR2wyJmJ/ocOpnKySEo0jom2yHN93oI1AtANRQrgY=;
        b=NVFdcZ8fO2kVmfj7S0sn6zHDrBbT8DCjHkcfD9JdNlBmwVaMiSoAcgfIHjWCNbpl2A
         pFMfYGvjD+jX/RBCVP78NbOLXXcfa1arcTLDesnhTrs1hMQe7AwdfaaThpgQUeve0NV4
         IV1tCYvG+UmrKlHac8zN0KKQxTs0inEcKrEBkUtaXOArsclizU8oeFCprOCZD3hXI/AR
         VPc0JkNLflOhe8sks113wyd/oRR/DMQaclhfxzulbvUeLaUhXhNejyO6DObzFQUfz7hV
         bCaCaNGObsVPH42fGLH5IbP9P3mMCige3lxf+oeaRrQeeG75xVA8X+zkjgxMpJ4rpTyK
         Y6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573154; x=1785177954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/WR2wyJmJ/ocOpnKySEo0jom2yHN93oI1AtANRQrgY=;
        b=IMiRKPdeKOM0l9iv75TdGzPpqDvkIOyYuxtpOTI3WIPkEnZf3FKKOxSl+t0n/RPcRS
         Idx9CwI+ncGvZw3WyVPEk3qgQ3LOc2JV7U78yFfwN9PhmWErOoHOrH/4vY4lcFNCGSNJ
         7ddSHOLudIQbZ6fNcK7NhOFBVllxJoSrp/FNPkr3L4IPZUzCH1ZXt+5AeMlP7IBeeoLc
         RXrXLQW7z/rgkRjylOQTLyYEDLONEyZA9R0AsDUDHbc1Z0XKOjoUv2CFdDA1x2L08yv/
         GJ20CdSGWZjzdY60cLg0SKKruFC7BlJLDvX7Y1k71oPtYPO7TcFyZcZ87DvU0D1ByU6v
         R2Yg==
X-Gm-Message-State: AOJu0YwFx8sirYnI43wzN45JMrmHedDNWvgZvBsiT2bdCMcb7rj77Tls
	IPxF9ZiQi6PF8q4ucRaH3Iz/Ixl2BWaF7adtgp4j5xTQaXJvb7juX5GpZs/9gR3jNSn9171jAdB
	VtTnXvu9+HrOJ6dQKYpibJ3Y6XheSW6c=
X-Gm-Gg: AR+sD13ciuDIG/NKYpQt4H8ezNJXsw08CXxlL4yCFCSx5gpEqODUFRPj+TtLT3SYRQ2
	FnHsh2Q+m3ocvpq1xvNq1M0ofvCEgk9MLIA+EQnuZNn6xdnz7S95Dd9NDOFUrmFoYaQeVWFWvy2
	dLINbHAZTFcnadNJZjWhUuHayR5+5PtiMm+6+jE4C7cgOSrcVT8ZJf5IYtYQt0ZvGpQ/DfYjTrN
	3fsUCONrgLVp3NyAlAVWQeOLfmgO5zBaW3jw+6xBUay6LtNnLMiIBxOyJ3ZMA==
X-Received: by 2002:a17:90a:d60f:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38e4b51656bmr15445712a91.28.1784573154105; Mon, 20 Jul 2026
 11:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720105606.305073-1-pmatyas@redhat.com>
In-Reply-To: <20260720105606.305073-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Jul 2026 14:45:41 -0400
X-Gm-Features: AUfX_mzeCyB8EF-iFhfKncvF18bCA-a8ouMqVBJslIe4wDZF2boL1GOzzGQrjqo
Message-ID: <CAEjxPJ4V8bSqrBLhuakU-0X+Byvz4=OP_Ya39ggqyVEJ7JQn1g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add module package fuzzer
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 7:07=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> =
wrote:
>
> Add a libFuzzer target for the binary module package format
> (.mod/.pp) read by sepol_module_package_read(). On a valid package,
> also exercises sepol_module_package_to_cil() to cover the CIL
> conversion path for module policies.
>
> The seed corpus contains a minimal module package produced by
> checkmodule + semodule_package to give the fuzzer a structurally
> correct starting point.
>
> Wire the new fuzzer into scripts/oss-fuzz.sh alongside the existing
> libsepol and checkpolicy fuzzers.
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>
> ---
>  libsepol/fuzz/min_mod.pp              | Bin 0 -> 859 bytes
>  libsepol/fuzz/module-package-fuzzer.c |  44 ++++++++++++++++++++++++++
>  scripts/oss-fuzz.sh                   |  11 +++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 libsepol/fuzz/min_mod.pp
>  create mode 100644 libsepol/fuzz/module-package-fuzzer.c

> diff --git a/libsepol/fuzz/module-package-fuzzer.c b/libsepol/fuzz/module=
-package-fuzzer.c
> new file mode 100644
> index 00000000..18d645bb
> --- /dev/null
> +++ b/libsepol/fuzz/module-package-fuzzer.c
> @@ -0,0 +1,44 @@
> +#include <sepol/debug.h>
> +#include <sepol/module.h>
> +#include <sepol/module_to_cil.h>
> +
> +extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +// set to 1 to enable more verbose libsepol logging
> +#define VERBOSE 0
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +       sepol_module_package_t *mod =3D NULL;
> +       struct sepol_policy_file *spf =3D NULL;
> +       FILE *devnull =3D NULL;
> +
> +       sepol_debug(VERBOSE);
> +
> +       if (sepol_policy_file_create(&spf))
> +               goto exit;
> +
> +       sepol_policy_file_set_mem(spf, (char *)data, size);
> +
> +       if (sepol_module_package_create(&mod))
> +               goto exit;
> +
> +       if (sepol_module_package_read(mod, spf, VERBOSE))
> +               goto exit;
> +
> +       devnull =3D fopen("/dev/null", "we");
> +       if (!devnull)
> +               goto exit;
> +
> +       if (sepol_module_package_to_cil(devnull, mod))
> +               abort();

Do we want it to abort if there was garbage in the .fc file or other
*_contexts files?
sepol_module_package_read() only parses the binary module and extracts the =
raw
contents of the contexts files but doesn't try to parse them, so the
error won't show up
until we try to convert to CIL.

> +
> +exit:
> +       if (devnull)
> +               fclose(devnull);
> +       sepol_module_package_free(mod);
> +       sepol_policy_file_free(spf);
> +
> +       /* Non-zero return values are reserved for future use. */
> +       return 0;
> +}
