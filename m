MIME-Version: 1.0
In-Reply-To: <20180124092736.8432-9-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
 <20180124092736.8432-9-marcus.folkesson@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 24 Jan 2018 23:06:56 +0100
Message-ID: <CAJfZ7=kFRfvFm4Zzw8Zg+vgAEGQYgHV+-jat+hV4UUrvQDfyTQ@mail.gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v4 08/15] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 24, 2018 at 10:27 AM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  python/audit2allow/Makefile           | 19 ++++++++++++-------
>  python/chcat/Makefile                 |  8 ++++----
>  python/semanage/Makefile              | 11 +++++------
>  python/sepolgen/src/sepolgen/Makefile |  3 ++-
>  python/sepolicy/Makefile              | 18 +++++++++---------
>  5 files changed, 32 insertions(+), 27 deletions(-)
>
> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> index 8db8075f..7463ed85 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -1,19 +1,24 @@
>  PYTHON ?= python
>
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -BINDIR ?= $(PREFIX)/bin
> -LIBDIR ?= $(PREFIX)/lib
> -MANDIR ?= $(PREFIX)/share/man
> -LOCALEDIR ?= /usr/share/locale
> -INCLUDEDIR ?= $(PREFIX)/include
> -LIBSEPOLA ?= $(LIBDIR)/libsepol.a
> +PREFIX ?= /usr
> +BINDIR ?= $(DESTDIR)$(PREFIX)/bin
> +LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
> +MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
>
>  CFLAGS ?= -Werror -Wall -W
>
> +# If no specific libsepol.a is specified, fall back on LDFLAGS search path
> +# Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> +# is no need to define a value for LDLIBS_LIBSEPOLA
> +ifeq ($(LIBSEPOLA),)
> +        LDLIBS_LIBSEPOLA := -l:libsepol.a
> +endif
> +
>  all: audit2why sepolgen-ifgen-attr-helper
>
>  sepolgen-ifgen-attr-helper: sepolgen-ifgen-attr-helper.o $(LIBSEPOLA)
> +       $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)

Please remove $(CFLAGS) here, as it is not needed when linking object files.

>
>  ...
