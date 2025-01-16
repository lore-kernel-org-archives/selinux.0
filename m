Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9BD18E750;
	Thu, 16 Jan 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059891; cv=none; b=tDbzIUib8utOmqHYnPf5zmWSK+ZE437KDgOeLUkJAc6zIXgnYZU3W49+kC9Wt5bw151lM9YxV5Rbliz22bHYFnbK1aI0Yu3MckO5nvS7tT7a+OC0kgnsw1PelprKjihfxjuskKJY3Rlkc0pyLiip3YvrFYza09yZuZg8pC0MJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059891; c=relaxed/simple;
	bh=c53tFjAuG5QleaxFMV+bYJvb1kbaoyDoId3NiGJzf+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxmMQg6X8UQG+nGqEctStdx/i048sAhcEH4K9Yk4ONM70eAeLtR3VZLm/93s/s9U3YDZJPpaNZ/ACNxaeOo+NG+gIwbwB8+OHwcfRttnuFXkCCeXTT/Y1XUSf/fhW5bqC9E8FqqcG2H0dNlv/wsgzLSYP3EHBgdbXy5DrGSBvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVIklVZW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVIklVZW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso4107265a91.1;
        Thu, 16 Jan 2025 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737059889; x=1737664689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHtIlsmNzNQbdLfJ7GIeEJKPaY4A7f8I/ovBqwz5EvE=;
        b=YVIklVZWFFcnMtMkX9HC4XSJcJcpmr7JA2JSnu2jii5u3uB02nVj6y2+YQtXc26feu
         K3AGngWq4aTC08UW01rkH0E3QOjRyin303zpG7lETsyOGLOzZtSVeofzRIBHavzoTvtM
         63fYvCW+uKZEfT7R8WVzqX5HP/jflBLlbyJ+48msnX1IdQTphe7N8nIXK+vRhCawlNvt
         hibM6FBk6fISpRGes0VrL8WoYUEjm+nH7YLh7r2Q1fTL7hh4t7fQgzjCHIkJjcOpx7/C
         SRIXJFxBMeGNmkP+nrxxm4HEFs/mjSolkM+LdbbuNNgZ2B29Cq5k/5PwEEnodPbOM8jp
         YecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737059889; x=1737664689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHtIlsmNzNQbdLfJ7GIeEJKPaY4A7f8I/ovBqwz5EvE=;
        b=VlB+8/VAK6fbIgB1WzHYYmuiaaIKxMhBbT8B3Vz0qbyrMWLiok7xYvj/JEGC6/KNxV
         OrX/6ywXhY5an2qLyMXka7gRCJwiKRywqtU4oxWP+b6ILg9cEm0mRofee84JpoLhte+r
         R1yGIm2bHVlM1Qt/4xy2Sq1iK9dTAAJmtwTorg/c2l+fcYUsJSHNxS7tRoVxNwAAz6qj
         YGlKTgKzJ8ZJZPCMKlEFk+d8pBJum87okMmFV41P6jVrH+dQBP7uxP4TzTsqKtyKIAAi
         lAuQZwcpt5OMpJ6CutKbOXj/Dzb5U4ilSITols9wk3KnjZKea187BTz1A9qQeUFXSogO
         5vKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/BgUmhM0NvcFi/ap0pQZ+npf1hATjV8Nkh7kVWkJ2zPNHFAjrVdGMyqjz7jYaayVPzuQRmkxMSHLRP70=@vger.kernel.org, AJvYcCXMCKpEIRIHiINyGqGd9z0PAodBsMmv5nwTu3WZOIj00fCTa8zzoeov4v70nJUQVWwAKlzLJ010Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwjlYcE21kTQi8CIggZMlzb3azXXW/qCC68ZtOqwyM+wFRo8P
	vuLl3wEnVPa9AwJ8YlVJ5q1ugn1QSoXvIrdB46h7BKp3C3UNqVU45RVKtPUoK6hDWOdGys4MhJ6
	2zL9Pg6xIfpqZbNba2Br2h9W8NKk=
X-Gm-Gg: ASbGncsZH0k67OQ/E1IoGgJYhEFXhPOLu3YHYBfUFJqm+du0opXJOu+ugFPas6p1Lkr
	tP2VPNEpTjkR+m9OHrq4M6YeocQm8Azv+UfD50g==
X-Google-Smtp-Source: AGHT+IE3FvdCgH1XmtT1IC5ZI19XIbA+o3sZik/HzCGQqlcar8NHtK/GM0/8ScBxIB5TIKn4KefIpfH9M72hInlFyUo=
X-Received: by 2002:a17:90b:4ed0:b0:2ee:7e53:bfae with SMTP id
 98e67ed59e1d1-2f728e001femr12415459a91.10.1737059889287; Thu, 16 Jan 2025
 12:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116195526.2303758-1-ingyujang25@gmail.com>
In-Reply-To: <20250116195526.2303758-1-ingyujang25@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 16 Jan 2025 15:37:58 -0500
X-Gm-Features: AbW1kvbfB5EksPiwXCkzhM0PIGCSjBTop1l5ad4HLQmzi6Vd-AaAieDMolSPZns
Message-ID: <CAEjxPJ4ewk2E0NjYa=B3GA9jh2+rDbipnhRuWUcJLAUcxG2LtA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Handle NULL return from selinux_inode in inode_security_rcu
To: Ingyu Jang <ingyujang25@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:55=E2=80=AFPM Ingyu Jang <ingyujang25@gmail.com> =
wrote:
>
> The 'selinux_inode' function may return NULL if 'inode->i_security' is
> uninitialized or if 'inode->i_security' is NULL.
> Previously, this scenario was not explicitly handled in
> 'inode_security_rcu', which might lead to NULL Pointer dereference.
>
> This patch modifies 'inode_security_rcu' to call 'selinux_inode' and
> check its return value.
> If 'selinux_inode' returns NULL, '-EACCES' is returned to ensure
> consistent error handling.
>
> Furthermore, analysis confirmed that all current usages of
> 'inode_security_rcu' check the return value using 'IS_ERR', ensuring
> compatibility with this change.
>
> Signed-off-by: Ingyu Jang <ingyujang25@gmail.com>

Do you have an actual example where this is currently possible if
SELinux is enabled?
It shouldn't be possible, so that would be a kernel bug that should be fixe=
d.

> ---
>  security/selinux/hooks.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 171dd7fceac5..61c9191bafbe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -310,11 +310,17 @@ static struct inode_security_struct *inode_security=
_novalidate(struct inode *ino
>  static struct inode_security_struct *inode_security_rcu(struct inode *in=
ode, bool rcu)
>  {
>         int error;
> +       struct inode_security_struct *isec;
>
>         error =3D __inode_security_revalidate(inode, NULL, !rcu);
>         if (error)
>                 return ERR_PTR(error);
> -       return selinux_inode(inode);
> +
> +       isec =3D selinux_inode(inode);
> +       if (!isec)
> +               return ERR_PTR(-EACCES);
> +
> +       return isec;
>  }
>
>  /*
> --
> 2.34.1
>
