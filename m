Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772203403F2
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569240; cv=pass; b=nbDM6iL4HKgLsLnV4DrsFtX8h0SnkUOtiKs8ZLLuIC7yW0SRLjjy/fNrddYJdq/So5rzalUDqvtuEqfyTzrOVad0GPyL+TedI2AyuoxZp7X2L89p22OamHajUemFqRbhAugxgC5LRSAGGS/gA7Wni/MhZ8rmJ20VnPItIkDwDdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569240; c=relaxed/simple;
	bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gds+SY4TP1rWWy5zqxnenSxZOrANUgzsycO+grvenlymRomelLU3j12mlvLY2kOWN1dV+YDKBfIcMYZ77G/kssiSjwe+IxwX8VJi82uKd44b8uzB9Z/7l1/+gBlmwbl6QrvPgKVfQFBBoBPkkHSGldlXp+Aa5O6SZvDIeTV0wKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=enlP9BVP; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="enlP9BVP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d6ff3aca06so115045ad.0
        for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 07:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789569238; cv=none;
        d=google.com; s=arc-20260327;
        b=EyIODsGxv4OiU/AC6c5EAOn0QCFhvs9hvYUk0znOOa387nksXGBqbZJ2tJYL6PuBqH
         ML79AdxzAFpx7kz+aTXrX0nnS8XpanwSScMZT+u02MzXfCw4KMJpXvzP7G5WZSq7jEn7
         kw3IyiMsuM+fcb9goHht9dNQnjT0/0b58BqJ68CeeKQRwvoKeKBpXWkVOLq8HzIUHWdk
         tBRgWdlQPDfboZHa8NrzCY5yccx7CzzY6IdLxCKxguqTSjsxhdFI1F6KJmS9GbCwVBM3
         6jq3DxeDh16WLQQ2BXO+fjsgBMM8sYnFPgjUq/F55IHbe7dB6JRIn2PGITL5l0NIhsUT
         0sFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        fh=VE+y090F/kzZlP13qecU6B8p7JYxaEi87TW2mRUpCmo=;
        b=FD6KPN/9fBr89tilIYof6ZB60X5HR3DXAZDZWrZ2tAUV6+984msv1zBPIGeJFnwWAD
         tN5UxeN6J1ABwXHkqj1JkLzFUEa0F04Ngg1cEibVEDGF8E6UrUevfeeDDaFQCUazP/CG
         nw2fxP8cgh9cDQmwmJ2zM35N5t5E6g+5lEt09Eu1r85Fpv8KWZ5jRZLBEFuJzaS1vRE/
         U07mwWaSCsd/kNq9BD3d6vwz0Xqk+9M5DMeV5PA90hEM9li8RNIVNv87Wfo7Ts4VtlWZ
         8XwQfUrtVVN825McQ23r47BHdJU8oMBGqFTItxVU3H0tILhpC0gs5PBjIM5gSpC7H+Ca
         a0BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789569238; x=1790174038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        b=enlP9BVPCseMCloxPgKpmFrxpdvmDWfyw0wlrGMj5nishBaaJ++qgTLDrXA9Ls06di
         gRT8tck0R+uTqB/pfBhSFKpHY9Kkqo8WK22itILYNg2HPfwiLEh3J4cKiCmw1kVSNAkr
         aF+NAV8RWhfzoPcKayF6UJToDx4ykr10POgjLyAkuremzJuaGQRAr3/P5XbpraMeBGQC
         po1cw+Bi09jpVJhjja6omm4xsJ86Jo7TyBvb/aqYzXz4ld0q13dEJKANC9CxeaZdFFYi
         Hi1I8tlvYVmwYKDvQYayGmadLQDwtrlMNckw0PFBlVKM5R3qPNlBHXSMJ8iIT4gakwce
         uYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789569238; x=1790174038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K7XcWTAG9pLSnk29MAn2WD3gdRS8+vQtAmNxqtasz3M=;
        b=RAUZ9Vlxvtm8dh3y1edUqXby0AEXj1otSVT6afAokGBFqv18AYMH8c7R/2veIOXkFZ
         drLBT6PPxAdswpdwpNbsqu5xrOC4vDJlXIoU9H5o1KA54QoP0sJ3TL4Ch/tKNzdKvdZS
         bMgiVWUBH2dnL9PhAhlHOHEuSyYl1IOQLZcpIIzXzF1oMsW6FH1Wfe5RafmJVKkI/nM6
         J+23TdCJ+3fl9lr/vgZ/Y3tT0BCRj9grz7xXJgL0d2N9b+EaB+cyFJ1avmh2SZAJ+iVC
         /z2WNUJXEz6iUhLa53AdojnTLGm2D2KW5TIvDWu4uERDrUx5URPPN+o2Qj9KoPhsK5nj
         lGIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeKQ3nHypbUie9J5XulmmhCEc3h992Q2BqX3/CjCi7ZUNQJ7Mauu3aW9WbtN8RgEy3nQzS/R5p@vger.kernel.org
X-Gm-Message-State: AFuF++lOAO3EjNkjMVP6WIb4r5pZ889pRuQNGDR1Bh774R+CR+ncNA0K
	NJIb+Ppl1gJLtLZ2/fVYqmBvpTJyLQTCTX3y9HKc1h+e8HyTLdpTI2C1QZYQ1J8jnYzPQffMy7Y
	Y9a9QKBDrrd7INHf8zxXWxeJiZOUVV0H9hRfccdHE
X-Gm-Gg: AYBFou3gfZef4NuKdiCaAbmZhHeVNOlKew9uir7WvACQyap4PVPw5LtgV5EmWvvQaJ8
	P/tF9RP+5QGXgaqR8tRu9OA2KAqjx6Juo9U/SC2TN97zZNS8vy1PpCTm9DBxBe1I3yYzOtOCXxA
	UHqJBlepLN3qafjvE27M2/tdCPYzKlB7AwYVcvbWJ2ipDJyciXdjS4K6LbtIitMWD8uereZ/WVG
	wdnfV7QsK3OIXsegaJ+3ZQ+zRiFeeSeWzkQXalW6u+HfaUTwypKiKhVlD4RUptEx07LiWVNeAAy
	omv1QOu5G/7QvEhlI5DkdmSDmBgD4C+IkZ2zmxmDsX0hgLaIOTsmnh+qoqjLeB4ZJVTjbHkhXfn
	8wUVJwf88KqB0bysidw7hIRki0h0j3PYmD145efDPyw==
X-Received: by 2002:a17:903:1b70:b0:2d7:2a35:d14 with SMTP id
 d9443c01a7336-2dd8e92caefmr4932795ad.11.1789569237830; Wed, 16 Sep 2026
 07:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com> <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
In-Reply-To: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Sep 2026 16:33:20 +0200
X-Gm-Features: AcwNN1VHcCpN0atD-cxO0BibJJcgM5o-LVFXYygCh_MGPfeRHWgz6O_0BmL4XXc
Message-ID: <CAG48ez3DRgU7eQtF71EEQw72+xV5kWv0nQn==9uVd=YPyGhJUg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> > For some reason (/me looks at gmail) your email never hit my inbox, I
> > only noticed it now while reviewing Jann's patchset.
>
> Oh weird?

(Same for me, I don't see that mail from Christian on this thread.)
