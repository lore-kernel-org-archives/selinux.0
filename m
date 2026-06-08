Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8C3F5BE7
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932138; cv=pass; b=NbdNGVlBxxF4NDh0ZNZjFiIZPbRi92l3xszrernCrB+i7EddoDLMNix5VzHLysUtKRBvxyfNCfSROpwI/hJHcpmVLw0tj9hDQsPqB3dmLHlkDj83CzhxONS+tX6vB6X0O9nP2ADXi/Ee6wQnYXI0itsL204R/yMfDXRipdy2DOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932138; c=relaxed/simple;
	bh=QiACAi1POT3mxJX2ndKUL/SSNmAN+ftTJtgV0WGVhNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrcjWwQIjkuRPFauhuLRgrGweAaIpwrTf7rNAJieoQSyck2gCqVk+7ZC3eDEcr5iPpEJqEH7WwEqJwcDggyPvBTxt8p9kx7EtRx4bsvuk5ia7nS7p4amSNQnYiuQAv3RWca6zQcwileuwYenLDCeNJTQ1drieTeaZBfjjvkmnNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxxHUc6+; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxxHUc6+"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so4792779e87.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932135; cv=none;
        d=google.com; s=arc-20240605;
        b=ESxpeHS29UeTRIgo2DEWsZWKady6yepd89RSTLBhdKv3MfVyY268WRQWhjNmklImKo
         o99sdzflNy3VYA4yIj7SjIrD7bR00g/7t6MhW6SUCARQKq3zaGEMGYhIBpLfB7ht+Ubi
         w1eRRS0EDBsnd5dKNu0GR8RE2CiuXSdvi6oqknDrNrcZxDjzmgr085sREI6tfZppl3d4
         zKQuZcVwX4JL6ejnoOiWWhNOiHTxab9UP4TNuXhd5PWTQqDb5sUUi2E2VLXqmUdMAebz
         q6A5gvSMf8YV6HXCS2JL32DR8SsRkCF1qkikssuWmjzBk0jU1fh9dKvCLgSqeaVYXTRe
         qOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a1kEjb/sGjbUIjGGqZ+CHUljbqPvId1OWMAPl4OVCjY=;
        fh=KtuaPFEUZevYIuW6OuOu/ArIGucEM6QUAGs2A8BPQxA=;
        b=kD9LTh0m3OuSwCOE+AReP/64ZhAoa1Eg/HxmNVOvtPigqwq8Fb0KoMsZirEvTyg88w
         9YokbS/DaeO/8BDfXA8NXu1DFB1Yze1iyI1ayO4Um5FXqd/783wu5vlSzs22njYFkTcS
         isKYbNOJKydU5H1aoDI3yNGLBNWTrCB0jutYWDHDM7D3HoiENpTNz6WyRZSpGCoUV7U/
         0YvJ0zFhUUcdPZLgq6kegnXGCTwrbmXoiQEdrwgTdQ2PH7IS2fBij8dOP4ZC+aL7ekoG
         cDj8tjnQsnyXnf7rVhWJRExkDHwcRsjppyVc423yK5dhXVDxar29unuUou8DrpJj4TDi
         rdmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932135; x=1781536935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1kEjb/sGjbUIjGGqZ+CHUljbqPvId1OWMAPl4OVCjY=;
        b=NxxHUc6+l0Vn/VOirtVP0KkyWCd9nNS/4rfSJkeyzrMH6ktxkRt0oKq4NwGrJxRBO1
         LnStlkEbGDktft6e2urL3StMWWjsh+Ir+PbGGwQf2PT+3PZSC69YYa11BUp20IOZ1kO/
         9XANB6t4HYJhTjgqEAc4DZAM6a7yAt5z8VgxvlPk6JaljZjihqWvOkfsBcdKj1SfBNrA
         OSkJQpvAaIFVLU+YV/Sp/d9VibenOiqUGC6crlz2Uby2e6Iny/k+mSn1XeAl9bwjzjya
         VeoMArwv6Bf4NfEKxUrpB5M1Igta06CQ1O5eKR0R1Z+xCgvZVaABgbhRtxJfYwDghfIU
         fGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932135; x=1781536935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1kEjb/sGjbUIjGGqZ+CHUljbqPvId1OWMAPl4OVCjY=;
        b=jx3RUgCN5ZR+kjY2ToQ/t33waWEtT/F1sHa1MAZJcIwWuN199JsXPWQihUMPK1APG8
         4U6EN7LPFzY17T41N33cqjpfm+HOuEeavjf7BCYRnaMQF0w8vkVGvg1LBjY+8fkUfnm3
         18p6GLpCkQK30avsjOJVbjOu2+vuvEDNNEOvPZ3RCeAwr5RL68KM75dxume/amLC/HGc
         nDMJiiT8RtCZGQwQr3XupJfFddi+BkXOrY/kSFpLNWpz+HYPSD2FSZx5XGX8sYC2gHg6
         VATIvv7Uq0MdJT06DCKgoeGOVH8oPEpHDA9E5NiiL1n7FwpN6lVM7TaNfSbmVyuX4SkC
         f1Yw==
X-Gm-Message-State: AOJu0YxXO9RwJxSb3VNNanp3yKQrCxH69U/9CWsmASoQ8dL9OPjNfcS8
	Dt8KZj7VDz8vTfZAFk1ao1QpJ6tNk3PovjgztqQbTCEHbOUvlF+FW7LUCm1jms+GuXFoOC9mK27
	bmFII3LFI88BGT7jY5XR0Ev6imZK2QYs=
X-Gm-Gg: Acq92OH1W3K1NikOp+bRsAY7pAjkbsxctNQL3aVO1iow5Qo6eBfBbcwwSraP4W8iER6
	9KLcwpScrjgwjBthBzdg7TQZh2CCLnavmfeOEIwp1WhzH59hrp6LNruqQIRtMfkhsL9jpkTCPlw
	0Ji5Z++cml6r6YUm8dzYr1frdlSJWIII6lDUbZnpN6h7PZ8arNOKYz0Ld1MOj+6MgVpbvbZMgCd
	CbTOeFaY2oEuTwpyzI0zX2mvd8mAJjJQbZtl4uN2foN77VqzS2d5y919KmBeGTN8RwdN14cosdE
	mQASpDqzXlR1b3w=
X-Received: by 2002:a05:6512:108e:b0:5aa:12a3:4296 with SMTP id
 2adb3069b0e04-5aa87b406b0mr5265788e87.7.1780932134924; Mon, 08 Jun 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608133036.309348-1-stephen.smalley.work@gmail.com> <CAEjxPJ7BWdm=MkoDGjGn1FwXQb5qzJpphbsPXx5o5LtfuYkTkw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7BWdm=MkoDGjGn1FwXQb5qzJpphbsPXx5o5LtfuYkTkw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 11:22:03 -0400
X-Gm-Features: AVVi8Ccj-uGvC8wuwxYeqTSDnYG0NLW0cYRlYqj6xcPzc99yWujRIAXlnny1Boo
Message-ID: <CAP+JOzRc-F5tXNanE-YHo3oaMj3MF5PmcTteOw5k1uP+63tPaA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: make reallocarray check more robust
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, 
	Waldemar Brodkorb <wbx@openadk.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 9:30=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Waldemar Brodkorb <wbx@openadk.org>
> >
> > Some cross-compiler toolchains dislike the usage of -o /dev/null and fa=
il
> > with: ld: final link failed: file truncated
> >
> > As stdin and stdout is already redirected to /dev/null there is
> > no need for gcc -o /dev/null.
> >
> > This fixes an Buildroot autobuild failure for libsepol package:
> > http://autobuild.buildroot.net/results/72b/72baaab4658254f4c5b3348298af=
1d5c891cacd6/
> >
> > Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> > ---
> >  libsepol/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index c222a8fd..cd6ef442 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -31,7 +31,7 @@ endif
> >
> >  # check for reallocarray(3) availability
> >  H :=3D \#
> > -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){retur=
n reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLA=
GS) -Werror=3Dimplicit-function-declaration -x c -o /dev/null - >/dev/null =
2>&1 && echo yes))
> > +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){retur=
n reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLA=
GS) -Werror=3Dimplicit-function-declaration -x c - >/dev/null 2>&1 && echo =
yes))
> >  override CFLAGS +=3D -DHAVE_REALLOCARRAY
> >  endif
>
> This leaves an a.out file which then breaks CI,
> https://github.com/stephensmalley/selinux/actions/runs/27141099174/job/80=
106217168
>
> Must be a better way to fix it.
>

Maybe use "-fsyntax-only"

 # check for reallocarray(3) availability
 H :=3D \#
-ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint
main(void){return reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS)
$(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-function-declaration -x c -o
/dev/null - >/dev/null 2>&1 && echo yes))
+ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint
main(void){return reallocarray(NULL,0,0)=3D=3DNULL;}' | $(CC) $(CPPFLAGS)
$(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-function-declaration
-fsyntax-only -x c - >/dev/null 2>&1 && echo yes))
 override CFLAGS +=3D -DHAVE_REALLOCARRAY
 endif

Jim

> >
> > --
> > 2.54.0
> >
