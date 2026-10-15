Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB02641FC
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074051; cv=pass; b=TKs2j4OCSlw4LjUjlbCDoUjOq8tMsUqDHsG1qNHdOO0xBMDCAueF0t/klxugRp+GJcP6+Y8Bi5Do4co3l8a1gpyPhJarp3FiDkghY883N2Jg7amLmT2O4Y+pbr8Fk7YR9BHpQLGPY82tMqe0NUN4Z7TSkdG7soF3eDqcN01LAEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074051; c=relaxed/simple;
	bh=pl/h/WeLSRS7atJLRBWQ2O8fUSkD4Huu+hR605iMxRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSrgIN1VEN+5DHaiuY2+z6j2w4DBkRt8Nz/yV2jKnChhDv8XIogFD6fE/8zmvOa2gB2xdl4gERPWiFqpr5HXxjM3wvcWLSqqRyvnco2PEUJavUq7yH/9xXOwZulz6RPsQxwl8I9cmeZGFqZXYAA86U3+sTq/VYaZiBL8Mg4Cjq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed5iXPRS; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed5iXPRS"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-679334baa1fso4675677d50.2
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792074049; cv=none;
        d=google.com; s=arc-20260327;
        b=LWLotOUp+bgdu3drVjBP15MZBDboez/MLQHNZGPrDeQcDXjsNS1pCVQSU9/mx+KIQR
         i1eyP4zt510a/7XeGPoQyiFPxRuxND2uV4LOJunQiaJyQnSs6RYeODIQb8o5BXQhkmOi
         6tbI6+VPkkr2XE5Ib3Pnd++AXIF5vXNWu3Lu9OQyBA6Y4L/XbP4XpZ1GTxTaCydYVJXj
         TbkJsJ2ieT4sOO7t2uqfE2L3bWijWk1bG16YBS4twQqEkVRJYibs/vHT1J0/5gmhJKoH
         +BDGWxuyHUTjpX/CLHEuBhNXKJuguRjSN+Demb36pISKXoHclsGR6IUxFSNNfKMgYHqN
         vV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pl/h/WeLSRS7atJLRBWQ2O8fUSkD4Huu+hR605iMxRc=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=E3DMtYFqL+giiJi32fns9KOFUPW1kiu8lgW7LX0rI7FBg2fjK82HDKzSgRGOvuDze9
         Bk5zNgZQFlmtamdxgrCHfzeuMyUiLnwX4bngDTBQ8d68lH+dxPYCkXv2dw7y05ZIxewU
         rLne2HgMEpGYFiHry0fZK3OLapk8qCSp32o3X0Bmj+aSSGcv1pbqni63DtDIq33+ncyS
         2yVUSRpEgK1SpYPlQPPlnESCW9Ohv5x0A3Sys5cRSKYEus3GQUpXcy7fVfd70nWz1L+x
         vYbd4WraSlpo6TIGEqRyiOoNSWDld6tpdOO+F3VNICBlGUcImaFRmi0rOyNmMDV58r1v
         UORA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074049; x=1792678849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pl/h/WeLSRS7atJLRBWQ2O8fUSkD4Huu+hR605iMxRc=;
        b=ed5iXPRS0FtvZOHcpnEsWh4NhgJIa8r1Vg8OrbA+vRT6pWazAFc0EPdqh6K2iRiXc2
         7zvqW2JTTD9gFIG6MhYPLsbgpbaXZ9YEivdBom8+aFF8fZuo/dW+iuMZTL0wKhbNzscD
         U1e4dGw8nv2Ff7x0H4n4mkHiEkuZH1OaxEy77RpJ1w2BwoXRKR/3/coxKLAec9ZvAi0c
         Iz3cm/eWaxuB+9+j4SPDbRGb4x7KTckLDsldQTMJpGXJ1n6H9AvTCjbC9DIBgxLL038H
         oh3cp+vRjuo+ImGGzWvlRt2mz3bWlBsY8AHu+QRy+5Q+48WZat/I5dMyN/4/mkUvis9v
         vztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074049; x=1792678849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pl/h/WeLSRS7atJLRBWQ2O8fUSkD4Huu+hR605iMxRc=;
        b=DH7QYpStw0cJf6Ujily4LcM6FpJfHpNOxA6dXklQvdimsmEc5jn+6Qi3FAfQxUrML2
         Iqm8R6v5eF0y9W3d0Fr9YiDnzSUXhZZb1wwK3l6/ZtW/3JIjl6JXltliVyUxE86iG/4o
         YnrV/ATYOSG6IeLnIcgQd20WB/AvkWKNJ8tT8g8r+Pa9uLiESKqkIBIX67+XDqzYN5Kf
         bhLWFBu0wqxdZ08DE34t0PTeJnGMsocyxQiu4Ow923m3qC/GlxGgdfs63GtrNyAiEPCV
         9oO9B3sIAiUOR/I9VvDqc7PQ4p5Nqgrd5fUXTvcmsWCyHMYXkeQqai1PurvaNgYNJgOQ
         mD8g==
X-Gm-Message-State: AFq9FYJ5jRc5HYEKWgg81Zjnb7U5YYsbtzSlvOq1R05hu2wcA9N5kXnJ
	RjUUgPBU9uEVs9bwLdXCtENMiF8Y/e44Q+hNMgkIB1tVXxuCU6lHjiJHhxXF19AG46JX8xDOr7o
	NBu3nw8daC/w3WWbM4L6HvYM4bM3D9aY=
X-Gm-Gg: AYBFou0sUIU5qlK+QDmCHX5T6N5kVHBW6eqPCKVpZpXplzWS+0ORdSz/ax5Lu1U083Z
	24sxYzUC8XTyCkEj/DOu0BN/3rNQGQQaDwUrABwDCP+Q0hg/HHZ1Q6VAnYucPqYelPGHm4YEROn
	+T6yLQSICHecY30ejWBZrwlksYgpZh49qmAFVwL0r2bN5+ee2DYMNzjVEHQ8Egdq6GirsUemIZW
	CUaZu9V+5UXcKPigi9G/kVaPpYo7G+5vHH5tLzszEb7sl2I9UxAhxObK6pGBvnSip0zX9Zg81Qv
	F1NZGh/UqwoX76PKY+ziCp2rj0jWqnoq5JumJMlUuLcEeBeJLJwYhXgJWDUj/zAzuA==
X-Received: by 2002:a05:690e:dcb:b0:679:935e:3543 with SMTP id
 956f58d0204a3-679935e39c4mr1446694d50.1.1792074048885; Thu, 15 Oct 2026
 07:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054535.844874-1-omosnacek@gmail.com> <20261015054535.844874-4-omosnacek@gmail.com>
In-Reply-To: <20261015054535.844874-4-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:20:38 -0400
X-Gm-Features: AclHuK_CRHdOKf3TjnodYb-1iFzKzXmbAspdU41yAlAOCrIwIM84bLvFQiFNo4I
Message-ID: <CAEjxPJ6MKXHj+B9N5rfgY9JaQGJyZJas1657a7ruGT-0EQEW9A@mail.gmail.com>
Subject: Re: [PATCH testsuite 3/5] tmt: rework sysadm_t testing
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:45=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> For sysadm testing we currently rely on the fact that TMT will connect
> to the test machine via SSH and thus SELinux login configuration will be
> applied. However, TMT uses `ssh -M` and `ssh -S` to keep a single SSH
> session across test execution and while a new shell is still started for
> each remote command, the SELinux context for the login shell is not
> recomputed, so `semanage login` changes are not applied.
>
> We currently work around this by forcing a reboot in the prepare-system
> phase, but after https://github.com/teemtee/tmt/pull/5069, we would now
> need to also do the reboot in unprepare phase as well, otherwise new SSH
> connections fail due to the ssh_sysadm_login boolean being already
> turned off and SSH still trying to transition into the sysadm context.
>
> So let's stop relying on TMT "logging in" via SSH and instead do a local
> SSH login over loopback, avoiding the need for reboots and unwanted
> interactions between `semanage login` configuration and TMT's SSH
> connections.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
