Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7FF36C9F0
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620794; cv=pass; b=e6DDT58M+SycvO/ppXffPon+cpEKfglDyKf4KQNuDGF8HRppIe9tSMmm2lixuaNvJAvClPgHc7pYMrvS1+0o7cN+GlP65OMeo6JxU3wQxgTiBMx428pdtcTrWQko7SwFn1sw1JYF49Unh67zgqFTYMm8tMXMMaLP7yjGHVGAg+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620794; c=relaxed/simple;
	bh=Heu9qLXtWaUUIgmTiAmg2SdyV7fHSibHlEL34u0w1uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQSgdyaaVD91pdNos8oidOERKyGzZSECRexQGuDn99MwchwzXFxMnRl0zF8GN0XGag5/bqQzvK83eipOt5QFbG5ASW1zgyl9x4tk4y4eAHOtBvN2OgVH35mfMmTHyFmFc8R50is+Mad+t3REgbMtngGEJwM0fLRLzPj22DCZTLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRm33ax+; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRm33ax+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36da151a152so3343117a91.1
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 07:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781620793; cv=none;
        d=google.com; s=arc-20240605;
        b=enA2ZjMXHY5joAmk82sFWlM4OxwkEnUk2YwJnoQmFk9NYTBc/S62HbuBNuEY8PGUvw
         jV7rlrna09vPtUeC12I+Rf4oN91/RYdBsow2E18hInY/HyV8IFnDRA+2WUfzAJYPBfkv
         tq/E+kpsuqLZKT2MCMG2OiWHCykFPzPYUsgQlYsUoXaOMMzGxWr5dpNWPvGZj4UVgW4t
         4qnb2rywzTV6fy+yn/TaQVAiDfkg4BWDrx93DgNz6gjpitFgt6TtictEpeIek+UP7glq
         E6AkIMUMRJWGMYN9eOPoUsdO2kiwLjRsbFGe2rdmFH28OnlgxqZaEKc7r/HcIK/4ulaj
         tqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=blZhdTUzdhyq98DfZEYMdZ3SD2mSK+IMdSkO88+Kg58=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=E2nLeyaLugeDxnN78Q7W6k7QdVv3iq8zTObuBPNHcDKa9YvipI9/0NCGBmzN05Ks2s
         VJTYuvacWDFjYEUoFXttvvMSJdH2eC8ujii5rw05AilO5DMqYArcWDBuOOhg99p2s/f8
         85d5dKyZnLuILXjjX92QMsYXz+gbsJZF2/JYFW1DxFdZuyFfRv7WExOVk9TL1N7D1b6j
         v7ZTus49prqwsCcwAlTe7Pce3LpiIIikEJHF4cboOrmnQgeUjB7pioXnfaBTTSBMVOpc
         r8ssdwEmDVUwN/kokRz4QOxTM3oFbdHDplcqUYIZUaxTI9Lnrf9BvlBiR6Z3ThQvQ6e7
         AmVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781620793; x=1782225593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blZhdTUzdhyq98DfZEYMdZ3SD2mSK+IMdSkO88+Kg58=;
        b=NRm33ax+YMD+jenS1WJGxXBQELY9pywMQnlnMy0WhKyp/0DKoEJoufwNYbY1DZSDJF
         Pgj+B+LLOnbx7Yy3VGkubMl2CdzGr7753Dc9yGWbXDbudA0GkpguxWhSjl8FoJKX+iv2
         o83eu7a6JYz4upEsnaHwtLZQUFqNhymuOR3gxfmbbnSR1fILlEOrVihxtEMS8JMVbk93
         Oey3nKzRHndvvx6j97lf+ikJ3yUSzNbwuOtiM4dW3bTl2P2sVMrt+wL2OAsxNbShuF75
         oX3wr2UEUVQMmWuDfGErHlraFN2B3e6g051uPTdInNKecb6IvDq/uJV02fZb+v3tq46l
         9z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620793; x=1782225593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=blZhdTUzdhyq98DfZEYMdZ3SD2mSK+IMdSkO88+Kg58=;
        b=a+eyH9YrsM85MPZkTmAUCG6StjngiBkHxDQWKqeK5aMxH6oLYdo5k5DbRleuI0bDyU
         EBN4Uat1D3nTbA9PIiIljuC9b2Wzvp2kgShftTYxGlza63Ln6EJRFHcjt26r3DHYsfDQ
         f0+Iqy4eUvB2a5Hey1nGomNVZKhDT9Zs4WlXkKGQ6l7re7JSaSjFEqgS0UUz7b+wjLDD
         zYmB/dwcFl39nqefpiL7Ypw+4DgYswHE4GHFtQ9kTSG26kkRg6TBUIsrEWRsFSw4xBVy
         ++3RKAnwJKo0tN96EW499j0Id4qmwCANFe/kJPp5fmNoscB+N19vIYOrAN48q5XH5nyy
         jxzg==
X-Gm-Message-State: AOJu0Ywgjc+Uotldss35iAaAB8pVK5Sw7UD52bwvUuU/NLKmaY8BbQAB
	U71r6BjQZbk9o5oyQ3rBkQY8TF0Q2nnMX097fEHEH1HcUJyzpV3sW2zfIQN+eu+5VJp2i2oGDgB
	BvkXSGzzHGd+oWskq1BJF7821U388nVAMlg==
X-Gm-Gg: Acq92OFeUwZ8EZoTeVhmnjkdaqOCqyj2Htcr1lFPnt1Swbq2thezwJnD8o49YqA5r/I
	gx5iwn0jtpyVvtBDHDXR1jwsd+HzC1rKmfkWcnPSHFONM2vaDGSvzxoO/xSj3cYeH+N4uIHGSYL
	Ih3SoSQrW9g4lJrzwcVVw0h5fs7MR2Sys8G9qKipPlFmwSl5T08+/rHebFdMySuETZ1HKxX55D6
	OTPmew23H2O3KGlUqRP/glYnn0sCL4V7jyrbsL6XVUVkcvVVEcWjqDfl8TokrlKS/v5kgnX/0sP
	/exUFpI=
X-Received: by 2002:a17:90b:1a8b:b0:36a:5d1f:7b6 with SMTP id
 98e67ed59e1d1-37c2bc5d322mr15135407a91.2.1781620792849; Tue, 16 Jun 2026
 07:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616141819.37971-1-jwcart2@gmail.com>
In-Reply-To: <20260616141819.37971-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 10:39:41 -0400
X-Gm-Features: AVVi8CeTM4cKUNyrcBi1GtG920wB4it-pPA0AgtD0lr3m87bmumSGO0H_ZYfKC4
Message-ID: <CAEjxPJ5rpD9KQ7K7W-SLebi3N8zAE33Z=gaz5rWN11a7Fm8s=w@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Check for proper length of addr and mask buffers
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 10:18=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> When creating an ocontext node the addr and mask buffers lengths
> are not being checked that they are the correct value for the
> protocol.
>
> Verify that the addr and mask buffer lengths are the correct vaalue

nit: spelling (vaalue->value)

> for the protocol and output an error if they are not.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2: Use sizeof instead of 4 or 16
>
>  libsepol/src/nodes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
> index e3ad36a8..0596f387 100644
> --- a/libsepol/src/nodes.c
> +++ b/libsepol/src/nodes.c
> @@ -34,10 +34,26 @@ static int node_from_record(sepol_handle_t *handle, c=
onst policydb_t *policydb,
>
>         switch (proto) {
>         case SEPOL_PROTO_IP4:
> +               if (addr_bsize !=3D sizeof(tmp_node->u.node.addr)) {
> +                       ERR(handle, "Wrong address size for IPv4 address"=
);
> +                       goto err;
> +               }
> +               if (mask_bsize !=3D sizeof(tmp_node->u.node.addr)) {

Technically this should be node.mask rather than node.addr since that
is what is being copied, but
they are the same of course.

> +                       ERR(handle, "Wrong address size for IPv4 mask");
> +                       goto err;
> +               }
>                 memcpy(&tmp_node->u.node.addr, addr_buf, addr_bsize);
>                 memcpy(&tmp_node->u.node.mask, mask_buf, mask_bsize);
>                 break;
>         case SEPOL_PROTO_IP6:
> +               if (addr_bsize !=3D sizeof(tmp_node->u.node6.addr)) {
> +                       ERR(handle, "Wrong address size for IPv6 address"=
);
> +                       goto err;
> +               }
> +               if (mask_bsize !=3D sizeof(tmp_node->u.node6.addr)) {

Ditto - should be node6.mask rather than node6.addr.

> +                       ERR(handle, "Wrong address size for IPv6 mask");
> +                       goto err;
> +               }
>                 memcpy(tmp_node->u.node6.addr, addr_buf, addr_bsize);
>                 memcpy(tmp_node->u.node6.mask, mask_buf, mask_bsize);
>                 break;
> --
> 2.54.0
>
