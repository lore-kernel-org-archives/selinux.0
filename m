Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF824E7806
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617811; cv=pass; b=dBTuP+70b9NuPWjp0KRWRHfCgyjXgiQdJ3VkMtqRwqDc8yqRdd0/DYl0LdL2ktd6oQZM5hvjADwI5H83Ez7a0KWfx+XlvzaVjmxol6HyHmxsBiBzRAbRGPXGi9eS1WaazLDaxKHqomeXhUFjSOkp69v7ufe2pXrANFtNKdQbQY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617811; c=relaxed/simple;
	bh=Qi2SiAdaI91/EhYOc7umYLfcD1fVVjKsRycq182dSck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTYVYUpT9yWE0x4qUr3cukWEDk+jNdX+T9RbYJU4tBeTF/kbreTBUiOSPeRaj2GLbeKQaqQ4xBJfhiPGiJ6aWcLXkELlO8BkQh3ghwOH8er6jA4+qe31dl+oYmQHAtTDHsrfrmpK+Exx4jZEl8YwpFtgdQ9Ng3aQZQ0/5J1aaL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAS2ts22; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAS2ts22"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso24694717b3.0
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790617809; cv=none;
        d=google.com; s=arc-20260327;
        b=KClSrektQDiKk7qUIkUDqxZSL07iYYh/LLBx3vfEJqNkBBsCLTlE2AgVLVKgwFIyAb
         IUtGTX54aKvi4CoYRrjhXNjibQ9K1TvSVEhB3RqZTXt+Xyt7E7AjzwHVs0Y/lNSjBdrd
         bI6bh+8S+uB/qyMVxLgtn5UmpSgjU0ttG85j6UwvOErTL982XJQnObEMiitjjJoFrTW/
         A+0WU6bRHufOG+V1O7JoJLEFeZ/uPqTxBb5x2iHBxTrqLhgD4hl6Ok7hKLFmCmZOXF3d
         zdcN4Pj5AOg/MsXAcct2ab8Tv6yJiHI6NiB5mrKplZS9OFsg6hEOsH/nal8UqCgT5Gon
         PX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qi2SiAdaI91/EhYOc7umYLfcD1fVVjKsRycq182dSck=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=Vu7ReG8pLAQwdj/PLSbTAvMevl8TqWOsect5OiGRm6IeSpuhQ+1nGePOEQfMKibdD2
         5wj2qXiLRm8QccbqEQQJIQUfDJzDCe18qdZPTSZMwHIXRH7YZw8Vb2jDwX7mUfD8Aoz6
         ouI7jmlECd9l3/uof2msOLL/YHGF3TOqZdA2QMKXFp54OlWeQqP7hNuMmLn6jLLEvwsE
         wUHmv3EYC10YLAX7PgVSDERBwkd3P0s+svzcAZxTLhZy6Dg1KiLB+WJFbQKJvoXiWEtp
         NH1d5j47J3VDVfPc57ynJPGB6oRoA+ertMhG3q7LRscTy6I0qbEiILCcOkHmGhvl1mQU
         VcXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617809; x=1791222609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qi2SiAdaI91/EhYOc7umYLfcD1fVVjKsRycq182dSck=;
        b=YAS2ts22xsTuBUADuP6+terRYunEkR750aGzGmuynS/PDdFxQA+4dPb5JViERq1Dxz
         hQaMQARu4eU287mhPZfs9ZJhtT2xwxDbIbjDwffn5pHJ+lC64VHj6zsAklYBk0h5v+U0
         PX/I+nQtmK8HgBEcOUSv1kV1f0lr5WXVFuWxmJwVCzzcm+FVJ0toM3ab28gD0BMQzZ+W
         s+eVwasGcroN7MPPOfEyUFdVv50CdMSXi8sXlFgoSR1Yjl/Z+cf6cfDqi1xs7ZqJtdOz
         ydBflProNVcHIaK5B8l2CTk4vbIMXJ0GI0NIyCnSa2xT1mvMrPTTCg3c6VkwQjn67yBf
         tllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617809; x=1791222609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qi2SiAdaI91/EhYOc7umYLfcD1fVVjKsRycq182dSck=;
        b=iD+8tnp7eQ7PZR/Wj0Mt6nVIMcPe9bi2zSW3sPscTjmufdy32o7j+hXJj9FB/nhldl
         qqGFe1afVwHHa1lwa7uHfnQ9eWv8uiT8zc1knVebAN42VlEM+ISsfJ73YtUKejmzLXhn
         6jci9sr9c2bcTdkbSJvr9z8flDHGLvs6Rng9+wkzIPAjvmy2ViuvBCGrb/HRmXa8Bzmk
         aaYimn7DFfuxjd4QPtWkFAQK0RkYG8ndiryS0D7mRfR86lhR6W/PyZo/u7mDf0eqo3nz
         SPSvfQ3YBg4m44zJsZBnVC5n6uyX8K3duIs6bzCcSah4R+aRrWU3WanZ1eQ2j9bZu1Qf
         gIiA==
X-Gm-Message-State: AFq9FYJDnYshZLL2Egg3RllXquqqm+GfYacDFNzyHLoP+nuPQigUiIr5
	6zpbEBvZNr+MJVog0VCeoLInBzUYeCd4Ir8zXWWwUuXxXQ47/GID/akI2gmoisRiTVXekDXvg2r
	bnlb5e6vs51xIn9/IbEaVNgth0NniAVFyPQ==
X-Gm-Gg: AYBFou2pLEoLayih+3KC0dMUMpta/89fqEqBLfWxhToFHSe51SazBeCJTukfqYxdrdq
	MDTpSDKlABWuXBiMEdWQQ8a3oig/piG8uUlC3knlojgRV7Kn3IP3bezdLrw3DcZYyZkEVmfaXTI
	h8ZOVSB9qafeKHZZWOVH/d/SvXcZqZKU2sI2L6tofy9LILWl+ytBAHQ/Rikjifs3tj7BdE1Pvb6
	mzk1bpUkMjCiT+2KCVr7tAeyEl1gklcQ10u4js5apObNrdPs5x+FzcAlTY0U2AqBbZwKzEQOokm
	vUYjik31tWuSpbstvGqaVe8EAoC7nvIdxzeI3ycg09LtU9L3F1njaH1fofqEMC9mYg==
X-Received: by 2002:a05:690c:580b:b0:89a:63da:cbea with SMTP id
 00721157ae682-8a64af3ab28mr56889287b3.48.1790617809180; Mon, 28 Sep 2026
 10:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de> <20260928165253.2388012-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 13:49:58 -0400
X-Gm-Features: AclHuK91J7tq3MrLafc3BUHNCgk0n3a09qePVSBuEfeOgmx2IjJTsWvsaZGfR1U
Message-ID: <CAEjxPJ7HzmQz5tfwCgru+qWNLpC4mHMKzQsOXKhuGJFUCgorRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: bounds-check role and user membership
 bitmaps at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:53=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> role->dominates, role->types and user->roles are read as ebitmaps but
> their set bits are never checked against the role and type symbol
> tables. A bit naming an undefined value is silently accepted, and an
> out-of-range one is used to index those tables later; in particular
> role_bounds_sanity_check() passes such a bit straight to sym_name(),
> reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
>
> Validate the three bitmaps in policydb_index() once every symbol table
> is populated (roles are read before types, so this cannot be done in
> role_read()).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
