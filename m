Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70C1F949
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600708; cv=none; b=rmm41YZ9iJqeCAW0X8OkU86MzLxPdiJ2yq8tmRt486U0E2su2ePDf/pmt2P92oT4HCZr1yFv4hL/wUrVNgYAb326DXV2DqcyKOL0X5EmgctjF9PDSQkQxIa7Qk00b9tkypeA3FEuvfAqYiR0Y8oMsBClbzKoAhQf5KjQ5rOFC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600708; c=relaxed/simple;
	bh=cj/TB8IJfgmovr79zvSzDH6q2PFAixnmiawHxTW+SVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnbeO0pZViB+USkcOUeft94L4QaDs+x9d28hUFi73s/Vnx74jBrFYYhUEiYGTyfY2AdTAiGUwcb9i/KPTU28git3YWMJHoUbQLr12yfaXGeM+fIRWrPz4lh7waGHWYnTCP7I2WQXxVxrtD66Iwk9htsd2hBQ4O/jUPtFZ0e7QjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fyT5b+sy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fyT5b+sy"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70b4e497d96so55306047b3.2
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749600705; x=1750205505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTNFlvLY9XcN/1e9H3K1aEwcxHyhCPksvLP3kPUIgwo=;
        b=fyT5b+syd1WnQ4zK4NTIkZsICzfkKcgUM44nat21YxsUJqiom8uD1vr4XiifAxUV0q
         RmTfSkSPYpZlB8h6ipE6qhFvgQHinza3Q1dUx492AyfMB3Pc+3vZLIYV05AwoG85eTFu
         1IPitp9JWrUNPJHxssCm16jIFzrtNOF97GYe5SlsipK6lUEFUaSLIyN8Rj4pinDo4byH
         bK+gyDywYRTxCYL1pomCC6Cx787yJ71JVaFzaSHC2L3ojeSANErViUVjeKJhgUIWSq6i
         5xBP0c9MTn1eEKdxQd4ojeBHl6pha+IY5hfSqWQWEVMdlMVh31CpMNCMhDWnNQCIjCPL
         3Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749600705; x=1750205505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTNFlvLY9XcN/1e9H3K1aEwcxHyhCPksvLP3kPUIgwo=;
        b=aWcMkajx9sh9DCo5IpSWsIIl064lnN2cTu+fbp0XQEgr7/2RYb92ehD3dsbsN/ipIt
         t+JfR8NPRDblsCBhkaswanPD8fxNylmsQmzsq8JhBqPibhcmOVppG8AA56A3mk+PjcjS
         uqjttPyfp/1xYpILadUM827NSjPMrPo4a6u+ZeW7zhIXo/C6mbWSKI9WScF85390GMxF
         cWWUj2A8CGVYGFhdX00MNi7Kbt1ESu2ulBcuiwVsPjQqQWED4Ar0TjAe1P5O7IfQRXv5
         29F20ENpRvdqT0nOvo8s/g3Cd6WMZdWntGB9vLpFwkoX3/zVzGTvO7wyVAcfwJpPiUqQ
         6ryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdVOwcey2yD3PnbayrggBwAWndkkh2k08oNMq4GmzF+qZ/QINh7WDN1sy/kDsuSCv74ihINCYA@vger.kernel.org
X-Gm-Message-State: AOJu0YxxePe+jLAhrNWGt6H4s2HCRIokR4bnkt2wO/uLFH9sbbSMbokN
	mVZ9HgumB/UmXJ06FL7Y3Bx81MEwXauZ2+8Bbrzwci0A/uRSegKU+esgN9g4W3DisW9Vaf+QvdR
	DIcfLABk8636jI9QnK0L+M+DM/9iPz+EWS35BTYuPxq23P9RzXQQ=
X-Gm-Gg: ASbGnctES7q5LkKjhUo3dQ8c+IKm9FqyuTw6XRUsBcS5bg2FBKI8cSaWKwqbdNnnD4+
	jKDGCHWSdM6sVGaxAATfwvaZftdtJWbr7TXge9tELHOS6DCG7Oc0/6FScbElYeozq+0St0A4T1Q
	juLgZWkpBrBFgu0U4QsnimYsbeLnTm+EnVunjbOpGmfDGCBu0s9y6Kvw==
X-Google-Smtp-Source: AGHT+IHJpryBz087Hiek3F7YEEbo2hUvIsnp+TlzUinqvyS0w+4M62RLd09ZXrMTZDOs1OictzRnHh8KcD2pYg8fbK0=
X-Received: by 2002:a05:690c:688f:b0:70e:7ae4:5a3e with SMTP id
 00721157ae682-711409ea39cmr25472137b3.11.1749600705629; Tue, 10 Jun 2025
 17:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515092402.14564-1-kalevi@kolttonen.fi> <947cf99e-41c4-4c95-8f08-b35a76246593@schaufler-ca.com>
In-Reply-To: <947cf99e-41c4-4c95-8f08-b35a76246593@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 20:11:34 -0400
X-Gm-Features: AX0GCFvuAW_AdsLM01-r00v9OCT0wudB2v-L65-gPhX_zVNEi7iaRwCzryhDE9I
Message-ID: <CAHC9VhQ=FPvOo9L=cG_AvBpZTkOe10gXFii6YY7RVCD=rtAiQA@mail.gmail.com>
Subject: Re: [PATCH] Fix variable type to be 'bool' instead of incorrect 'int'.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:24=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 5/15/2025 2:24 AM, Kalevi Kolttonen wrote:
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> This needs to be sent to the LSM list: linux-security-module@vger.kernel.=
org
>
> There is a major rework of the LSM initialization process. You may want t=
o
> base future patches on that.
>
> https://lore.kernel.org/linux-security-module/20250409185019.238841-31-pa=
ul@paul-moore.com/

Yes, in light of that patchset I'm not sure this is something we want
to bother with right now.

> > ---
> >  security/security.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index fb57e8fddd91..02336de43ba9 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -288,7 +288,7 @@ static void __init lsm_set_blob_sizes(struct lsm_bl=
ob_sizes *needed)
> >  /* Prepare LSM for initialization. */
> >  static void __init prepare_lsm(struct lsm_info *lsm)
> >  {
> > -     int enabled =3D lsm_allowed(lsm);
> > +     bool enabled =3D lsm_allowed(lsm);
> >
> >       /* Record enablement (to handle any following exclusive LSMs). */
> >       set_enabled(lsm, enabled);

--=20
paul-moore.com
