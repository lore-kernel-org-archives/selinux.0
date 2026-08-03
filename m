Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F403ACF10
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787435; cv=none; b=ulA1X1oiealzfD+beRLjGmrNMWhimNe5bRDsPYm3T6kX3FaGcAL1fppFK4HthgW8bfGXB9ayBpoIpus7TjO2P8AuL6lHXdmZzrB0VGDCRvlzxHE6i7UY+TN1oeE/YG+MxMhmG/2TkeAWlpzHcLF1rXeNoT7yd/aF4iiRJPLVpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787435; c=relaxed/simple;
	bh=D516SGOh5LEe2YDu7Tzxgp/6hoEADOVnMzuWwzJQFro=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=B1RJJZgE5HIrOsCog6Zd09Onhr+mbaWHEQdXmdhuKJL9RIIBmUHwxyNnSzD/mXyvqZ+Did0b+4iZvNF2RMV+ZXuHi6vI96T8PJyERHO8IVTZZ8qjgQajR/dJzeHyY0ucYvPDMIrZE2fk6ga4wNLHKMPPANphYXmeZN8GRy3/fgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DrH1XR2H; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DrH1XR2H"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9061a795d76so33568806d6.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785787433; x=1786392233; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DA7FRPW6SbI40IUIoqyw1m2eYtidoQail71J/7sr0aA=;
        b=DrH1XR2HEKyZHmL5SpRLYD+0/7Wd9ps8nkCV9SagHttOsKa3ENa0moHvAjU7iNPEOV
         +E8rRDshgIyuY+Qa4RGKEXXpLK4T348AZvnPqOvGiluHvx3Yyl29Kl2sNB3ewjgIHlH5
         6UmfGT4cLoY9F48vZ7cM+T06L+r9VjUVRWlRu6f+w59zJ/1ezIELKjqU/oGpydK3DiK0
         rjH6hIJ+gpTEavssLTbuhv/geKOoIWhXUSRpvmNld0FbeASr2qILxV6bMicE1iV+DmXn
         koM25ZxA5FRTIBGhSiiGDrlCRGBoweJFgj1zN918vrbxtyrQplHtVyn6vNOWyq2bNlfE
         3aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785787433; x=1786392233;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DA7FRPW6SbI40IUIoqyw1m2eYtidoQail71J/7sr0aA=;
        b=p6XhK0hqc8ZpWQerk9czb5iwu1IdT3NoUFLucl9JXQkaQgwyKWBgHzK5V08bXaAYwN
         DLZ619PkyjSETvnNeMItptoIBumexCKlY5Zbj2nQ+XmRTVxbFCp3/9lwElaz9z/4d9YK
         qUDx/utf2as8mr7RMOZ6BPkdKwPnhU4QnFdr/S4fTkgpzIs0r+XzA8Uo0NvflW2EVyP0
         FSpKBvNFTZOj61IIURt4h2lDnHh7+I9mZJQahmX4pXNx9KGIGqEpMcqf0Or2fiGu714k
         JanZ7FluIlGze9Ty03E60K3APLan4Q4Hue87B90P73+kU/kSctjG6sWj32wmoHg5Ap72
         f+WA==
X-Forwarded-Encrypted: i=1; AHgh+RqwGuYn/ivCIpLodb1a1GUU+vTZHv/JVnOEIIBoP+JG8len0/hIUqbTYNV/GSb6xOsIaFxiHSKY@vger.kernel.org
X-Gm-Message-State: AOJu0YygYXrdySzjmocKklPayjysz1wRoSGnjVYe0pnn6IrnWBtgg3Xc
	q/C+q2vOCQavuDX7/OF5iLpbvZwBTJmdmLedJru2lccIhY+UOtOtHNd2YndaXsgWyQ==
X-Gm-Gg: AR+sD13xf60ADaStI7jpLN+67OaA1VVVYVCMxkb+n7PgNNbUUtyl45Dg+kH7ypnfhVH
	avftl7tZn1dGeSt7M5x0TvmD+IXdgksllIc2jY/xh+XU7awJ/tYI8qJ+920h2j31UqiIETA3wD1
	LkfQLY6xupyfCRUeemhk5L3O/nGZ2ukQcT9nGNh8TmXjiUQ+i3LIUnA7TDVlC+2PQ1m4Z1VKCYb
	TYcxirvqBr1xPO92zmoL7laS+b+llh10W15S2tCgpWn4KlibAfTiI1fBUhs8zT7TkBMd8PUIRLP
	e8jWUYcJGf1jkkU4upg9VbAjmBWKiyJdQWBSIRtOBfrNkkpMbNKxLo0G5NuD2UM+CpHzszYh7Qy
	ycDPiW545BjOE/PaQkz2xBVILehgq72guNZ2EhX0Wp+FVwRHt/lsCXMAjflpaHNfQyXUaenfw/a
	mKX+uNv0WEKD1JdjTl53ElO8PGBtpuzvW4rJDAV5UlyI8bltpQBUAfOPkmvyZOt3wFjGRPHCkmU
	ml90VVYtHbxSDzLuZyoB42bjn//rqo2Cw==
X-Received: by 2002:a05:6214:2aa4:b0:905:6e01:b9a3 with SMTP id 6a1803df08f44-90849712a51mr189306596d6.31.1785787432714;
        Mon, 03 Aug 2026 13:03:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908432a0ddfsm82522546d6.10.2026.08.03.13.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 13:03:49 -0700 (PDT)
Date: Mon, 03 Aug 2026 16:03:48 -0400
Message-ID: <b2121f481ef5f88b2dbd2a6070a91598@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260803_1511/pstg-lib:20260803_1500/pstg-pwork:20260803_1511
From: Paul Moore <paul@paul-moore.com>
To: Bryam Vargas <hexlabsecurity@proton.me>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, =?utf-8?q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 3/4] selinux: reject an unclaimed class value in  security_get_classes()
References: <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>
In-Reply-To: <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>

On Jul 31, 2026 Bryam Vargas <hexlabsecurity@proton.me> wrote:
> 
> security_get_classes() sizes an array by p_classes.nprim and fills it at
> value - 1, so a class value the policy never defines leaves a NULL.
> sel_make_classes() passes every entry to sel_make_dir(), reaching the same
> d_alloc_name() dereference as the permission array. The class symbol table
> is allowed to be sparse (policydb_class_isvalid() exists to absorb that),
> but this getter builds its own array straight from the hash table and has
> no such predicate.
> 
> Fail the lookup when a value went unclaimed instead of handing out the
> NULL. Conforming policies define every class they declare and are
> unaffected.
> 
> Fixes: 55fcf09b3fe4 ("selinux: add support for querying object classes and permissions from the running policy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/services.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)

Merged into selinux/stable-7.2, thanks.

--
paul-moore.com
