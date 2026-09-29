Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C43DE43D
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696411; cv=pass; b=J+mt1yITQcp6sskZxqOZMrCXqKPgFnTfml0cqILCL6TX3NP348xpLuWwboGHnZZqFco+ajcYn2kgWnE4Wn5P9jLW4xOmL8xWk6/fUTJl7JjCDD75VDMA4u90MwYjosqRgF9sYDqtohIo4LGfO+S/EROV8953//tYKBRBLz7EtGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696411; c=relaxed/simple;
	bh=Dtc71uC0C6QNyMl+4AyamwrF5zUU/1bjaIFwQ+ZrcY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2KO+8m3pIPLqo1YEvIUxvHNmvnxt+Nw7vN3iPVTZWA8gkvTzL/ikI8xDAXpE0DcLW9BmHDHhI5bt88SM79fYeJWixDPJPpnmWcMdBvYZQhMuqUDURD7TMcdzyar6sKeliiF/O5fuBxwk7HKmXC1r9Klkirkgy7saWExC8ZSfNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHLnA4qP; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHLnA4qP"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ebso4221736d50.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696409; cv=none;
        d=google.com; s=arc-20260327;
        b=E5m7jEFbea0g6XnvuY1bYm3c07upqG22FrtymUjz7JOGegB+ZA4w5Dn/8yRGFvQkeC
         wvM0OsEtkvNW2EaLIgCvyKXRQt4szMdp4DQb37uiVAfhDQ06vBqFO+vuiA3sabiNZpZv
         EbXxjyrVL9hxMblWNWFz9dP6ILo1Qz0/9ed2b/3CihWtXPDUy3r41Y+WLnfjPkvS7y7n
         pBhlEEGoct19pG+Jg9AUYOJDeAs1C4Ugc94ynrN32Y7Nmhc3AmYZbz5QXrpGtCcWXg+d
         qHF+IB8OAD7ZS1fhBlPevQKi4WS/or53ydleKBDSmJ5+O/ylQ/Vk/20xRBKwMSyMjcB0
         AT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dtc71uC0C6QNyMl+4AyamwrF5zUU/1bjaIFwQ+ZrcY4=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=MxMjuZXfgX8ZaYVNBMZcs2c0aV7iIS6OLvZ2tNT5mw60UmGbZaFbJgNxFEMtXPF87u
         VKfUK7mZdvCYKJaIkDmKww6UAycGW/eUDMLxbcbnd+XuvR0VVOzr8tRSU/tnu/8Qg2lr
         MJ7Gu30LqvDyZ3qfin9RR+uObiP/IS3FQGNBZnAOKJyj2rV/q8jGMgHg8zCWRfL7GlYs
         r3pocCo/xHTkcRG5HUwM70QJ4axMy2E/0CwEbKcrBCcNt9lu3HFEia7Hhg2X4T0XAwJy
         hpoHOgtYkY4n4c7ovC4MU3Pgw7rZQZrPLE9BVEQOgr/hvToR15LRK7uT1YJzIge5phNA
         4Wkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696409; x=1791301209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dtc71uC0C6QNyMl+4AyamwrF5zUU/1bjaIFwQ+ZrcY4=;
        b=AHLnA4qPlYOpS4DgHnBFMccUPwUDNhBQlrgz/wf5cQL/WJsmu2bNMbGLyUeI9Zh8rp
         fiwwS2VbfLla4cJ6fG0WnwW8EG9eiXW+xBRrN+YKOaknou1oEP6//qxY0tnUxZEET6Uq
         xpqXmttB7p28XS/Ky7zJ+6QuFcVTpB16lra5SDmZS4ZOBwHpILpqGzH4QECcmZRmuJ0u
         +N9NTwfGftMGM4CtT3YlZfhmBQfpY852wlrCsTuc3xTJZsb/yd8mB2GBzu/Daw0G6C4K
         1OhiH2FdwldLi7SagJk+dq4ypnui6EWZcEMNlTxyayspm42W3dLFoooxpFHgZ1Rr2Ufn
         O9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696409; x=1791301209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dtc71uC0C6QNyMl+4AyamwrF5zUU/1bjaIFwQ+ZrcY4=;
        b=hDUF620AYpDVTv4WbopqlHE8SFfX7ch3R0hpWt0JDCWfg6EnAaN7HRKndxXB6xjspX
         e8cQ4M27oStLn/mn3M3/jKGYlNPh48WyBcnnil3HxD5DjGChGWOPt8/OGkElTgXe32Yt
         BNtdR+sQ6XhaCdz95qDD8xryjPIyAOXNTSUqE7uSmO2WPOWwdtiHG7LJ9xMeXchCfd20
         yEsiADUjaHyl1XhE0KMjePo3PuYu+8LX5FzbV+lS/VdQY1OnSpKW5qfKi8YpuUyUJAN9
         FG/TXs8jq9dNX2/aDcWSPPhkflRvl7e1rWGhjd3ILGUD3meEp5rRyiLNc4hIgOTba1pS
         Wvgg==
X-Gm-Message-State: AFq9FYI9dSQrBmRI9madi+YkpgWhHIWx9NuojZpnEOuM2U8iFz/Kr5j1
	tSA7pIheGstEm3FX4lc6vgyKbWfLTpzwXJZoW8ToXF5O/ey1sJ1mbSP9VvYgOePk0F7d9/U1MG2
	PNPfr3VCWuqFad7fqsuYFzuHPFxsTYac=
X-Gm-Gg: AYBFou0XRcW2MniPMBfNW3Tr5WPk6q88UXfbWlvdw7RgCvtF/bj46f4nU9lSZyQjddw
	q88er1MBhIDVMwIbpzUOHaBm1oKcjtoiPghBzZ7vpnrpiF2MLj9UX/RFRAMIUmm38WHbtDBtuNJ
	EdIpbutRcSdiz5Owo8U1ennlYYCSyRlA84FsMQIjmeLi9bN706Dr2Iw7SZjgMjxs4eeR1OZJ2x3
	duim73F9IKbjZkTaoY8Rv5XLQWliFTNYDKZRcx7ISP2t/fWyd5Kxw+x8KTNhKDLx+Cc76zRCfxh
	U1PFhxBpM7TUDFhsbuRxbR5942oq30KzszKK1SpUSnGxn08Levw8FOM=
X-Received: by 2002:a05:690e:118b:b0:66f:e246:ea13 with SMTP id
 956f58d0204a3-672ed219f53mr6026781d50.21.1790696408631; Tue, 29 Sep 2026
 08:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-12-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-12-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:39:57 -0400
X-Gm-Features: AclHuK_9IXyPUMO5N3e4Vp2K246TqjthnBNTJZojueQsXzKbtOjlQ1UXxlZhVxc
Message-ID: <CAEjxPJ6n1i+_Kr-6tpBD+V86oTD7NwjS8b5xxF6aq6cxPcW--Q@mail.gmail.com>
Subject: Re: [RFC PATCH 13/32] selinux: remove unused SECSID_WILD and sidtab_search_force()
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
> Neither has any user.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
