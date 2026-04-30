Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586743A453D
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550494; cv=pass; b=LXO8HLAhwl6HjR2Nwr+AxnbrgExSPIWdDJmNrOt8EICZ/9FHbkn5PrhARlFwLHz1nKj/hRZCVAuUDEJhMzdC5FAbfFN+wtnUXnIvl83Q2noyvEIgyNFl3vX/37hWXjqPORRCXAN+JOvW4BcLRoFWQtXt3ZC6zXnvqdFa9rirh74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550494; c=relaxed/simple;
	bh=TdOcc5Gwv0N9S7lwc1uqHi6G0LeDEuDaN0k+eIwg1v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDFRoi+lYCyzTScyyqKIZWVwAoFoe6BvODDoRq8T53U9M5ArWcsuQmapP14aAEKOO1kwnESW+3eS0P/JkORTLJSdTqv6JjCpo5u0xK6DZtVaKo6VHizmwG1gYi1KNhQoVidhOLudO3ymuamtez2A2MosfMq5z9LGMLR03PalRvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T78OYH5g; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T78OYH5g"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-827270d50d4so836952b3a.3
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 05:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777550493; cv=none;
        d=google.com; s=arc-20240605;
        b=fES2xiLVgJ8vlk0TlExm1YIk2x0g+mSv0MCiY/3wboTde7ukP/SKbBypN1y7vDAwr8
         ISwsd5rvt1TdRPQxG2h3wIfcTSNWLgj/VWbvfRE7DMBnYr0wEqkgF5PPle6+coI2j5qb
         fs022a04+wzmuNfhKS0KU7pBDS+HelE5rbMmuEfikVUIq3XgPv+UQgza4jCRt4524MPC
         vjVMlxVLiNltYaSpDZc+qA+79oCyRzHatG7xL/dIEhqSibhVnrbdNGrCgV9T4haYLyJ9
         n6Mzz1/hD3G+1PqsxYAB5YqPNJHys+9gXaGtnCREXU7xCHAC9Efw02Xkr0r9wtsMQwIT
         0vGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DBRIQMT1XbgyA9f4wWh7nOtRauw2eKlXWKYGShdvB8=;
        fh=ZlKqpZpQp1DJ5c3Br8OchqalgDubFg3PTgpCIbXBxN4=;
        b=dCTctEFgnANGhih3LnGxPODYJPVG9jaXdgzuU5NgQBdZSETisCrDCUBfOiVq/dX3IC
         SW2J1zilo+2iMonYtkHPV6ZPe3z1ssfRJknuHzdaTPBmtC8z7N5zb9Yxggj35PZf/fzS
         kCrMTIt7EgJ7wN65ZaKmYY4RCItzQdf7+Bxup0heLHlh5qyo/0SMGKqYIV1ZnCbUDHPF
         9BXc9tUgj3Dro3y8kRxsFkxyGpeHxtoRPQGzxgtKLlhd7V2awLgrM3+VmX7kr4yQeZt6
         I5JwBl9b7loPyQkc/rgQi41ibFe3GnMrprG7IQsQa3zOZUgCPgjTN80Vk7zBhBqUBFIJ
         o+Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777550493; x=1778155293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DBRIQMT1XbgyA9f4wWh7nOtRauw2eKlXWKYGShdvB8=;
        b=T78OYH5gfBysRNGiKNh+9W4UkdHmZq9unEpqJcp7+xdSNUbs/gYjHVc+Aub/hlaNRn
         9qA9s6sASl/owcgbdRgEO5XKnLHLG9I5elWCIgaGP5QA8GMsYzW+rhvGOSVvu0A5+CoO
         EE73TaWTXpcJjedasrEsssveX83laUVt+L7KTbjfRsYhsmGI2m3AaVwK2RzWWvhIwtmP
         GSuMsGtDEuhsAPLQgQSz+MHTg9uQ5g0nf3Gb1Uzk+UVIMKyey02vV7XdulXatIZbqt2x
         EDpZaz4qmzCzOmq+/c8xlAh4jz0jJhIIp6ki7Ta2mIj0i1nTWx3EwpvmIJwbVHjPj9YQ
         FaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550493; x=1778155293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DBRIQMT1XbgyA9f4wWh7nOtRauw2eKlXWKYGShdvB8=;
        b=PUsetuV7NhbOPYrq3Cd93iNI3ezlQMI8qxH53kpIYMXPuEbDY5sTjGf/sxKcOcssnH
         /hgKpEqpPP647Y0svWT0WuWvae9rfxfU0pZ46x9H9R649C5bVoihhbs1+d16LutTF6Cp
         NLGeG+NMz2u/WmlvGHgpjj76NgaOoDQQbONGiwmqmNlwT0o9RvfeKWA2YldOkY9kQQTx
         EiCNreSZB0V7S3MhLQYYyHTomf2Sbg5IBfo4nFq62UFV1YjqH/e8ORIsT40I6k3MMqjB
         dCf5JxPOKZ2zmhme3JZzGstQf38LcHAlqvVUYQeunrxPVps6tyIT8I8IdJpiTT4+WVKJ
         O9Cw==
X-Gm-Message-State: AOJu0Yyhvoq0Pvw+nIT27dPjKqgJzdsDZ+5OABX7fESiZuIIyc3KBBh+
	LkEXJgR3q7vEdcjfD5gIYESBpsHdzIe05P6MXbfyNsqMOnxEPxq/Q/bTFD4tlKMirUKWj6MMfLf
	AGnGpe7t2VTalqhygnyTPDtE50Iyh8mc=
X-Gm-Gg: AeBDieurd3EckyHaRTuYYh066yop9ldTMpn1ty8qHruJXNPfcwTNNcIDI6jTwcWpL0N
	8ISbtcmxQc79NDSyTjC+0wT0s+J+Ua+CkcUhof58yiR/+gP2/T9uTMpRQ8HFNuJfNB18snz7V4m
	A37bJ5xyMj/PHrqjgEx6xGSRM6FgvNi2aHeYg3IxOCuw5t8sZfS09fZoic5wivyTeyusiD7Wh3z
	XsylNTVJUw5rdsPS6Xpiyn1vDCNB3JNXT74p3GurSqOJkMj152Dduri8RV1RB7WIJPfQUEWruf0
	IVxj4fljW/DKb6OMYpcQxZGXU7xI
X-Received: by 2002:a05:6a00:92a7:b0:82f:91f:bf35 with SMTP id
 d2e1a72fcca58-834fdb078b0mr3373412b3a.3.1777550492650; Thu, 30 Apr 2026
 05:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429211229.3750-1-stephen.smalley.work@gmail.com> <CAHC9VhRZ6Y5BvzUd_D+oeqRnaYk1NdfK-FpXELK00VkpHZBzGA@mail.gmail.com>
In-Reply-To: <CAHC9VhRZ6Y5BvzUd_D+oeqRnaYk1NdfK-FpXELK00VkpHZBzGA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Apr 2026 08:01:21 -0400
X-Gm-Features: AVHnY4KF_uyWgCKuUnQDkvHRrAukp1mX8hcxu0p2H-XYBiCiXu45HBF9mbAnFk4
Message-ID: <CAEjxPJ4UjVCvrMeT3nF5YvzKGdHgk3nMxBisXt=vzA26r8K6cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selinux: prune deprecated interfaces
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Apr 29, 2026 at 5:12=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > *** BLURB HERE ***
>
> *** REPLY HERE ***

Sorry about that - thought it would pick up the same cover note that I
used previously. Don't think it is worth re-posting just for the cover
letter.
As before, this series prunes already deprecated selinuxfs interfaces
but unlike the previous version leaves the selinuxfs nodes intact and
just returns a non-error status of the appropriate form to avoid
breaking userspace. Only one I'm not 100% sure about is
/sys/fs/selinux/user;
I didn't have a system with an old enough libselinux to test its
effect on e.g. pam_selinux and friends.

>
> > Stephen Smalley (3):
> >   selinux: prune /sys/fs/selinux/checkreqprot
> >   selinux: prune /sys/fs/selinux/disable
> >   selinux: prune /sys/fs/selinux/user
> >
> >  .../{obsolete =3D> removed}/sysfs-selinux-user  |   0
> >  security/selinux/include/security.h           |   2 -
> >  security/selinux/selinuxfs.c                  | 145 ++----------------
> >  security/selinux/ss/services.c                | 125 ---------------
> >  4 files changed, 13 insertions(+), 259 deletions(-)
> >  rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-user (1=
00%)
> >
> > --
> > 2.54.0
>
> --
> paul-moore.com
