Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC644E675
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249833; cv=pass; b=uWIKUpjVi64+fqxrTfLhcCnLKGonNsySDpFNRM1zSK/Xs54EPuuj2TVyVs8v3Z44Yo9z/cXYTuh/EJ1zFMADRISBbouvEPmqMeXJbT3RmklEc+Udo6NW/VQbp6Jp+n6tqXq4SdiOD8BC1KtPh3qocrf5gik3+zWt0116eiMFEcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249833; c=relaxed/simple;
	bh=R3uBDJcljfqU1TUPaS5VBaZwRzsWg4xx7ML+15nP+xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1hhF4jh/5dIkdaKh02sUnUJrusmpGScmIC5XtyzjPjomgaFP20Ta1BhGDv1kQchcDAifeg52o+raBVuw7VRK9vNGBnRWuNG7FATH0aABFIs0dtxQPt81MJ7U+RHBN7WvQY5g640fUPKeG7iqMQElRq+zgZEnNh03qi9b8HYjW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiCx5zt6; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiCx5zt6"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-451a49abd8aso1854286fac.3
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 07:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785249831; cv=none;
        d=google.com; s=arc-20260327;
        b=TMst66oHB7EJWl9D7xdgn0FGFCe26/ZS0DZ6L5UmgjeHjnbbo6jPk+wB1hu56jx6lR
         XDvEgqkYmYp5qC99wEwlr+4gpKuxcmtJKwUmAVfpiR8sODEAUlnLIYytAbvL7bJzNl3j
         t+XCTipwAwf4MwPwWHJ9gjxiOc/Jqo7gDXKjPsKCZFMlU8ehKt8eslwn+vM9Pb4/LLhv
         KAsvcO4ix7ZkkqKFZGZsX+B9QF9PMDWE6BHcO2pICdj3ghZFH7w4y3fzqTHy89yC9bi4
         2AUwco7VbnwIBYHODVDBiABixtzRYDWT6syS31aD/lo/H6u0Faph50cUwUszyWXnxr6s
         wjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DD5GomCDIY96X1PJqL12kJyGPc7e1JlsJveCu2sm3uw=;
        fh=rVO7TxafxvwWWX8yEaS2K4NlQsRHZdmAG6R84l1LPg8=;
        b=S3DglRrDDl933Vv7S42OGuz+sPRT2BzWHVXJ6jsTW5QdtUo2Mj8PoJxx15Y5zJiAWK
         RX9xNNNXNHP+67miDRf2ik7TJRsDOhKxWnPsT5HnPJW/xWPB8Eh4PIFAvCMYFdiZIJ1D
         E1DoXaCrS0u1TWVRSh/2BpsE6pr074htMgMpUrSheGqTO2gYARsLmFMLEmhK4uaTB+FO
         7YF1GGF/NhcKE4m/0gw6Z98xlTZfMV+vQXwzNPWvPHTCmc9ObQgbjA2JWgzONtNvaVzQ
         jsRYp4+B4TIIx1Dl7V975BwT8dybR3Nr86JNaIHGnNnYE6n50fwfrcKNODMH6k2tL8fq
         0PWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785249831; x=1785854631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DD5GomCDIY96X1PJqL12kJyGPc7e1JlsJveCu2sm3uw=;
        b=QiCx5zt6+FDEB4xNjlo3BfjpTbuznQB5eJzus06e0qzE8VbwhxSN49uiWYkEAOpunu
         0tEk7BAdUk3q0xFRjr/5vcOvCVsks0ZKc+W1J/v+kEJwm6qKIgo1KGvLAzsLo0WOqISs
         ULBMeBqEfadFKjsfegqSu+PyLF/wkSqxvlyIC0henP0SCCh9+g/209+ej6fgdGacViQM
         DoJitwQ8aXBvgfRAAwv/xIwWuqbGL7C9HlrLAwaIhVDVcNJ1aui/BFT3IqwdCG0lBlB0
         dz2BvY2m2csreMeKcyHAt70Kn0+L810hq6ZG7KUrQTOYylAEfak0+8WtuYmMdzrmY0Lw
         rZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249831; x=1785854631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DD5GomCDIY96X1PJqL12kJyGPc7e1JlsJveCu2sm3uw=;
        b=SYz6X8S1TDAoOJWkv4AuGFgHehMSVccYnxzLzeKebC5H8iZDhstPpnXI12jKlM3+Np
         O8pWTYLtvoonf2ycUohNhKcfD2YGmxBfhyHuBalY0SQjEoCt8CtsD52NeDn7x/mQI+iM
         QZiOnuRwAthHflQair5qpZFHXGtbfRbBw8AK0f5u//sV94YFR9UXaxaE5T/YQ+S3xEa9
         z+YbK1p7463oOP2Rg4sQd2ZeBeRGU0cnro1UiYNburGxLIgl0jMT10lDCLi5cRPlNKgW
         RRCtHnmgD2PJuExp9EyngZiiL713qCgbeT85+BwSUC2+vZZZSrJTMkGSNmZ09JLLdo4m
         1Y/w==
X-Forwarded-Encrypted: i=1; AHgh+RoJgapaK5s5z2DATx5vFeJcszbd4AmksBz03rWa4WxfC2kf9vWPk2jxICBW3rygm/hHnFfGXEvb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfck0PDLFNB0mgTz3UEasudcXFfKqgyL1QS7l6j0LsAoAbffvV
	wYsM8utisVNyC9O3Nk/zwcOLWcZRQ1ISj4Xn4FUXqzvkYqzATeMNwiq8a5XExN3G9hpr+rUrnAG
	0OV8COs3Z5qqGXJgrLfG1NbD2Z0ox3EA=
X-Gm-Gg: AR+sD11y5CZmhsCl+LQ3ca+ErEEfELB6rsHIyzTGFLTRgp4sJrbUxHKsM3LW4WKH6br
	gxY+IPaXUKgsQ1pHddDwoLPL+Ll1k5Hs+FU5ZPPRVsM+qpj3FhLaKmniyJoAvXqCuibqjWEGECM
	riDWS2F19WVAsw+ItBeJLtFAuEaJH3mU3Nq4fU50NKmbYkzPQpsCkFsek4tGTI+xLqTM8yQRXJa
	NyxJr/6+DBO8AYCNhkOzpbC/sdlAB4EqQOMwSa++AUdyHqNw23DeVgunsoYFA==
X-Received: by 2002:a05:6870:718f:b0:409:5241:8abc with SMTP id
 586e51a60fabf-4586cf6662emr1401621fac.20.1785249830764; Tue, 28 Jul 2026
 07:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me> <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>
In-Reply-To: <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 10:43:39 -0400
X-Gm-Features: AUfX_mz1S8Cj7Y2oGS42n1h-6c2TLktHfXUQC67eanylybwnZNXgiKOVr3XIsAw
Message-ID: <CAEjxPJ4X_p6Qpebe9cV=eruOVM2HXHMDWsWJpQA3QoBc+W1kXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: reject a class permission count below its
 inherited common
To: hexlabsecurity@proton.me
Cc: Paul Moore <paul@paul-moore.com>, Kees Cook <kees@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:30=E2=80=AFPM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> security_get_permissions() maps an inherited common's permissions into
> an array sized by the class's own permissions.nprim, but class_read()
> takes that nprim verbatim from the policy image and never checks that it
> covers the common.  A class that inherits a common of N permissions while
> declaring a smaller nprim is accepted, and on load the common's
> permissions are written past the class-sized array -- an out-of-bounds
> heap write.
>
> Reject a class whose permission count is below its inherited common's.
> Well-formed policies, where the class count already includes the
> inherited permissions, are unaffected.
>
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes an=
d permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko again made some interesting observations but not about your
patch per se,
https://lore.kernel.org/selinux/20260728014625.C7A391F000E9@smtp.kernel.org=
/T/#u

> ---
>  security/selinux/ss/policydb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 6973b68d9782..c6f55f0b4cb5 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1422,6 +1422,18 @@ static int class_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *
>                                cladatum->comkey);
>                         goto bad;
>                 }
> +
> +               /*
> +                * security_get_permissions() maps the common's permissio=
ns
> +                * into an array sized by this class's nprim, so a class =
must
> +                * declare at least as many as the common it inherits.
> +                */
> +               if (cladatum->permissions.nprim <
> +                   cladatum->comdatum->permissions.nprim) {
> +                       pr_err("SELinux:  class %s has fewer permissions =
than common %s\n",
> +                              key, cladatum->comkey);
> +                       goto bad;
> +               }
>         }
>         for (i =3D 0; i < nel; i++) {
>                 rc =3D perm_read(p, &cladatum->permissions, fp);
>
> --
> 2.55.0
>
>
