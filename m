Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B7443AB6
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513270; cv=pass; b=gR5zxdHeJmHWWtEZXL30cLHvlq8kUHgl3WLl9tmH7iddBKrGWpiBY57pf0ipI4d5mdD2fxtM5fOVwz76fSTr5qOya31Z6hv7qkD4bpyE0g/QcuC8CLIadKkwm4lDa2iOm8+L53OKs9GBNq6TwUxORgMK9IHa5Nbx5t1eBXay+xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513270; c=relaxed/simple;
	bh=0YvLxt2QWt2EwAJ7CY+bF5SKpodyZD6hTuPUT44is/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXx0RxpIxUFwLmFAlEsuwEbS3XEjlx5x17tulhkKlWQmglld3Cc8pfgsokBjrPWYOLlYkMIUopeT+8YC6Lj9LquyVg97HJy4gVIsRutpQqFja+bioP6t6O9DXgMtTdrFMO5XADh9DQFzN7PB/yHiz61eJI7cocy5wrMQmIuiPvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcA1FRha; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcA1FRha"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a427e628a9so469976b6e.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785513268; cv=none;
        d=google.com; s=arc-20260327;
        b=dvez2EQk34w39eG2LzHRrFBe7FEcWNKFADQNEti+6CjM53RSfQsYuw+TElWZzaEj//
         tx1TdhSNBTVaqTLjpjCqbSW8P8AOIhp+UNIlArRA6PoGJqTtI/6WsHCQ4CBMAbPhaNug
         FQZINnsfqx/p9Dr/V1bhmA78ukRAEmQiERoVlOvIIYuXbSfLJKJPw5VaiavWMRmwAOkD
         Qdkys+TejFgTvx13SBCVmPwSz/goW6EVfUIfMo3n8Y3lhGSWjfnE17t3GKrDBo693Fs7
         g/w46BMCxgot/lS8PXTGG8KAU+wNoOdZIPpMomaai1orYVKPI0C+pZFdSWd+GVxQh6eE
         6GWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfO7VHPXAQUV3NOKXpt4wHtOlytCMU8U0aJpQqSv2Wk=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=czw0ukm8XqSb5zkRzS19qm5wkIy6BL7Uv3mKjYgwiCBtvtWJW0xAMj1UpJG0FBQ94n
         OJ48l521bxkTvNgwPs1R1BPy3p/rVzu4E+XxU2hddLwOcw4JklAUtVwOIzdCVtdI/etA
         MA1VumgKS6xi8E2LrHh1ANV2hpxGb2MgvoM5vVlyRmMv25JBA6f6kCogVTvJEAmSuoVH
         GQGmDhjM7k+HsnoQz2Ap5jXuSE609YTmO+z0KMfSUbqX7YcRk53THjas897yV4GkcACS
         dkfZnER6SpjJ6n5w2oif8e/Q9zFqHi23FBIzkkLvkmhUQFdrNFfjlaUH6CGmSJiBrWeF
         9hug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785513268; x=1786118068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TfO7VHPXAQUV3NOKXpt4wHtOlytCMU8U0aJpQqSv2Wk=;
        b=jcA1FRhaRp23KzEJBFOUdYJ3uyFIRSm61RyWl7DVJR0M0sR2O7IRh5jHhpFF3+PpSb
         nMUE3RDOFWIIUhbc2UFg8XheKHWd119K5+doWxTlHSfRWJBfJnVipo9PPPb8PVg5kklc
         p2FErpb7jtviqrR7TQ4d93ltjRfcrhi5Xet4Ra6hrgcx2s0AHroBTP9hmf3xusMNopa5
         M9UacHSU84hzWSc+OWjB/77Jq3cDL4mCKjR6s2kkQ51SRC8okMCjyYk5IU7yRkkFWIJ6
         fcSohxF/JQ0SU2qLBaUbVNEejxKyKRMKGxS2OUEEPueu8j4b3r8WFdUo8QFurIgPO3wb
         eb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513268; x=1786118068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TfO7VHPXAQUV3NOKXpt4wHtOlytCMU8U0aJpQqSv2Wk=;
        b=CpsBVIJ7pFLgfKnHo9/nf1V+Vc10/22ctewhcRiZ0zEtnfmk2xjQXfK3LHjkpSWd7V
         0CqVn8s0cfx83qaWj1unpzRG2iLTQNDNb302yzQ9GNvS+R5+zZL7vzWa7UrbG+eWs8DN
         goXcK4Ju1koAuGJ4pfBLK/SkTdeiHarBKMpGgxF3MTyycUQI0BXXFW+kX/uhlI0QrRmA
         qgmOR19T5kGNw4nphhwwGXZvH1iZbfXoJbMRTjUDU/8EwKh+Tfeps4dYMpO4TvcSB1j9
         IOfFt2ejIsmHnTQ0rjAJidFUTl7bBrBEsLr8S9kHe8k9kr/emFm0fbnfD7NuUcwYAYMS
         GP1A==
X-Gm-Message-State: AOJu0YwzNXCN+PKt67iDxKmEYvb5kCNQ6RoFqV2tsRSaZT988UstRcRa
	ghSzytYq6GkEUtYpbJjp7Dz/ocCFWXVg8LEYTez8Z7XGJYKWvH+RsjQ8MuOkJ/Xd7tA+UqtgAzA
	66cAeqGmg5KTTtS3zjdSy53VqwE4WZuc=
X-Gm-Gg: AR+sD11chr5S4jxyXNwpuBDuHb2xHIYty6FKHieq3HDZRWGfDIBuq439no86thTGGMr
	maE3UEgJiDtzPDoO0YHTVsLKkggCt8qJM9Hg1c2rWbGOfX08vH9UbJTZNL8t5l0LG4Cnza99GI4
	3NqcpBqxss7sTZO/6OKTGNR+nC9lfCu6Her7WEwdYSsI8l9j917YKgOn6JBUVKJahS/GQQbA0Rn
	rzTAzST1RxYGKWVwAfW+3XXLA7sj8njTbfIWWFEl/5Hqzs83u19bqAhbnCK26rrebsC7zCP+CKF
	eFP/USk3Pr58pmaiTqZSsU9/aNcz1KacPEcHpa8jgIgJ
X-Received: by 2002:a05:6808:15a9:b0:4ae:f5be:fe29 with SMTP id
 5614622812f47-4af5e0519c0mr923956b6e.5.1785513267626; Fri, 31 Jul 2026
 08:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731152609.47168-1-jwcart2@gmail.com>
In-Reply-To: <20260731152609.47168-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 11:54:16 -0400
X-Gm-Features: AUfX_mxgTjZJEdnYnfSD2sFJtQ2ZXPZLVXfPmMJyuMVZA4DxKswiEBQ_KMD_-zI
Message-ID: <CAEjxPJ4kRvrt77OLNRh9fcR=U3MQx1tpUr5sT695C3_heqpo+g@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/fuzz: Exercise module to CIL code when fuzzing
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:26=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> When fuzzing a kernel policy both sepol_kernel_policydb_to_conf()
> and sepol_kernel_policydb_to_cil() are called to test those parts
> of the code base. Call sepol_module_policydb_to_cil() for base and
> module policies to test that part of the code base.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: Add include for module_to_cil.h
>     Move the whole if statement for POLICY_BASE into the else block with
>       the sepol_module_policydb_to_cil() call to make it clearer what is
>       being done for kernel, base, and module policies.
>
>  libsepol/fuzz/binpolicy-fuzzer.c | 39 ++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-f=
uzzer.c
> index c0d96d8f..017f996e 100644
> --- a/libsepol/fuzz/binpolicy-fuzzer.c
> +++ b/libsepol/fuzz/binpolicy-fuzzer.c
> @@ -1,6 +1,7 @@
>  #include <sepol/debug.h>
>  #include <sepol/kernel_to_cil.h>
>  #include <sepol/kernel_to_conf.h>
> +#include <sepol/module_to_cil.h>
>  #include <sepol/policydb/expand.h>
>  #include <sepol/policydb/hierarchy.h>
>  #include <sepol/policydb/link.h>
> @@ -72,30 +73,34 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>
>                 if (sepol_kernel_policydb_to_cil(devnull, &policydb))
>                         abort();
> +       } else {
> +               if (sepol_module_policydb_to_cil(devnull, &policydb, 0))
> +                       abort();
>
> -       } else if (policydb.policy_type =3D=3D POLICY_BASE) {
> -               if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
> -                       goto exit;
> +               if (policydb.policy_type =3D=3D POLICY_BASE) {
> +                       if (link_modules(NULL, &policydb, NULL, 0, VERBOS=
E))
> +                               goto exit;
>
> -               if (policydb_init(&out))
> -                       goto exit;
> +                       if (policydb_init(&out))
> +                               goto exit;
>
> -               if (expand_module(NULL, &policydb, &out, VERBOSE,
> -                                 /*check_assertions=3D*/0))
> -                       goto exit;
> +                       if (expand_module(NULL, &policydb, &out, VERBOSE,
> +                                         /*check_assertions=3D*/0))
> +                               goto exit;
>
> -               (void)check_assertions(NULL, &out,
> -                                      out.global->branch_list->avrules);
> -               (void)hierarchy_check_constraints(NULL, &out);
> +                       (void)check_assertions(
> +                               NULL, &out, out.global->branch_list->avru=
les);
> +                       (void)hierarchy_check_constraints(NULL, &out);
>
> -               if (write_binary_policy(&out, devnull))
> -                       abort();
> +                       if (write_binary_policy(&out, devnull))
> +                               abort();
>
> -               if (sepol_kernel_policydb_to_conf(devnull, &out))
> -                       abort();
> +                       if (sepol_kernel_policydb_to_conf(devnull, &out))
> +                               abort();
>
> -               if (sepol_kernel_policydb_to_cil(devnull, &out))
> -                       abort();
> +                       if (sepol_kernel_policydb_to_cil(devnull, &out))
> +                               abort();
> +               }
>         }
>
>  exit:
> --
> 2.55.0
>
