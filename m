Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701E281523;
	Wed, 14 May 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243620; cv=none; b=VuMVfpefK81J4GTkft03Z2vADtEPtxFwrONvKHc1u0mNWLdpyK3dDzq7hBkHABwmL9cUWnkAnNjutJAd6+KmWAS/U5SmX3gc/fZZz0FtjsEUVS4KPWn1dBp8wvqS5Mo5Nnor3JbGE7fHx7VjmuHcZxXjlrp1UAOwUPCv7pMzKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243620; c=relaxed/simple;
	bh=SBGs5aqQoIcQv5AeecthKWkmcdpO1DvubmLNvinLeW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swLsQgAtFIq5H0hHvAeUzT5rpBXRbX54GuuEyVWEiT0eeiX9e6ITMxyqS9D7jI7BfP7q1IgLm2ckZddnu3vzVN0QAk8NacwCbWG4Rii5sxR08QIR2wsTVz7JLGep3ZbKRHmhOdU1lVuqBNPW9iYCdlLgV+2aK/dZBHrkx6eWQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HykYjfUf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HykYjfUf"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so968477a12.1;
        Wed, 14 May 2025 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747243618; x=1747848418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXdOsv+JeFC3tkk7zMl5ORas2oCATlnIgxCr0ZeJyEE=;
        b=HykYjfUf2Cp/RQp0ZjVsxo99pdceKL2cOCnGX3Ny1vihFliZXD5G0AFxvo30JetphN
         tgF7wqCSjBPT4wX9fsVMuYwI650KfDiGwBd0EU/YlNzST4BHBl5Rje7qKCzw3Ds2fFnm
         QQBF6XgL85uYhDAA3gwKyG8wLMCA1h9xcbHgxhAgyvi9ltNzcLLLRBBOQMRrJsvrDtCo
         6JR9dqh4NtB7aZxLPB0qJzoFNklD9zHpAfviB0SkvNk5/QscR6dig/K8QXNDTsXMIAwt
         1zluGfQGEqd66ueXvEOwn+8XGWRmuZpXvvhsgm9sqBLbM6XgPQ4mgQCpjT62FkpXgS1D
         Fe3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747243618; x=1747848418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXdOsv+JeFC3tkk7zMl5ORas2oCATlnIgxCr0ZeJyEE=;
        b=sf+2tDMZW8ef2og+b1D8z5YiEZoNvgAspv3jsPq+BsdyR3Fe4HfkmmvV38krjMS2Zg
         UTFWqE0HM1cgt/OrdcFBGKl2bsjGdh3HP9qsuCkn5RoYkYp0h0aGDkiYRrOKjdO1XzZ/
         Sco9fiUn2MOxTYgVuTKGLUBR7+/024aouE9fQstqjjPnQstMxi3pQz2assV8p89CV87z
         MVMZXXVMKvIJd8zrxckLTUH7cuNV+znTTdaakGvI7FtdePRiEmvNCeWdXlo2Vl3DjuG/
         TI0e5oP+uaGu19m6nIpz/FQ4edxdjm9Kxsav4vmciyZ+b9C1ZF7wViqVvY7rdiWB489e
         3kEw==
X-Forwarded-Encrypted: i=1; AJvYcCVPYVP+WOqnKYNpvfOKE41gRFWQC11DMmdiCrq4VQufysm7m/hkQnf4fQrzc4OO9Mq4T1/HjEoDQBI/xe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35jdmTlpoLdjk2CnqNymsMoBK9E6wQ8RDlGpzgfUcTYf4gtGc
	z60KcRiViRNFctjAIGcb1Dkx0Z6PwZw2Fj4xr2WRNV8E0fIc9j9Sn0p46XWvl1NeWrQA7uHOL0T
	2r8y64odR6e/QuhwwIGZsOM5ThnVQ6Sk=
X-Gm-Gg: ASbGncvakmJ7xgK/HP3rT+vMmRRg2LwkyM2+H+Ed9+Aa3oMgp5rdp4SJuKWi+lQzkOm
	Iy5vPIoFTpQIHtBRgseSM+YmS8uvbuavJHK9sjI16xbLH3cFoIdpbxpyLVeoSu8ogwtpmTV1+5+
	E0fsJwEW8WfWn5wvO/bW+d/oJ3EGEfWUamulAHfqaJDyE=
X-Google-Smtp-Source: AGHT+IFBy1t3y/D8r6XUD2ltmRelt7Erb5zhTlAiA8TI+jtnn9BARZ2+d48pBK55rte/NOInQhsH0wezn1MmJVXYO+I=
X-Received: by 2002:a17:90b:28cb:b0:2fa:21d3:4332 with SMTP id
 98e67ed59e1d1-30e4dbb70bdmr512142a91.12.1747243618274; Wed, 14 May 2025
 10:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-4-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 13:26:47 -0400
X-Gm-Features: AX0GCFuwxadOlRGUvjRAX7B36T6U0iifdXWaImJjhCLRgjXNqLwPrekZSaMa-GY
Message-ID: <CAEjxPJ6uxn+nmYruOJvrAHMNQYQhx1tVZ1eG5_YC2CAqEiQisg@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] selinux: check length fields in policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Eric Suen <ericsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In multiple places the binary policy announces how many items of some
> kind are to be expected next.  Before reading them the kernel already
> allocates enough memory for that announced size.  Validate that the
> remaining input size can actually fit the announced items, to avoid OOM
> issues on malformed binary policies.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3:
>   - fix error branch by returning directly instead of jumping to goto
>     label, see
>       https://lore.kernel.org/all/202412241405.LK8YTZqp-lkp@intel.com/
>   - rename to size_check()
>   - add comments for magic values
> ---
>  security/selinux/ss/avtab.c       |  5 +++++
>  security/selinux/ss/conditional.c | 17 ++++++++++++++++
>  security/selinux/ss/policydb.c    | 32 +++++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.h    | 13 +++++++++++++
>  4 files changed, 67 insertions(+)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 33556922f15e..50df8b69de2b 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -548,6 +548,11 @@ int avtab_read(struct avtab *a, struct policy_file *=
fp, struct policydb *pol)
>                 goto bad;
>         }
>
> +       /* avtab_read_item() reads at least 96 bytes for any valid entry =
*/
> +       rc =3D size_check(3 * sizeof(u32), nel, fp);
> +       if (rc)
> +               goto bad;
> +
>         rc =3D avtab_alloc(a, nel);
>         if (rc)
>                 goto bad;
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/cond=
itional.c
> index db30462ed6a3..92ed4f23a217 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -12,6 +12,7 @@
>
>  #include "security.h"
>  #include "conditional.h"
> +#include "policydb.h"
>  #include "services.h"
>
>  /*
> @@ -329,6 +330,11 @@ static int cond_read_av_list(struct policydb *p, str=
uct policy_file *fp,
>         if (len =3D=3D 0)
>                 return 0;
>
> +       /* avtab_read_item() reads at least 96 bytes for any valid entry =
*/
> +       rc =3D size_check(3 * sizeof(u32), len, fp);
> +       if (rc)
> +               return rc;
> +
>         list->nodes =3D kcalloc(len, sizeof(*list->nodes), GFP_KERNEL);
>         if (!list->nodes)
>                 return -ENOMEM;
> @@ -379,6 +385,12 @@ static int cond_read_node(struct policydb *p, struct=
 cond_node *node, struct pol
>
>         /* expr */
>         len =3D le32_to_cpu(buf[1]);
> +
> +       /* we will read 64 bytes per node */
> +       rc =3D size_check(2 * sizeof(u32), len, fp);
> +       if (rc)
> +               return rc;
> +
>         node->expr.nodes =3D kcalloc(len, sizeof(*node->expr.nodes), GFP_=
KERNEL);
>         if (!node->expr.nodes)
>                 return -ENOMEM;
> @@ -417,6 +429,11 @@ int cond_read_list(struct policydb *p, struct policy=
_file *fp)
>
>         len =3D le32_to_cpu(buf[0]);
>
> +       /* cond_read_node() reads at least 128 bytes for any valid node *=
/
> +       rc =3D size_check(4 * sizeof(u32), len, fp);
> +       if (rc)
> +               return rc;
> +
>         p->cond_list =3D kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
>         if (!p->cond_list)
>                 return -ENOMEM;
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 3e4a28a2928b..46c010afd44f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1100,6 +1100,9 @@ int str_read(char **strp, gfp_t flags, struct polic=
y_file *fp, u32 len)
>         if ((len =3D=3D 0) || (len =3D=3D (u32)-1))
>                 return -EINVAL;
>
> +       if (size_check(sizeof(char), len, fp))
> +               return -EINVAL;
> +
>         str =3D kmalloc(len + 1, flags | __GFP_NOWARN);
>         if (!str)
>                 return -ENOMEM;
> @@ -1174,6 +1177,11 @@ static int common_read(struct policydb *p, struct =
symtab *s, struct policy_file
>         if (nel > SEL_VEC_MAX)
>                 goto bad;
>
> +       /* perm_read() reads at least 64 bytes for any valid permission *=
/
> +       rc =3D size_check(2 * sizeof(u32), nel, fp);
> +       if (rc)
> +               goto bad;
> +
>         rc =3D symtab_init(&comdatum->permissions, nel);
>         if (rc)
>                 goto bad;
> @@ -1348,6 +1356,11 @@ static int class_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *
>                 goto bad;
>         cladatum->value =3D val;
>
> +       /* perm_read() reads at least 64 bytes for any valid permission *=
/
> +       rc =3D size_check(2 * sizeof(u32), nel, fp);
> +       if (rc)
> +               goto bad;
> +
>         rc =3D symtab_init(&cladatum->permissions, nel);
>         if (rc)
>                 goto bad;
> @@ -1921,6 +1934,13 @@ static int range_read(struct policydb *p, struct p=
olicy_file *fp)
>
>         nel =3D le32_to_cpu(buf[0]);
>
> +       /* we read at least 64 bytes and mls_read_range_helper() 32 bytes
> +        * for any valid range-transition
> +        */
> +       rc =3D size_check(3 * sizeof(u32), nel, fp);
> +       if (rc)
> +               return rc;
> +
>         rc =3D hashtab_init(&p->range_tr, nel);
>         if (rc)
>                 return rc;
> @@ -2689,6 +2709,13 @@ int policydb_read(struct policydb *p, struct polic=
y_file *fp)
>                 nprim =3D le32_to_cpu(buf[0]);
>                 nel =3D le32_to_cpu(buf[1]);
>
> +               /* every read_f() implementation reads at least 128 bytes
> +                * for any valid entry
> +                */
> +               rc =3D size_check(4 * sizeof(u32), nel, fp);
> +               if (rc)
> +                       goto out;
> +
>                 rc =3D symtab_init(&p->symtab[i], nel);
>                 if (rc)
>                         goto out;
> @@ -2730,6 +2757,11 @@ int policydb_read(struct policydb *p, struct polic=
y_file *fp)
>                 goto bad;
>         nel =3D le32_to_cpu(buf[0]);
>
> +       /* we read at least 96 bytes for any valid role-transition */
> +       rc =3D size_check(3 * sizeof(u32), nel, fp);
> +       if (rc)
> +               goto bad;
> +
>         rc =3D hashtab_init(&p->role_tr, nel);
>         if (rc)
>                 goto bad;
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index 9b3cc393a979..bb96a6cb6101 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -353,6 +353,19 @@ struct policy_data {
>         struct policy_file *fp;
>  };
>
> +static inline int size_check(size_t bytes, size_t num, const struct poli=
cy_file *fp)
> +{
> +       size_t len;
> +
> +       if (unlikely(check_mul_overflow(bytes, num, &len)))
> +               return -EINVAL;
> +
> +       if (unlikely(len > fp->len))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  static inline int next_entry(void *buf, struct policy_file *fp, size_t b=
ytes)
>  {
>         if (bytes > fp->len)
> --
> 2.49.0
>
