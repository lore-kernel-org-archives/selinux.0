Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8D377ED4
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685291; cv=pass; b=XPphkYnpXvB/dvnmYkd1XUaAdk77Ipcwa6mAV9espKvEi7GlUOwjTDo7KRE52eJPUK/RsHTS33CwtNgZz7VhHVOhTYXsXO+IXE4KHwdHOuGcpIdg0GA7ErIKQCwxnh78jBn3Jjj8VvGf2yWeHAFRW3N7sNzA4pXgcOz0N0DKZS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685291; c=relaxed/simple;
	bh=NDEcq6Hi125cadGZd78dtcjOu9bL6O/aBeYmpYsBxj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXUbfaVKUBEXX0FvRZjx1kcoNHhTNswEFyRfZmra77KXFqkTd3FY73QYSFNusYSwcPcmVyH6Vk0RMUZQ/uUpXZSWFtcK3Xj//aHCj5yG3r40lBYufSJech+q3HqaYflPSyqrFM34rasij8rJRx6sFKNA0OTgdEYJV0Msdnx8L6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK4f0NOQ; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK4f0NOQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c35980fdso22791615ad.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 11:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780685289; cv=none;
        d=google.com; s=arc-20240605;
        b=j5+4F+1S5BxjyDqdb0PmBjng57kifhklqLIcfRcV777y4kv/QuN7hiZryNA/rxN4QB
         oMuXXuOKp3YjiK0iU7Qv8+nNEUcisbo0a2XVXWW+6JQWoWvRvR9Q30vlnO6ogGE40acs
         WVrRELex3tK3tTq9Jp+4sYtU4pgorSfhLrGYOcOxDQeLpeC9h6gSuN+3ecrc1K/NJ1Fj
         ZNlxy9dRTOHEZ+haPYycs5XSvGnP/IQBtMiulEibmu5HZMSi3UuEsSkJ6yOdeQuqu3mC
         KtgAj2dc0iCs1HeobBEP4p9trPRmdaGeaYed+sYPsTdtNJ8HW32GsUIYSmGqj1eYO15j
         KZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0o+PelKwREqFCPOFWlA4Qcg32rByFIHDxG3wqyFsVc=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=GceWjbU8RKMQ6IkvXEZ/9ISXQidkqH7qfOi3gwhxsvio8RwKVpQi/Qwja+yKKTrTxW
         TaSbOGYmQ24W4tHaC+72OUHje8AanWAw//jURgdd+dTgHXjwbnvw8MOP2NeZ8wHj3eRf
         CqeREJYNsPB1Ybm7RRYUPCniEPy9SuweGwiGG6KgUSvDGr7OIgFCy4k89MixWZWbCGGK
         O1vZTQhZDb6XDPKwWITB9KIzlyLrqPSZlnpjuapALReR7VCV7T2IkNWKA/W9kIIQM1Kg
         gQRCxHwinO/QPM997PoZn3oX6gLJNXEOlJy71afKo39sb0mcJ2A1AjY1qyZqolWIhAJP
         PU+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685289; x=1781290089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0o+PelKwREqFCPOFWlA4Qcg32rByFIHDxG3wqyFsVc=;
        b=nK4f0NOQ7UXb8rJSA3Gqb6xGk4ESiAthVI8Fv/uSsWo3E3J4XKX3fxeUBTCNpbI+O/
         051qq6ml+OG7EMfdNnkuTl6GdRD4uI/u14fb3CZYg/+nRxMx719QS3ovoeNlsLEURSD3
         91IH1MMIRN84s2zNDJzb+1pl4dIr2cZh7709xmr3AxEoYwVNItRW+nm/g7TRkQqJPrA3
         e5Xe/JDqilqXPCdiFUd8Yk+10CpQ4JcF73pHQHrHy6YpLQ2/mU9Oj3/AWfvLElJjhSyj
         WXC8nEbHKz92DF5sLR6nQ6/VPSz8bRTf0otoRL4U4LH2KApJ5SOFRAlgkiO2bdXvHI3M
         EjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685289; x=1781290089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0o+PelKwREqFCPOFWlA4Qcg32rByFIHDxG3wqyFsVc=;
        b=UMzH4jhZ0y+QsNxUqFK91jVXtO1/qZaSr7mb/Ni+ahRM89Xlwok+/SSgr55UGZHbED
         7vmeMvw0XOmJ1Gt/j+xrRWo1iq4vOJidqburGzCkj84o8e+BBpb2XKSoJ/sl5LbOWOxa
         3eY5cexWEvJJNIJEtbkEuDjiQHCPApVvGOGCLcOWn4vNIS2h0Frh+7HOCSuritxmnhC7
         zTnsUXY9XCAL4NM681dvVsKPO1PMKnEalH3DRnQPJkeH+bkSfBky9A7qewF1JKB/epBm
         Ioo3P1xychmKHlSrFoziKWKYdR8cuJ3Nzo5j4S3T4WCIq8Djx9YIq7rFIY0CVn956tbr
         lS4Q==
X-Gm-Message-State: AOJu0YzmZ2USzF1D49Lupd36TVDs9m/kQq2U5K2giqVZ46fTg57pspK5
	kXSc3Iszp1tj4vksZJJxXQS/WgYptH9dekasexTc+vODTvka4nLWOns83rhJw3QtdS+Zst8yomd
	eNf6vi8zQGu3DmkcSss7saN3JM1bV5NPCqQ==
X-Gm-Gg: Acq92OEpZr0q6dXTAJKTZR1JRhJ41y1iPxmfgnQ2qR3WKUTle4wfp4Kseg5oPmlmERz
	drhTBjvH+HGKzaEX03FfIiMJngVjjKxbxenbJcaFc72cDDxHgCZ/Y/3J//O6mYQN8aPuXhE+R8L
	ebREufn3O5kPuup+myFEudITzEhuakx4t9ecr8683Aui1Kt+onLj7r+Rx/UQZ3wQKBvnl3QQ6ZM
	cZMB1lEw4khAk/du1cm1VDGfPzIZt6XdnEOaJkXhPYAWJwyNGMRYglqCHTqO8T34fSH66l22wb3
	H/+Hxnlyqa+VWMmaOncffylv0kOU
X-Received: by 2002:a17:903:1246:b0:2ba:924b:3948 with SMTP id
 d9443c01a7336-2c1e821dcbbmr50863335ad.15.1780685289104; Fri, 05 Jun 2026
 11:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605181441.248083-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260605181441.248083-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 14:47:57 -0400
X-Gm-Features: AVHnY4IItb7Z6CwturhcUnlQiJ8UJN8C24Z-FT_hBQhtDHVvhAOaJlvAmaqb8jc
Message-ID: <CAEjxPJ6OPe8vC-++R=LCk=ntei2hmD4z1YgEngP=kSo11R7OuQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] restorecond: warn on selinux_restorecon(3) failure
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 2:22=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Warn in case selinux_restorecon(3) fails instead of ignoring.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: print to stderr when using custom user
> ---
>  restorecond/watch.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 8e1c36fe..a30603c7 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -202,7 +202,19 @@ void watch_list_add(int fd, const char *path)
>                                 continue;
>                         if (len > 0 && strcmp(&p[len], "/..") =3D=3D 0)
>                                 continue;
> -                       selinux_restorecon(p, r_opts.restorecon_flags);
> +                       if (selinux_restorecon(p, r_opts.restorecon_flags=
) <
> +                           0) {
> +                               if (errno !=3D ENOENT) {
> +                                       if (!run_as_user)
> +                                               syslog(LOG_ERR,
> +                                                      "Unable to relabel=
 (%s) %s\n",
> +                                                      p, strerror(errno)=
);
> +                                       else
> +                                               fprintf(stderr,
> +                                                       "Unable to relabe=
l (%s) %s\n",
> +                                                       p, strerror(errno=
));
> +                               }
> +                       }
>                 }
>                 globfree(&globbuf);
>         }
> @@ -286,8 +298,24 @@ int watch_list_find(int wd, const char *file)
>                                     0)
>                                         exitApp("Error allocating memory.=
");
>
> -                               selinux_restorecon(path,
> -                                                  r_opts.restorecon_flag=
s);
> +                               if (selinux_restorecon(
> +                                           path, r_opts.restorecon_flags=
) <
> +                                   0) {
> +                                       if (errno !=3D ENOENT) {
> +                                               if (!run_as_user)
> +                                                       syslog(LOG_ERR,
> +                                                              "Unable to=
 relabel (%s) %s\n",
> +                                                              path,
> +                                                              strerror(e=
rrno));
> +                                               else
> +                                                       fprintf(stderr,
> +                                                               "Unable t=
o relabel (%s) %s\n",
> +                                                               path,
> +                                                               strerror(
> +                                                                       e=
rrno));
> +                                       }
> +                               }
> +
>                                 free(path);
>                                 return 0;
>                         }
> --
> 2.53.0
>
>
