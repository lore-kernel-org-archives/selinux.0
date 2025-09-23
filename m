Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC72FD1CF
	for <selinux@vger.kernel.org>; Tue, 23 Sep 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632204; cv=none; b=smVltdUxx4aTEOdgTSdD4xxmgPqagNE6SAbGuzDTQs6qK84c6SXdqZHhHWyDFZzxaDI95GnFEY10v8CFhC5btul11OZJ5PkkHZXT+xamQO6IKnPKCR3zAU73FAluC8ElPghSzPvgP2/8tehFWHD7pG1CFze5zH89nnolUF6+R7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632204; c=relaxed/simple;
	bh=MqQXauR3TqW87nMcC/2DYpK5ng2fX7s92okPViRMOik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiQX2Wu7FGHWQ10Xzo1YuwRil1+RzkTXxgn7XkayH1ykwFZcrVKu04QuayiYS35XogFVKeTckO6JgyQqvJSYYSW1UnoAUZWse0rytn/TZWMc3ykLxLkVnvN5NqsKkKfyll2arT0xrTteXn7eYw1w4UDW4rT4oSOutqUFk/PBirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfpTgxDC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfpTgxDC"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5515eaefceso4163525a12.2
        for <selinux@vger.kernel.org>; Tue, 23 Sep 2025 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758632202; x=1759237002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqQXauR3TqW87nMcC/2DYpK5ng2fX7s92okPViRMOik=;
        b=IfpTgxDCrkM6+ZLQkXCivKay8O1tM1NXF476t/qfMRAT2OaY9hAeV94mDl5pH5UyS5
         NIAQo36inTG3Rf+afjO19gMIFZta2E7TXxlk+T1oBv/EynWqVXdPgtD/4IOBax1GfFmX
         d9rcD31vOnBsDYDKruoH1mv5gryQhjAXQq18QHimDfqdDpsJhwV6pUc9fy/SI4xctIS7
         qjp3iAAXDRGx6KktMyeMAcpMeFezGXSQbZdrAMKKHmOg5eFEGlOhWKDs5uuTo7WtzUx5
         /Tw8t4F0mNf2jLzHl7egOgU9Sqs63LEjSQuyk/JAkPVk5ResU5ChUY6WMoW0Wj91phcL
         Nuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632202; x=1759237002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqQXauR3TqW87nMcC/2DYpK5ng2fX7s92okPViRMOik=;
        b=UrepQEzFVG/v7piW4+XJmebO3ooJ61y4eLeiTET6yTOxOtqsHbmrEtPjIHQTYZeAcD
         4aSs5DQH4VVacY6tQxtjitO0z1ckN5X9VJ9vsDAWkk9BA3rdbeD27Mqc4fdt4ky9WqRk
         dvbA3rqZUuYvXMOISl/37LxameUFIzfkVax9K5iQd9pBEoPRoJYKjNUGSXgTW3yR+3KJ
         fTtM2at1/7shcmu2+cZnqrUztT8E4/gNAlaXURTEc47/Lj26DGbf8QLsP0vy42P0MGta
         2kmIPS3WS/Z1pdJh9+j9ztNdNxo4ylfb7mVJpeSpYG7wLICJn3X/P5Szx5PyKny/+XMq
         CfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7rpYqsgv4OrFhMliUBctPxDd9BHkPyqa0q52OCNAKJ6tQDq8/OW1W/tNN0wuEMR3bIWokjy4W@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwhxh5NsbrmhQqa2X2ic9JNKboCUAGcR+EfXGKvxVKOF/RJOX
	E6SDtyZhLjBX1gb/oJiKj8wizqbp1OMsG8wYXqb1WrVchnVg3XxwW4OiQKUIVhybTTo4ILm63QQ
	y02OZ7sCTt3wkiMi9XfjUsvs6qu2YleTNzw==
X-Gm-Gg: ASbGncvL6RDk499oQ5UhL76FNB7RMIwEBeiQw3GMHob+Ow9iUq9G/fkCSRuq6cGvXfM
	qhf7cSfoqRiV84EUdugCmFlq+BEVYY8zO/1b10UEpuMfeLhLuoQ394dnFiFh5NWX4oAeaIYJl7k
	GbwF0lxIz1i40NG9kNXcj17JO5+ABGfG/VAFSyBelQCVjuQ5D2E0Jj06vntEqmm8GA69AvWO/q2
	YrYAic=
X-Google-Smtp-Source: AGHT+IGIR0Dg6KTTkTNwsy5s1ZY0j9djaX4RlWtKd2ZVeVX+1BTDWUvJa7AvBD+scrggd/V0KUNGCE4oeJrfTtefwS8=
X-Received: by 2002:a17:90b:4fca:b0:32e:381f:880d with SMTP id
 98e67ed59e1d1-332a951400bmr3316417a91.8.1758632202343; Tue, 23 Sep 2025
 05:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055026.617170-1-tweek@google.com> <CAEjxPJ6HmLe5c-iosTvfDYy5EVz8xNRq0=A-jDKTKXvCNWMypA@mail.gmail.com>
 <CAEjxPJ61HCx3xz5HQwVKD+-9ctOL9WjuQ1mXu435eg9k+JRsTg@mail.gmail.com> <CAEjxPJ5qJBpK+gioHBWcju3KdrSStZ9RAWL9XVuguQ90DSvYAg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5qJBpK+gioHBWcju3KdrSStZ9RAWL9XVuguQ90DSvYAg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Sep 2025 08:56:29 -0400
X-Gm-Features: AS18NWA4xjlKSP-SGL55-XzHvC-8YoDNp76bhoUaSdgoNBZycJ2WAskL-nip--g
Message-ID: <CAEjxPJ7aQjuKsNyip+Gy14tig3rMSd=R59oBxWxnvWzM0k-d4Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add memfd_class capability
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:44=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 10, 2025 at 10:35=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 10:20=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, Sep 2, 2025 at 1:50=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@=
google.com> wrote:
> > > >
> > > > memfd_class was declared upstream in [1]. Add it to the list of kno=
wn
> > > > capabilities.
> > > >
> > > > [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@=
google.com/
> > > >
> > > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Will re-base on merge.
> >
> > Thanks, now merged - note that the policy capability number changed
> > due to the previous merge of the functionfs_seclabel polcap.
>
> With apologies, this has now been reverted due to the kernel revert.
> Happy to re-base on top when/if the kernel patch lands.

Now re-applied, hopefully for good this time.
