Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC9383C94
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613260; cv=pass; b=eimzaHpjx78G1XGKZgBswpzDoLdyylTDaI4DVIUSd77GjatpM9bRORwWN0eqExcJSUHeGC9SFDrd09UGc9dBi3WjHYSI1RvpS3ZHv5Uqx36mkyT9Lewr2ew+Qp48M0/X6NUQCGqaETLZTAFjCBuUE7UI46ZnV8dcVjeEAuRdxJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613260; c=relaxed/simple;
	bh=bh4rTBxc+k2k9I7ILgQv9jbnkPh36rocdpnK9Kqt3/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtxDf3AiEStt2Kn/vc08qixmVo6ZHB1izI792rQlyzsAUj7zM3i6x2qmm/UhBCc8qPmZ6SrZ8f58M+8lnRRLv25ydhd9DzLuaOytnecJbAvnHVmTxW/kNDMyCqQNF46ZcaFQ795uqigHK9FPeloi1l1nPvQY0czYDBCypiUQIoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3YWQH2o; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3YWQH2o"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393d07e8938so54545421fa.2
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 12:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613255; cv=none;
        d=google.com; s=arc-20240605;
        b=fVWcQi6i3X04OcmQ7619KvX+q4/rHkk17okSR/SuvQP0W3EpWjZd5MzC1QBC/YistK
         fTZK4ezAruAtJg8A2+Atnd81YDjgu4FwfQmEHPFOpXvUA5p5Ia40eBNG9FwTq/a1WBRn
         awcz4k3wmOJVgzHN04+3rzvWTL89dguUY4hVWtrhKz9gM4j9fIl48QstgoZoNkuk46vi
         0Cr4fcV3ihvhK0Dj24hLVwxVqjaRmA8IqO49XhRF57g0DZIq2r06pXYwFxkLHm9sTBXA
         6fMI8ZcVXKqnpj44EucmFiWdaADGbW1/iqXH0doEyhYbxooSzQCSFws6zMiq0f1Koi2k
         etSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eY4L4zZ2ftAYr9nNlQkOXxq55FO3UPDBdg4zXEggkZM=;
        fh=mFQboJxWocvAtOma6DaRcuQcCUuideATZmTdRNfolWk=;
        b=VPgx86AITTxpVwG8G3IOGjFJBg7VqJaX6xLfoNl/QRtLfalbMTJwLbMhmReNV0C59P
         os5UhpjTvaO3qsgVPiagdBP9+XCXMx4NVEuUPCLT/Lev9PH8HHqYvclZ+KC5rCTCWMcb
         DHLomQchaEX8VuCzgV00f4DP3ciYcaGmLI24Dh/0Vh+3suWWA5EOSlE6E3NaZTmJ/pBb
         abgD02QqXfAswlEnjPbADR26xqFnRPc6a7rKV0Vb0CrmQSstID9CKKEUmsgdQqY5YAOa
         UXjtDIHnjnaDs0X04PT2zWW2V/OWip1ok2eSk3ZRQ+6SJSirQWwRCZ/ttwp2is8+hi10
         ExiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778613255; x=1779218055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY4L4zZ2ftAYr9nNlQkOXxq55FO3UPDBdg4zXEggkZM=;
        b=g3YWQH2ox9PrlDAOxG2Fd7a4kF7PurHVo4NwbCXNedeaGDbCjdOXzgyuFoj5zhis9G
         2rrP0qbzsTNu0YwGTO/q2mq75/I+EaVi2/H1Q7kEAKkQHWl0YqCAnpVqHxm2plLcXQFs
         bFthd0nvXx+CXYsfowe1v/NB739X2vZfw/6WK6uMQEudM/+Y4vQa2nmapvew+cNgvMAQ
         ZJ3efP6ynkY8muJfk7KHU4Dvdcgx2WGBvK0hxphAp4bjnFRpBco+Bg4w9MI3L/mVk96w
         Z314XK/5pSPZW3OLL30fh+EC+35DcyGKQ3WxE5J91NYihl+wudnGgpoXiVTaoznJVKND
         neUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613255; x=1779218055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY4L4zZ2ftAYr9nNlQkOXxq55FO3UPDBdg4zXEggkZM=;
        b=E5ouCG1IOC3APd8LBRkrfqKt0ot7o3VFsVLuzkXd3jH83u641xkXird7T9h7LdyQFz
         7ipsWssrDXVjkRtr6VnK0LyZ5x6TTLygP45/Kp6Zz4T2Bku5CzpyJnN6jvI4W9DhpwWn
         Q/aqKpFREbHxN1s2DNnqr1IadpaesGa8LGOh87EUvEg2KIe7iK44/knwhB+eqkUaVQaN
         L1L+BL4x1jnKsYswrnz+ynpgQ5yL5GQCwS/e75NW2kJVBAmTAXuWjXGf+s76ZDWNILiu
         BUu8TDXrsW/EpY3emo0KKX38xl7YP9scdZbktjSskTq6Dq5YOs7tQHe6r0pmxYtp+hjA
         mtmg==
X-Forwarded-Encrypted: i=1; AFNElJ/zyl2Da56fVVJeNxp6hqaVS07IrhuUlU5yGd2xDL4Hq1QcHpPSk3bD+lPO3VhfxoNkS2kiAX7j@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNtHV1xGnyXMWlI9GBXcMRFSdY774WBdRBXFGu4qZKVJ/sS6d
	zkgcLScu58F1DGG9OqnNzuoPG5l4j1XbFpcZXVwA2yVvj4P3f0lsGxspnfIrFoDMaCx/5AL7UIo
	XDmpivbW9GwJ8JWCvwIcecity0YEn/KuXwrR3
X-Gm-Gg: Acq92OFnm8mh5o5fIx0aHzqyNN6U8mYrQ+isbyDrhk7rV5cMnqIvY6MVZyzXMifTe/K
	m5C+5o0wXqb/y5nRHdmt4LkDEokLA4p5lRJXi9ciq2Cl8R+AEMh7ORSo1eXfZmlOaSLa7A6jnk0
	LEZgZE2lYZPHSwGpMUR8JRmlhKSQ+3l5sdZdbrjwStVEI5SXgm9Wwln8z+4E2gzELlHCbNOqAfI
	VQ0faCS5ZnJ5KWxzAY91lzqUrqMO0U+uiv0PcS6S1+QHZJlCna/PD6mMt4dQQr7bxJ6KIwntKth
	micy
X-Received: by 2002:a2e:9784:0:b0:38e:a00e:2bb5 with SMTP id
 38308e7fff4ca-3944b604ee3mr493421fa.19.1778613254544; Tue, 12 May 2026
 12:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403065234.2172150-2-nvraxn@posteo.uk> <20260403065618.2172556-2-nvraxn@posteo.uk>
In-Reply-To: <20260403065618.2172556-2-nvraxn@posteo.uk>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 May 2026 15:14:02 -0400
X-Gm-Features: AVHnY4Ij8XdMSBEbmwUN-zNym9Fo0ZSeuc0i8FJNairY9czB3sTWPWSXlzDvFNg
Message-ID: <CAP+JOzR4bmbSTwyxV6W0awuOQH+jJwCokp=T9s4UuPMuOM0tKQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: policydb_read(): use a static string for policydb_str
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: nvraxn@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 2:56=E2=80=AFAM Rahul Sandhu <nvraxn@posteo.uk> wrot=
e:
>
> We know the maximum possible size of policydb_str at compile time; it's
> POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
> As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
> avoiding an extra allocation.
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> v3: fix authorship mess
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 9760b164..8d290d86 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -4192,7 +4192,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
>         unsigned int i, j, r_policyvers;
>         uint32_t buf[5], nprim;
>         size_t len, nel;
> -       char *policydb_str;
> +       char policydb_str[POLICYDB_STRING_MAX_LENGTH + 1];
>         const struct policydb_compat_info *info;
>         unsigned int policy_type, bufindex;
>         ebitmap_node_t *tnode;
> @@ -4222,16 +4222,9 @@ int policydb_read(policydb_t * p, struct policy_fi=
le *fp, unsigned verbose)
>                 return POLICYDB_ERROR;
>         }
>
> -       policydb_str =3D malloc(len + 1);
> -       if (!policydb_str) {
> -               ERR(fp->handle, "unable to allocate memory for policydb "
> -                   "string of length %zu", len);
> -               return POLICYDB_ERROR;
> -       }
>         rc =3D next_entry(policydb_str, fp, len);
>         if (rc < 0) {
>                 ERR(fp->handle, "truncated policydb string identifier");
> -               free(policydb_str);
>                 return POLICYDB_ERROR;
>         }
>         policydb_str[len] =3D 0;
> @@ -4248,22 +4241,16 @@ int policydb_read(policydb_t * p, struct policy_f=
ile *fp, unsigned verbose)
>                 if (i =3D=3D POLICYDB_TARGET_SZ) {
>                         ERR(fp->handle, "cannot find a valid target for p=
olicy "
>                                 "string %s", policydb_str);
> -                       free(policydb_str);
>                         return POLICYDB_ERROR;
>                 }
>         } else {
>                 if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
>                         ERR(fp->handle, "invalid string identifier %s",
>                                 policydb_str);
> -                       free(policydb_str);
>                         return POLICYDB_ERROR;
>                 }
>         }
>
> -       /* Done with policydb_str. */
> -       free(policydb_str);
> -       policydb_str =3D NULL;
> -
>         /* Read the version, config, and table sizes (and policy type if =
it's a module). */
>         if (policy_type =3D=3D POLICY_KERN)
>                 nel =3D 4;
> --
> 2.53.0
>
>
