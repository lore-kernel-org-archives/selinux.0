Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2Rbwd0t"
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9AB7
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:45:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50be9e6427dso6198927e87.1
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399504; x=1703004304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHEZVfD0CblduWh5RUqI5P4Iln55tytoq9l4bHalIV4=;
        b=S2Rbwd0tb4sq59BYb8PgqzuIyT+4v+JJ8s82RACcwqbInlsiD7XcG6iiCsUTsQ/TT4
         Yy6H7qQu5AG9qy6N1P+wq9f0E/CAJf0pcvTgTFcmxdDOrL6f39BX1WU/ivNiGT7ZEm+k
         UdE7sHxJ6dW92uHorCKlR+efmgQykBVW7UGZOYN0EQDWgc6nztBdl0fFYFRHs4V5sTxX
         c0N8g7OHMVQRimvIkt/zmckPnXSMKqZ8MAwq6u1XfgIr0KFiC8KHzHpGvThAFR4x33Wy
         2BaAHSZM0I67BNGvYz0GkvC30IwjamOV/JTrbh0BLksjJNjhkg1RoZhFkPLn//tSUTKw
         PpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399504; x=1703004304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHEZVfD0CblduWh5RUqI5P4Iln55tytoq9l4bHalIV4=;
        b=e7tc9mn6ucDyKgAFcrCZTSbqxdsxZhzdjhY3/xswLX2DvrAk8i+mtOzTkhkCzLUth3
         4hGqlM/CrJqTeIdiWhidQwxPM+kwd8smNanEvbXmmHhTYJI4aJ5HLEoTx3yiVyhoCQ+o
         Fg8W0jFOKAe8tevU093lvmZzC4+qJ6v+HdZHNic97WxUXSKFOsOWNQADSdDMe2h2X5Y3
         A5mo/p2QoLNlYK0r5C6N4F6rLLDU2eICR66OC/TaXMZR5dmIDFl5JBLwm5kSp0s7T49R
         DiNRvp3rkxivMraFuzoPWOpK3loxjhk7vlih7PsGS+2aZ8P/s05vaVjTU5kqtq+ALzau
         8CNQ==
X-Gm-Message-State: AOJu0YypybDxpIk7Gege37BgSKbAzC02/ZcwEpMb5t8/YiBzwCVdOGhz
	ECaVxGbtf5w56UD/iXpY9Z4apDWX4ua1eKirLU4=
X-Google-Smtp-Source: AGHT+IEGhM15NgTqtfwm2T3goMaBE1vUH7vKgMxY1vEaZrFKkmBNtuxVzhUAr0Vq1z4DGhiOEXOIKRciJu5re+kj+RY=
X-Received: by 2002:a05:6512:15b:b0:50c:e98:1df2 with SMTP id
 m27-20020a056512015b00b0050c0e981df2mr2922626lfo.69.1702399503657; Tue, 12
 Dec 2023 08:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206143151.1047189-1-vmojzis@redhat.com> <CAP+JOzTYN1izhZz-S9V-aRPsnSbgPj-jEjvcEFSY76yQTKFgKg@mail.gmail.com>
In-Reply-To: <CAP+JOzTYN1izhZz-S9V-aRPsnSbgPj-jEjvcEFSY76yQTKFgKg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 11:44:52 -0500
Message-ID: <CAP+JOzSfNVH5LMBf=g7m_9UOJ_5Eo743qchYVOXiej8=V=qacA@mail.gmail.com>
Subject: Re: [PATCH] python: Harden more tools agains "rogue" modules
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:10=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Dec 6, 2023 at 9:33=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
> >
> > Python scripts present in the same directory as the tool
> > override regular modules.
> >
> > Fixes:
> >       #cat > /usr/bin/signal.py <<EOF
> >       import sys
> >       print("BAD GUY!", file=3Dsys.stderr)
> >       sys.exit(1)
> >       EOF
> >       #sandbox date
> >       BAD GUY!
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  dbus/selinux_server.py       | 2 +-
> >  gui/polgengui.py             | 2 +-
> >  gui/system-config-selinux.py | 6 +++---
> >  sandbox/sandbox              | 2 +-
> >  sandbox/start                | 2 +-
> >  5 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> > index a969f226..469c526f 100644
> > --- a/dbus/selinux_server.py
> > +++ b/dbus/selinux_server.py
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3
> > +#!/usr/bin/python3 -EsI
> >
> >  import dbus
> >  import dbus.service
> > diff --git a/gui/polgengui.py b/gui/polgengui.py
> > index 16116ba6..9c151a11 100644
> > --- a/gui/polgengui.py
> > +++ b/gui/polgengui.py
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  #
> >  # polgengui.py - GUI for SELinux Config tool in system-config-selinux
> >  #
> > diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.p=
y
> > index 9f53b7fe..0b6ba4b5 100644
> > --- a/gui/system-config-selinux.py
> > +++ b/gui/system-config-selinux.py
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  #
> >  # system-config-selinux.py - GUI for SELinux Config tool in system-con=
fig-selinux
> >  #
> > @@ -32,6 +32,8 @@ except RuntimeError as e:
> >      print("This is a graphical application and requires DISPLAY to be =
set.")
> >      sys.exit(1)
> >
> > +sys.path.append('/usr/share/system-config-selinux')
> > +
> >  from gi.repository import GObject
> >  import statusPage
> >  import booleansPage
> > @@ -66,8 +68,6 @@ except:
> >
> >  version =3D "1.0"
> >
> > -sys.path.append('/usr/share/system-config-selinux')
> > -
> >
> >  ##
> >  ## Pull in the Glade file
> > diff --git a/sandbox/sandbox b/sandbox/sandbox
> > index a2762a7d..fe631a92 100644
> > --- a/sandbox/sandbox
> > +++ b/sandbox/sandbox
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  # Authors: Dan Walsh <dwalsh@redhat.com>
> >  # Authors: Thomas Liu <tliu@fedoraproject.org>
> >  # Authors: Josh Cogliati
> > diff --git a/sandbox/start b/sandbox/start
> > index 4ed3cb5c..3c1a1783 100644
> > --- a/sandbox/start
> > +++ b/sandbox/start
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/python3 -Es
> > +#!/usr/bin/python3 -EsI
> >  try:
> >      from subprocess import getstatusoutput
> >  except ImportError:
> > --
> > 2.41.0
> >
> >
