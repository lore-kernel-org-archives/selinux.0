Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235047FAF7
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157758; cv=pass; b=n2Mdyv+nEFPG+MyakSnEvOIfW/14A9sGs11bL29aXxt5EVDMpBTMSn8GgN2fFVZiOFZUA67RZKw58da7Y1kVnQW12MVPOLjuMghWvcFx9A7kWQcnvqcn3dKsjPNx9SOtNGXV+73L/GoIeA6Fdi0kcv7ODaJ3lGO5MrZRaiSR+TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157758; c=relaxed/simple;
	bh=d4w0hu0hXzpDXVtGPLPpi/cL/UZ/63nsTpwcmfeYgCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLVI5fIu1aazhkDujEyhwZn+jO/ayK/V36jRu+FMkKM3bNiQqcyyc059JMMOo8LbV4KaLQ7LKe0+PH+Rq1ES3IHFMnxeCeGdwuY5etCEygkX+pZ+mnlz83b+I4vfWCxRVVxwanSFhlceDUrGqccf6uGlPVv6qN/NmQQn8Ec1lS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx6ppAPi; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx6ppAPi"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66c70d1672cso1501650d50.0
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 09:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787157756; cv=none;
        d=google.com; s=arc-20260327;
        b=e6aaU3a75euS5ujykbHEOmPrd5m/2/cD4J7tcINEzh/B4tYPbPCXeU6uLZd2qmW1Is
         hCuv2KPVAdav946yR1IxnEZIGogy/mlnw/esnkyoITI6l4gPynE38naiYhXadlNaBqvF
         dcEDXygz2nGcnJGopWa2mgTO3rqODKQoVDxWs+1zRefWPRLuPwkehhU9cAgzmuWk+clP
         sFm2515mqdny9ZV2yiQEDKUtQeDHNHE12JkmJ2KKvp9l2DwmDC6aS84CEx7oknmd1DI1
         xjeYEP4ASNK0MG5k9HkXYtamyhs2uf7atDi3dufHmi64gHig2pDzNTBro+36Mu4hNQRq
         lMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d4w0hu0hXzpDXVtGPLPpi/cL/UZ/63nsTpwcmfeYgCY=;
        fh=lzgMvuNvWJItzFGfnrDKsc33eUPDc/x4BwHkUHQsq+k=;
        b=UgUkXGdsRedS9io+tEdomr3T0kBcuzhjSciWiXACt3tagnZQrGRAkEkHpS3a2rov+8
         dEWfa83xivB22RHyQgIxEKfDR8kvX7VLDMTam8s9f2DZkXyb3nWWQbyrQHExIQhugtV7
         nNNoviuQkWat2Wb5VELrbojG8CvSMlxVxDRqnxG0y3lYOuyt7LM3s9EyeSTi7h/LQSKb
         rl//3ePNB6D1Y795ZmchMZFZJGNIS9AvVjZGlHlXe/lJwkes2AzhGIEmrfndJF42HGh+
         mxapBt2fGr1Ki1EiPaMTK+aawKqNXhlEZ/fFWAapdmoIUDRYeQAQKUg6t5Jp0T5vQznp
         yXLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787157756; x=1787762556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d4w0hu0hXzpDXVtGPLPpi/cL/UZ/63nsTpwcmfeYgCY=;
        b=Kx6ppAPibs6nXm34JWibZSnUB+BA/iCWLiHcf3aIBO8adKtBSWKhmTOXnLPIit6wn2
         U+zMQG66/ke9ETeYhUw1SlcP7aNBytzyR5uJnXGsYxehrfiRbbZoX+pBT7q+q9YtVPNo
         vxC9as3XDXnYst3pk6AeqQme9yIBD/6ygqDn/3ERR+RDeT/GHvYhnw/BecquW22cCv84
         5Aw4pHfA1IhsvFSG33jDYbZNMkB5wWpCT3aY+lMih97+wlFxCVV3yaOXKkwurAhJiVOD
         ovKQJUpp52wpWkwmufa9U2jnuvVugHDlcm7XRg1cabNavtD3F+rR7j63VFKlJdLiRKAW
         /Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157756; x=1787762556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4w0hu0hXzpDXVtGPLPpi/cL/UZ/63nsTpwcmfeYgCY=;
        b=rsY08k7f/nDRgXsXDJCz1WsKGFyLlCYepUSggd+CfxnZxD8SQVmWQciumrqg0XZ45H
         zYUGI89059XU2qezpBlqyIkO9+5mxqc71//V7HVOp3S3Sn2iEjdOjakoDVikrXkEH6g9
         y2rnr+J5l+6otrPfN4ojspzioJ+0AOpfxhRkcUDBf3YbzhoSfDT5NOTv9+9HTwzQhMl/
         bwUAptOgoOst5hd+tEl3oN98HIW34WoDzUeTtG28eJV1t0pbSgQZT+eFkUAx9p1+N4PM
         rTHi4DjOxkWq9zY25NgxuoJslaNrkiFfriABarZ5qRxH9HX4KNI6nOS5QVwkE8fqUAJp
         H73Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqlk1iBuyufsze5h3WrrTK/xDA1zeeh7LtTZL7Yo2lwIOXt49olpfprGa4aeoJiveFQCaf8J2vM@vger.kernel.org
X-Gm-Message-State: AFuF++kP7Cc1etb+afH0+FLhYMGGF5MoKpnK5tt0AnSvuZIHS8/god3z
	EhGlNB/YZk0dR6gn68ek3Qxes004iBI+9GGZhtRdFWdTnB3weRz5cfgXBc6E9bODNA/oLSn3oBM
	ll8XCd8vJYGAt/M5Xh/2NndtNgqvgWFM=
X-Gm-Gg: AR+sD12RaPtgQ6aQm1GJJb3sBFfKJ9hoAJ4tUkVDcE75xgz4EYXALrO+Wwn88jsXf3S
	qfqWxTgYT+qMk8zeE4Scm9Turjh5nWlms2yZrte+FMFENs4Bnp9y9mCC3sCmHbYNz9noqDmIBoD
	+NPjJS6monyaC6Ph5w1t3vcof1GdMo5nSLX7AXdEw3YU8cHD1krVYcWee/gbTc4wz11UglfKp1b
	d6q2l4KUTDMLFElvPUwdrj1RMvp/od7DGhVG/curz31hPDB5a+m7pg9M0qLyQpO/ieYf3qNUkJF
	F03iahx6gL6xVZNs5500i2WHeEoWwsGII12jt8hiBSE06mTG4BKTgYH+LfCI
X-Received: by 2002:a53:d04b:0:20b0:668:7df:af5 with SMTP id
 956f58d0204a3-66ccb7513b6mr1963794d50.45.1787157755589; Wed, 19 Aug 2026
 09:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818192340.119297-1-boeroboy@gmail.com> <20260818192340.119297-2-boeroboy@gmail.com>
 <CAEjxPJ59MhYLc1ivJWVKX9H_EOvwyGKyaEHvULRWkFq=Xc-Q5Q@mail.gmail.com> <CAP+JOzQjN79NZC5E=SWGYE8q5UtJktadfiDVnk7ooijqsdyJhg@mail.gmail.com>
In-Reply-To: <CAP+JOzQjN79NZC5E=SWGYE8q5UtJktadfiDVnk7ooijqsdyJhg@mail.gmail.com>
From: John Boero <boeroboy@gmail.com>
Date: Wed, 19 Aug 2026 11:42:23 -0500
X-Gm-Features: AcwNN1V4UDMljjBPL_KrDFMFRBL4aap0JDbTNcSDUGu4kCUQvfF_fbGRNDQw5eA
Message-ID: <CAO5W59gA2+g2Za8gbii3=ZGviH6YsrhUMD6is+UnaURTX9et7A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] policycoreutils/setfiles: reject invalid -T arguments
To: James Carter <jwcart2@gmail.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wow thank you. Very helpful. I'll set this in my global profile now.


On Wed, Aug 19, 2026 at 11:41=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Aug 18, 2026 at 4:05=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Aug 18, 2026 at 3:24=E2=80=AFPM jboero <boeroboy@gmail.com> wro=
te:
> > >
> > > From: Johnny Boero <boeroboy@gmail.com>
> > >
> > > The -T option is parsed with strtoull(3), which happily accepts leadi=
ng
> > > whitespace, a sign and, in particular, negative values: "-T -1" wraps
> > > around to SIZE_MAX threads, which then fails a calloc(3) of SIZE_MAX
> > > pthread_t entries rather than reporting a usage error.
> > >
> > > Factor the parsing out into a helper and reject anything that is not =
a
> > > plain decimal thread count.
> > >
> > > Signed-off-by: Johnny Boero <boeroboy@gmail.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> This series has been merged.
> Thanks,
> Jim
>
> >
