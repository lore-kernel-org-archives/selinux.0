Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35C34CFAE
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806782; cv=pass; b=Bok/0NTbwx4qzlfzO6gPqv1W/iKyO2NiRatYcoTq5cxKBPpOOkbKjiFotsQK0lkmOZ+3pSvxjtDS2YU8o8WH5hpDyYod9l6gck+KJ5JMmu5QRH74k1e3SwwESWi5STHOkBL6D07TpAy9Y3pYPTMx6uEXb3N3CALG19pHrAXp7aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806782; c=relaxed/simple;
	bh=lBJXxMM1+a8NV8eynoFi0HzriBhHUBdh1AMnLqp0b0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q20MI05DauI5hLzZ6t6TlDSpHHyblE9Bs7YtenKHVqbKD3q+T+2zi9lBSNU5xImV1i211WTW2QsePw+z0nwEFVqwve1BMkXbW+ydrsmITFSGOcMT//9C6yDqun3aBD+oZxc0VgDER/HEWhec3CeaRvzOShe5QScSfnRE3NECCBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sW3a0ZSG; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sW3a0ZSG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so4328154b3a.0
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779806780; cv=none;
        d=google.com; s=arc-20240605;
        b=XhrSxJE26VVy5Ts0mo0bqVK+oYK4V8wrMC08e2oftWEjgRygxwvmiiE4LgIbi0/mHB
         ySXtLwsbnL8eA3Kj95hBZSfObIT99qp1Y9Wda7iL16IdIU2KuUq/kMTJDyr8gof14NoL
         iMobv5ALRBofR7rYJdjNzWfzIRBL/giOrkMBDATR2t+vpExWFH9Bj7m2vgmlR2TrdiaC
         cVwVumr1GCTPzsjH+Mcuj0G+RZ/3xEshw6hc/O20JPF7AOi5r58qZS+2nBd+oWL9npS3
         IXUd94S4FfrEb8e7ETNpMUXox+L8x9OUn/aPQHOb1ucazOgru97jSyt34MTg1IeFEbU3
         ZiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lBJXxMM1+a8NV8eynoFi0HzriBhHUBdh1AMnLqp0b0I=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=ccfDymfFQi5/OSvvKiXizGa3IsejZUlWtXorIW7j0cS0wCo6XLgpMPO5+wY/z4fsXz
         kzE+kAmCGZrgcIUduW4GhJjeF8/55cUBJNqVt3pGPnUj2D9U8IfiUxIas2BA7UFSFgIe
         YoUOEzL14KZ8dyIa6791Vw/Od24/Q2QGQ6fdZLZu004fT6dE8ZelYJWsZX6nHf9pBI3e
         DJN785Chyy+b8iaoef89gUq+JETwM++EESjUtDFL177ycqX7qIIPqwFAssFW3Memj23t
         8+eh5N2KEh8j4zaXYbKxUOe2umTGvC33Ev09L0PLKXLXAkOAyFabFQDp97Q2J9zBkHcF
         +gSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779806780; x=1780411580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBJXxMM1+a8NV8eynoFi0HzriBhHUBdh1AMnLqp0b0I=;
        b=sW3a0ZSGe8WmNaYQiZqIT8lhBcqtF+10sop3gdZ0YP/sEUjJXRPI7K5lZ4oxDS2vHB
         Vh62rnjIkCSt1+1CX4gQqNXSPh5DQphKPPPcfR21ZpGMi/LOqLxWxqmw2BMYJS6X8Qsx
         Ra6w0z+SKfg+ruk3mx5a0fzn7hPiV84Vr6wOqe+dimzPLD+fKMUN8QR7z8vJm4qzupUo
         FrBERUunUbmiOWdtxr8vDnVCR49ApLix4eO7WJOQ8DI0N13gXvc60Yun5XxJ1t0gEc6T
         xW+Vpx2PYqxOlmj8Di4x4C5NPn2ySepeAcTY7YKxeoUIXrR3cGOy8mt3EehfP3TtIUdu
         57KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806780; x=1780411580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lBJXxMM1+a8NV8eynoFi0HzriBhHUBdh1AMnLqp0b0I=;
        b=Ws5saANXLCM19J0fC/oYf5thGjEIvju+BL5T4cI1AwBfGsXCOMm1SB1CYAx1WzIn1b
         4c0rYt0rC8uhwHjRWa/4UDUbmk7Ta1S4mZNgA7OOSXCFLPyCVNphqJaPFdkKemKYr44y
         /CRAt4nDSrBf8XPaxcIG/aKJ3LusoXUf2a5Hhy40LcR3YzXLw6RmfjjIFzmfXu9QSBfM
         71oLPmizwHtNGkufdIKspqFpGebV2zgX0ZsUvghS56AerHF6SGTjOZyRV+PeBdC1xWbX
         sSmQVLCc8yBKRCQVPTeIdR6mkBxPebt1wGsLI3mR5YN6fWlxpADdzjS8q8Uy6hz+XjA7
         S9Kw==
X-Gm-Message-State: AOJu0YzuAG5J5+yJgjIC9rXRuC1/ApkLm3Gt597p6znU9RFdxfOkuV8S
	YL9zyNwFh+1E2hsVqNt4WQzaWqDmv4XeWrMlqx5uKyFeGYUQxjN0ghKv4VhiOqYV10L2MgROV+s
	YrwKqYY5mBeEzLm87Ew8X4sh7bUOU4npceQ==
X-Gm-Gg: Acq92OGxB2b986cykgKBHHfz7v6+48VHjUhi5jJkHTKI8nBTvVRr+IoKbxHPxrpm+Oc
	I89u9+i822jq69KwhnDShToD30odlEpmDK1CWpTfMf0t1Ko6NDrp0XC+JSiHmGJhGI6onkyN/Bd
	tm9Pz0bSHrwAG2YFFDbiOvqOQjNk76MIJkXBfjIqGpGD295+z0bjh7Nd7zYqn1YfJxs7yYLfbKE
	N9pwkMZCKpezoykvozEO68NJ+cV+3n/rwgCeIuEyz6EBZUEhgnCq+ma+F1xVZ8sghTkdV+GSYe1
	33ZaPo4=
X-Received: by 2002:a05:6a00:4f94:b0:82c:6da7:2d3d with SMTP id
 d2e1a72fcca58-8415f3d0e36mr17019175b3a.11.1779806780192; Tue, 26 May 2026
 07:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525161704.228092-1-lautrbach@redhat.com> <CAEjxPJ4qTxikR_RrMMwnG2YJv1qtOtQpu3UBNCRPN6xbM1x7GA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4qTxikR_RrMMwnG2YJv1qtOtQpu3UBNCRPN6xbM1x7GA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:46:08 -0400
X-Gm-Features: AVHnY4KS_L-MSM70iVndVjXMt1L7FEFp4PrEcNA_cWRQZqOCbYCLg6OTXleygEI
Message-ID: <CAEjxPJ5uwoK5LfRx9DtAFNnSyRZscbc4pkt-+b=itKinciJhmQ@mail.gmail.com>
Subject: Re: [PATCH] restorecond: Do not unlink pidfile if not used
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 9:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 25, 2026 at 12:17=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> >
> > With -F or -d, restorecond does not create nor use pidfile and therefor=
e
> > it should not try to remove it.
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Is there a reason we are using 0 instead of NULL for pidfile despite
> it being a pointer?
>
> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
