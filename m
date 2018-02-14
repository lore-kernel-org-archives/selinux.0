MIME-Version: 1.0
In-Reply-To: <20180214095717.1050-8-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
 <20180214095717.1050-8-marcus.folkesson@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 14 Feb 2018 20:00:36 +0100
Message-ID: <CAJfZ7==vs7bZgbX4JYHJFV8grD4+rcK8hqJVJDGuycWDrqe1Sw@mail.gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v5 07/15] policycoreutils: build: follow
 standard semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 14, 2018 at 10:57 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>
> Notes:
>     v5:
>         - Only use $(DESTDIR) in install
>     v2:
>         - Rework all packages (not just selinux/sepol/semanage)
>
>  policycoreutils/hll/pp/Makefile      |  9 +++------
>  policycoreutils/load_policy/Makefile | 16 ++++++++--------
>  policycoreutils/man/Makefile         |  7 ++++---
>  policycoreutils/newrole/Makefile     | 24 ++++++++++++------------
>  policycoreutils/po/Makefile          |  7 ++++---
>  policycoreutils/run_init/Makefile    | 22 +++++++++++-----------
>  policycoreutils/scripts/Makefile     | 13 ++++++-------
>  policycoreutils/secon/Makefile       | 12 +++++-------
>  policycoreutils/semodule/Makefile    | 16 +++++++---------
>  policycoreutils/sestatus/Makefile    | 21 ++++++++++-----------
>  policycoreutils/setfiles/Makefile    | 23 +++++++++++------------
>  policycoreutils/setsebool/Makefile   | 18 ++++++++----------
>  12 files changed, 89 insertions(+), 99 deletions(-)
>
[...]
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
> index bc254dab..3cd58353 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -1,10 +1,8 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -INCLUDEDIR ?= $(PREFIX)/include
> +PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> -LIBDIR ?= $(PREFIX)/lib
> -BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
> +BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions

You forgot to remove $(DESTDIR) here, so setsebool's bash completion
file gets installed in $DESTDIR/$DESTDIR/usr/... All the other
modifications on variables look good to me.
Thanks!
Nicolas

>
>  CFLAGS ?= -Werror -Wall -W
>  override LDLIBS += -lsepol -lselinux -lsemanage
> @@ -17,12 +15,12 @@ all: setsebool
>  setsebool: $(SETSEBOOL_OBJS)
>
>  install: all
> -       -mkdir -p $(SBINDIR)
> -       install -m 755 setsebool $(SBINDIR)
> -       -mkdir -p $(MANDIR)/man8
> -       install -m 644 setsebool.8 $(MANDIR)/man8/
> -       -mkdir -p $(BASHCOMPLETIONDIR)
> -       install -m 644 $(BASHCOMPLETIONS) $(BASHCOMPLETIONDIR)/setsebool
> +       -mkdir -p $(DESTDIR)$(SBINDIR)
> +       install -m 755 setsebool $(DESTDIR)$(SBINDIR)
> +       -mkdir -p $(DESTDIR)$(MANDIR)/man8
> +       install -m 644 setsebool.8 $(DESTDIR)$(MANDIR)/man8/
> +       -mkdir -p $(DESTDIR)$(BASHCOMPLETIONDIR)
> +       install -m 644 $(BASHCOMPLETIONS) $(DESTDIR)$(BASHCOMPLETIONDIR)/setsebool
>
>  relabel:
>
> --
> 2.15.1
>
