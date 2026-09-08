Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C39F563293
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881435; cv=pass; b=VcCoVd+ZHD0JCbA7STZJnzCrT9mfJBVw5q0Wyba3t+iaw5JUhuGqO84L8aKNq1JuxZE2Fd0yGzH6xe6CMNdffPwo0PHLK+AYIkVgsEct41/kwLxh5fJdau6V9DXI8a4A+Y6/N8w8JR3Dw/xbhF3IQKQu4oni49E+WUlvKbXCmak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881435; c=relaxed/simple;
	bh=YDATousf7yNN3RGr6SgiPwqCWC/Kq0MWIepsrbexNjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZbkx1DIBJvkDjtyQScOx5+s+doqksAZTv425OYs3lSEhOwQVsQTFwV1CA88y7RgAFqhUxk/xmDfOPXHrf9CTyMkRlAYLSQTKZJgIOYN5B5Z8R74YxQG+G6FLDDRWeA3ZXiWtZYeLYSezJqd8npywo+4c/hH5R+w2imjmvLE+48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC+yo6xc; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC+yo6xc"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4ab47c40e7eso2946291b6e.3
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 08:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788881414; cv=none;
        d=google.com; s=arc-20260327;
        b=Ay93TvXX8TBWG0+V3yLWaFE+NEFrRON+WTdJP47SWfm4ogv5qyMoOi5oVE7bCVrM6H
         utjKcfC/TCiPTllaCzcMHJqQVDHmtimKq8b6oL3RRzanE2WsmN/aWJgRHVVo5KtZ349r
         H65EM448mBxrgo6+/kTBG/9nE7tanf9CPBEnBTG/c4AD/gVPlq5RskM+I+XIWCnuzq+L
         Fqd9e+N+6F1WhY5/4+9qPuMdCiz/GXgPxrmSUcirilq2ISNrs8ohGPVpoHhrUCBhjLoO
         kjVUzj6ox1bq0SpQVAFi7s8NVpcnzp45AzgLd38Nr/CoC5oliuhTx37TsHgsz0y5ejzS
         6RRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ZuDZ9h1qeZ6Gqge4noLqMtRGzhLKhgYqbv6QyArgpg=;
        fh=5uUbXaOGVxnX9l32AjDA+Vdsh/vKQMRGo5Z1o13sbL4=;
        b=anLvC3tHx/+5RpApcMuPO9Jx8VIrreGWhFUCohPEf8/sWD2QJtUXVAZA6XDu1e1kS2
         K9+vODAuUcpKHZmy8uwC2iyv8DcNa0wM9fy1bPQex58vnifAYzUXVMOw8MAeWTw7PuNR
         DAOtTj07Hnahy/rfJj9wVfZyoO2OUjaWuJHKIb0X/Aq6XgeoULhau5b09aP0ZyMGv2oC
         ARs9+FpikQkiZo8pHsWhPTk0WRk9Fn+J34yIzmE7T6I7SSt/GqWMB1ravRwUGNoi+jpH
         wE4IPPpza4oG4WgCfCSnIhziw1gTmCJlKDkjV0hAfo8tiu+cHyzf6x8C0pfl+QxZYD1q
         HiMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788881414; x=1789486214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ZuDZ9h1qeZ6Gqge4noLqMtRGzhLKhgYqbv6QyArgpg=;
        b=FC+yo6xcUhvm22DdNHvbhoU4G3z20n0Pnb70r3nOGF/ryHQCYoqD48tvKzFEUPqt10
         bJ0xBdkpOZP1zM80UoePsBkfC7XNuhs+XBesFtD6Cqkbu6F4bi19ETN9QKFr9hOXleuN
         znUeY6Mgg7PmIw2l6FPOnrna5cBv3sLSkO9IGscvpKwRGeNdygS6jAVJDR0qCK5mk7O4
         6x9wibZ76NVnfy28t95efQ6aFVD6NqhMXzYl8nN0qZ0qyw2MjkEX+oitaSf5HpEERwLj
         xr2X3LEkrfphl9ZbLqpX7heq9RO+coU85vcw+C7TPtSDiYh35Q8PmlKCKEzd8686UBJd
         7Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881414; x=1789486214;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZuDZ9h1qeZ6Gqge4noLqMtRGzhLKhgYqbv6QyArgpg=;
        b=mFKj9dqqIhEPrd8f3Ka4aBDPKQGm8DoPXz+oj+JLKI8P3YjkTmVvA54kWyAD2dq0gT
         V9lIasSzVDVXDcEbSHEFgr9dqFrxpgIdBFr4r7LIKYWwSdM8IswN1fYLRZqFO101WV74
         qIOUgQk0otOJen//jAhsCDpbjaXQ+K/jRnw2lXHb4JwzdgsLfiLQd1VnfJ/R555tnbfz
         YWaqEA6mOvwKX2/9IYCh8ldyHZIo3G7yn7PyMYvHhmorymwLYVbUt8JLoNDMTJh75sFS
         QfObp2eGGx9dHiWEIt6SKjoQL191SCTbn5tzGEXk2Xnk3TH2LlP49lNRO2VYPNbcHZNA
         xIUQ==
X-Gm-Message-State: AFuF++kT368at4tUuPsJczbUEhoS9XjCnGDWylYw0ul8Gg1XZ2KVUYe/
	ko5YePXzGhrwul49fE3b15fZJJQuhHYZWCxM3gfyCoKFmgdLn7WZqIxv6X7HQ/ey6IF8Kz7cyFG
	dG9438aeMSeYEBx5y3tdaZ+aP9hgiZNGR2g==
X-Gm-Gg: AYBFou0v6GYjA7Qs0TORofb0+G2uiTcGa59WzFFGUPjOUj19vraKVx5OQ3jq+ObCkk5
	6GXEFtFiRvlW2lroGoDnUsocIeo5wmZT/zj+PEcNNp9/L4f2DlPAtY5R7exA8vVohaMwO+UA67P
	yKsYlfQ34KQ/Co0Pds8Mi6+SUAh8O7w4fS5kvejPPlpkWtGx6F8iEuTbWZW+f3TkGgi1q+Wpk2A
	IdA2MUiEWSchnUL75ljtHZaUBcytMKrOSodx6cxm2uInPbii5w0QygzeNhbIDYCWIhoKynPo/4j
	0aEdXsDOI1NFEiGN+2UokBewmXscmgejfR+FKVPaD90P
X-Received: by 2002:a05:6820:6ae7:b0:6b6:71f7:ecbe with SMTP id
 006d021491bc7-6b6fdfb58dfmr27129684eaf.18.1788881412512; Tue, 08 Sep 2026
 08:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908144341.17206-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260908144341.17206-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 8 Sep 2026 11:30:01 -0400
X-Gm-Features: AcwNN1UIMTLRUF6v4-5IJNGTM7etGbb9bIzrte3urA4vfJOeFfs9y2175JeF2pw
Message-ID: <CAEjxPJ4Ub0aBkD+s3VU+4_KKLZcGpKfrSro66KX7LzXV36y=iQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: treat genfscon lookup failure as non-fatal for booleans
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com, russell@coker.com.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> selinuxfs.c:sel_make_bools() labels the inodes representing policy
> booleans based on genfscon rules in the policy. If there is no
> matching entry, we fall back to assigning the well-defined security
> initial SID but propagate the error back to the callers. This ends up
> producing a fatal error during policy load, which can halt the system
> on first policy load if enforcing. We do not treat similar genfscon
> lookup failures as fatal elsewhere in SELinux, so follow the same
> approach here.
>
> Link: https://lore.kernel.org/selinux/RvCmRlQYQ3uewSzEeY0utQ@coker.com.au=
/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 292302eb60f3..7ff2ba6623b9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1277,6 +1277,7 @@ static int sel_make_bools(struct selinux_policy *ne=
wpolicy, struct dentry *bool_
>                         pr_warn_ratelimited("SELinux: no sid found, defau=
lting to security isid for %s\n",
>                                            page);
>                         sid =3D SECINITSID_SECURITY;
> +                       ret =3D 0;

sashiko correctly pointed out that this is a dead store because ret is
overwritten with the return value from sel_attach_file() a few lines
later, so this patch has no effect. Sorry for the noise. Not sure then
why the policy load is failing on that policy.
