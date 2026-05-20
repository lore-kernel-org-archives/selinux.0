Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE0283CB5
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307994; cv=pass; b=DX/PF4ZRVSrT1HmAsxu2VsKXzNXOQ8ayPP7qy63+mtZ8lgLKnyzvHnWATGbac47l9zRrNOl1as09vwrwYEqHfgRPEcd5De+f+mfhOTNjGXuDKae7CyJ5txRs5e47ql+hvJ4LuLayiNNKpVB9YKCvnYEPQYRjtGGD7N04xvtegbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307994; c=relaxed/simple;
	bh=I8XCKLGVNy3KnqNOPfSyDVllnlBDOmCWaEz5KKCpuDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gsv9mXAybK6NamgHMEfbGdNjCk9Fr/SR0LZWL92d1oJXNzhU+6pl2VAnZ4s+YV643JypJIBRMQBuWTUhRdHcyIqSODSfVXwDpQr9ahsMSYbWGJya4yrRp8P/rwm5ckjmOOVItxE4qCC8pAW5suGwm9SstDSYVCCqCnlT8J5bg3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=On1bjodV; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="On1bjodV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba17c8cfacso50177525ad.2
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307992; cv=none;
        d=google.com; s=arc-20240605;
        b=ZcrbOWF++HyXs1kui/+o6feCQ/5ZWW4JGzIpvSmhXrE47+4oj/pyZoNtnV9ZFktmzc
         C/4MUFd0nUXxkU9UDvHcSjj5nfN7kz2MkeiD3I4QGW7E6OMjurKAERmn+OwevgSPHN9n
         IyJemyc+GH9mTPTOca+0gFqtt+XIQuJBaTbEkOOlWXJ6D5QC9UmB/P43hSCbyZtw3AvM
         6W0C+9by9wvlqGc6u8ugZWe92zEKSI0s0opVxtfHfT2T4sZfMZW9hmnro8M9Rz30dFU+
         Lh700p/aU0S7bkmfzT3EgS0PNmmpAB7pRa/iWaNgrxM8VqalA8894D50zEFZOuW2xImc
         jN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pIwp8huL/Ggch0//l7rghN+J9tdVMuAFNMvN+fPlMAg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=IYcXcbzAZb1AuY/D2ZHSGwTbSXskq1ootgTEbHdMnIfmx9xJu5XcFWVMY6piXEe+nV
         bO0zikHOGLIcaoeqg06nsIXwD/XVYIZ3M0d9Qcx3p8zKDjv5Ac7qn3PMEvzdppI49y2I
         uK1Z1GivLisXIVr1tEQSbXhS03kFVlFMitUrHine2WubwgWNcvdkFy1sSHUhN8tCQVqm
         ggScM5cBP1H8w38s6nKdLNMhBznP1TpiOKggzV1tYby03EL/3uqlZuAKaAYCOeliWHtl
         MO8wMlX90MDMsgtoX/E0ya/qqd3dgrp6lqAFGQQdbAZgcn2u4T9jC3veNRc/XWEgve9e
         J5oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307992; x=1779912792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIwp8huL/Ggch0//l7rghN+J9tdVMuAFNMvN+fPlMAg=;
        b=On1bjodVBvLlkS7ShmRJh53XtyITPrkSuy/iacQ2lKrJXKkHDBaG5LOSOEumNPeHA1
         Lk3Z+WL/p4nJGYzqyyTYQRKPs68G9GfmTipkkQ/gKOthG5IIe+a9B5P8q5uGXsC8piKg
         P84KA8HcPYCej1nNvWlEqk6EreCbiQAo7qCzAuvvHrY40utwgMgfvQaKIm7w02FzKmVc
         ILIm/iQKSeMD/AE7MIVSkaStcoivEa0FeN8mpySXOBYtIGZdRCJnaIw8R5BENlsn8nFz
         uemcb+LFZnTWB12W5EZ/ffIOhhE/m/CpTtdHjF7/CHU0Fhg5fczzNnDd2UcEonXEpvUx
         odtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307992; x=1779912792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIwp8huL/Ggch0//l7rghN+J9tdVMuAFNMvN+fPlMAg=;
        b=pVRtKAg/UgMksg90kq7JqscdyB3Zqsladj0y35kBSLg9n7SaVv1H9QjkAxGw6VMiKh
         yY8LkYTX9j092BFeGUZV2zcejq+MmnkDnkigqnTH/uxDqM5tFEmOJ55V3nvMuNwp4t9d
         gQjm2YzhQdGqDYdp9bEBCO+YvkI71i+QRbHNpW3lXC6ZwSiL7dA+bOySPkDDp89PPYDc
         naMnwytNxj0fEs6pxfUvHW5c8LkrwTO7AF2PX4fsHRtYvXKfRXFxL+Nd7BBBLDNmLhRh
         o3IsNqiNpIbQEdP86C8mcVoT71OwTNLxqYvTRO5Bqo4In9SUZLZnhpNw60KbBX1mJBKl
         TZQg==
X-Gm-Message-State: AOJu0YwUffvYoRH5hc1N84ES1EfCgEy/nwK247mbKWB4S71kPJ+y+F8+
	oQ3xXty1eQqWphVGo3abXaioxyHlahYcAhCLBub1sSxqibIRIqLy62DpditgEeYLnANjdXVfb4k
	lpeKHTuNa3YIYzsONTrI/Qe93TUfT51M=
X-Gm-Gg: Acq92OGnIyHwdcTFTWsHnLVUQwoFQZrSEsNnJcYGhQ5s656AeWJEzAHBo5qxMhGf0/P
	xYmwA0+LOU6OURJ+D2VO4CVyn4h3Um7bp1TVi59j5Zj9M4www+1m2odiSxxG3iJk7x7JFGGL/mO
	QF5iDZ2s1YDA5BgHgWN+EKj/rJvyMQE7kxXezTO3c1tIDQ2UfDL8dXM/qXU7PsWoK4txTp4DUP6
	u9bylQb39O/bwYEUUCVb607ZrTUMLyVVvBZXXsK85YNxs7qKueCtvMe/+7FdcP9FZD45CWGmj4a
	s2El7Oo=
X-Received: by 2002:a17:902:f547:b0:2ba:3e2f:6883 with SMTP id
 d9443c01a7336-2bd7e8f9108mr255863325ad.19.1779307992362; Wed, 20 May 2026
 13:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de>
 <20260520121051.20863-2-cgoettsche@seltendoof.de> <CAEjxPJ6E7k18phrgQGFmezYxp8sgY76ZRaXon3XsajPmw4_Bnw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6E7k18phrgQGFmezYxp8sgY76ZRaXon3XsajPmw4_Bnw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 16:13:01 -0400
X-Gm-Features: AVHnY4IbIDk8uoGWSBwfo-asEYqJ5G4tUuPCXn4XEwQJ5h83GbEN3M3G719v654
Message-ID: <CAEjxPJ68mv59+B+erJg4T=whoNXOPgVMT3qB5ivYAaoaSL=xUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: improve restorecon progress locking
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 8:13=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Use an atomic counter to avoid acquiring the synchronizing mutex for
> > each file.  Only acquire when actually writing to stdout.
> >
> > Suggested-by: Copilot
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
