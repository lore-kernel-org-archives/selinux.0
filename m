Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1LK8YxG007358
 for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2017 15:08:34 -0500
Received: by mail-ot0-f196.google.com with SMTP id y13so15001247oty.2
 for <selinux@tycho.nsa.gov>; Tue, 21 Feb 2017 12:08:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170221185821.26373-1-ncopa@alpinelinux.org>
References: <20170221185821.26373-1-ncopa@alpinelinux.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 21 Feb 2017 12:08:29 -0800
Message-ID: <CAFftDdpJwPKd1Nw+0MCBz0ud1O4VfVDH+VzPbkDp3T3W1dYetA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: allow link with -lfts
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 21, 2017 at 10:58 AM, Natanael Copa <ncopa@alpinelinux.org> wrote:
> This makes it possible to build libselinux with the external libtfs for
> systems which does not implement the non-standard fts. For example musl
> libc.
>
>   make FTS_LDFLAGS=-lfts

The way this was done before for PCRE was a flag to add USE_PCRE2 to
the make command where it then picks the ld flags to add.
In this case, specifying raw LDFLAGS should, in theory just be done
via LDFLAGS (not sure if it works, the makefiles are not that great at
times).

I think we would want something close to the PCRE example, like make
USE_LIBFTS=y

>
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---
>  libselinux/src/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 5640a57..513a9e7 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -92,6 +92,7 @@ LD_SONAME_FLAGS=-install_name,$(LIBSO)
>  endif
>
>  PCRE_LDFLAGS ?= -lpcre
> +FTS_LDFLAGS ?=
>
>  override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
>
> @@ -143,7 +144,7 @@ $(LIBA): $(OBJS)
>         $(RANLIB) $@
>
>  $(LIBSO): $(LOBJS)
> -       $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
> +       $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) $(FTS_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> --
> 2.11.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
