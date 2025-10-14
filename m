Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3530C371
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445409; cv=none; b=gC0drfnAJSNE1ircOZCUFxpEn1G9E/r/U7alKssQkkEb5DFnhit2pxHwD1KPhBip5jnh4OFZRn1MzatR/x3u6Yx50z7Wa3ppDO0FTZWao4rRDJPSTiXp7AST/a1U1vaETxvp7zKwT0qAHzgmi2cJoI+3UE9zpfrint/4Sgi2gSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445409; c=relaxed/simple;
	bh=RHV27hcQOpu0iwNyP1JcqGkwe7y1MgkMGppeLGkx2qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g98zN//6TfxKhjLC1GoSx8Gj8zHf4R3tawpY2baJlWmMyFoHK5v0voLuRcAxi8c6yqSQlg+x6JEAlQQZjmGgm13SKEpu9rN1fY+kiye++w08djZP+//QQGWncZVApnfjNqI1ju9dPm4cvfUppvzKaF8iksyrid5KyzXV75fV1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbO7vZ6e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbO7vZ6e"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26d0fbe238bso38075295ad.3
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760445407; x=1761050207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHV27hcQOpu0iwNyP1JcqGkwe7y1MgkMGppeLGkx2qA=;
        b=EbO7vZ6eTSZDCgZKGrsu40BrYZ16Efo6tpixLFldg7R9+yojt0mt/3GrKNvQbsNqBd
         U5O/O3a4V8wQXiig3YfDNtWWVnPYqPJrNRUA87Ro+JcLQVNIILCJD2HxaZ+bu4SwFLok
         ZC4e6mAaZrkLJUeL9bGLQVOIndiye1fWF3IxTsNayRXYV1ONzaEf1kS6p8HVO5QskEqF
         WtU7Kxows1MfzF/e2+ik4POgfAekjOTBLu/aJInPpvsWsKejvFDiHLKKN5K+1RwvrcaS
         2fpmMbP7y3xTcsEtwbnczGx6XSkrf4scauYNMhMN8oeT9TJvTKQYDjorXt2q2Fxau81/
         EiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445407; x=1761050207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHV27hcQOpu0iwNyP1JcqGkwe7y1MgkMGppeLGkx2qA=;
        b=p8IOykf9P+eEphdb/9lfGxm/2S/7imtNTvSBa3Hrp9g+Z/HDo4y8mg8jxGPWF4AM/u
         iyxZP8Df568m28IVAH/97Od7N+6H3Sof2DCG6pQX80EzOe2GUg678Nm3Ekr8H5BE0+Ll
         o3TCmuKiZ78vAVvL5qeY+3CPkJ0j7/uaAfOQSIq1sfkUrvYTW40ilrEArGtZUmvaWucF
         WcgS3iDCwnJKy2uqTkKAvrSxW70Eg7oo2L7DOuTNKQAC3Jer8nswn9w8cWT/2lMuZl3s
         jh7wXpGw962JSuaVxhmTQWcIANng28ZFyv5vzGRwpYtDON6GtdwSz09NIK7fCB5ea9Ic
         Ve7w==
X-Forwarded-Encrypted: i=1; AJvYcCU1QyRqcoKABbv4O6XHuySPqJopXkbPUgpFHLb5Ld44W9radl324IuvPH3vjNWWbm1lPXk62apy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrnb2t2/VTrIm/KXpG9PMlITPsw+dC9j4K2C9s5Djjme2uAgZl
	gd5RCIz3+VX6sA9ybsoSxoxGp6KFbaWrSRP2XFP8+cI9g9eGqO8sSnf0woJgycVfDOjQUlHA8up
	iYvfft0eheEFclNRbjiJOAl5GMXWuPqnXfQ==
X-Gm-Gg: ASbGncvEIm7U5ypxakyLY87v+E902qVdM8ezKa2+oNTeNNdYFIAGJk4gGBljhbCxtQv
	7n5kBoergnvy9k/jA57zkt0fjqGFZLf9SJZRo4WU3bOEmIUWlLTbUuDfUgP9ROEu/e8XqyIDuiw
	qJcmKKrQ16CCOGLafCZX8GWAoWa3eeLS41S16enEq2I81FioiXpmypLhruvFcUAGnPg1bgxPKvF
	cc5z+H0w/b2BP+bW0tQ3cy+awYkQnzkMVH4
X-Google-Smtp-Source: AGHT+IHloQXhoPV44NeqwyU9+jIqjyk6RrZ2abUe+HtCi9AkOsPrAEPoLLuGZyOoCYG1fqeZ8j1EvNo1V4xH6de2rKI=
X-Received: by 2002:a17:903:2f0e:b0:248:a642:eec6 with SMTP id
 d9443c01a7336-29027402f2dmr266262745ad.50.1760445407047; Tue, 14 Oct 2025
 05:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DDHWVS1R3X60.17PAF8BR4DEWA@gmail.com>
In-Reply-To: <DDHWVS1R3X60.17PAF8BR4DEWA@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Oct 2025 08:36:36 -0400
X-Gm-Features: AS18NWB45Q6sv6es0iJCBdB0N5JRxh_lOHJ5S-u_SbVhVTntwh5NiT4shnnPVg4
Message-ID: <CAEjxPJ7uSGfOTi8L5WzfA50ZH+kzxNvRGtooMaNuS-iQwVay_g@mail.gmail.com>
Subject: Re: [PATCH v2] default_contexts: introduce PAM stacks
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:44=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> > I'd like to see an actual implementation of how this will be used
> > before we add it to libselinux.
> > Also looking for input from the distro package maintainers.
>
> Sure, no problem. I'll have a patch for pam_selinux(8) ready soon as
> well. This patch goes back to the systemd-run0 discussion we had. I
> just realised that if we're adding this to default_contexts, then we
> also want to probably add the same functionality to contexts/users, so
> I'll send another (RFC?) patch to document that too.

I think ideally we'd provide an extended libselinux function for
reading these values for use by the pam modules to avoid exposing the
file format directly to the pam modules, unless that has already
happened.

>
> Would you like me to ping your github account (@stephensmalley) on the
> PR I send to pam?

Sure.
