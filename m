MIME-Version: 1.0
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Date: Fri, 31 Aug 2012 14:36:26 -0400
Message-ID: <CAB9W1A0CaS_SEZUC4k2iD1tS43GqQWhghpFRP89Fy9TohH6e6A@mail.gmail.com>
Subject: Re: [PATCH 01/18] libselinux: label_file: use PCRE instead of glibc
 regex functions
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 31, 2012 at 1:49 PM, Eric Paris <eparis@redhat.com> wrote:
> The PCRE functions are about x10 faster than the glibc functions.  So
> use the external library.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  libselinux/src/Makefile     |  2 ++
>  libselinux/src/label_file.c | 63 ++++++++++++++++++++++++---------------------
>  2 files changed, 35 insertions(+), 30 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 74e53bb..ac019df 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -20,6 +20,8 @@ RUBYINC ?= $(shell pkg-config --cflags ruby-$(RUBYLIBVER))
>  RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
>  LIBBASE=$(shell basename $(LIBDIR))
>
> +LDFLAGS ?= -lpcre
> +
>  VERSION = $(shell cat ../VERSION)
>  LIBVERSION = 1

Minor nit: I think normally it would be added to LDLIBS rather than
LDFLAGS, so maybe add a LDLIBS += -lselinux -lpcre to the Makefile and
then replace all instances of -lselinux with $(LDLIBS).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
