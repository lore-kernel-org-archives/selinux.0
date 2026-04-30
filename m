Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2962264B0
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777586552; cv=pass; b=lsLV1RUJLG/Ri2TdcUpPlmp9A6QBg1Yh5bAd4NiWAEhPu3fc04HrHO7YtK5cJqbR2qCYlpkTcMP7e7Wb8buJvb13kHSk8D+YXcNUUBc7Ra0xB1oDHox/U3sJklSq6DxhUSl670J7PkVa88Fl6IEMqc8xqXRfyE0o1IYAmhgltNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777586552; c=relaxed/simple;
	bh=vlMOXgGWLfytuV3Vt2RuF3o8b+T/OKcU6hTxtb6Abpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFGuC1HqYraE1qj8YdxOR3qptB8e8+5jha0lOTvLqoSJZBa9+IGipxTVr/fquq4cceaJMA+6v/TGcwbgA2HhKl0P6c+swcytmkJHWrRK98YEtFxXQaAHaRMFZamwgvpbSw9umFzBCf/BcH6G8d6AvzcBIBhEs0uL7wWRAB+PLtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YaKpTwHC; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YaKpTwHC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-356337f058aso902993a91.2
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 15:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777586550; cv=none;
        d=google.com; s=arc-20240605;
        b=LtBlvmzoLso02PVC+uXeh1SjuW8G8DpHYq7R/aV5DoB+HHmuu67Cg5dMDAI3WqRcp7
         JbJpfCaMVENrvO0p5VzK09bKad5nu9j7PS+RJKi6ZFR85sYAnalgMM1mLQpezWP1wLzc
         lkIhY+RPOY+mCd13VuK6YNSoZGfPiFDvjQ+tw0RtNhN/agPD1wXZ6RjCRiGThdVoDC67
         kRCL76LRAGPBKlNkQUTUOVNDWMp92BFbtkrFeFl1fX72P3xxvfrViGAbOx5z8X+f1IiC
         Jgzio4uXU23ErKcMhlRLGf7PLBiYJc46yCc/pqpm9U5TAQayk9QbZ4JXlcl7RPUx6iG2
         1eyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sVPteDPYR9EYuK2K0N2SfF6pFWpCmjbSKwSaYqX6/Mw=;
        fh=vphYyh+rY/nE9Fu6WHIKlyu23+qIwpyAK04QfMXpFbM=;
        b=WIX5UbLVBynrWANnXGwOMRaxne+/guk0+eQWRJrU5xpx7WCuasjrgVs7asQRdJebNg
         uQv8E6+0JCuXSn6sOi+/ZfY6rV29NF9+v7oqHP9Xy8OxfT12RETuRHQ8q4bqkhsxF2xx
         yxlXJoQf8ki4xb+kr81SfY4qnT5l2ulhMcYNOYKOmfNRgJwXZOyN6gUW0HFZMdK7b/BG
         /4yl4/azvUBnpGH/tqArUqdrL8oXuodpUl6FzYJw9sIZkDG8ylfym+6OPe6g4IxD9cAh
         yPYYJmNqbI+7ws4o5kNRnOHrih3zTEj0DYtybcSCb9AOQldm7fGm1PXWvHoYbkDjXwqu
         Xayg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777586550; x=1778191350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVPteDPYR9EYuK2K0N2SfF6pFWpCmjbSKwSaYqX6/Mw=;
        b=YaKpTwHC8lkgM14BuuxsgCY6MK1EGVoE7VqZhwxboOYYQJqXu+ogLO8WILpGQnXu9O
         +MCGX2S3l+nG/ySrUCXqBV6gjhZQaRE4IExftYfYPLm+PKEjk9DcNhePbxwdmghAOCeu
         1YJWDPpY2wndiZFwq447DjdfaR9Zui6U0A2lfETcUiT3tzgnu6RQkDfIztDoymQ6fZdl
         ti9AUA7seDhYFoNEZh+GLw1FvpnHTVj98zsDQDAbFNoGRPzvmrkBrlFLuILFOZyZReeL
         oPn4iaZHbT0mP24LN3vf2OkYlxFyBceFuYT5Ni1Eai8AZu0tlfVHfLGZ0AcG1L0gzBsp
         fHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777586550; x=1778191350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sVPteDPYR9EYuK2K0N2SfF6pFWpCmjbSKwSaYqX6/Mw=;
        b=qCRLra0wDSkxjKTmL44VjoJ11gBpPQs/x9vFumKfo3JpnlHkYTSsnPJsjTpMOKD9C4
         3PHxqGitM8laqFsNQL+wQYCjJ4MrB13o+Aww7MfpXM9hXG2pmvxlofm5pe9stH5uW6Q9
         KiGhBd+WowzzKtGusJ8R/uKFUrXUK++xItoS0VLXky1KEpuKcVZUt2dvJBd22soInnYI
         RTiYuWQx7B6Ccq69hFQKTz8/eyk+mVskaXbDzPMf/TmYfIiw9yuG1oZQouSipgWqNb1f
         /hTpg45TmATZmiOpgCStB1JX50rN+CajAslMYiqyBRPdiKHqPeZDYycWGrSirlVVmX0+
         RH7g==
X-Forwarded-Encrypted: i=1; AFNElJ89JuFh82AEspfYiEHIQU0ytkQU6Bw95Cl4paYk6VsifGaGrL82RBOdL2UbFL+eEHq4vGnddHMK@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZ19yUTiwWg9C2vuLST1T55LvffvooIt215c4eFBF0TG8rKs9
	+OULozYPHrzJbCJcUjm+k3hS6BVLJq9pstmOyuI063Ist+6aKc6x+OFRxYfAHn67UJcUQil1rJJ
	aE7KslnwKFFW1S62jCxOnQo5+vn5XoWUaAi8fkH9x
X-Gm-Gg: AeBDieujFVFdw283AV1+Rc5zir9ibaXZobxm8SiNjmKQaiHVdWUGATf7+rhsc7bTrGo
	Uo8xxTJjfGOt9EV+UhQ4qCoF49dst/GD5Z984TxToo9Ypdrd4CgEwjXu4tuIysdtJlttoJ2pCgF
	rjw58le1l/CgI7L+E06n66vNjjuGCIW6lWFRtoLZQmcH/Hw7/tJEKI9U6jnbHyf14zFAc+gPD68
	zAqpvdOvbOLkEUtqjUwhrZN0w0tewFNm7InX0nbgjX5SUJJobbKtzcC7DPrnGoQSON+JTaNYwq1
	NSWa/B9wr9OtDiGANRng1dzDmxB8
X-Received: by 2002:a17:90b:46:b0:35b:9894:f6f9 with SMTP id
 98e67ed59e1d1-364ef50a2abmr375427a91.18.1777586550052; Thu, 30 Apr 2026
 15:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430202033.1865-1-stephen.smalley.work@gmail.com> <afPD-AGMyVacgwDK@14-5A-FC-31-E8-67>
In-Reply-To: <afPD-AGMyVacgwDK@14-5A-FC-31-E8-67>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Apr 2026 18:02:18 -0400
X-Gm-Features: AVHnY4K7eoELAhm7-iySynM7QHNhLloh7KcXzrNvBvl22tIZmnIGy5fvgyvjPWc
Message-ID: <CAHC9VhSuYyAAnBv5Rx2epOZnnGSzf2ZbCaroC6V5c8sznLptxA@mail.gmail.com>
Subject: Re: [PATCH] selinux: tighten type and boolean validation
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 5:04=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
> On Thu, Apr 30, 2026 at 04:20:32PM -0400, Stephen Smalley wrote:
> > Tighten type and boolean validation during policy load
> > to improve robustness in the face of ill-formed policies.
> >
> > Some or all of this might be redundant with the patches
> > previously posted in the series linked below:
> > https://lore.kernel.org/all/20250511173055.406906-15-cgoettsche@seltend=
oof.de/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/ss/conditional.c |  7 +++++--
> >  security/selinux/ss/policydb.c    | 23 +++++++++++++++++++----
> >  2 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/co=
nditional.c
> > index 64f1bbb8caa0..342153ecdcb3 100644
> > --- a/security/selinux/ss/conditional.c
> > +++ b/security/selinux/ss/conditional.c
> > @@ -357,12 +357,15 @@ static int cond_read_av_list(struct policydb *p, =
struct policy_file *fp,
> >
> >  static int expr_node_isvalid(struct policydb *p, struct cond_expr_node=
 *expr)
> >  {
> > -     if (expr->expr_type <=3D 0 || expr->expr_type > COND_LAST) {
> > +     if (!expr->expr_type || expr->expr_type > COND_LAST) {
>
> Is this correct? Previous check included the '< 0' case but your
> new test omits it.

That shouldn't be an issue because the expr_type field in
cond_expr_node is a u32, it will never be negative.

--=20
paul-moore.com
