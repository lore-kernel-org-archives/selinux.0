Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u758mICE032369
 for <selinux@tycho.nsa.gov>; Fri, 5 Aug 2016 04:48:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so2821572wma.1
 for <selinux@tycho.nsa.gov>; Fri, 05 Aug 2016 01:48:09 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id ko7sm16714181wjc.48.2016.08.05.01.48.06
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Aug 2016 01:48:06 -0700 (PDT)
Subject: Re: [PATCH 09/12] policycoreutils: gettext compat for py2 and 3
To: selinux@tycho.nsa.gov
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
 <1470335645-24224-10-git-send-email-jason@perfinion.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <f44147c5-6246-beb7-39ca-78c9f7ea6409@gmail.com>
Date: Fri, 5 Aug 2016 10:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <1470335645-24224-10-git-send-email-jason@perfinion.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k6OIRXEAiBGvvQm2cx5VSmfPrviTarh7e"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k6OIRXEAiBGvvQm2cx5VSmfPrviTarh7e
Content-Type: multipart/mixed; boundary="MOeH28ijSqOXxV3TsFWDOjOUcjHevlRUf"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <f44147c5-6246-beb7-39ca-78c9f7ea6409@gmail.com>
Subject: Re: [PATCH 09/12] policycoreutils: gettext compat for py2 and 3
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
 <1470335645-24224-10-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-10-git-send-email-jason@perfinion.com>

--MOeH28ijSqOXxV3TsFWDOjOUcjHevlRUf
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/04/2016 08:34 PM, Jason Zaman wrote:
> Install gettext the same way everywhere and have fallbacks to use
> str/unicode depending on python version.

Speaking of gettext. gettext is actually a buildrequire but it is
currently not in the list of build requires for selinux

> ---
>  policycoreutils/gui/booleansPage.py            | 22 +++++++++++++-----=
----
>  policycoreutils/gui/domainsPage.py             | 21 +++++++++++++-----=
---
>  policycoreutils/gui/fcontextPage.py            | 22 +++++++++++++-----=
----
>  policycoreutils/gui/loginsPage.py              | 21 +++++++++++++-----=
---
>  policycoreutils/gui/mappingsPage.py            | 21 +++++++++++++-----=
---
>  policycoreutils/gui/modulesPage.py             | 21 +++++++++++++-----=
---
>  policycoreutils/gui/polgengui.py               | 22 +++++++++++++-----=
----
>  policycoreutils/gui/portsPage.py               | 25 +++++++++++++-----=
-------
>  policycoreutils/gui/semanagePage.py            | 21 +++++++++++++-----=
---
>  policycoreutils/gui/statusPage.py              | 24 ++++++++++++++++--=
------
>  policycoreutils/gui/system-config-selinux.py   | 22 +++++++++++++-----=
----
>  policycoreutils/gui/usersPage.py               | 22 +++++++++++++++---=
----
>  policycoreutils/sandbox/sandbox                | 15 ++++++++-------
>  policycoreutils/scripts/chcat                  | 13 ++++++++++---
>  policycoreutils/semanage/semanage              |  4 ++--
>  policycoreutils/semanage/seobject.py           | 23 ++++++++++++++++--=
-----
>  policycoreutils/sepolicy/sepolicy.py           | 21 +++++++++++++-----=
---
>  policycoreutils/sepolicy/sepolicy/__init__.py  | 23 ++++++++++++++----=
-----
>  policycoreutils/sepolicy/sepolicy/generate.py  | 22 +++++++++++++-----=
----
>  policycoreutils/sepolicy/sepolicy/gui.py       | 21 +++++++++++++-----=
---
>  policycoreutils/sepolicy/sepolicy/interface.py | 22 +++++++++++++-----=
----
>  21 files changed, 263 insertions(+), 165 deletions(-)
>=20
> diff --git a/policycoreutils/gui/booleansPage.py b/policycoreutils/gui/=
booleansPage.py
> index 507a79d..7057ff4 100644
> --- a/policycoreutils/gui/booleansPage.py
> +++ b/policycoreutils/gui/booleansPage.py
> @@ -40,18 +40,22 @@ DISABLED =3D 2
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  from glob import fnmatch
> =20
> diff --git a/policycoreutils/gui/domainsPage.py b/policycoreutils/gui/d=
omainsPage.py
> index 9992d00..8f113ce 100644
> --- a/policycoreutils/gui/domainsPage.py
> +++ b/policycoreutils/gui/domainsPage.py
> @@ -32,17 +32,22 @@ from semanagePage import *
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class domainsPage(semanagePage):
> diff --git a/policycoreutils/gui/fcontextPage.py b/policycoreutils/gui/=
fcontextPage.py
> index c8d6ba8..2b95099 100644
> --- a/policycoreutils/gui/fcontextPage.py
> +++ b/policycoreutils/gui/fcontextPage.py
> @@ -47,18 +47,22 @@ class context:
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class fcontextPage(semanagePage):
> diff --git a/policycoreutils/gui/loginsPage.py b/policycoreutils/gui/lo=
ginsPage.py
> index 982e252..8e0b7a2 100644
> --- a/policycoreutils/gui/loginsPage.py
> +++ b/policycoreutils/gui/loginsPage.py
> @@ -30,17 +30,22 @@ from semanagePage import *
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class loginsPage(semanagePage):
> diff --git a/policycoreutils/gui/mappingsPage.py b/policycoreutils/gui/=
mappingsPage.py
> index 1429bf7..3b4ceb6 100644
> --- a/policycoreutils/gui/mappingsPage.py
> +++ b/policycoreutils/gui/mappingsPage.py
> @@ -28,17 +28,22 @@ import seobject
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class loginsPage:
> diff --git a/policycoreutils/gui/modulesPage.py b/policycoreutils/gui/m=
odulesPage.py
> index 3b83e45..c7c7848 100644
> --- a/policycoreutils/gui/modulesPage.py
> +++ b/policycoreutils/gui/modulesPage.py
> @@ -32,17 +32,22 @@ from subprocess import Popen, PIPE
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class modulesPage(semanagePage):
> diff --git a/policycoreutils/gui/polgengui.py b/policycoreutils/gui/pol=
gengui.py
> index 1c349a7..1f97ada 100644
> --- a/policycoreutils/gui/polgengui.py
> +++ b/policycoreutils/gui/polgengui.py
> @@ -58,18 +58,22 @@ def get_all_modules():
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  gnome.program_init("SELinux Policy Generation Tool", "5")
> =20
> diff --git a/policycoreutils/gui/portsPage.py b/policycoreutils/gui/por=
tsPage.py
> index 8e74ac0..7e7a653 100644
> --- a/policycoreutils/gui/portsPage.py
> +++ b/policycoreutils/gui/portsPage.py
> @@ -30,21 +30,22 @@ from semanagePage import *
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
> -TYPE_COL =3D 0
> -PROTOCOL_COL =3D 1
> -MLS_COL =3D 2
> -PORT_COL =3D 3
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class portsPage(semanagePage):
> diff --git a/policycoreutils/gui/semanagePage.py b/policycoreutils/gui/=
semanagePage.py
> index 5d7f2cf..d07ce27 100644
> --- a/policycoreutils/gui/semanagePage.py
> +++ b/policycoreutils/gui/semanagePage.py
> @@ -28,17 +28,22 @@ import seobject
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  def idle_func():
> diff --git a/policycoreutils/gui/statusPage.py b/policycoreutils/gui/st=
atusPage.py
> index 991d8f3..de27752 100644
> --- a/policycoreutils/gui/statusPage.py
> +++ b/policycoreutils/gui/statusPage.py
> @@ -23,6 +23,7 @@ import os
>  import gobject
>  import sys
>  import tempfile
> +import selinux
> =20
>  INSTALLPATH =3D '/usr/share/system-config-selinux'
>  sys.path.append(INSTALLPATH)
> @@ -40,15 +41,22 @@ RELABELFILE =3D "/.autorelabel"
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
> -import selinux
>  try:
> -    gettext.install(PROGNAME, localedir=3D"/usr/share/locale", unicode=
=3D1)
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
> +    gettext.install(PROGNAME,
> +                    localedir=3D"/usr/share/locale",
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class statusPage:
> diff --git a/policycoreutils/gui/system-config-selinux.py b/policycoreu=
tils/gui/system-config-selinux.py
> index 7d342d0..8d2be13 100644
> --- a/policycoreutils/gui/system-config-selinux.py
> +++ b/policycoreutils/gui/system-config-selinux.py
> @@ -47,18 +47,22 @@ import selinux
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  gnome.program_init("SELinux Management Tool", "5")
> =20
> diff --git a/policycoreutils/gui/usersPage.py b/policycoreutils/gui/use=
rsPage.py
> index abf8d3b..eb978ea 100644
> --- a/policycoreutils/gui/usersPage.py
> +++ b/policycoreutils/gui/usersPage.py
> @@ -30,14 +30,22 @@ from semanagePage import *
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> -    gettext.install(PROGNAME, localedir=3D"/usr/share/locale", unicode=
=3D1)
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
> +    gettext.install(PROGNAME,
> +                    localedir=3D"/usr/share/locale",
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  class usersPage(semanagePage):
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/=
sandbox
> index 9e0024f..4f5128a 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -35,18 +35,19 @@ from tempfile import mkdtemp
>  import pwd
>  import sepolicy
> =20
> -PROGNAME =3D "policycoreutils"
>  SEUNSHARE =3D "/usr/sbin/seunshare"
>  SANDBOXSH =3D "/usr/share/sandbox/sandboxX.sh"
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
> -
> +PROGNAME =3D "policycoreutils"
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    codeset=3D'utf-8')
> -except IOError:
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
>      try:
>          import builtins
>          builtins.__dict__['_'] =3D str
> diff --git a/policycoreutils/scripts/chcat b/policycoreutils/scripts/ch=
cat
> index 267390e..2269ee0 100755
> --- a/policycoreutils/scripts/chcat
> +++ b/policycoreutils/scripts/chcat
> @@ -30,11 +30,18 @@ import string
>  import getopt
>  import selinux
>  import seobject
> -import gettext
> =20
> +PROGNAME =3D "policycoreutils"
>  try:
> -    gettext.install('policycoreutils')
> -except IOError:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
> +    gettext.install(PROGNAME,
> +                    localedir=3D"/usr/share/locale",
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
>      try:
>          import builtins
>          builtins.__dict__['_'] =3D str
> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semana=
ge/semanage
> index e6e3a49..d945243 100644
> --- a/policycoreutils/semanage/semanage
> +++ b/policycoreutils/semanage/semanage
> @@ -27,9 +27,9 @@ import traceback
>  import argparse
>  import seobject
>  import sys
> -import gettext
>  PROGNAME =3D "policycoreutils"
>  try:
> +    import gettext
>      kwargs =3D {}
>      if sys.version_info < (3,):
>          kwargs['unicode'] =3D True
> @@ -37,7 +37,7 @@ try:
>                      localedir=3D"/usr/share/locale",
>                      codeset=3D'utf-8',
>                      **kwargs)
> -except IOError:
> +except:
>      try:
>          import builtins
>          builtins.__dict__['_'] =3D str
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/sem=
anage/seobject.py
> index 2cc56d9..bd261df 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -34,13 +34,22 @@ import sepolicy
>  sepolicy.gen_bool_dict()
>  from IPy import IP
> =20
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
> -
> -import gettext
> -translation =3D gettext.translation(PROGNAME, localedir=3D"/usr/share/=
locale", fallback=3DTrue)
> -_ =3D translation.ugettext
> +try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
> +    gettext.install(PROGNAME,
> +                    localedir=3D"/usr/share/locale",
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  import syslog
> =20
> diff --git a/policycoreutils/sepolicy/sepolicy.py b/policycoreutils/sep=
olicy/sepolicy.py
> index 7d57f6e..3e502a7 100755
> --- a/policycoreutils/sepolicy/sepolicy.py
> +++ b/policycoreutils/sepolicy/sepolicy.py
> @@ -27,18 +27,23 @@ import selinux
>  import sepolicy
>  from sepolicy import get_os_version, get_conditionals, get_conditional=
s_format_text
>  import argparse
> -import gettext
>  PROGNAME =3D "policycoreutils"
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  usage =3D "sepolicy generate [-h] [-n NAME] [-p PATH] ["
>  usage_dict =3D {' --newtype': ('-t [TYPES [TYPES ...]]',), ' --customi=
ze': ('-d DOMAIN', '-a  ADMIN_DOMAIN', "[ -w WRITEPATHS ]",), ' --admin_u=
ser': ('[-r TRANSITION_ROLE ]', "[ -w WRITEPATHS ]",), ' --application': =
('COMMAND', "[ -w WRITEPATHS ]",), ' --cgi': ('COMMAND', "[ -w WRITEPATHS=
 ]",), ' --confined_admin': ('-a  ADMIN_DOMAIN', "[ -w WRITEPATHS ]",), '=
 --dbus': ('COMMAND', "[ -w WRITEPATHS ]",), ' --desktop_user': ('', "[ -=
w WRITEPATHS ]",), ' --inetd': ('COMMAND', "[ -w WRITEPATHS ]",), ' --ini=
t': ('COMMAND', "[ -w WRITEPATHS ]",), ' --sandbox': ("[ -w WRITEPATHS ]"=
,), ' --term_user': ("[ -w WRITEPATHS ]",), ' --x_user': ("[ -w WRITEPATH=
S ]",)}
> diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycore=
utils/sepolicy/sepolicy/__init__.py
> index 6aec4c0..c8d3b90 100644
> --- a/policycoreutils/sepolicy/sepolicy/__init__.py
> +++ b/policycoreutils/sepolicy/sepolicy/__init__.py
> @@ -6,8 +6,6 @@
>  from . import _policy
>  import selinux
>  import glob
> -PROGNAME =3D "policycoreutils"
> -import gettext
>  import sepolgen.defaults as defaults
>  import sepolgen.interfaces as interfaces
>  import sys
> @@ -15,16 +13,23 @@ import os
>  import re
>  import gzip
> =20
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
> +PROGNAME =3D "policycoreutils"
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  TYPE =3D _policy.TYPE
>  ROLE =3D _policy.ROLE
> diff --git a/policycoreutils/sepolicy/sepolicy/generate.py b/policycore=
utils/sepolicy/sepolicy/generate.py
> index 2d83702..00361c6 100644
> --- a/policycoreutils/sepolicy/sepolicy/generate.py
> +++ b/policycoreutils/sepolicy/sepolicy/generate.py
> @@ -53,18 +53,22 @@ import sepolgen.defaults as defaults
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  def get_rpm_nvr_from_header(hdr):
> diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils=
/sepolicy/sepolicy/gui.py
> index 0ffe9ee..7f1888c 100644
> --- a/policycoreutils/sepolicy/sepolicy/gui.py
> +++ b/policycoreutils/sepolicy/sepolicy/gui.py
> @@ -39,20 +39,25 @@ import sepolicy.manpage
>  import dbus
>  import os
>  import re
> -import gettext
>  import unicodedata
> =20
>  PROGNAME =3D "policycoreutils"
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
>  reverse_file_type_str =3D {}
>  for f in sepolicy.file_type_str:
> diff --git a/policycoreutils/sepolicy/sepolicy/interface.py b/policycor=
eutils/sepolicy/sepolicy/interface.py
> index 85f7351..c2cb971 100644
> --- a/policycoreutils/sepolicy/sepolicy/interface.py
> +++ b/policycoreutils/sepolicy/sepolicy/interface.py
> @@ -33,18 +33,22 @@ __all__ =3D ['get_all_interfaces', 'get_interfaces_=
from_xml', 'get_admin', 'get_us
>  ## I18N
>  ##
>  PROGNAME =3D "policycoreutils"
> -
> -import gettext
> -gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
> -gettext.textdomain(PROGNAME)
>  try:
> +    import gettext
> +    kwargs =3D {}
> +    if sys.version_info < (3,):
> +        kwargs['unicode'] =3D True
>      gettext.install(PROGNAME,
>                      localedir=3D"/usr/share/locale",
> -                    unicode=3DFalse,
> -                    codeset=3D'utf-8')
> -except IOError:
> -    import __builtin__
> -    __builtin__.__dict__['_'] =3D unicode
> +                    codeset=3D'utf-8',
> +                    **kwargs)
> +except:
> +    try:
> +        import builtins
> +        builtins.__dict__['_'] =3D str
> +    except ImportError:
> +        import __builtin__
> +        __builtin__.__dict__['_'] =3D unicode
> =20
> =20
>  def get_interfaces_from_xml(path):
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--MOeH28ijSqOXxV3TsFWDOjOUcjHevlRUf--

--k6OIRXEAiBGvvQm2cx5VSmfPrviTarh7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXpFLBAAoJECV0jlU3+UdpJJUL/RflCrgLyodhqNjrPMbEDIUs
11vOc/MbjnepetfAw7fDXn3FncSuc5A2h1G21XlIpOkpBSReESVBx90JyqtWoJkj
VfJ7PciU/QzhBiqYSyug775arK6J1IxD4gHY4HTMM0OPpQnw4Je8H2PwJZqouqJW
dB2QVH6tZNt2YD7feOI/7d7kqbl3plRQgToLIH3/0yVIdx8PM6aB8rURWfmzbHiX
9ZS6hrVGTgTuzlAZKl/lBRdjKKKSw6IxIj9yrx8eWg4itoPH4y1xjlP7p9TrAoKf
Czqu98U688MXF/De7mRBsC0Gtocxa7hkh6Fu/Dkq4vdaDDwio7w04Lox/2PMk6Kx
McQj2omjNNEWGnyahYkqjxVe1cGzi40lYrX1BKMPWSSASJukK5o+hm3UZKftKByz
wgdILv4p6KcUdWI2EK5rpldJBXMx8MBUm7s73bM6EeTOXElQXuO06Arb6UbN6n5K
93SHwAPSH7nkRQDacNcnfQj6czbVPMonxhWCsi0iEg==
=2AL9
-----END PGP SIGNATURE-----

--k6OIRXEAiBGvvQm2cx5VSmfPrviTarh7e--
