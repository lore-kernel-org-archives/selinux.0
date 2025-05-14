Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577271F76A8;
	Wed, 14 May 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246561; cv=none; b=XGXaGWgE/FgtBpH6sFFxv1dh25NQhlod3h6THT4B/qpYaDX5yRGtMqiS1UpBDyuIs8hczC1CllP40urEPze5BlRyKVPZgcHtCQEJAVwMdOkKuOdNMTOpFfWAEj4/bQhtKvGu8QFCuXChOEW4Cg53CgbVWuDZ9y2EUnneGZojL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246561; c=relaxed/simple;
	bh=S7s8gyB+LxdrzjPZwmAEQBK/PjRLNUJW31jjKnw/QVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag+uqKnOwsXTdMltA5g9LLdOE/LFrx+GUPeG+W840OQ5X0GHmp8IHpAaqafPHP2hZz6Zu5ou+00Fewu6SJFImHGLj3CHwM/kiK9EbjChYTp0VbKSA7hF7Bp3iGDWrma5/tFLJbBdD45C6HtBSu5EHVXwzX74IALyodnrpB+8zf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFH7TiAh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFH7TiAh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30c47918d84so166637a91.3;
        Wed, 14 May 2025 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747246558; x=1747851358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks2e3ghqHLXQQkdmaQokVVmeEBA0ZdlTacN0FP7jAkc=;
        b=lFH7TiAh7XYVd94Em2s3jeqXA43a/ch3p8KYYqB/P6CUhQRQ+1Y6xfUP/wBIg4RVuJ
         GhTBM1cWXZKO820UWmlzmtR9Dz1pOLw3yKsxD60m8duPzRC82CL6YbhpnCcJUNjeskg0
         bbC6KQo5vfHavrrRlrMMk4blbUhQjI9rYrfCDsHVygaCcdiKK5R8f68U9Yos09rxXLMi
         IpT4/C5KLmNOFM6QKggbUdhYB4fEkyAUJOFntAPjefbSc2NFhL/8qXDimIUjkA2nR4dd
         z+lZF/yxFeawTWOQdkM68IzfOmrS6ArX7HND1Sy6bCCI6tpqrPgabykwfnBCRlUOBJ0b
         C+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747246558; x=1747851358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks2e3ghqHLXQQkdmaQokVVmeEBA0ZdlTacN0FP7jAkc=;
        b=qnqM+u3WHQ2E3P6eVuDgk4CQJzsnmEwDjG10xtTOaA7aW9jOWXbJHbIPQaWZ71BCf2
         m0OaisAvMNG7rdzDrno9V8vuHuzqTcJZGBw9hm0zJ4OIS7n9+eb4p2TUPy1GolfOggJ3
         57T5GItgQgl4ZMKzRuCl2VZKfla69rtEIYaNSNz1MgsVHL8wl9Z/V/QvcGisuFOR+RDp
         IBA5fgpiWUYt666RRPwpoJEKoFuEfZbnZ6YnjmYVDPoOWb3AIZpM9C4/LxHOOTw+eLfQ
         MsqoX9iTvGEKfaMe9FIKfiGuUIkBlYeug8eC7ZMkFFr/siSoMU2p5JMW7kmrm1esdkLv
         lSHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0vllzd8+tfevAnYtNsshP23YUe5PE818eG9kn2XUsBL6U9lXRPoCp/1g02ldzjxn4hFATaV79KS4uEl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ars7+VW+8jaO+IbFOzwrBeUpcThNmVGuhZlnM+kaTCC3WuWJ
	xpRm/UnM2lGMZc6yKbCx/NBm1Ymuk+iP7sUhE2LSKW3p2Yq0xykwVX7AJU9NsKCOcQAo5ZKAJ4k
	APEJLT/gJx3YPMHd5+cIiXa5i/Sk=
X-Gm-Gg: ASbGncvremAkJxpmpThak/lh+mJ5TolZp8jqFLV9B4ztcJNasSriWcHEsC1BOntLQj/
	4crhepU3DCVntM158La0z9dlhe1btY8/z1D072Sa0/eoTVSMUXJtCLqpKZzDuT0Tm/Fv+PstYq9
	6aDzsVQVVi2NOtMutKrAncKM/kybIuS6SD
X-Google-Smtp-Source: AGHT+IGxCJKg/pkOQyap434EC4iAHQqIV2wczjYn10oi46YgFZxe/KF8s1Ax+jTiPn2uwFMZfmiqjSib0U7g6gj2Mxk=
X-Received: by 2002:a17:90b:2e52:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-30e2e62a703mr5725096a91.23.1747246557848; Wed, 14 May 2025
 11:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-7-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 14:15:46 -0400
X-Gm-Features: AX0GCFuY7KSaYvvPpUqSnV13wlvbHU8Cx7hV9W-p8TaAIzwW51hfE-FCjq20_pM
Message-ID: <CAEjxPJ4G_0m8gM5QyJ7UZmmRut6p46O0qAihDbsJ3U-N5dDKqA@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] selinux: check type attr map overflows
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Eric Suen <ericsu@linux.microsoft.com>, Canfeng Guo <guocanfeng@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate that no types with an invalid too high ID are present in the
> attribute map.  Gaps are still not checked.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

But see my commentary below.

> ---
> v3: squash with previous patch ("selinux: introduce
>     ebitmap_highest_set_bit()")
> ---
>  security/selinux/ss/ebitmap.c  | 27 +++++++++++++++++++++++++++
>  security/selinux/ss/ebitmap.h  |  1 +
>  security/selinux/ss/policydb.c |  5 +++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.=
c
> index 43bc19e21960..5d6b5b72b3e5 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -257,6 +257,33 @@ int ebitmap_contains(const struct ebitmap *e1, const=
 struct ebitmap *e2,
>         return 1;
>  }
>
> +u32 ebitmap_highest_set_bit(const struct ebitmap *e)
> +{
> +       const struct ebitmap_node *n;
> +       unsigned long unit;
> +       u32 pos =3D 0;
> +
> +       n =3D e->node;
> +       if (!n)
> +               return 0;
> +
> +       while (n->next)
> +               n =3D n->next;
> +
> +       for (unsigned int i =3D EBITMAP_UNIT_NUMS; i > 0; i--) {
> +               unit =3D n->maps[i - 1];
> +               if (unit =3D=3D 0)
> +                       continue;
> +
> +               pos =3D (i - 1) * EBITMAP_UNIT_SIZE;
> +               while (unit >>=3D 1)
> +                       pos++;
> +               break;
> +       }
> +
> +       return n->startbit + pos;
> +}

Always fun to see new extensions to the ebitmap code that dates back
at least to 1996 in the original Flask code base. It's changed a lot
since then. That said, if we ever want to compute this frequently
we'll likely want to cache it in the ebitmap struct itself but this
seems fine for this usage. On a different but related note, I saw a
lot of time spent spinning through all-bits-set category set ebitmaps
in child SELinux namespaces due to the global SID mapping needing to
map contexts to each namespace. I solved that by introducing a cache
for the global SID mapping but was wondering if we ought to have a
more compressed representation of the all-bits-set ebitmap and more
efficient iterators for it. Just noting for future, not a request to
change this.


> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 8969f7c8637c..27f6809b562a 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2955,6 +2955,11 @@ int policydb_read(struct policydb *p, struct polic=
y_file *fp)
>                         if (rc)
>                                 goto bad;
>                 }
> +
> +               rc =3D -EINVAL;
> +               if (ebitmap_highest_set_bit(e) >=3D p->p_types.nprim)
> +                       goto bad;
> +
>                 /* add the type itself as the degenerate case */
>                 rc =3D ebitmap_set_bit(e, i, 1);
>                 if (rc)
> --
> 2.49.0
>
