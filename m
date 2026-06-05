Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9E416CF6
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676671; cv=pass; b=EwI5lklTaWCKWHNkr2AjYs8MZb59OhUgZjKGBno4t6k4k0Z5NiEe7+28ob1pEr7Fetk+OV6AMFYcAsvEqVrR45j6xYwhHBMPbEBcoFCkzpjiUaZRcmOdg0q7+KEoIAxnGsYF1qCLqjQX89a2WdbC1M+Dblwg00Y4TTsapA+LINQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676671; c=relaxed/simple;
	bh=hZadOCmGExhjOrvWYv2Z32cTybEbMyZzKZsp2DmnveA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBpslQEp+ifsG0AeSWgSiv7qrKEQtsQj8VX0oMp+KGcCDHMSgvW0SADusgzQZNyU013K4VvsEn/13071OPEvSqEkmd3xIn73Ht+kOVqCE5/4HrvQwSG706kbWdi05gzfXO2LqvVKK9W27U3Kp3Bln8A+3oOsDck3lGXdT6OrxFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJrQNlBb; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJrQNlBb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso1446604a91.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676668; cv=none;
        d=google.com; s=arc-20240605;
        b=BwDEclIOZArGgOSYssGKjZx4XOD53XlJwAo5TCUVMkDatctUfkDivsu7ih2xW1MFCv
         hhKG18pUpCxYSOtj/f9vV8cNf5giOvc0sl5+hwYgQ/wdFh4965Qz3AywtRT8eOTaoj47
         b9hkoukhH6SqKYVfv/Qe9AI1APTLhzViCPvjW+PJGnJO0CHbq8WiQQu3EIteuqCJmINR
         NksDjnz55UTQlcsO85TPXABIvHNFQK8rlj/kIclcxxh8xpOz5dpXIZAs133ep6nAnt19
         ZPY0XoOriCwIJgZXevB6sBbQUB06FgLiI4vyKp3wa3V+SX3XrLVE6kB5jOm83TWLBizm
         g+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2rBBfygj2A4bGiVICvdyfDZWPonlMLt0Qr03wfSKIcg=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=Msj8+cEZW4HVvlRRsicBAycHfkC4nd/h+pWrkBw9wgcIjHWh/1Qd6hOULsaBOcnkrV
         h6BT7793AKgrQn409VFOK/g1p0vyYrJgl95VfhliVJ219UCdpAy007UMdbLfrLBI9Cx+
         /2cCXtWzLbXMuAOVxhYOacUpLLW3HP76o3AhIilIbL5KziVY4ImGkcRRXOaO8drA7CLy
         rD7+CfyhrBwOBJd4K84LjuqRCisr/ZduJxhwcNxNUUpDiCovZQ89JWoW1bthf0j+4eJs
         W/hudYGE3hHevSHLq4fhqObBgMcUS5z7xqAVF1qxN32/CClBIZw6rYaeV45jFz/ZDs5O
         Rp5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676668; x=1781281468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rBBfygj2A4bGiVICvdyfDZWPonlMLt0Qr03wfSKIcg=;
        b=EJrQNlBbg4wZoEfvTG07uxILiVqPeZEGyHsXnhJgpsXPCw0EFkBzdXY+QXOwG9YGf7
         zpMtqjtCcgSfswh7QOFyyqqVKwE/TgsgtDahrilskXHRSBdzD2PaJbqbAgFZJoDni38f
         CFNMz5TmTGmbmFau6uGhbpfMbUqnoSxp74Ib8CSvHIFUv/90QPamSWIQqMR8TESL8UJ6
         33KNe5AbcffbzTpgwMtu9HMCnLD2AuGrjmxAzaNfDJi8aLv56ufIQKgho5MAbnij93/z
         ziWofkpDAxJNKik4jigsy7HHLSFqgh+97EHlJuDg9kqvoxg3+4RcAxh0wJJ86yzZCJnK
         VsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676668; x=1781281468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2rBBfygj2A4bGiVICvdyfDZWPonlMLt0Qr03wfSKIcg=;
        b=sOvAyQk1uXZMr9pTJjHR8ophir5+fJH8SG+Wetrq/1wgQbT1GewC1NXApQqBZA6FZr
         BVHdXy2kpi42tgWNRACsZPzAlHizegnzq8JEupCE7k5ITtGyofvBs9jPc8ljH50TTob4
         El2jsKtw1sBgB6iEiP5kCdlQS9mWfFjOh2LlxDyt4/+ch1r5005P5TQdr3U9bRb5Ydl/
         1YedQqOqJ+QLshTOrfAXC07+j9uEZcfIdw3v85kN42kWDyyhguc96oWshss0hroz+d/c
         oJn8juJsn2H27h4iaSATPOXByHNvgGGoGYGOyWhoWHB8XJk1/n8mOlhXzkqXp07Lv9sT
         6Wig==
X-Gm-Message-State: AOJu0YxWiuELix7nvnqepyq8x+w1KTc6XHm7Mbi8K15G67s0RX0H2QAd
	w+tranjV6ykBKIBblmlu4zEE6GwQdkXgFdixnkfWQLxItaaCBhBKBZ16LqDr8Uus0vLuumSv0/f
	pUSH3Tt7V6zrxDiolmCoF25Vl4ufHerw=
X-Gm-Gg: Acq92OEm1cHJViX8AZSPI6lJ7k2xsb7o58m4afwdMRn2f0cZlg1z8I+2j/XFAjiPzgQ
	7O1mB4VTA6Bd4FdPR85DK/1dw9JA0Pw+pxCcdcDjb3srKvcOFpKOG3Nq9RhHuYzIlGWENwsL0S0
	9BLv6fYDghYQpB17TU6wx7+Mf3RozNUn7lQZ3DcajW0O05Hc9gaRkaZ/c6HIBaGgrMcRf0Eqvlq
	ooBHl7KANNsFquMNPblUEggK4hEd3+vDMX9W2dJfv74T/LafiZ3P+zKyWOAUKJQSvfvDqyWfNtt
	5YZW5A4hzlrxI6DCYw==
X-Received: by 2002:a17:90b:38cc:b0:368:f179:ba07 with SMTP id
 98e67ed59e1d1-370eec125f1mr5287850a91.9.1780676668363; Fri, 05 Jun 2026
 09:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604171746.263416-1-stephen.smalley.work@gmail.com> <CAP+JOzQ0bkw9M18SfeBWJz3i8qnr_q_Q0U=JtL=GuQzcpx+SUA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ0bkw9M18SfeBWJz3i8qnr_q_Q0U=JtL=GuQzcpx+SUA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:24:17 -0400
X-Gm-Features: AVHnY4KV11j69K12bu7di91DejSO2eLnpWntBiajiPCZPGkdlDGb55UFhgXIAls
Message-ID: <CAEjxPJ4j+Z=9T1uthg-BQH4AQf8yT3iLm4z5+EotsvqH76QyLA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix selinux_status_updated() for MAP_FAILED case
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:27=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > If the status page could not be mapped but the seqno has changed since
> > the last call to selinux_status_updated(), we can just update the last
> > seqno and return 1/true to reflect that fact.  We must not continue
> > further in the function and try to dereference selinux_status.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libselinux/src/sestatus.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > index 2022b23d..bb69fe90 100644
> > --- a/libselinux/src/sestatus.c
> > +++ b/libselinux/src/sestatus.c
> > @@ -120,6 +120,11 @@ int selinux_status_updated(void)
> >         if (last_seqno =3D=3D curr_seqno)
> >                 return 0;
> >
> > +       if (selinux_status =3D=3D MAP_FAILED) {
> > +               last_seqno =3D curr_seqno;
> > +               return 1;
> > +       }
> > +
> >         /* sequence must not be changed during references */
> >         do {
> >                 enforcing =3D selinux_status->enforcing;
> > --
> > 2.54.0
> >
