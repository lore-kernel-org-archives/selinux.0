Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126273793D0
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563498; cv=pass; b=N/taJsWikCXircBgI5+n7UuEViXaK7QI7cVZEwlEUJDvfjZ0YFYs6cmdSWDKwJ/EenoLhLcsfkpkgpjSKZoCD8bEwAoDu/y4+/QRuZAhlPMmzIEfnOli+pDJ0Z17/pDe4e9e5jgt2TQqD/xfqEwJkiULv+ISSlSCIK4R8NML7+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563498; c=relaxed/simple;
	bh=aWpSUod0EtiI4wKySUcimzLttrt+1VpjKGuZqX/gN2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vby7Rc+oHMrvxpPhURAMzETLfgwL0V5ZpExsKhtgpY59hV0Aht8YyRZAJQu6N6H4wZIy/nz2k7lFIrmRhv+IxqQdFZUAGF9XBA8YR2dNTbgw0liPHgs2/GydMik0Pz13LLj5DoDUKRFqh5kVqZWyYI90pWNYM7vDgg9Q0HTIeFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z67aDF0O; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z67aDF0O"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso852799fac.0
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 12:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563496; cv=none;
        d=google.com; s=arc-20260327;
        b=XVDHzKzFtDcAEQYdq2fvG2r9jUaToF2ibcH3D7HTmYMZL/QG9uH/HatVrwZcGQsqlX
         hWfmc2QSfelNbg8N5rY7QsUbJb63w0jTLKNUXynT1ZEB8mwzCS5UQknu0FDCSTaPBs1V
         2SmLpRfdgg0cwyruAj6RPDLHpIGOEPwyrElIG+2y9bhvG8D7U/QmP7++HtfJR2iNFPy+
         RBM2bAnyAxRLluFGzmBaQlzZYdbci1miF9/KMzcRI00bUIUv04bW4cSpRt2QV9AgTewq
         N4CpM502Zr8LPva8BAuRcjCSytXnbYc9u9ouV52Js6+4lzLgYiJiYfNRRG9Fmzu28ia4
         VIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWpSUod0EtiI4wKySUcimzLttrt+1VpjKGuZqX/gN2c=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=WLAwvoaA96fvHhvwiZ6YrEpoOrldvA70gDtJqszyBewoGZr4o1sbUkpDm+3f8TZ92I
         Q8doswNqIU2LLjXp/I0v531UNZPnHvFanUtXaWd6HKp2WudlfaMJ/jgipIFC0vtgB9WN
         RvLGgdH4251giaHdV8Q/50XHlWPMh6tkeMMY5N0D/1ER4LiD0KpYQdmyC6eTNEmrl7uo
         W72NSgp+HM1eZKbsy31i8scLrIqMB8L6sfKYU8BPrQIo04YfUseiqDkBbPCU+te5+nws
         7D11JNmG3FxZeQbnAxsajzE+OF/EU9hWViiXpt0uKgnsfI0np2eFfYGvOUwme+jx9stL
         uvYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563496; x=1787168296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aWpSUod0EtiI4wKySUcimzLttrt+1VpjKGuZqX/gN2c=;
        b=Z67aDF0OHwWSPhuofg3vv0cPUyPI2eMtjWfl39nnWXrT+TtXNYjMCl1Cwp2+YgM/mE
         01HhlLWSTdfTry9oQE6ZQII6/BY6WfuwQvU+eaJSUdUhn/SfDL5AaeZ3Orpwx1k0amiy
         RjZjdTkjhmfpR5PxbqW5ZiIo1nLIXmkNCsDkM0lb8JJWmoHQWUpVF8tnc++NhYCWQxFA
         XS6aKO0BbhZ5hij60IhqUKprYtq9RjPm7uaFehCAUbPPia9NUN76i2Q5NTix0J6vKIr1
         9o/H91bdP1BLUQ246VLg7KmXS0rL/Puq11z62ntu2cMq7v01i3bPuTh0W93k8JeW0iAt
         shJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563496; x=1787168296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWpSUod0EtiI4wKySUcimzLttrt+1VpjKGuZqX/gN2c=;
        b=XJYEzQZR3wZYCpqWVjXBsNMtlinn6cuwLO8nJBnDYZGEjmOfIupLQCtoVapafPZu4P
         fICHA+FFy9rvht+S0gBEa1qBzHtnByL25wKp1snCmphcXXR1705rbEEv0j+Aq+GiHzrk
         amnkG2aaNSz02Gvd/9rBEARVC/lx6Z6bup9Ub7kpUQuwvPpXpe76E21T2dF4QO9fnVSo
         XXb17R1uDtWmakpEIRTkbPv0LfGmgXY838QZRi0+Wwmu45AzLksq1/u9vmjaDwrKuLiu
         qCasNIn5K8LHw1aYPUeBMg5YaRFv8hDpQ9EtQdfr/uY6OfdKSB4V5ISFd14aV7ncGb7Q
         ppdA==
X-Gm-Message-State: AOJu0Yy5I/20wF10LCFb+Fa9/j4ac5rQjXJrpwdvbNxwp0lfyeoYW/qE
	ReIPomMmqUaDtSBamKW342KT9gz0JPC9awDj/0zq9Ttr25EPQ4fz+/CP2f9uk3gO/+XTQJf7V6M
	1yL3s8Nlg598CEaY0IV8kwoazu51wLfL/wQ==
X-Gm-Gg: AR+sD12z8QBE0U4qwA7xsZcC0ljcGv0zRNBStoAcsECRNd51HNGigej6CB3h6Cit4n3
	Xlfo9XI/3VMsgGti7E6CdYDk8BQDNvLEc8gXdU9Ok4SxGpSRi0YcmJ9lmOIa/+110EaN/deo7Au
	c8AoHntCkABjWHVCqdO6HOFg3OL0+g+buBjy0B6bJZx5BS6yb+PD8m+wxeDBEGo0AZbfVaPOa/f
	SAcYv6zK1+O+ZLENUgWWnvRkHquz4azzjUZA/11AG9yE+2hpxG+cY2cAkTgIX6UEJxGw7r4bYij
	U6avsBoI+Z1zAv50EuYsIyq7RJxgO85jJUTC2YvM1qmd
X-Received: by 2002:a05:6870:b2eb:b0:43b:bb18:affd with SMTP id
 586e51a60fabf-45e622c44f2mr611447fac.8.1786563495667; Wed, 12 Aug 2026
 12:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812182807.7311-1-jwcart2@gmail.com> <CAEjxPJ7GQqCkz-OVHRgmRn0C5xyYqv6gzqavKh0PrRuR6KVSUg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7GQqCkz-OVHRgmRn0C5xyYqv6gzqavKh0PrRuR6KVSUg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Aug 2026 15:38:03 -0400
X-Gm-Features: AUfX_mzUaCBvnOgr0JNCsDR_SPMszM9ONSACgThe0cadAonniRv1Oq5dDHm0uIs
Message-ID: <CAEjxPJ4tW4M7rEVo=acwe_duivvQi=uYrOscHk4Dt7czvHN19w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use spaceship comparison operator when
 comparing ibpkeys
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 3:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 12, 2026 at 2:28=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The comparsion function for ibpkeys in kernel_to_common subtracts
> > the subnet_prefixes of the two ibpkeys which are unsigned 64-bit
> > values and stores the result in an int which might not be able
> > to contain the result.
> >
> > Use the spaceship comparison operator to compare the subnet_prefxes
> > to avoid any issues.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
