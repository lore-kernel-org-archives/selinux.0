Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652A41F7ED
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913091; cv=pass; b=hYw6d5sp2J67Vzt7ufe1fiDZgASV+Ln3jipZsU5AKpAMEjL+18/ZkqvNx7EzISZsLd8TRXcCjzW+T45wCO7X9hcez669gGFcdTRNRmdusk9KcIbMMMLM9DHSffuASAuCFJAXb+MSk91M0t4YnG4C4y92eDWTRJws4VOsBWwDOHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913091; c=relaxed/simple;
	bh=2rOG8PDsFNuGRF2UeGLbP8XUDExCrzw1ODTfScIigpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHIP8XK2z4kKRo7pVaa/5hahTrsL26uL9TDkBokXp+OgI7sDPZLGdFitVjFRAYrRg3r6H+VAE/IjPgRKJM5et/Zmp3V5orn+iJwWUdlUZ2ZOMN13efF4IeK48c01Ct6MRqIQ5RKEogkMDwpoSNX8vGkoKQr9J3LB2WcF1w10TuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPhqWyZF; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPhqWyZF"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-456395f4e7bso370070fac.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 10:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784913089; cv=none;
        d=google.com; s=arc-20260327;
        b=ViU5UljG9ZVKFoQfGu7feoKxhBADuiIvU4V1kLhPRxnohWNYFhxJwgPZR/NQiUfyva
         qsjau+uZD7iRuktAncutpFd1X6oxNM+1GKvP/f+ZmmVSBudCvNr9IDqiG0HDfbkFyV70
         Lhq1A6EGqm/KBkl9YYzPX5aWXUkOi4m9M4PBYGWGRA/I6aexLrgS+oj4WZau7Fxn/MOj
         ZaJVLTfWUUTJekEFqAjWC3iIoIzembpIGq+uzBHLf2SZH7JePLUBq1YfoTU++pMOIVYG
         WmjQmN2HvQ+973rUcK91BLso1Ybm4YVaYvRAzjPQzbiufDv4nM5Jgc5CSkwueDtNmnnA
         l8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2rOG8PDsFNuGRF2UeGLbP8XUDExCrzw1ODTfScIigpw=;
        fh=J1inx4OMYyvHKaldL1KOxd3IE+AmnSfOUU2h0D4CEhk=;
        b=j/mJXlX3/XwQFvGf9npAC1eSkFbGUalyH5hXzigMaGN6mjeg/TaogrWpTYzG5QIpyn
         Qw2Xfr9ytuOEgliWzJKQpOeK4wTZwrFcpeiZ96la7qCO8UXjK70jW57ULB3Fmb2Inscy
         rSBqf798GnvUotPGmwUMVjwT6cm9v2dHu8giGdnmyMuapCIQIoW/PbaE3vS1mjxk54El
         oI1Ji9FO1wKUJqJr+6BJ6TTcQ1AX07HR3K4K6UIuHYVA7m6Jg9ir3ck0D8g8O2cFGGmh
         65+3XUCHu/UsBf0reJFsJ/1zYneaD6QP6izoAqCPfLry/8BkgX281DAjNVQ5q1sDwqFU
         g3cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913089; x=1785517889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2rOG8PDsFNuGRF2UeGLbP8XUDExCrzw1ODTfScIigpw=;
        b=JPhqWyZFLqTkwXd3IXs3tz3GTCJi1RZLt6OS571bRDECNNbPYyRLI5cgFQe6I3AL6o
         vnwzZbNRPhctqUnwxFVbRH1DD8xzhTTtU1Ldiot4cz+1yhx+WGRt+6juhMXI8ZpUZRtA
         TImph5rnZsbfm2GaICpU2mMNOee3fCLa1fQGfrPZTHE0+sbVzxlQd5smgN9q7Ac/8Ykz
         JL6S8nLo0IKDv7yLRlo5S5ebo0PABBkBvPb61jhUZpGvtbUuzdJmqUCID36SLFnLpy8z
         x7z0qoWVU2foh7sZ3vEfNO036UggWsUqyrRnVoUftNgPJbXq4wKp66YzMjBSc6IV0eOB
         M3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913089; x=1785517889;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rOG8PDsFNuGRF2UeGLbP8XUDExCrzw1ODTfScIigpw=;
        b=H4G4wRN5ZR1sXt7uAfoc2N5buGLa188kCGIIOLd0kk0xqoQfyj0oBoDkyg176I6O6V
         Os8FmZSiBSl278E1W8uAKi3wICIwVwsFYFro8IldThNOxU6t4eG1bo7rdCafqtHUDMe9
         D05gFsBu8FrpUB5dN9Z8Fo4utT3Iq2LPKKmN9Ld0uXyCwgvkdefq9Y9ltMaQ+ZWEsQdl
         23zggUAt6zg6eQeMWKIsjlUAtAxEdavkCe6iITzOgmDLIJ885pZ3tSWRTyLZZe8QcBe8
         mg/fcBph21iye5eDFCIDxz7YNIOt9uaVS5sMaNYoG/VSPvJl6mdxRUBWlrdUc57ZQsyf
         G1qA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0oyRddZyUB3o5RvVZ+HzZ2sPpXx0rOgheYKpT1BkCYSPFTtIYXIXV0FAsvf5fEQOjQoWHs5S7@vger.kernel.org
X-Gm-Message-State: AOJu0YwuzDNerr9FoMqQimzFQ+wq4Qkzf0f3IZ0P39c/0xbS+gAbk2aC
	q5rVRLWPVgKcQ7qpw2FjmOVXGC0SjIMi+hXCW8K9uzugow2pHg0M6wDK/fl2ixh4Oj6qWFVWZWH
	iUg8As1mPZkTUBWXxubqpBo4Yar0mrKqT9Q==
X-Gm-Gg: AR+sD13xh+NH0Qqk5wvhQ7LAickCzPO3EQsPKbRvioQviNbOXvWQoHCo9hxebXcalpN
	QuXub8HdRcvwuzBdknafUJPseNVwz7eL7hUnkH1bQVD/o8PngDDEHTjEDPonV+PcUTSwCJUlJ9d
	vWczHHcn7MOanTS03XOedg6FI1GzydKeDQ/YWXZYmCsF9/zjW5WdmbUcPB6s7twLtbc0ztN+8NZ
	wj90AUYwGw1MIq3cLOqi15Dpjm4st0yXvpaNEztdONdfDMIIrHCFVpnn+reyg==
X-Received: by 2002:a05:6870:c693:b0:456:3b34:7a0 with SMTP id
 586e51a60fabf-457a103b031mr5352902fac.28.1784913089316; Fri, 24 Jul 2026
 10:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
 <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com>
 <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com> <20260724170714.71963-1-hexlabsecurity@proton.me>
In-Reply-To: <20260724170714.71963-1-hexlabsecurity@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 13:11:18 -0400
X-Gm-Features: AUfX_mwQ_7_yPHaNspJjdA8fgFPtdjPF39XjCSKKczMDYXcX4SXN4rh-HmGrxWM
Message-ID: <CAEjxPJ4pVw-BzkHNbdKE7aOvCjDX5qpQA6UF_KADmhEhdkXExA@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:07=E2=80=AFPM Bryam Vargas <hexlabsecurity@proton=
.me> wrote:
>
> On Fri, 24 Jul 2026 11:56:11 -0400, Stephen Smalley wrote:
> > Also wondering to what extent this may overlap with this series that
> > was never fully merged:
> > https://lore.kernel.org/selinux/20250511173055.406906-15-cgoettsche@sel=
tendoof.de/
>
> Little concrete overlap. I went through the v3 "harden against malformed
> policies" series: patch 3 adds the value > SEL_VEC_MAX, nel, U16_MAX-clas=
s and
> default-* enum bounds (my hunk sits on top of its perm_read value > SEL_V=
EC_MAX
> check, already in mainline), and later patches bound the top-level symbol=
 values
> against the symtab counts. None of the 14 patches bounds a permission val=
ue
> against the owning class/common nprim or touches security_get_permissions=
(), so
> the OOB this patch closes isn't covered there. Happy to coordinate with C=
hristian
> (on Cc) so this and a revived series don't collide.
>
> The review is right that this is incomplete. A class that inherits a comm=
on maps
> the common's permissions into an array sized by the class's own nprim
> (security_get_permissions() -> get_permissions_callback(), perms[value - =
1]),
> and nothing checks the class nprim covers the common; perm_read() doesn't=
 catch
> it because the common's values are bounded against the common's nprim. v2=
 adds a
> class_read() check rejecting permissions.nprim < comdatum->permissions.np=
rim,
> with the A/B for that trigger. The sparse-value NULL deref in
> sel_make_perm_files() is separate -- I can fold it into the series or pos=
t it on
> its own, whichever you prefer.
>
> Correct on CAP_MAC_ADMIN too: the precondition is the load_policy permiss=
ion
> plus DAC write to /sys/fs/selinux/load, not the capability. That line was=
 below
> the --- so it never entered the commit message.
>
> Thanks for the ack.

Ok, thanks, will defer to Paul on whether to just take this patch or
wait on a larger one.
