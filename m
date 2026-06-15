Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC740B399
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540919; cv=pass; b=mvhwz7zOqjyxqkRYdejzcdWlSK+CDZOAgwxXvFvw3t8C6DKAW15NsUOt83uevi3YwelxCPYXXyjny7DEggzVC0aBCTw2pF36d2vDKFw7gWdV9c/E+AailyKAu/kxWyzktgLYb0mO2msVu5CyHnidMAub9WOAidVS/mwmqTAlERA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540919; c=relaxed/simple;
	bh=9/e1nl+TC6gGtlGlW+JvRiskshRCURcl2BEJJbH+7sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b26kk92UM7nMdMxZqm8YcJWohSL4m7gBpCusCv94uhSby0NMBpqNQJN9jazIILmtSN3BkfvkNOxIKmh0iT0us3n3GFlYcTp5LJFqi3j7jymYbxTLSx++A3zqrIU9lSkAZmmVDn6x1QeuXzTuf2Yn5qc1rlhhSQAQU5JsIT+2/wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCO41eLz; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCO41eLz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf18c30bb2so27764895ad.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781540918; cv=none;
        d=google.com; s=arc-20240605;
        b=B5Pwv5fU67/7+lGmA31iqq7Z1r0m+QckUgymzfhIZsOx2IkgkfPB2lSe0dlD+gOW5X
         MR9PpieEzvoQ840KM91YYguDqb0VrMl2rchvWsVr+zya5fqadTC57AehB46NEkFw6lsj
         ws/dWvlXJ7aAFKSJwhAn94MpfrhoaO2nq1vcIBjlWAcMOLEp7229lvRRQcFLkswoFZ5E
         My2NMN4KrD+LYZswy++gNQFBseoPvNC6/yK9ooXuicMfWvErYPsHlRdszMJICEwwIV1x
         FUnnQ+GXxt6jFYTMmLdsrdgxVgDheMxQ6v1mVqwplFuYpkntobRIF2IJ+jfMlR5NvFj3
         M5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDqScoi0tpsacCuzK3vSJrWnWuvB4L5esL9iY3eipSQ=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=SyRPzX8rscsm9cXmton8O+QndFbdjzGUaksCS9V/Xr9GGqmlDPgTF1TnOGHzs7Ouhu
         hdjbrKdmOUxPtSC6p1xBCRKg6FWQoQqLkqNQvfkHQxV5bLdCYfDQm+o6IIaMZsA+rCI+
         cqbck1k4W/uzLUgVvS+IjVzaZ3/gpStnHdYCE0kOZu54d8BUcyK1nhoXG1OJH1tz1t3Q
         yGGsNIQ8eNd6Am2m2IKcGfLUGV0JkxlmDPDsB2t7nNTbMt0w42eXPxZaUwjEny6lO5xf
         6xNLzhemdofh5NDdShBuOglKwQRy+N6euaWCDizJkPIfMy7LUSiUH3z0R7ucSHT80KFr
         DPoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540918; x=1782145718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDqScoi0tpsacCuzK3vSJrWnWuvB4L5esL9iY3eipSQ=;
        b=SCO41eLz9CaOjJZkftpkY7edVMLEAXsmWIwvZ+kn9c6AOvbuNlFJuF6KtHqAml6Grk
         Yk/tbDegtszJbEKBK/UsAVlPjAza4AC1BphgSeUDDVz2JigHrl4N53HcujNxg9P8SpKo
         XLGW9MCvzTBCsWcUJvPcDqDDUmixy4J8/47wbyUZs3/x5xBfRRkWhRTaOED7AGhwLVNu
         x2ARruz4aqYdd4bEVYI5ZNbReV5nIEcbI16VsiPBRagJt0lafjmv9UhIcDZuywFh5XeY
         LRr24jW0mFURt1EF7xrCOzb8hydi4B7kgylotvrnjaUxbX4VheP0ZBo3GCbqs1V/Py9F
         8L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540918; x=1782145718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDqScoi0tpsacCuzK3vSJrWnWuvB4L5esL9iY3eipSQ=;
        b=cRpWKfnc14ROnlBPHdkV74hnta51ycq87j3/lNvIDsbLduLBB9CYjy4N0Qhn+DzWIi
         UvV/z2en2+Dh0Dz4/W9I90OLXSEcd28Kg+Bg/ctW2iwoZoredhsUFlwsYwdAj50hutEP
         L3EN27NA3r2Jrp+jCOve9U36eydsWAdciS39jgxnlCDVZEIKK0eixo7UhzMjsYmGfwsO
         bs2eVT39TTe3faij7WXIhIFPC6E5cAlsbK6Jag72yfMfc/S39KpCSYMYC9nFyIdltHL/
         lNk/06JsOkQCkYup8rDV44quN6n5rcol8WMm2Fp75P1lUWTF5Dkb9nQxVicAgVWocHiZ
         2lpw==
X-Gm-Message-State: AOJu0YyPlufvzmQ8ots/kiYHs4vMM0rNPrX8DSKzKRos1M/v4ie9i70E
	ZJKnV5ez6rUmZvhuqM8fG0/DcFQFbmxfoJA7HJdlsbqxOG6cBIoFoMqV3Ad7iwChB0NP5RdCvMt
	psChEqVORCsEHZSPl26DHVkzZxZxy8e0=
X-Gm-Gg: Acq92OFMULLSAFY7CeOgk6b+EeZIlqSnOc5Y103IiH599atr33PjsIjZO/bjR7uhDE6
	J5c5eLWFKn3g3U6k/wNwouu0xMA8zzRhcrpm77P5rGJ2232mwyDEBjb0vtgN2wX0YiZHhLvqCbl
	dPwVawidPPpCTepc7UvLc0Au5BRnvF9tWNswBduFZL7lXDA68ji3D6x3im89BXTBfuMJCrrK4gw
	P2Joxf6lu9dsHB7maAWNfDQYVxQTm4mVl7YzXhxkIR6eyOXbdtbdmEVicuremTox52+6xGx98TW
	AG1EQ3Y=
X-Received: by 2002:a17:902:e78b:b0:2bf:2243:d4e9 with SMTP id
 d9443c01a7336-2c6641efb9cmr131743035ad.13.1781540917691; Mon, 15 Jun 2026
 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614190837.2947-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614190837.2947-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 12:28:24 -0400
X-Gm-Features: AVVi8CcRzhSMu8NbpeCbOI8hbUaw5Efpht2NEinQculQHYwOIILlM-jJrGcYG0Q
Message-ID: <CAEjxPJ6pQAEeyrUO+E7VsKdsNE=+ZBMMzeyoiwrTMECpYJLizQ@mail.gmail.com>
Subject: Re: [PATCH] audit2allow: make error message more helpful
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 3:08=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  python/audit2allow/sepolgen-ifgen-attr-helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/aud=
it2allow/sepolgen-ifgen-attr-helper.c
> index 609efb31..c8e68874 100644
> --- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
> +++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
> @@ -212,7 +212,8 @@ static policydb_t *load_policy(const char *filename)
>         ret =3D policydb_read(policydb, &pf, 1);
>         if (ret) {
>                 fprintf(stderr,
> -                       "error(s) encountered while parsing configuration=
\n");
> +                       "error(s) encountered while parsing configuration=
 %s\n",
> +                       filename);
>                 free(policydb);
>                 fclose(fp);
>                 return NULL;
> --
> 2.54.0
>
>
