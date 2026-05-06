Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D224C042A
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092757; cv=pass; b=YyzhkypZdNj9kdTaXx9oOoL6CIQjBjgut1uCqqI436030YBbhXyN4DmXff3aFICJ0IaUYvA//L/1msp4vQpEFq0XTYUiz+F+Ym+x0URk8NvA6I6ue0dqWd/EdXOK98BT06qHIG7Wlc9MtPIG1fg0PAp8zqAmLUskBjMghdOPyQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092757; c=relaxed/simple;
	bh=wt/9DwRkAJT2tO20KKocT2ScAi+8ugmh+zewxVP4Ryg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtrlQ79/biyp9tdvrrBap9cZQayQ9OWX9RdukJ3RMwFOv+kBiuM6267OofRU4ebK0I3Vrv7j678hB+syStTeHt6PKa/3YbQw6XaKpe+C+fBJjaokesK2ePm80BKht0U52avcW3M+ZqfWb9hjx6A4baJ07BwfibdzODEAmR0JMrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2SGELd7; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2SGELd7"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bd87e5d8ffso14554477b3.1
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 11:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778092754; cv=none;
        d=google.com; s=arc-20240605;
        b=Ht+0jKQRIoLqzHpoqQZ7KFJTS8zGk2phXlUhzPPBws7jlp5MYnroQUB4IAvfoGkrgQ
         tc+Bko9GmaMOoLMwCXARKA3qh1eR1FU3D4DXzAMj8r8ZQgr5nm2i3OBByEmwCpXD97l8
         cwmRA3QIaHvKLl4ocxJU4Rneqyr+xKA7F4kexrQcYtIQytDT1v5zYC9sOxkk32ngQke/
         iGtW072FxrZozR9ohpf+Hgib6HfJx+xwUGuXdC2/sd6WLma2S1rvEvuSoCSAFLwdwqBN
         DHHpsRp/ohhGiAlw4ZG/KiA762Lvk6XRJxlavEChcseEOd3+C3GeVsygdDqT9eyuaSRJ
         eHQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szNjsrBtsD5pm9tnURbunHqjPtHl7lSYOm5pjeEdN3Y=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=Sfi8WLMQngA3u/PMq4zZCW6kXoe+kETd2jjuh225HF2qHu5YxaU/lKqDa7An10Viv/
         iMw4nCSFOage5Bhk/QcYzwsai4zA/rHUZCKpVnt2j7M1+NGsrX7ZRGlIQ0FG42c4st7X
         K+FK0acFPjvzVFgO0MH8m8N4Ta/sbOX1n0hArmbhJ2f/2RCt4xlYqyIsfgXMCfMImZnG
         lbMGdGxSZFNJFC6QCr65cC2MG8uvdqr4rVcnLKZNCaEWYo7idY9CaRu3GjzGLTxjnM2g
         yblpCGqTKhGs/La4N8w81CHxNZ5BjLL4KC1TqJWNVPgjto5XaYFgc6Arr+gIgKzcHkae
         JgbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778092754; x=1778697554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szNjsrBtsD5pm9tnURbunHqjPtHl7lSYOm5pjeEdN3Y=;
        b=g2SGELd7gF4wqkosL80NJBnKod+wzWLgH/wIVe5F5cQL5CRiTRF2RQbWeF49fAUyTq
         8XjI9TZ62KpKGkNpbKRSvrGdVmLd/ifBdZiKnBRu2cOjgbTdnMJLDMudMv7cdA+yfLMe
         m3uarB4oFjqwBddB6GcgxXYsmICCOCTkRqHf7dyevjXCoyFmcnfwH9IZzugwONykDJp/
         ugaa0tAjqfC+veaSU32r2ICxdK559AXpLduZYmi7w9mQvrq0/OU7vIB/VnZDkYKFefLF
         6zWfo3Jg8sOjNEd00JG2cJ46PXW0FnXdJcJD4GOCtPv758AsUCRnxr2yDT/PhH5BvJPT
         JObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778092754; x=1778697554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szNjsrBtsD5pm9tnURbunHqjPtHl7lSYOm5pjeEdN3Y=;
        b=GCLGvJv66YNVegx3NMAgsMlZu5m3XLCQ9RneV1FLac+oLeYD4Rhy98hFiLykK9sLo+
         d3cV3PPOe62lYD+Yxze3oe9wTGG8Ev37GIVhHaZTxytQCWH09idzuxXDI2BtrUSdmVj6
         s25yk08NEXpP8oN0uMbbpjnrwYDt6742KpDJgsQBHLH2TlPLDYtekH2SlK7Xz4/38ocb
         dZPcS+qCCRJafTCQpt0WHBycHVY1U33pZyNQU1liEpQtPGzHoUb9IyXZS5/r4zBit4wI
         /A4OIEBPxAooAQX9ypn/h/W1ZThDgJqskGTCPt66w+Qo77CaFkuRQzd0q4ta46j4iuL3
         mviw==
X-Gm-Message-State: AOJu0YzQsWLIrYFYdKKTiZV1bfhYQ9OgU2HUSDr1lndnq3dP7aA61nUk
	0KQN01QWg+ZFO3KgFv13OuqNDix9oV+rFz51W1QFNMr6Krv4si5P/EAbTuO1GZ3vnMBp80fAs4D
	+a2t4j3QMlitDSsXB5HcwIw+08PeCrEhYwQ==
X-Gm-Gg: AeBDievMpi60SjCJ9722UpWEqO/31izodIzDOnZiZ1EnqyrodXX/vman9IPEVm9F5K2
	d61mrG/wsHnJ+5AmnriaVlElSEOuNmrm6RkTD0Ed2Z/BwdCIDNLk688CMuz1wIwif0viM7tpOja
	12gVWj3iVkhaRf/18QMICn+ZrNmoEqCvYiO3kjLIHs1VyTIBvQCUQdGGM70y5m3LBVdOPT59Qqv
	ObF3MPR+t7wPWailZX8m2JHmi7qjEkQR88smtzoYZOos9eyQX+v9HqR7B55Qhf4puaMBPx1roAj
	MM/lCPtzvkzmARAn2M20XBe3r7MbGPh5SMntrGg=
X-Received: by 2002:a05:690c:81:b0:7b6:dada:4017 with SMTP id
 00721157ae682-7bdf67a0575mr37370957b3.24.1778092753915; Wed, 06 May 2026
 11:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aftvCdG7qZ5TeQhI@14-5A-FC-31-E8-67> <CAEjxPJ5PVu=ypZ1coyq5B9kNNFkyE2s2HM2m+fmBSBv=ObxwHg@mail.gmail.com>
 <afuKhEPR1zPlsN1P@14-5A-FC-31-E8-67>
In-Reply-To: <afuKhEPR1zPlsN1P@14-5A-FC-31-E8-67>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 6 May 2026 14:39:02 -0400
X-Gm-Features: AVHnY4IIE1dVVuZXCE3ifvhIhpT__ZuYvc5Qa5flERgRCvpAcUSLHt3su12GxYk
Message-ID: <CAEjxPJ4_oecko_vwtfdzkpw_z10ckCBrNTRvjkAJ6WPq2boX=w@mail.gmail.com>
Subject: Re: libsemanage: why is expand_check integer?
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:37=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> On Wed, May 06, 2026 at 02:31:23PM -0400, Stephen Smalley wrote:
> > On Wed, May 6, 2026 at 12:42=E2=80=AFPM Kalevi Kolttonen <kalevi@koltto=
nen.fi> wrote:
> > >
> > > Hello!
> > >
> > > libsemanage/src/conf-parse.y: why is 'expand_check' conf
> > > option type 'int' even though it is really a boolean?
> > >
> > > expand_check:   EXPAND_CHECK '=3D' ARG  {
> > >                         char *endptr;
> > >                         long value;
> > >                         errno =3D 0;
> > >                         value =3D strtol($3, &endptr, 10);
> > >                         if (*endptr !=3D '\0' || errno !=3D 0 || (val=
ue !=3D 0 && value !=3D 1))
> > >                                 yyerror("expand-check can only be '1'=
 or '0'");
> > >                         else
> > >                                 current_conf->expand_check =3D value;
> > >                         free($3);
> > >                 }
> > >         ;
> > >
> > > Many other boolean conf options are handled like this:
> > >
> > > disable_genhomedircon: DISABLE_GENHOMEDIRCON '=3D' ARG {
> > >         if (strcasecmp($3, "false") =3D=3D 0) {
> > >                 current_conf->disable_genhomedircon =3D 0;
> > >         } else if (strcasecmp($3, "true") =3D=3D 0) {
> > >                 current_conf->disable_genhomedircon =3D 1;
> > >         } else {
> > >                 yyerror("disable-genhomedircon can only be 'true' or =
'false'");
> > >         }
> > >         free($3);
> > >  }
> > >
> > > Is it worth converting 'expand_check' to be like this too or
> > > is it wrong to break the existing configurations that use '0'
> > > or '1' as values?
> >
> > We should definitely preserve backward-compatibility for all existing
> > userspace configuration files and APIs/ABIs.
> > Some of us predate stdbool ;)
>
> Understood. It is just very ugly to have exceptions like this,
> overall consistency would be much more beautiful.
>
> Would it be okay to change to change to code to accept
> 'true' and 'false' while preserving the old config format
> too? Or is it just a useless exercise?

I wouldn't object but it is far from our highest priority at the moment.
