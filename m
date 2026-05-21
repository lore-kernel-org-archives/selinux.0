Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67F3D6CD9
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373466; cv=pass; b=fZBNbzkcTg/+9p2an24XiYZ2xoYS8Az6IUK6RK9PTAtWOXWfFNwVSchpS42mNAxgM9TrXuBZ004xUdeY0aya4OEkjurskBJpO+a/lFqYIqzvkh5nVL3wmEmZD7szpnQM6JHawG961/xC9upP/D3qJoyl2JzvNnUALI/NLrsnjE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373466; c=relaxed/simple;
	bh=tLU2mwFmdKiUm+8GTrLH1DtBysOG9azjagXmv+N2aow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCvMwtx2/OJ1WDqiZiiJgaUPpi0TgqtzOOr/8SGAXhHxGsBoDwCqpqc8ectNOuzvzng/XScFowLHlrl7F8pDBvLq0wlYUArwa6eNLJFFWhQjrSqEKf0qXX3lX3QkscC1JZBMr29qkp+ZZNItkWRbb5XNLgLYJTs1mWuiOouneI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6FWLjKY; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6FWLjKY"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-394095009beso54180511fa.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373462; cv=none;
        d=google.com; s=arc-20240605;
        b=X9Y1h75rlROlFff51GHPDRN+WR3LkLG7Qzff/kaFYFCYU3xMRBrZe8uGX0oqT6GpRh
         NT5fT5aUa2CnHSf7RYkuSsX19bbqMykhdineYbVl+9NDtGd8AMPViB96XGHM8Ua9KkT6
         WAJssEW/GJdNSz0Mvygf88ZmpjwmeYcQAGSZ9livpWGjwRqEc5qYHq2uRe6pzmCqujb1
         O49rv+SUvZ3tjNQp3SLgB6X/qMypA7fOhxBx9cWgNkVTeugUuWyzAWnrghxtTsSSTRzV
         7FvkEXxhqBMrdn719czEDAWBPPQ90woKE1blJL3yv5+OvW8FzSfQFjqqDh4qNKtobgxh
         HP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1wV8QZuVKdGUNALk2D+OCNiwFxuy9GhxyHR9YvfyR+w=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=J7VcjOkGJ+Dat13ZC152jPl+0+IrpHt2PaB70o2ImjowXwmjsR8OIVC2su/WuBKeW7
         +BB7iORiUmeLcFhftlW5zdAtaw2mMibz/Zva1q5x5NRwLieluzB1ugXMK60wD/3Fd1Tr
         Tstd5MNpy37KBGrK4Rvv00CiasGbby2uyl1KxvzxZDZe8pT0zIiB4O5Uauxk48YC86nV
         AjKrfaNJFubzsKuKLczdlEaoP8hSURXgzHqiFBBosl6Qfz/IgS6oMgqJ214XXl37Qbc4
         +tCBZ9peCzabdScMaun91EbslCvY5R4F3U+mwljqJ8q/jT8XixT1baDUDgxrS6usd+h1
         AGpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373462; x=1779978262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wV8QZuVKdGUNALk2D+OCNiwFxuy9GhxyHR9YvfyR+w=;
        b=Q6FWLjKYzkYyeQtt4g0JpBrM0Haraj/+/+6HB6DivrAAcljNGEOpWUYdoJPL5r4ve8
         kZ0JSC1TBN537svVmCgcmcj8/b5hjpVNuDKxwq41efrmwrZyGzFCgcfejEMngCJWx1QS
         ebZ0Nuh7pCHzd335yPnUyKJwg2yvV2lP1K5wleVoqlY8Oi24rSkMIxIuOY2tkIDzAXS7
         YhL5ldlivnuM8uBlN1AJGK3mvi4RrYOnXcCBZ6rSxcDtX3XbUKjqDNXuqNUjSkWJVqBB
         UnIhbiFwg0A/jxwoRrCanOTKk8B2wnLUq5zkxnj9/es2xeBe33/2bk4JGNzfEV1XUHmr
         sPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373462; x=1779978262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1wV8QZuVKdGUNALk2D+OCNiwFxuy9GhxyHR9YvfyR+w=;
        b=XR08B9wxjepZRya322LdyYQeJonTDKrBmMHvzrcy5nwr1Ajyi9uDouHmLEJyiDcrmO
         0IgEge1X1g1mdr3H0/04jXXbb9dtZ8G00tLS+LaENCxhrcVbLdmk636kmTNSjZ64zIwF
         R+k2pzmVguyXhlzndi9scCGqooSSL8bj/sCwFpu4iprLO9j2FwVB26cFVGQNzDTs/K+T
         rRKp6Xy74UhzI91iKJ278NZQXX7vLJGPYnhz6mTVsgJKh17FZpSIwJCK6LKReneXKFcc
         rhkQPxJyaT2dyLJ2sa+lK/BwH7kKtkPGpKh31qcxKiMJHo128NbSbiiXd2zKnolgKdUm
         JKXQ==
X-Gm-Message-State: AOJu0Yy0NC/9vOQlZBvGW1d4TKE/2Uza0eAREovuIiLXUhkdCWZCpCzF
	tuVag4z6qf1FvasB1H9rCekPjrcC+KS98/vVSOYsz4lp5k3HUK38uRUSXztiOUznav73BjNycYb
	FM1EHUfLoDDun4draTKHftksOdMIteW8=
X-Gm-Gg: Acq92OG79MyY4M7t6dYK3B9Rvfj5/ppa0YdGnZrXZ3lKPPZkEET3oRMv8ggoY1ULTED
	oOYMGKYyrGzZs3JvLZwNjRkl9xm7WDnW/zdTSeimh7n4CajkTQP/Ro6dGTQU4celAPdR8RUEtd5
	wY908ohCYT+pWftFY6eiYzbtBQnv8Aa1Fi37I+0pBNvAS7MghFAibQWtyXfJRxkdcHivbkv9D+p
	dcl5qlomZu7yFeFms/Zax1v8huzLwjiGj5bR7J4C4tNoGQ22nekxmdOBsw4M61ne7IzFy+g7zNW
	7wh2
X-Received: by 2002:a05:651c:889:b0:394:7f1:5114 with SMTP id
 38308e7fff4ca-395ca6b6774mr12278211fa.28.1779373462212; Thu, 21 May 2026
 07:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515143410.13166-1-stephen.smalley.work@gmail.com> <CAP+JOzSX9P3w-Lr4c=P8HkRWihoaMBQ5UboT9Z1FXeO23B-41A@mail.gmail.com>
In-Reply-To: <CAP+JOzSX9P3w-Lr4c=P8HkRWihoaMBQ5UboT9Z1FXeO23B-41A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:24:10 -0400
X-Gm-Features: AVHnY4Kg3msJ3zGzyT6eKlZoyYgzNlIe_DsnhFaHgmUH0BraEkBWC9ooYBUd8Zs
Message-ID: <CAP+JOzRBKPYj0+bbXd2yNmAHsEYb7QER663dYmZzqJf5p1SUBQ@mail.gmail.com>
Subject: Re: [PATCH] dbus/selinux_server.py: validate policy config value
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:02=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, May 15, 2026 at 10:34=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Perform basic validation of the policy config value; we could
> > further limit it to only existing subdirectories of /etc/selinux.
> > Also, fix up usage of p.communicate() to avoid potential pipe
> > deadlock issues and distinguish error messages.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  dbus/selinux_server.py | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> > index 469c526f..3da2ef30 100644
> > --- a/dbus/selinux_server.py
> > +++ b/dbus/selinux_server.py
> > @@ -6,6 +6,7 @@ from dbus.mainloop.glib import DBusGMainLoop
> >  from gi.repository import GObject
> >  from gi.repository import GLib
> >  import os
> > +import re
> >  import selinux
> >  from subprocess import Popen, PIPE, STDOUT
> >
> > @@ -33,8 +34,7 @@ class selinux_server(dbus.service.Object):
> >          if not self.is_authorized(sender, "org.selinux.semanage"):
> >              raise dbus.exceptions.DBusException("Not authorized")
> >          p =3D Popen(["/usr/sbin/semanage", "import"], stdout=3DPIPE, s=
tderr=3DPIPE, stdin=3DPIPE, universal_newlines=3DTrue)
> > -        p.stdin.write(buf)
> > -        output =3D p.communicate()
> > +        output =3D p.communicate(input=3Dbuf)
> >          if p.returncode and p.returncode !=3D 0:
> >              raise dbus.exceptions.DBusException(output[1])
> >
> > @@ -48,10 +48,9 @@ class selinux_server(dbus.service.Object):
> >          if not self.is_authorized(sender, "org.selinux.customized"):
> >              raise dbus.exceptions.DBusException("Not authorized")
> >          p =3D Popen(["/usr/sbin/semanage", "export"], stdout=3DPIPE, s=
tderr=3DPIPE, universal_newlines=3DTrue)
> > -        buf =3D p.stdout.read()
> > -        output =3D p.communicate()
> > +        buf, err =3D p.communicate()
> >          if p.returncode and p.returncode !=3D 0:
> > -            raise OSError("Failed to read SELinux configuration: %s", =
output)
> > +            raise OSError("Failed to read SELinux configuration: %s" %=
 err)
> >          return buf
> >
> >      #
> > @@ -63,10 +62,9 @@ class selinux_server(dbus.service.Object):
> >          if not self.is_authorized(sender, "org.selinux.semodule_list")=
:
> >              raise dbus.exceptions.DBusException("Not authorized")
> >          p =3D Popen(["/usr/sbin/semodule", "--list=3Dfull"], stdout=3D=
PIPE, stderr=3DPIPE, universal_newlines=3DTrue)
> > -        buf =3D p.stdout.read()
> > -        output =3D p.communicate()
> > +        buf, err =3D p.communicate()
> >          if p.returncode and p.returncode !=3D 0:
> > -            raise OSError("Failed to list SELinux modules: %s", output=
)
> > +            raise OSError("Failed to list SELinux modules: %s" % err)
> >          return buf
> >
> >      #
> > @@ -140,6 +138,8 @@ class selinux_server(dbus.service.Object):
> >      def change_default_policy(self, value, sender):
> >          if not self.is_authorized(sender, "org.selinux.change_default_=
policy"):
> >              raise dbus.exceptions.DBusException("Not authorized")
> > +        if not re.fullmatch(r'[A-Za-z0-9_.]+', str(value)):
> > +            raise ValueError("Invalid policy name: %s" % value)
> >          path =3D selinux.selinux_path() + value
> >          if os.path.isdir(path):
> >              return self.write_selinux_config(policy=3Dvalue)
> > --
> > 2.54.0
> >
