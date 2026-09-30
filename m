Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED53E0C44
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801981; cv=none; b=WmUxpEf8tyIY1nFD6VFfHqlKHc+7QunuGOvByoQI7w8poV3Sp3fDKdGctVY2raavW9Jcq9wLvJWMFWkE0NpPTMsSxoJv7TkQfr+g0jWErlb35ytNJXqNl9lOypBcUK/krH08sDo9dkuJXb94voCtEomMbaOIg7EnkiqjbbKiJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801981; c=relaxed/simple;
	bh=WG5Ehvz2j7TnqKoCcPMOALfCCblns5M5tt+IDWZ9ETE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=gb5KZCMHTtZUlQdLqtVtpYyHc85IwHk5fZHDQsYqeBQdEzwJE/GzdTNtTseLDjbRFtSxm2HQmVr98FSjZaK12diM5T+g5GS1vC7VZqBXEwMwqX8iEArLPuGHEhj51z4dHxXXfAlhufyA+CrHwNHe5qO+3s4ECHTsvzlRQLi6VBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VwBDq6gV; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VwBDq6gV"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939922847efso520993285a.0
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790801979; x=1791406779; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rum8N4iqJrLHYcsHVtRHizY5hZCyQwSijji12bcloz0=;
        b=VwBDq6gVSAMcDqbsxzv1pxCh9NjBWPs3ZicU6J4K82lzU0zWVxnpuNla+GDkKEVQAI
         KLWVvJgZgUn8UyhBzHm+F3Jne7YDFTFhJgQ3ygH7AXQKYgVCo5OSx9/sAN+2OySnYkY7
         eJIN/laTAIh/N6awvAUtT3PP8Cz/q82pR5hAwf0CEf8M8tEOG0MwF32MmLxDQH2OTmsv
         UXc0L9wcvROHg2MiA8DsJkUImmdnhyxnAruT3Ouec+8XnU8STQUE1141gqCEwwBuUfar
         un0Uan4bo5+2lxol9jiA6bL3QGNEoqmUKkWgzTp2wQhkI9KkTdiI73qMrbB7AjsT6YBA
         np5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790801979; x=1791406779;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rum8N4iqJrLHYcsHVtRHizY5hZCyQwSijji12bcloz0=;
        b=GT8qc0xyew0dGDf0iSR0qPVBMWtCUVUiWxonqw5EMjAOvMGp1ZCJDHKbN95sUXgOF2
         mNNf+RLPv2o4YDh1TMTrnaI9XrqhqyUgMvXUvwUwOzHW3eeyRVFPOav2daK0ngJ50Dxn
         Gjp+aU7QKDTVSLd46AhYge/Y9tmxEWoWRqxmAOcOGQd+ehdp5tRiQMDnT9ho9OHgjdEc
         Zwuwe43eoW0eRbsG0BS/TDgdiXt8SDywQnB5gvCOE2qjeNM89Vm4JKDlkckh+H7+yTdB
         FJY3NyNoWcBR7giG2nKeBzl3AA985CCGWRTrgPHIfWh66tzrYmdHTvKC2hmRWp7sEAii
         6Z+g==
X-Forwarded-Encrypted: i=1; AKwUvBxOsP7mKe7sJ8xFZX8/1Bkaj4G1dFrqh4CCF1adu4b3dLSca5w+yM7zwPcZIb466fyKM+EqJ92v@vger.kernel.org
X-Gm-Message-State: AFuF++ncGLVlM0VzIfapoD9n0OgDe6VQGkb4aRcbTFPgfIFmLQLpdgse
	uhlXZBQ5/3KUOkdA2vuJ9ok9Eqrb0R6jQTajJ/92ZErdh/Ihaa9JafhPhAhXAHHEcw==
X-Gm-Gg: AYBFou2V/CII+1LO4Sw1IGxm30SWyvps0hSVnW36zOIpTH3PoJzczADUBPUYAbDH97m
	mfymX8VsPg4nD/jW8jnlwhWU0VsjBwgDnNNamphS2fYR9P8E5TK8+tHkghN3r85NANjFJfZbX2h
	DI69dl3C2pz4itIuL3ykszis8sQwshpB+cnOLSmVpsl9+lQKYJdIf8bKtMhR15gVXM6edZFb9zG
	PwbHhCPjP0vIvg3NbiGA6MVAlA5O+VD8wwLOphc0LPROn9wVgBI9PAhfbJ+jZhBHYrJYhGkKyxU
	ODflxSLn9znONbskIZBWMtqJBPXoVKtKxeBxWuAc6As7yRaPUKSb4uQINi47BG3+hxWzOhmH3tE
	6TnAWm/etJ2zbFK5st+fIPPLkUk7GHdtnrYm10Z8tyZKda3LRrZukMEx80ObvItlFT+LSL5plq+
	G5pKOi57MJtBS35mOYa4LsiZLmpmt18uicbm1NFQ+ARGhs6tQfVYXeHPpHLj+C+ywwkKBRP3kHk
	oUyA8c7fuJQoVj8tNDushmMhC74e+s7MSGjTnsEJFXf7dAOk6ft7kEkUZdItKN1MZ4yrGdx3gFA
	lo3IzXyQZQ==
X-Received: by 2002:a05:620a:294f:b0:93b:c458:8254 with SMTP id af79cd13be357-93ca980be20mr493061885a.46.1790801978724;
        Wed, 30 Sep 2026 13:59:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb649d825sm56126885a.11.2026.09.30.13.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:59:37 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:59:36 -0400
Message-ID: <372d1c5412aba3811d5ee476c00ea095@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260929_2146/pstg-lib:20260930_1504/pstg-pwork:20260929_2146
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnacek@gmail.com>, =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2 1/3] selinux: bounds-check role and user membership  bitmaps at load
References: <20260928165253.2388012-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-3-cgoettsche@seltendoof.de>

On Sep 28, 2026 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
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
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2: check each bit instead of just comparing the highest bit against
> nprim
> ---
>  security/selinux/ss/policydb.c | 52 ++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Merged into selinux/dev, thanks!

--
paul-moore.com
