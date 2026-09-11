Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0213B4AF9FA
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151527; cv=pass; b=l2/t3NlPfQbRdggWWgrQ5Np1MFJkiYrVbTLqpzloepf+8+575xN+wGWM6OlrR6YtBsvItl+Fiby1KpaHxVyjoxw12kSlLhhkryHiF1F0sEqUvk5aqFdQVASJ3qXGHZqUDK0/9D8UD97uUJ16jhQ/5F3WcxIIFUXZmJjtsuTgrHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151527; c=relaxed/simple;
	bh=jRbhfFBcwrpLHj4cXRbLVm91f5kIHrwbcTOUEIa+FA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sfVnaggpm8+YZLj0NBD3EFm/9oyB53ax+Rg9E+x8F+pujMXwelAA53aR1Bu6XnaU/6M9gF3OpFYxdx9OrApeRKIush9HahhfOgQSPKMaeY2vRfXL6k2dTpmEb0UlShAzi+Nc5Ao6xUW2vvxxhCId8fmcE2P0YjWAb+wfGGl4pgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=datkSsuS; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="datkSsuS"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ee4399c3abso1503161a34.2
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 11:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789151525; cv=none;
        d=google.com; s=arc-20260327;
        b=OCwK5y+jjqom/ySUcX7NKJT4x+ipB+HhBeqy/rkLIdCpgBZfeM8Zsrivd7gI54OBm6
         8br/GpHsIdqv+mevqGq7gNh7WhIH5n7+VCimbSSyfhALVPvuK9Vn8MRWCF7Sghehw/I2
         F/weF3FFgkNr0/CmvP1gTOcLNPx5M7g2xU1zK+5mbhCpujaN9qLejeLFG4K7eWjEh7SU
         8pFuhrryKusUTUZr9MwjbTokx7EKbwVtEAn/5N2yL8UAl0H3klwAEb5KXcA6wVtQW65E
         hqpx0IjueggoGTwl5R+5j/CTSHOuQTOgqEZlQA8xbybE80p+wEywhExqCqsT/EGv3NTt
         +Esg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FzS/LM/HOeDqjMLfEw5g+XD+fjjKfmr3CKzQelI5ASk=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=DzuYOvkof6H7FNCk626ksMgPUR8Hxfbvu4Gb26wYlwFGEmGdHNt74ea2FvMAupFXhC
         oCJf8qgDH52b52cdeEoL2Z+F4k/L5L6dx2rWZANJNJgO/oryB7H6EUN05L2nDYTLHSGe
         AjNTV6OohRvSvWDtp2qaNLLnDVJrE5oNLr3rPELE18SKfr3LJ8uJMNWmQrhQ4s/U8pw+
         /ZcBVLzrKVjFis3LLzdXmaJNhE4Iz8nVqGszPlJdt7srRu63UQwcdXHRVROq+mfITfRx
         zwWfj5dLKYtrzM8n2R2rofig/dJItJf1gv6Wrc0BZNd8HH8AnLLeYhW2zzg5CCWQxNCB
         4FWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789151525; x=1789756325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FzS/LM/HOeDqjMLfEw5g+XD+fjjKfmr3CKzQelI5ASk=;
        b=datkSsuSLiMSoNBUDGQa8iyqyJm/bu48BPvg0RnVZMRYyjknfp8OvsV3wb4V2uECfE
         XBvYv4v2+0gcljiA/HqB7Y3OjimuEWXBbO+mjwG4VJf19eDHQAfFPcXT+l8tX/Ypn/mR
         hMu4ymICbwXUiY5U3cw4hwJsRS2rKNpe3DPhgEia1FTAgq+aFKp9IYOgSZt61+8WxtxP
         /hyhKbYJi0pZLSFNFnbLsnr2dJrvpCH6RklOwXrbpcoUJsFrz3mVudK081f6FqcbOPS1
         0traXAmkp12ARpVvtYRwjc4R6DFJv+3jO8HsDom8GVjEgTncTPgGtir/bBgEQHTKA2zj
         n26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789151525; x=1789756325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FzS/LM/HOeDqjMLfEw5g+XD+fjjKfmr3CKzQelI5ASk=;
        b=SGL9qklwHj0Y/UDpWawR2CzskBfALbiWa5iXJyHrteAhVny2UFVGB5LtYKgBzfAm+I
         ZVDpwJCaKWnJhFcFeanAIpIYDJUXOQOfera8z8m7V+okpnPgEZJriFDAd++kO7zYdZ/H
         1Hrgu6GHfZLWToPbpaT29hAw3Om9Sd6ER+EMTpSwYBvZyvgzV+MIh7TCb8k78TT6oyBY
         od9cgGXe10Yd8slJoncbvFfbl29+8/J5GMwcSbmz8Xgs63Tl0qsZbeI15XsvEHevPGTz
         +CHoPRlOhiDftedLNbzHjfsB9w/a5Zl3UheTfVfeUwh/7r958jNyBkQhwc2iDNjcgfkK
         7n3w==
X-Gm-Message-State: AFuF++kt/UI9yZS08NcArIBNrpWd8i9q7goRNr+ez5JgTvTLkOcY9zTT
	PxYw6sFAZHtDacZvIwrRYihZUenfEcZtSrw947OIfGyTrZRpONIhuUs8r3HpUZ6wvl2TTw2TYb6
	ax4BDaHV6W6O042ryoRoMuxaGCtEk0T51tMfm
X-Gm-Gg: AYBFou2NGoGemGnylncRGim0M5l7aJJS5dUKPt0AEiqB6qyWgLIL9zQWqOvmjXuesgq
	afMzZ0LZ1+nv3lee12r+MSU9raTVQxZcVE/tgK02+9PCYQLnUKQycvUQauW1onm52CBv9erXAYm
	8yZbyH62mxwfXZu4AQSadtHI9I/pPWgw4x3UoFjcdHTbk8ie8r8VUImuu2Wzkczvtr+OE1onM/+
	2ogLmrTOV/rMX9rBRBYrSFvlzdpcHMIs3MJnR6STT57ZnfeOQrPxmgpcw8b2IHB7V5E+zmURcHV
	oxlrk9F8nmRiJmd3yLgFnnu3y3YCDUKm1+bkSuJtE0WNplKom8Ur1To=
X-Received: by 2002:a05:6820:a29c:10b0:6b7:83c5:fdf8 with SMTP id
 006d021491bc7-6c0bc8bf79fmr3223806eaf.57.1789151524678; Fri, 11 Sep 2026
 11:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911143226.17807-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260911143226.17807-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Sep 2026 14:31:53 -0400
X-Gm-Features: AcwNN1UcUIGK7CO5Eand3yROCG9yu0w__-pGIgUNAgR8IDgHecP-Ppu8iXSWVI0
Message-ID: <CAEjxPJ4DwW2dKKAd9b7Yi-D+TrpT42B8HhvagZNQYP-AHH7n_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol/fuzz: add POLICY_BASE and POLICY_MOD seed
 corpus entries
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The shipped binpolicy-fuzzer seed is a POLICY_KERN policy, so
> link_modules() and sepol_module_policydb_to_cil() only get exercised
> once the fuzzer happens to mutate the magic and type fields into a
> valid module header.  Ship a small base and module policy (compiled
> from libsepol/tests/policies/test-deps/) so those paths are covered
> from the first iteration.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 only changed patch 2/3, not this one.

This series has been merged.
