Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381A3A874C
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695764; cv=pass; b=DbI+mC7Ht0jtaLTYvn9d5pxyiEQuMnQj+sOc4MhmPCvbpRxEY4ph1MpY50SB6Hyfc0e0FqQ4Byqw5rCIxpGNH6Fz6tWWwi917vItgRsfr4G9IRfC2lblJQTpKzklB2IZkyJn3bYUdvk+GZgxNoKcYzRlUCOd40g+H1T9wXlBiJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695764; c=relaxed/simple;
	bh=eHrn4kq+crnc4EGoM/Yh4KUAPAoExUfY2K1YWSDdrVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1DT6YFcalZ64j/pVZDn1wSpJ7vWZcvOaKKt2wD8jSyvm3tL7HqA+1WIdJWajs7j8L4FfaPza6ZZvfGrfObjFcroNoWiUsHb82Ol7f/Ro5fidlC3jbikav2iaxjwGvdnvnnEQyhsv0FOeJxpP+tjrTfpD+gm3GAp5MaAC+mEbvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL3xfdoz; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL3xfdoz"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a87fe69060so33651477b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:29:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695762; cv=none;
        d=google.com; s=arc-20260327;
        b=qFqMQrSNKld9MC1tLXA8mGMwJSuttGDi0JtCJPo8+WzD2QIh6jegDqrG1sf73jQoZY
         Rgbk91rMf0jVVvtIUDrOaue5ubvn3X8NTVCPXnSzQMIzfE+yk0MRta7CCh3r47mPiF3S
         BSfQcb8O9gk9d05BC3b+eEyrcVGnwy9gOHS1CnH2AYKxYqU+gu3TComDiGLWPQlSIXee
         VC35rX7ouqUfZ5bIO9plxko29vdxsc95iiMBk58aCwuzWi6vNQUzCriQsGMo1dLv3rz2
         0UTL9v8TN/1ko7yaCXIIBJhJgWcyh9XxHD84ulVCE3eIVIc5c72NErHd48uUjOGKMlfx
         lgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHrn4kq+crnc4EGoM/Yh4KUAPAoExUfY2K1YWSDdrVQ=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=oTyekAgyiz/Zs1rrtfRk1nroEMqhsr/YJ/F+waq1xQTiFiKWWd8XRcfX/I2lSOnaWO
         CoXgERhBxzTHXFAxGQX1OWOfMuX9PslEWMmpLLyFuxLlnautUz+8YfMqycw0XK1FC689
         o+2vNne6L87ROE+gdYVBKqaC8nswTNLUx9rey1pG3/JobOd+YwPx0inKJsppI3z0rv6C
         dhvpJC7djBc6ol4pvp1tw5pl4uwWI35ZeCWKUgYpGl0iczpHME1cRTNe4fI4nGqZG2La
         obUw0JlTpp8fDl+EmzmKnIlAR/8fXUXS5qt23trehVV06waT0g4vUQLGRQwERRue+ftB
         Scpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695762; x=1791300562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHrn4kq+crnc4EGoM/Yh4KUAPAoExUfY2K1YWSDdrVQ=;
        b=WL3xfdozcrO3h3V/EazOhjwE2JgrmkofhB8k9fdaBRrMd+ftN2phWxVNARbxAqCA62
         ClyN2Ywb/FuCAsMcuVwiRc2dwaAxLLE0wEPHAGg3B85Wejux71FpfPFHJ31ES9hyXcgZ
         Yk/sC01AeQtRKMhcc/edztSWTvC9/hlG1x2J3jS6Vz7q9bhEU8Z4uAHmCxGMwS3iiwEN
         0zMSXmJ6sJqWrYvsPMNy8eyUByhKgFEjmg2/e+3kQqbOjnk6/3WLyde8dk/9l4KTNG38
         Z2L3XzPvpeHIYt3+e6rFNpHx9rr0MzAc3uI7/y50SY3ffb7I0SmL/JGvqM1HGPPE0Q4x
         9zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695762; x=1791300562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHrn4kq+crnc4EGoM/Yh4KUAPAoExUfY2K1YWSDdrVQ=;
        b=yn/8MN/w+OCohpxft/LO7+nuiLBeZO/XlVGPoEnluC57DmQozPyoUGzkKAFOhJStN6
         QYL+SIUZNGLLrgXnP7oSaJeKOOsLL2X42Swj/1tPPKa7b2Yvyiw8AiahDHgfjZoFynk5
         hqICCXRVpVSwASpAv64zbT4tuxRRHAhTY1E4fGN7CQF+b0nooNx6Yd/TvfMrFsp/FzLF
         e/vKl6rCYecw3ANgYLn8d4J1uavKav1P6dXJNawJ62hHGBU686NT7UG2KcQxjDy4wCJe
         dOirgh/QbrH61yIHCFM7TRpdxXx0SSBvOHsWP1cV/RUbR+6YiNSRpwBSi30kQigBwO2X
         oSDg==
X-Gm-Message-State: AFq9FYKQYoqmcrpYoI6ra4MSwIaYw7PoN9T6pUAFhc2edKPzqo37Rg/O
	yfXhV3UIX5EAfi0h96t6wN7ms+tZge7z8mHx0bLOrAUN+zJm1gFYo4MP0zgDEAT5/qwbNQ7fbdD
	6dZEDEEiT+95ceypmYusNqbH6dyMBWSE=
X-Gm-Gg: AYBFou1R2k1OTUw3duYKtwqFnxXi+dmieX7n0yFbsxhEk8AqnFAz72iHq7FyCdafQBK
	BeluD35MKdCw5cOrQ1l06SolULqv4ceREX8RINEaJQ5IQ3PJEiJSFMaqKtVeJUreJ80qc8byEMj
	YjzqPFLvEjyfHs3t6jiMZpJbTvWGviiG9aYlHh9LHlGJphPrRYsgHDyWzo9223pmZpyOoUZ9YNm
	yxiofN+osBaOz/XT7YN8glU6Ff6wZZycy6yuYp8Gt2Hd6ujbQW7IlKvajyP+IlUe0+EZ/FZwDYP
	Kwx8LmmAsas6AqU8VMjS1q2/ygx5IcF7JBR+sCqh+jmFpTXy51FDf14=
X-Received: by 2002:a05:690c:f03:b0:884:c89c:ae4e with SMTP id
 00721157ae682-8a648610f98mr78009217b3.6.1790695761822; Tue, 29 Sep 2026
 08:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:29:11 -0400
X-Gm-Features: AclHuK8ZndbhmF60Ywt_AH8AhrSLG81GztTxdmUhC4sn3sP6LhGvs4OeH2uii6k
Message-ID: <CAEjxPJ6xK-HUB_vMJTfWvAxCShnR38WCC5XXE1sgvsLrbNjuSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/32] selinux: use vmemdup_user() for policy loading
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Replace the open-coded vmalloc() + copy_from_user() in sel_write_load()
> with vmemdup_user().
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
