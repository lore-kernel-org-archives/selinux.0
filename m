Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCF3295DAC
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540848; cv=pass; b=duS8bIJ3J90yDwuL8HrV6jLMGYJN9avGSUIIFbSOu6N4EQdZhla0YkfnNu+TmZl1b0joR9WzSM48WO0PXRem5WESWKv1Kpaa9Yl19bWR/4y0PGS9c4SeTf3W+h3lrHd6IpA2wkQj4R5GJCmIQUc3KGH+1K8sRPTy/3lASd1Pdj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540848; c=relaxed/simple;
	bh=iQA5AQutT479JrsCyJgVQisfoUcVz7NTXntHdLEa110=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK4oC7gLRxwCzs3jk8RMBh1iEFiSNv6Mmsm1dSlm54/axh5sSA0b87m280oNr6kFImreN29eY/c8ZZlU2EuOptjFDIaaXhzTKBEAmsS7LWFAxMfIAPMbWqZwUSTdz2hGfaXHt+W/RBwoAd2BJlDy9TREMPixohv6xI4vgGhfAdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6wxsrws; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6wxsrws"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0a5354da1so28406495ad.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781540847; cv=none;
        d=google.com; s=arc-20240605;
        b=NUv6IKXxa0wiSI8a+HxQU8o+ymve9FF2WxIR1u0t2Pe62BgaRqB1R43qgw7Dfy3/NU
         gLLMvr9XFOE9W79+A5S6lETHxnpkcGCqXlf1JUSTH5N1sQci28YevFZZ7sViTJu7PldH
         RptqJD2aeAH8e3gJrFGZ8nzcqsXra0+SuqTFNd2nHLAdUNFWygMcs9cm9ZPYKUwg8fMo
         Zfy8wq9HKMeF2VZDtP4wKiVQw823+vJk3BqD5FcRzZEuGLTI0MJ6d5Hp5hhtxMt3l21f
         dGb69qPT8nHTVKCNt6ud6iQBlC8nZl+ZTP86HPXtDJdP4IpjE46AWNzbvHUlpjDdndJq
         73Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owuEg14NAzdbUVVOmR22ADYyIXxjc6wQrk8AOkLzLu8=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=SWIX4+MjQk0FFzlVrtzVJsC6mmDs/61xtmrq190w2BeQstEm4yWj992kV2zoEe1vnd
         B8kIqvBOyucDliLdozIAh8K6+SmiUFoaDguxRxJuzIY4aTtfee3YI9dbmaf/mfk5mjMH
         IpRsM1qZ0P5aDqhlKf06rPrJmsk4La8sYdbem9c41LTrq8KbmnS43HKj3SdVZoVAePYK
         y1jccaFv042dc7NSYiidxH4kvMf8j75T8che0AGZTgGutnZeVuIIpFeXwOhuluCvWIey
         BrXuOIuXMPXz+cYjbY7D+6eOVuMA4eMU9pUnzprAg/40JCOVYNvDq0LAWOi+QWIccnzi
         Z+qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540847; x=1782145647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owuEg14NAzdbUVVOmR22ADYyIXxjc6wQrk8AOkLzLu8=;
        b=X6wxsrwst2gY/YnelLHLGhTzDncp+1px19etu8NaBa3rvT/fA04XhZ77Gb2OLSAVWc
         W2DiGNIwTGABMRXOY5P1BpCG+nOUSp5S43aDdBoRKhqZbdfsDfKGZwpq65DsCk1uXyLs
         0Bfw4a1FAGqTlVKZAxJDoazfQ1Ue8LrwbUyQSe58pHmKOKlvMDNMNAq3XpFPiTysUD8e
         ZQ8qMLzouwLr4/AaTVXRfom/TMFGKkSqFDJaJOc9lWeM4ogjx2q9w37lFx3XRjm06Bh7
         ftPc+DGYh8aVqJSvNeidRYhUDEjhjqF8P93OS5P/mBrq5++py4kPeLo9ke3bWFGEnvIx
         5lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540847; x=1782145647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owuEg14NAzdbUVVOmR22ADYyIXxjc6wQrk8AOkLzLu8=;
        b=su6C8XYcTy1E4pFvELzfM/NsV1Q84l14eVL8zKVfu2u8se776u5i+CeJMyNEWTXQBF
         pK5o8kyqsC6/TN4jRJH0oPw9GUILREi8+ekCbe+ikyNixssx53EB5+90sZXWJy6aa3Z4
         QZOC0md763pHTS6ABeryYaDy/eG0BCyVmkhKxV9SEf2RlgRB03I3mKhr4JLPO42lg9iB
         Sp3Dvdr+0t9NkH8INoSM4TeSLLXFYw76IM+ASIUh1A6CHNa14+umIkPzJKxPvpGq07wu
         PA/q/VnzB94L5DXlPo8l/0ycc8rMpv9EmZHl87xDsNOYYSSf/UCKVL2bsH+X6cOsTxOJ
         FTsA==
X-Gm-Message-State: AOJu0Yy4D3WmIPbsE4TfJc986FFelK8wjTah5Q7klcc6k0upQJL9jIG/
	AX0cFsSVp/Nz9N9ANB/nSehm5dIIs07GZdKsS7RomAp6hE+AABI5luBp2CC/V/By/AOyd7HsP6J
	V3QGcNGpuidj29P840RyHjehxN2hRNEA=
X-Gm-Gg: Acq92OFcGYmrWD7ONAoLOADJAVWTXkTZRzkTu2qi3oauB/XYVxN4qjwFd2Xc7vXo92i
	b8CpZh42maBjWWZ/zJbLjKnLwq6z4xnsQ+LegCXdUhxrMyGAKScozvvypbzza8bF5i9eN3DmWf9
	k1y/qZg7P+FL6kwh4DscGfwr1iWV1xXPQSrnvbsgOT/ic3xxSvmOoe/nG14KpR4wVckijitCd0/
	Xbms7VBQLnojRSUFjj4qm8e3J+IiLyxqAoEl3fq1I5mF3tD5hzcuIO+Xo3eDtiD79viZy+2Zb8N
	aQ3+gS8=
X-Received: by 2002:a17:903:1450:b0:2c1:6ed:513b with SMTP id
 d9443c01a7336-2c699b17ec1mr1700755ad.16.1781540846915; Mon, 15 Jun 2026
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614182353.59521-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614182353.59521-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 12:27:15 -0400
X-Gm-Features: AVVi8Cd6rTJSasbCbcKkPt02Om3X_PZO4dre-cU_Eh8oWhCX6sAjA6jCSPKlG8k
Message-ID: <CAEjxPJ6+P_AyrYg8AN4fsTn0Ut7mzaHHAMpHNTR4p8B2Y+JB9Q@mail.gmail.com>
Subject: Re: [PATCH] sandbox: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 2:24=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  sandbox/seunshare.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 58baa7ff..3fa42f9a 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -241,15 +241,15 @@ static int pin_dir(const char *dir, struct stat *st=
_out)
>
>  /**
>   * This function checks to see if the shell is known in /etc/shells.
> - * If so, it returns 0. On error or illegal shell, it returns -1.
> + * If so, it returns true. On error or illegal shell, it returns false.
>   */
> -static int verify_shell(const char *shell_name)
> +static bool verify_shell(const char *shell_name)
>  {
> -       int rc =3D -1;
> +       bool found =3D false;
>         const char *buf;
>
>         if (!(shell_name && shell_name[0]))
> -               return rc;
> +               return found;
>
>         while ((buf =3D getusershell()) !=3D NULL) {
>                 /* ignore comments */
> @@ -258,12 +258,12 @@ static int verify_shell(const char *shell_name)
>
>                 /* check the shell skipping newline char */
>                 if (!strcmp(shell_name, buf)) {
> -                       rc =3D 0;
> +                       found =3D true;
>                         break;
>                 }
>         }
>         endusershell();
> -       return rc;
> +       return found;
>  }
>
>  /**
> @@ -802,7 +802,7 @@ int main(int argc, char **argv)
>                 return -1;
>         }
>
> -       if (verify_shell(pwd->pw_shell) < 0) {
> +       if (!verify_shell(pwd->pw_shell)) {
>                 fprintf(stderr, _("Error: User shell is not valid\n"));
>                 return -1;
>         }
> --
> 2.54.0
>
>
