Received: from mail-yx2-f19.google.com (mail-yx2-f19.google.com [74.125.224.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C324E5335
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699336; cv=pass; b=gA7tZMlz++zIs5EZPlZhyKxQuO+XBYh/CPLiAXuKQkFzN8EhFvIPae+SzzTl+mc6qjbfwGUdAOcZetgXrXRmYSWUGE4yDE41ZAUI5CL7ASp5RiXQydcGN3wP7JF9N+Nh33XtVxUYWoj45hdS5Z9B4sOQW9CT5SYPl71/iBC3zmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699336; c=relaxed/simple;
	bh=sFVpnYipejAa5/09ouQH6qLOd3Vs26tR/8ZyQ87QzXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHxZnM6uiOpjjWhmuRKr4Vg4TrfKj3o5GHbWxDe1TqqKv9bgSABlsozf/VAp6+1BYCOYNkXNdFYMRzTu19Ny/0JCPGzkmeLvkBvk+bkMLs1eWO75ObdzFVNEdqitsaiaNIQ53HUJXskEXyO3boWECsu1mUTilhZYD2nay8+ztvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebHz70o1; arc=pass smtp.client-ip=74.125.224.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebHz70o1"
Received: by mail-yx2-f19.google.com with SMTP id 00721157ae682-8a7af43a358so40999857b3.1
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699334; cv=none;
        d=google.com; s=arc-20260327;
        b=MjYNq1vG0T1osoVI7hg2cl+3E9VMKs5uobavxE6pOSKPQNVctbZiPD7Ll1J2scvyfb
         y8c06ne5evwZxtxa6BeneYkSF6YtnAfVQyTAnboa5PIXJQWNfo4d57pJYFZ5R4XsbM7n
         ypSPBnUjoysnRpTPGHaMbcIXBp+8HPpzxVsTiqoiTsSBKa48QQTU3IbzbABN9YW6y23w
         qC07pCjMUVDA02s1YNEGXgAAgxeyNBDyp3E0Z0O5SVYk3m3qxm/955EbYL1bnSk4iD4O
         ePyE5rLzmLi90o2dRgsYFvtFba2YFbfsZ/R56yOaDgl78bqwxLhYRQHhP7RP9j8DLQA+
         RLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sFVpnYipejAa5/09ouQH6qLOd3Vs26tR/8ZyQ87QzXg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GhUyRH17L0Ag0fYO9AmcFloxr3OIu4Cqq1RNFnMAXwXZyzXzK/ddy6v7brTV9A5ROT
         81ez1YS13v2Dw4G8glAE77nHct+sY9d5K8yl5YXrvvtQYtdx3xxR2mM5I8CMI610MWjS
         s6S+TM73Ud6qlu9TLzgRtGz/YQhoCf/ALJ+KBlJIoZeFBWmK8Rvob/7zJ3Witfq0gyBQ
         lNTbrF6tJSSLIewHF89vRtk0WyyU/jI056El1XivpBbJ9MeAJy4kI/G4kt2HZrzhW4HG
         64Kj3k45ZsxXEWVDNZ1NMy9uVWPCBCPMZdhnxG7LGnqh6FuLWzecnfz/Z3CfnV9167m5
         x5hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699334; x=1791304134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sFVpnYipejAa5/09ouQH6qLOd3Vs26tR/8ZyQ87QzXg=;
        b=ebHz70o1Ffh6kYSdcubOTzjqRuHzftk5SSnkxv61RHWLLgJP+eZeojcMblV7joafJp
         N1S6hjm0mKP6ZtpCNj8eR+EcyL0N0qF+gD+AMHzz3s8yRu23F+55oUmUB+blJXasVi57
         qegCvR2EyLEg32UkpX6NWh/uCey4bGn9X5PvwYH7wGwvfTsjUAQKXBVwa/hKZozyGdqQ
         vPmpIQpcN+txV88az0x1ip0lGpRlQk+DbV7XVS9ySFoCtOrchIuxWBPkzyP7m8mXvpRW
         o/WXW/ji6Hq54hGfoxbax/jChSHJWhkCeeeBAkv5yCNPU1bPJiPZDlyx0LiRK2TsJd/S
         WQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699334; x=1791304134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFVpnYipejAa5/09ouQH6qLOd3Vs26tR/8ZyQ87QzXg=;
        b=ZbXvx6gzEl4cvTzho/rwZqlo1lC+PCx/iDOO20I/7lKmYq3qxsbsB6oen28A9Pa61l
         3eDgCEqII+nwS36KxUvQsl1QmcXDO8HwPJDUdVNBA1nYAVZdchLR+uHwod8T8J3FsgLx
         rMPTEm50wnyLkvNbhuvSvfEBto/uldJ74Ljisd6Co3kCLRuvS/yNT/r0m77QCbQjyx+w
         FVdh/kR0RrRcTm08KmqtvLow+ezxautx9dZw8OYqgXxML6cCTJBF6UI8QUTJKOXJh6g4
         ZOTHjyXgAASz357HGxEOLKwrww7+PSB1rnV0lcViWUga2KyW6GW4OOJb8CG8eN+34gYN
         7pvQ==
X-Gm-Message-State: AFq9FYJ7MxCn8NOIURy5tp0jDNWtWKu8dx/VIF4qJ2cLUc0PzAAXv5Fx
	TxUCVD6JcsXzAZBHX+5R6KlkeRNS4IJXiXTze8fF3778OENklsyvNoBCWfdxqSmrfg31hjqywrX
	bDyaMWtu6Q+TASncbmHISu8Juv5s4KuQ=
X-Gm-Gg: AYBFou0kthiEIw1UDy8u6RI7oDD3/kiUgdV+bfOPdTk0lbJiP4RHMJAC10YC96H4+OK
	sUULw4cDKBy1339rrrr1bJb8zOmt8kYpWcroqfIYHUtnP/S4ZRtsAty8XumFlgxl/QLfciOyzv8
	HUMt8F+iPLq/yv33SDtSQbX46lT7DFJjd1BZ2FhtkNs8SX36vfypcN+Zn/QG5Lu7P0qEWqSefJ+
	X7l66i88rB8DwsOiJOyBdJEdGDuuVV90fS4hHJboJxolUb2LNnuMd8bngCxq8LXBAKMwqlGH0Ec
	GNgc5MKogSHUB8fqXphi5CIPc1329xiY1LwErM0gFHDoIaTtF5Fl0TzFocp358R1/A==
X-Received: by 2002:a05:690c:698b:b0:8a9:aa18:84ad with SMTP id
 00721157ae682-8a9aa188d20mr47106917b3.32.1790699334439; Tue, 29 Sep 2026
 09:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-12-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-12-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:28:43 -0400
X-Gm-Features: AclHuK-JOVnkA_VA200_k0ErPgSjQpNO-r_bft6lOEoAlwIXjQ78Hm4NI9m7gp0
Message-ID: <CAEjxPJ484rMt+OKS1OywciV3nN9Fv4t+cY5mj3fx6fuG6Ehr2g@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] test: overlayfs related tweaks
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> OverlayFS does not support a couple of ioctl's and other features, like
> NFS, so skip and tweak relevant tests.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
