Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ickq9luJ"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D295C100
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 06:10:53 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso3118563e87.2
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702390252; x=1702995052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSW2kHl3TpRbVXq+inxb4pqJeHtLl6kCSBuWVP9ECMI=;
        b=Ickq9luJO/jMNsEbaDmS2eE5VinJcpnZ5vYF+3c789exKsShXvfDMfmNhEJmIm9/eo
         MEG1de/MmJR9XDQlJvOs2kgLqXcEY9CiQ2z2R7grz8AIiAgzsxEvY3XoPgQr8gQzb7MU
         SGvMw2NdnWentxRZ7bzwsU3DmCXVBv3UZCT3uWTNrudHNE08YqdMaE2nD3jfgJ+mTcTA
         tPKdvrkjN9yM2N0x5hg4093QdclUszsW+9Iw6IBtV37IzzEU5t7Nl6YGtqv7c3Pi9cH1
         K5I9yGmJogVFHmpFMH/lVvi1Dnna+DTh6BqOeYLNTmD0CC+MXQy44f2r1979p97KFCnR
         NXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702390252; x=1702995052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSW2kHl3TpRbVXq+inxb4pqJeHtLl6kCSBuWVP9ECMI=;
        b=OEJHiBDhDIMjuJzoW1X8RC6+8TWjIpwyAdYJAclsnrdmD7PW3rND7oxrNuhl04VNO9
         w+F1ow8uQkVpHiQSHai/6CeCxpJsqN0GmuLOcSeU/tLoNHyifjCy4qeQacOeuvBEQcaG
         yNCOQyvgpoHkmhAHo19Z0rfE7zAmXoJo/+0t76ubwlajgVrfOLvujJrK5gkC5XUByRkz
         bngRTq20t3c48yPDxVHaGtG5c4nMQS2Rn4mo+8v02/66GyPQ4ZdohxKfOQ81GXibHEeD
         u+UVA0oWZ9OQzoIPaLTf/4j1T5IwMAKMR1fpkZXiwqIqtcOYaVaOwm81+BBKmv7meMAU
         9aQA==
X-Gm-Message-State: AOJu0YwOKQoigPblUtWe5qx5DJt7grdrfhP2GHbeYwLupJr5SlJsi1Aq
	BJD9WFzV4kYpeN3Q1bPLaI+92q8v7uh0xThUGV8=
X-Google-Smtp-Source: AGHT+IHHVo/39KbLW3COLNbXpw9RjasvA9g7QVp95eKhj030M2cnx1qENDE/W9oHyv1Di66aij6ABmcF/yQRCMvAFx8=
X-Received: by 2002:ac2:5399:0:b0:50b:f8da:23f2 with SMTP id
 g25-20020ac25399000000b0050bf8da23f2mr3180774lfh.135.1702390251659; Tue, 12
 Dec 2023 06:10:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206143151.1047189-1-vmojzis@redhat.com>
In-Reply-To: <20231206143151.1047189-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 09:10:40 -0500
Message-ID: <CAP+JOzTYN1izhZz-S9V-aRPsnSbgPj-jEjvcEFSY76yQTKFgKg@mail.gmail.com>
Subject: Re: [PATCH] python: Harden more tools agains "rogue" modules
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 9:33=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> Python scripts present in the same directory as the tool
> override regular modules.
>
> Fixes:
>       #cat > /usr/bin/signal.py <<EOF
>       import sys
>       print("BAD GUY!", file=3Dsys.stderr)
>       sys.exit(1)
>       EOF
>       #sandbox date
>       BAD GUY!
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  dbus/selinux_server.py       | 2 +-
>  gui/polgengui.py             | 2 +-
>  gui/system-config-selinux.py | 6 +++---
>  sandbox/sandbox              | 2 +-
>  sandbox/start                | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> index a969f226..469c526f 100644
> --- a/dbus/selinux_server.py
> +++ b/dbus/selinux_server.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3
> +#!/usr/bin/python3 -EsI
>
>  import dbus
>  import dbus.service
> diff --git a/gui/polgengui.py b/gui/polgengui.py
> index 16116ba6..9c151a11 100644
> --- a/gui/polgengui.py
> +++ b/gui/polgengui.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  #
>  # polgengui.py - GUI for SELinux Config tool in system-config-selinux
>  #
> diff --git a/gui/system-config-selinux.py b/gui/system-config-selinux.py
> index 9f53b7fe..0b6ba4b5 100644
> --- a/gui/system-config-selinux.py
> +++ b/gui/system-config-selinux.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  #
>  # system-config-selinux.py - GUI for SELinux Config tool in system-confi=
g-selinux
>  #
> @@ -32,6 +32,8 @@ except RuntimeError as e:
>      print("This is a graphical application and requires DISPLAY to be se=
t.")
>      sys.exit(1)
>
> +sys.path.append('/usr/share/system-config-selinux')
> +
>  from gi.repository import GObject
>  import statusPage
>  import booleansPage
> @@ -66,8 +68,6 @@ except:
>
>  version =3D "1.0"
>
> -sys.path.append('/usr/share/system-config-selinux')
> -
>
>  ##
>  ## Pull in the Glade file
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index a2762a7d..fe631a92 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  # Authors: Dan Walsh <dwalsh@redhat.com>
>  # Authors: Thomas Liu <tliu@fedoraproject.org>
>  # Authors: Josh Cogliati
> diff --git a/sandbox/start b/sandbox/start
> index 4ed3cb5c..3c1a1783 100644
> --- a/sandbox/start
> +++ b/sandbox/start
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  try:
>      from subprocess import getstatusoutput
>  except ImportError:
> --
> 2.41.0
>
>
