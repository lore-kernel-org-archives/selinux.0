Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF227E04C
	for <selinux@vger.kernel.org>; Mon,  8 Sep 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365963; cv=none; b=ZlQDLOMCfV7Tzk3MZnwcymDdhRUyDB2PbIn1CDU/TVXQx/WJ18Ls0d/bAJm8iGc9Dd0SNFJpuupm201BPuLxoXiL0ZBe9VpRxEltlgAIBiUk7LWyjQEd2ArDU1egySrRuX6JmR1gsdj+YRQCeZcKcGxwFniO2YRZGFha+vE+QYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365963; c=relaxed/simple;
	bh=XRTx+EIPYf2U/8kH1WHhk+Pr+1repADusuxwe8OzR40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfyDFzSKgvYFw4154WWx/PN39OCyFoCe9ZhdsASJYOqkuKu06Kn7TI+G/g+RzhD2ECcvL1RWTnzdd1KmO0diE95ogDGGfWqiFIzGhSKjonjbonoDe2kq7tPQWPptfAuZ92Ibn0yDgZsbwV3PjufMYdm5JepNpt9P4xj6v5+UPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NwwlXF+2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NwwlXF+2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32da35469f7so87784a91.1
        for <selinux@vger.kernel.org>; Mon, 08 Sep 2025 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757365961; x=1757970761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2NQT+Mk3p4TSCxt7pK5wFXpw9ktcr0hQ9tdUnoEinw=;
        b=NwwlXF+2GLZv9OEZPONFZAH0prn35DQcA8xpLQXPmRs5wk7t16OIVhF34SSXAmHze4
         EhbUUQ/o+G2Kx+jyo6TPwl0WusU4pdkuz1NmPIENKUvkQSKbNpXY2IwlAi90i1dmngWF
         j0E18L4XRmjZEtPYOIH+CowhukKP4lZs4aDtGKYf4jzbqYVafBWWZKuAmiSDWkePnO6+
         uxd3tFSuh4wd7AHyeIKwMYM84tcbmy5MXMvrnQYsliXXTMG6F2CdDZpAz3/Ce7EwAJVo
         O+xJvIRQhL05GSaTMHsq60jR8H/5m73DxDbNJwLS3DbsRgPdCXH2ljE7fbU8bEDDHuJF
         vF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365961; x=1757970761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2NQT+Mk3p4TSCxt7pK5wFXpw9ktcr0hQ9tdUnoEinw=;
        b=MTzb43w1pAvw1QEw27XaP50zmgvIgUpxv0SXOpCySuT1RHinaLDc4EPn5B7eNLzZGN
         IVvDhozz87COsPPHKnFF8wVFD7mll0dI4kdIWOyJrXzz5zZCCPSxO/LqZEca2QHDSjAa
         g6g27tup6CbXsh4rA6DKqGxGuNgDXqEWYcnNGZcHy/n4CWDzCBXWwtWwKDb8ZlqUJW3+
         dou2PnKjdLISx6zI465lvPjx8IR6VuSsFqIOenP3Y6hHBvFTpeOFe4MxgbliqMkq+AUL
         tBoL81xzBXSEFmb+SiSh9tBoWobWTDBIva7JxqW9nASeu5h5HqjD+p+06XOhMYGBoUgW
         a9+g==
X-Forwarded-Encrypted: i=1; AJvYcCW8sM4dCvvGHonEDMGTNw7k5tbGmdDhN+lfHdw3Hno85Rp6bdEmHQzyLm4D8nmIqOspg17iEOb2@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXIPSNOO65lXrDhnIXhVHcEd9w9IamdHwlyqkgEGDIrp1ymt2
	OsV17maVEE+kU+70ew8Ao70wcD1feETn/eONQwWlqFc8Zs03bn04wegekr2f2sqESZ+n5CRRvLr
	1jROwS6hDx4Flt9mSCBztbZdceosR0ZxVx7k+kzGt
X-Gm-Gg: ASbGncvFY+XI1fN1jEuZ2U8jwRxTgK4KVulftgXCB3P/wl63pGKBP0kN7n1DFojTd4r
	/zG766A1nF3m0oyXcK/kk0YxW2MdPIManVsI3R3m3yrs0cpPgZakES0GRmLAF+R51PRCi84rd0A
	lKImaz7CTcMnKcpQRI5rbIXb9b/kDRqeM4NCaiBNCafKByoewssxrgX4I0qJVAltCAsVkSp8r8D
	Ok2rD8=
X-Google-Smtp-Source: AGHT+IF+BzdxpdKA4HQ7DSSEF6ppz8VTpKBNm20HIVjqV21Axz9rUCShq8QssdNHtSFg2qc+MCxuDjz1Saanyjzg7Ds=
X-Received: by 2002:a17:90b:1e51:b0:32b:d089:5c14 with SMTP id
 98e67ed59e1d1-32d440c5edfmr12330752a91.35.1757365961252; Mon, 08 Sep 2025
 14:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
 <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
In-Reply-To: <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 17:12:29 -0400
X-Gm-Features: Ac12FXzddwEYAqNyhtf5sw2V7Z4CigwREJqUTu6_Er36SjqbkuSUTppS-HqFowg
Message-ID: <CAHC9VhSmwuwvTWc+QSbQq3my=D6YuV5bUu3120_XXH+_6ei_cg@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:12=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/14/25 15:50, Paul Moore wrote:
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Sorry this took so long.
> So the patch itself looks good, and can have my
> Acked-by: John Johansen <john.johansen@canonical.com>

No worries, thanks.

> with that said I have done 3 different builds with this series. Tweaking =
the base,
> and the config, and I haven't been able to successfully booted any of the=
m. I am
> not sure what I am missing yet. I working on a bisect, but its just a sid=
e project
> atm.
>
> Until I can get a successful boot, and test. I am going to refrain from f=
inishing
> out the review.

It obviously built, booted, and worked for me, but as I mentioned in
the other mail to Mimi, that was some weeks ago so it's possible that
there is an issue with this patchset and one of the latest tagged
-rc's from Linus.  Once the IMA/EVM patch is sorted out, which I
expect to happen in a day or two, I'll go ahead and do another post of
the patchset (complete with the usual testing beforehand) and when I
do I'll make a full tree available in the cover letter for people to
review/test/etc. in a known working context.

--=20
paul-moore.com
