Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FB258ECE;
	Tue, 19 Aug 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629909; cv=none; b=Y54aDIXbFJLvTKsfsDzNB03YTzTP2XXF+YdqX9njOBj0aWTn38QoSN9sBm5mVfVc7D22bCUEEpfaUsf9dFbx2hjA80tZu7WLhOfl3X/nDosIMtDGFL1zUFi6pE4JA4oKE4vchP3iiFZG87ZdznbOR56w47B5wsQCUvqcxMS3Qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629909; c=relaxed/simple;
	bh=rHQqrR9awc9iGjIkEB/xn4JTH0DWf9zfoZPAzieR+e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDp/y3lDHmxdfeeQL8ob94yLdFI343hGTtq5cJomGXoN2D0p2eQ5hvpxeUXmUZgxFfct3A+8Xz8mWOK+skhUAjvrtVCqlvxT3HCb8KhR0IK1oL46czjP00jj5bMoTok5KzYcb7VoMzERh0iSRxuYTJeZn0+8s/JOZl0AZOVqvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkSz/76O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkSz/76O"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445806df50so42369635ad.1;
        Tue, 19 Aug 2025 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755629908; x=1756234708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIaobvd0OUtyWkmHEExMq7PsYIyI2GQUyCk8KLI9Sds=;
        b=EkSz/76Od+VFX8mtL+zNzMAOEESKNPmgQCpro0jtmJTJQllnqNPF5pM+bHuQpwP3RM
         TKJHZK/r7E74yLHXRI6pMTufSHfX0+EsAGX9S81eV3NL2xc5IjPpSZNiKlaYXUM412Fm
         UfGptITkU5Pld8qPTcNNCT2oFuzV5zlIrsamnp8OhbWqS1nrC0+DXw6MIUnlj6LWmc9q
         peQ9bMiVt55SNp9Bh3eRRnpT4ZsnqIIuUwu7LIWI+grGS8JXdsRUPJE+tivE3q6bo0LM
         uBxLj8l7zUIyDA5/Sme8DcZ4VSlWgcTayz896SUOEeqbE5Ulk3kS5Bc8oXKA5czSaUHV
         oWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629908; x=1756234708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIaobvd0OUtyWkmHEExMq7PsYIyI2GQUyCk8KLI9Sds=;
        b=g4DLPp2bD7ZLe8sy6naGs4eE0QIJHIL17gucj9Xn8Uh37RNxcJwVWqAOXDr/2Cpgyy
         cUPA06CTOUwTfMU+sASdH6JIb9Uzq+akenRFMLYCGMsMjyB0Nos7yEXIc2CYR2f8NofE
         4+lJ5DhtW2l33j2WFWmZ65qLIRjaGdWs20Wz+Oom76MthdYlt7Y6/R/RhHlJGkgcWh1D
         mhZ2GNqRSgpCZcX2rxu1HteqAlseqFVdyeTVGf/rQW36tA5mLKKuJmZ0FemTm7QdAT//
         6pBExzUdRkcwbnoEfOETT84tPobm1qgwMOmav6vILkcVpXCaN95uQgSMpQfRKCK0w0Lr
         EJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNNYthK12NFBabZcdZoulDnES94Kxm4kF+mrH2s/bQu6NWVB2VS2d/Eihhf2NjodSSVYW8IR5qHw==@vger.kernel.org, AJvYcCXcKH09CISEjD1g22Ddxz2rVGaeDYKfvWNQRgCoE/74MFS5yify7fymgH0artvwILCb3/l9ePvRv0zNt/uW/C6WxdW1bEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xcKHMrNH+n+Kx/zlHzSlvYb4L6KK2sjDT45QC91S+qENOrSc
	FgaitdmrIY7PWYF+xisXM46F1OJg7gQGeDphqhx5YnoNjSSK/QM49o0Wi3Cxt/8ECvYRQ8p0z2r
	ysa+K1SKxLMVwO6cm3d0rA6ibnsPbS94=
X-Gm-Gg: ASbGnctNJa57GPxQUch2RCFDJPfoc7GSbbnXHXYL8wRKkzrY/DKB6n0kFdoSE5ELyw1
	O+At4U7Wojnz6fjaDNyRahnGsm7rASNSMXQuxE/j++68dThjWq2E4Ndh6i+Bu8zXbrR0weptsur
	n6e0eo2MhuY1+T57MAE+UFFbEjhz3lilj9RR+0ZMDlGEWyvA69FN3fD+gJn/VNZPUcWlnIMxsFB
	t8+OKU=
X-Google-Smtp-Source: AGHT+IFKvnB6MyC4sp/bNfOLpHICPMxKCazA9S3bUdqITNFb6U96ND5qaxZnNIQJ0RaNlW+e/8KfuyDUJ9QlBKlXLZI=
X-Received: by 2002:a17:903:11d1:b0:240:3b9e:dd65 with SMTP id
 d9443c01a7336-245ef25b7fcmr679165ad.38.1755629907679; Tue, 19 Aug 2025
 11:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com> <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 19 Aug 2025 14:58:16 -0400
X-Gm-Features: Ac12FXy5xUNqUTqPJDOe3ps596yYQP4Jldnt33U6IaU6sIoeEVRLqt4oexr_23w
Message-ID: <CAEjxPJ7NpSdfUZzzj0SnN8WuUv7E9SEj5v28x_y8R178_JMESA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 19, 2025 at 1:11=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > The advantage of a clone flag is that the operation is atomic with
> > the other namespace flag based behaviors. Having a two step process
> >
> >         clone(); lsm_set_self_attr(); - or -
> >         lsm_set_self_attr(); clone();
> >
> > is going to lead to cases where neither order really works correctly.
>
> I was envisioning something that works similarly to LSM_ATTR_EXEC
> where the unshare isn't immediate, but rather happens at a future
> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().

I've only implemented support for an immediate unsharing of the
SELinux namespace, not any kind of deferred unsharing until the next
exec or clone.
Not saying that would be impossible, but since I was following the
example of clone(2) and unshare(2) I didn't do it.
May be some complications in doing so, but I haven't looked at it yet.
