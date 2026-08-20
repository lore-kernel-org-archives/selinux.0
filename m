Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B547DF8B
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245498; cv=pass; b=e/aUQi5XnYFw15QlUH1cQk1HFDu69vlCFw561cdiv6MTWg96sUxZ1/8sb02R4tvoXAlfM+bO13f68QW7fr1VMK5SUwcibJQ9d6Q6n8fHwJ+eWzRWgLEHGU1ZQEyik26n2ELakYaQj1N1P2VvRZzPeAB1MWDIhT5ctJafj9pfG4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245498; c=relaxed/simple;
	bh=zk15vrhz9igx2e0QTN1PdWPX0bMqY97yn0+5tH0idL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+mMQsDFngeR6+F1l2uRsT0Z4b3wCxQVO62ImhqfiA7eGima0ruGS0uqXPnGFfk6yTPkT/jnYVompk+gDeGvrqk4tf9y2Ta5RSspdxa4YFLSWdI7RrhunjimEdFcigEpM8ijFu2NQBA4SxSw6wp+jYYWXoia8/OtnN1N9vcQWBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZU9+Wrb; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZU9+Wrb"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4583b1703d3so23678fac.3
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 10:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787245495; cv=none;
        d=google.com; s=arc-20260327;
        b=kQnqaplWCdxlnmkj0Qk/MdafkVz8mxDm2KqgtLy1idVVNVw/ynjtAxC/mspO5jBb6r
         UypgB/jTlAGr80W4cKo1gsMicv375ZTYeSoqDZ1K22A4nlzsiM3wP/RQ9/7p0Xqe9u85
         OvysVUp5kir2ffR5HH1763Y67KsNKIh1JS+i7/08TEDaWDZzmVGGomvZd+02V/st97F/
         4uA6Pme3a5weBHq5hNtrbRrDUeZ0fv4GFVIavLqHd/qv1NPfG2d9Y5dzHYWh6QF6rme4
         U56JxaS8C3XEk9aXxYApPfXMccgkpc0vC6DjexrlVuvrhDJL2y9ZpIVYE3nuKIVgTWRD
         teAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zk15vrhz9igx2e0QTN1PdWPX0bMqY97yn0+5tH0idL4=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=glESKnoljpRGub2vraGDy93RpuNy24RpuUURRicnhUJrB7UjiFOoAeJBcj2eYsqQUF
         vQUeyehorFEUouKMbwGO+Seg6CVH8m+GXA/NdqaFnt7N0kb7NyC1eBff/XrN9TUO2xEC
         Zj7AhfiMVw40bZjN+7AV4Q6jAcXx07ukY3S6VD496J8MXDytM9g5UsvWeuhAnxzl4OxL
         v+MxY4BZgEDm8QWqk6e5hRx0eUS3ozWY6r7HrYXcnkdsaBMObrne2VGJahDADuOTo5b8
         I+TX49Jgw3UkUUKnxHs4Tuy/d6I27tlBxwrb7V3q6gbcByB6NNeSB+h2qxIdfI54/NOG
         yuOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787245495; x=1787850295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zk15vrhz9igx2e0QTN1PdWPX0bMqY97yn0+5tH0idL4=;
        b=NZU9+Wrbus+64mK7I9HQOlCWF7kOAZ91BojmWO+vf7YtNHwIsTm/nWSf2LfD61rTJO
         /cpS28A4QWypVp6Q5pzaf4IRsc9jPWFYP0DNATHDrnaD5Er1NNL+n+qLVm+mZ/Z22goN
         hcI8Y1hee3O/N3GSys8dfPsNAGZ9jFJc1dPlgJAYtvqh7y/oLCLKvZve9gbw1VD2McYm
         vZ1PuN90t/c8D6du5+EoNU/DKZrV4VvzGEiuBSXJ6k7SvyTmGkCSohRPQ7Yme+YKcZz0
         +2xsE5YEzXdTZVLqzFi8ancrSH9fXerdxzumhC4idG4kSrDFSoeMCzKqrNKPTIukw3bd
         X36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245495; x=1787850295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zk15vrhz9igx2e0QTN1PdWPX0bMqY97yn0+5tH0idL4=;
        b=l51enxBDy7zdDYPwW5Pr+gV4IGejjqHVOFtPdo1nkO08thdKHTNjDmrxWo3vTDzldx
         /4zI8h0DvF8JHnrSGCw7N8sDm7VaOy0JTwdt0o44fz47oT0b/++Bt05tjIC2JBlaAxWI
         gJMxXO0yXC84aQsGrrD3w8psvAHyJ2Vt6PNxf1oMjtHKfYEUm1285dAf3M7LqalevBfK
         /KlnbFn8ezrlGhBFUATx4GTQ5oSoZdZrpIlR/W3WqWLqyQeEYxaR37ViyNpDw4aPRT+D
         ugaHRS/41iXY32hibm39xv67A2kW/guaQTmXXJpjJRie72HuixsTPJ6wBEdweqrjYyTn
         OYCA==
X-Gm-Message-State: AOJu0Yylxtk7V3DBiBDk8jjf7P0pl6vPtF2WetrV4ezHSkaWEsARhwRZ
	Qy6nLwCo3tPmlPJutguOJxQpERWVgkDghfLywPqI1VLMLff5mPqkgFNpsf1lv1oQhjWP5lIw3FQ
	RvvOjOhitxeRw1BfMHFZZwA83giMVGW8=
X-Gm-Gg: AR+sD13fUtsZmsX3IKTTqfTTtWDFnnvbsJywXmDootjs8axlXOObIJoV+WQtGXwUawu
	H0GPBljEZNgEaJHfe9ObUJtWAPjXIqWI5bNmJuqShWYYoyffUApmjZn5iGhGPTXk4PboyZ4ySTN
	AAoDLbYAhWEYkLS/wcqQ3PjgThk+iwAUryT9oH56QorPkx7i/Yf2ECog2gW8fvL5xf2NuQxGvM5
	SEeeI5Z8uLUhoovA2Y31OlV67eCsGDL1c63Fw5fvbdpVzPtbyizDbBQCKo9O8VTRw90JJBlE5Ch
	vTjrWPfbezuaGB40KWG3IkruQ3C382UAvFCYGPk4mjpm
X-Received: by 2002:a05:6870:be99:b0:447:9474:df1c with SMTP id
 586e51a60fabf-462f671f0b5mr14316703fac.14.1787245494707; Thu, 20 Aug 2026
 10:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820154143.12706-1-jwcart2@gmail.com>
In-Reply-To: <20260820154143.12706-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Aug 2026 13:04:43 -0400
X-Gm-Features: AcwNN1Wy3M86spVatLLxsmx6R9kQLAfqNCLKvDCtLhwd5-UCacPTlNcLPdLZrT0
Message-ID: <CAEjxPJ50V=sQrV21z5-+3fXizB1hNEgiCZAP-6tm1a8d1TzXDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Validate expressions do not mix tunables
 and booleans
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:41=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> A conditional expression should never have a mixture of both
> tunables and booleans. This is not allowed in CIL, checkpolicy,
> or checkmodule and could only occur in a maliciously crafted
> binary policy.
>
> When validating the policy, validate that conditional expressions
> do not contain a mixture of both tunables and booleans and exit
> with an error if they do.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
