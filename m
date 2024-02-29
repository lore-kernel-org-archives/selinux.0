Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D047CF15
	for <selinux@vger.kernel.org>; Thu, 29 Feb 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216259; cv=none; b=NipXhr39Ty2LAZL1NolI8HXbj1VwZXSQd5xWN5/lJWUR9nFnG3Y1P59l51p7WxMoc2Lx53zKaRitI/W1jFBnBXwf9WCZhv5aEoxcY3VVYdLM1LZr1RlVFLf2DL5Xs8odm8/1lCIxu3iPTNZ2cWySJ5NduTfj6MKBfkSAErGHkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216259; c=relaxed/simple;
	bh=E1p/aIZGM2ULOnGjO8mKQfNWvy5IfdK02QyTJIJdMxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBt2yZvZrnZdFd+g+s9/WnmK2bubNUDsyeCsMvyl7+zVsxRwyUZnQ53KozwnDhB1kKcLwX1IzNVBND4KbEprqtDPgIulr/UGeO1SIAWhYjx5gHiELpSnKTteUDCLU/kCkO1xoRXHPW+M+bMLiw1qIkzX2dGBg54NHD2oMbRsgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m85N9983; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m85N9983"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9b28acb4so686896b6e.2
        for <selinux@vger.kernel.org>; Thu, 29 Feb 2024 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709216257; x=1709821057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrLKT+UBz4/hBRntJcW9vSYTZvbmkVQa3TzhV3JpICY=;
        b=m85N9983Mk6KsNLZid9lqrxkrTcMOkH8TwOqGZ2BQUs5q7ELrbIaxisqEd1cX+JYod
         h6mirfDXuMQ/FZ1IGz2uikoZZe0AxEf26e+Sv0y6pDoyRsx9ONgepEi0DhZNcMFjnFUB
         zYPh3gn7KVgSP29X0LbgS5GbZE0VbazNvFtZh5wMVwPc+h4BlKIOUUFGFaz+LOZ/8X+m
         HEwV+EPHndUU95B6EP4wZ3+MKPse6Shrj8wzlx/Y1tb4mpC0ndtOr+K4Je00AinfgvkZ
         jwCYjokmbRpDrk0lLE4AjYSYmE0KRZldMql/e/ertpRte6iTyrSoUOcMeEF+wqR8uuMb
         wWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216257; x=1709821057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrLKT+UBz4/hBRntJcW9vSYTZvbmkVQa3TzhV3JpICY=;
        b=F4TdHYpp5OxOYNcIsLVKZF7DGjGoi5+eOR/Gk3QCdzZBTMJNPaa72vBbygjq8mm8bJ
         djhllAQY1S5g745EV3r4JNlsBIyHlCyham2UMKYwtlh6RwsA6JAJXo13KbJ3uiJOB0T1
         Imz8XgXQW/U/eSQqYyuMCAGkaz0JJ4a4B1oBwUqCrxmWfAhS9PEjyuenuMk0DjXY7i3X
         K5OQPIW+3Z9dDU+1UjGx1IHCeIlL2lOaSPPyTUZKkRKrEIb13PD/CbstuyboqV1FW2zd
         z1T9XWcgZ4LaviVDC+ayXj8RSPmXc/euQy+PrRUowMngw6J2xJuJ3vyo/AHtQzQczhza
         3eig==
X-Gm-Message-State: AOJu0YwzIg5ybl9PBjxd0wmsp9L1Z3Mpr9QB+dRbxgliPtvRo2Hh4KfX
	aHP3JZqQdpgAAiKPzBZIcZhe3ar7Xlb28GptrgcrA1Blbn85I9QdLW/2MNL6TGAe5ebufznNFt8
	sbaEm9Z9y1800vbZN3w+G1mA+ipI=
X-Google-Smtp-Source: AGHT+IHkXlMScuseYrMF2AyKM0A91ukvG5Ra+wlS8mUJElpiAuIfjxRf+UDiPp3dn/S3J6yxiH+xNpNaToZWWIAAYWo=
X-Received: by 2002:a05:6808:6349:b0:3c1:5749:d9ae with SMTP id
 eb9-20020a056808634900b003c15749d9aemr1964893oib.33.1709216256847; Thu, 29
 Feb 2024 06:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207150003.174701-1-vmojzis@redhat.com>
In-Reply-To: <20240207150003.174701-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 29 Feb 2024 09:17:25 -0500
Message-ID: <CAP+JOzTd1mwA+yy-cgfgMDGGLC-+Fzn4fLj9X+=GKOeyQUcwgQ@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Do not sort local fcontext definitions
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:11=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> Entries in file_contexts.local are processed from the most recent one to
> the oldest, with first match being used. Therefore it is important to
> preserve their order when listing (semanage fcontext -lC) and exporting
> (semanage export).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Not sure if this is the best solution since the local file context
> customizations are still sorted in the output of "semanage fcontext -l".
> Adding a new section for "Local file context changes" would make it
> clear that such changes are treated differently, but it would make it
> harder to find context definitions affecting specific path.
> The most important part of this patch is the change to "customized"
> since that stops "semanage export | semanage import" from reordering the
> local customizations.
>
> Note: The order of dictionary.keys() is only guaranteed in python 3.6+.
>
> Note2: The change to fcontextPage can only be seen when the user
> disables ordering by "File specification" column, which is enabled by
> defalut.
>
>  gui/fcontextPage.py         | 6 +++++-
>  python/semanage/seobject.py | 9 +++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/gui/fcontextPage.py b/gui/fcontextPage.py
> index 767664f2..c88df580 100644
> --- a/gui/fcontextPage.py
> +++ b/gui/fcontextPage.py
> @@ -133,7 +133,11 @@ class fcontextPage(semanagePage):
>          self.fcontext =3D seobject.fcontextRecords()
>          self.store.clear()
>          fcon_dict =3D self.fcontext.get_all(self.local)
> -        for k in sorted(fcon_dict.keys()):
> +        if self.local:
> +            fkeys =3D fcon_dict.keys()
> +        else:
> +            fkeys =3D sorted(fcon_dict.keys())
> +        for k in fkeys:
>              if not self.match(fcon_dict, k, filter):
>                  continue
>              iter =3D self.store.append()
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index dfb15b1d..25ec4315 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2735,7 +2735,7 @@ class fcontextRecords(semanageRecords):
>      def customized(self):
>          l =3D []
>          fcon_dict =3D self.get_all(True)
> -        for k in sorted(fcon_dict.keys()):
> +        for k in fcon_dict.keys():
>              if fcon_dict[k]:
>                  if fcon_dict[k][3]:
>                      l.append("-a -f %s -t %s -r '%s' '%s'" % (file_type_=
str_to_option[k[1]], fcon_dict[k][2], fcon_dict[k][3], k[0]))
> @@ -2752,7 +2752,12 @@ class fcontextRecords(semanageRecords):
>          if len(fcon_dict) !=3D 0:
>              if heading:
>                  print("%-50s %-18s %s\n" % (_("SELinux fcontext"), _("ty=
pe"), _("Context")))
> -            for k in sorted(fcon_dict.keys()):
> +            # do not sort local customizations since they are evaluated =
based on the order they where added in
> +            if locallist:
> +                fkeys =3D fcon_dict.keys()
> +            else:
> +                fkeys =3D sorted(fcon_dict.keys())
> +            for k in fkeys:
>                  if fcon_dict[k]:
>                      if is_mls_enabled:
>                          print("%-50s %-18s %s:%s:%s:%s " % (k[0], k[1], =
fcon_dict[k][0], fcon_dict[k][1], fcon_dict[k][2], translate(fcon_dict[k][3=
], False)))
> --
> 2.43.0
>
>
