Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB4348C76
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160369; cv=pass; b=pQi2Kwf/sMsMAKLd1sJ9aJE9/EoU1NwD9k8Tcp7Yk6JTYAgxtNBv3Mz/gFRnraRbbDAwOZNdcAQ/4C5YkPvryLaZs5wxrxT9NyG6rnWZ30BMCR4wzkN/KI5QDOuFBEU/pQwDxyqEPEQhfsV3+koECuWQvoWT7Kl6zf/rgbXF9xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160369; c=relaxed/simple;
	bh=ta4c8pqNmSexaAsDFjOE++RvF++oHgK7RYuhnR1A/do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYOydtlNUs+CF5Pfy5uZPqUYCRkVYolre9zDEr0NHPou3GmZg8nArqTjhXPBSbxbVFOsCMwGKg0fUztqrdLMpgxuVbX9a/xpAHKHOMZuSndjJ3zfPaCSawI5CmeWS22dVZnLEvT8Gp6hKrpXEXFaTLUiq9EythnyjiJCHyZs4ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXDCq9oV; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXDCq9oV"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c89370405aaso2086149a12.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 13:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782160368; cv=none;
        d=google.com; s=arc-20240605;
        b=Xyzn74RN3azjNu89iFU+MTlNHmb+RS0d9DbMM2nLGMeSrp0iEm1IqGf78JQFAvwHab
         PpHYBklNyUfkbpuwS1qa0XwUVNz36j9KvgfqO9iRkKP6JgRHf6JcwSATrcXes+y7zrE5
         aZ0srmgpbDu+qqj/InYbRa+RKVug70uLYP2lSZeVydYBKfWxbMQ/9fBJBl8MX2z75Alq
         ueL1IIU2gsIngBhbFJKsHtMF1FeJYJboiPNQFxt/EwqkUSx5DDiNzlJJyUUtox7R3iY4
         zPcOwF+UlHx36EIHL2vPxGVmIW7RlwPoQSrHKoQl8CJ8m/vTkNnecfIiJ4TWmA67LvSN
         CGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcykP/dhT6I6QAzZum1TWZnlKTPLt/XScu2qHPKO8IA=;
        fh=jRyevUK2w2AHXbqDg68JL/TGkgAfqiBixLBAah9ARNM=;
        b=lDe2+DhlHb0HZIW3KtoTVgI3T2KESCjv93C/Cwx6C98jhM1mzSnJy5bg3Wez6nXirO
         9mA4vdQDbY4KUZI3VyECZnp4iGQcypY1p0qrcJEzySdY3HDTv+yYGk658BgFHdfM+6vt
         s3Zz6i5J/Fp7FW4X+YneoygLeq/m71U5nnzCQwrvwwYtgIuYP+6mM1rEUl0KJXJNR0QT
         hlwwOva7KmpvgfNouL8jihXlnJy/6y+bJcrJUYvyer/+akmlNZiXmTNRNWarlg3XwvUp
         hNT6K5M+e14nRW5KWsVMo/6lWYaP/5QeSqRPJrx5Xuc/cKB4UxQex6jdXgKXCzWKbIVv
         PXJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782160368; x=1782765168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcykP/dhT6I6QAzZum1TWZnlKTPLt/XScu2qHPKO8IA=;
        b=GXDCq9oVI7Y1koDdHSpzPvJ7t8HSTM1I74JkIS/5MGSTwryt8KZwACti3qaDbpBXvR
         /dLOcCdRuFr2rq8XUaTuNMpoqrRcSRkJP6raFAIKX+F3zoAi1eAVg5GOHZT/Ojn/7Bxk
         dtzNqXCODt5WkBSpKnQYBcLh4nN8wC5L6v/sH3Z8yzaX35S8HqJFPVOsINvW38TgTI6m
         mwnpsKBdu7FD2KR3pqDWHGzClDkTKoIBfCkRETaybUOIygrPh9K6tNOi7q2KULVzhEgu
         tdaKPtPbG+q0GGlRvIRGWRNnMYrYqaHRdXMtQWBQzoazYh8xG/jWKnoE880GW12ZnGwP
         qyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782160368; x=1782765168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcykP/dhT6I6QAzZum1TWZnlKTPLt/XScu2qHPKO8IA=;
        b=LHGO9gaJzYxO/CMMqKJErZ1I72Gu1e8z4uBoXJoBBYL9ZxciLqAs9HM2gcEtYY9p2L
         kiEvfZEcOrpSdE3uzG0N/DwDFZbktDOCdHDjQ8aNwBsFHRyanTulIpS1mjhko7BkVhkh
         MTasTTL7hPgrANz6SRVa8NnaRGKw5rT9zri9Cw80AomCo/x/TPxkugTyvQDiUZUyqyfE
         8ooMO9IYNWMMw9RFzITg/wf783yh8+A6mKDAinIy3zP7rM2+sQTpYhnhCbvFya74w8YF
         p0DR7As/xz0LQdgRdA2tcVtMLQU7m6ncJCI3NN1Xc2ijBBsnt0JGzq/r0Fr8J5OCn91E
         vZ8Q==
X-Gm-Message-State: AOJu0YxOy/BYZILNJelECVWEh+O1kpAp6ApjW52JQ80LnlUUrSqsNCMu
	cou29hA2oUbJJNUlhGDdCHcB66/qM7LUYtUKeZeljkPMkqSPcU+ab2Nb4J672mbUl5gsnFEqi5U
	aLgTjWw6IY5KI8kp+NXcDlBMuy2qMCYs=
X-Gm-Gg: AfdE7cmkREPnvPwjuN/8I2OY+kN6pz7ZbXHrffNwfc04XHo4fUNCteeDBfjCcrVpLAX
	a2pl20Zt0AUCVfxtar/M+KPeYG5UP+L7z9boPjoSJA0g84qsnYeGpDrhLc06hzYJEoF52yvQa9r
	ey75Jknm+kZKr8MxfkucGCQ/Q0T7twi7zEIE/SgOqHEJ/1/HvuNyIEdzvqDcfjB1/58jU1MzNbJ
	NbhqruO8528I4TIS7r0GGSWa/L8u8Wyf8q3AGYJKxH7F6i+WX7QNjlkgMIucpvN/rbY18KSM/cs
	zhy1Z6s=
X-Received: by 2002:a05:6300:91:b0:3b1:80c7:5f8c with SMTP id
 adf61e73a8af0-3bd1516d8d0mr46915637.28.1782160368100; Mon, 22 Jun 2026
 13:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622124251.31555-1-stephen.smalley.work@gmail.com> <CAP+JOzQ-121aE=2wmxZj2zEfUhO8NFWL577LTU51xqXy_dRcxQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ-121aE=2wmxZj2zEfUhO8NFWL577LTU51xqXy_dRcxQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 16:32:36 -0400
X-Gm-Features: AVVi8Ceik84ptMfBMh0kkbySNsv7Hq_r6XF08pFu-iwgS1lmIeOyx4Ycv_MQbME
Message-ID: <CAEjxPJ7KBATmS65HmzHv7a2NGwnH_FLVyO192BkLm0cBuSmtKg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix double free of borrowed type datum on
 error path
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:45=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 22, 2026 at 8:43=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > cil_typepermissive_to_policydb() and cil_typeneveraudit_to_policydb()
> > get sepol_type from __cil_get_sepol_type_datum(), a borrowed
> > hashtab_search() result owned by pdb->p_types. Their error path ran
> > type_datum_destroy() and free() on that borrowed pointer, so
> > type_destroy() freed the same type again when the policydb was
> > destroyed.
> >
> > Drop the destroy and free of the borrowed datum from both error paths,
> > matching the sibling alias converters that only release their own
> > allocation. With nothing left under the exit label, the gotos are
> > replaced with direct returns and the now-empty label removed.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/534
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libsepol/cil/src/cil_binary.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index db3eb0be..caf2d987 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -611,18 +611,13 @@ int cil_typepermissive_to_policydb(policydb_t *pd=
b,
> >         rc =3D __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type=
),
> >                                         &sepol_type);
> >         if (rc !=3D SEPOL_OK)
> > -               goto exit;
> > +               return rc;
> >
> >         if (ebitmap_set_bit(&pdb->permissive_map, sepol_type->s.value, =
1)) {
> > -               goto exit;
> > +               return rc;
> >         }
> >
> >         return SEPOL_OK;
> > -
> > -exit:
> > -       type_datum_destroy(sepol_type);
> > -       free(sepol_type);
> > -       return rc;
> >  }
> >
> >  int cil_typeneveraudit_to_policydb(policydb_t *pdb,
> > @@ -634,18 +629,13 @@ int cil_typeneveraudit_to_policydb(policydb_t *pd=
b,
> >         rc =3D __cil_get_sepol_type_datum(pdb, DATUM(cil_typeperm->type=
),
> >                                         &sepol_type);
> >         if (rc !=3D SEPOL_OK)
> > -               goto exit;
> > +               return rc;
> >
> >         if (ebitmap_set_bit(&pdb->neveraudit_map, sepol_type->s.value, =
1)) {
> > -               goto exit;
> > +               return rc;
> >         }
> >
> >         return SEPOL_OK;
> > -
> > -exit:
> > -       type_datum_destroy(sepol_type);
> > -       free(sepol_type);
> > -       return rc;
> >  }
> >
> >  int cil_typeattribute_to_policydb(policydb_t *pdb,
> > --
> > 2.54.0
> >
