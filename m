Message-ID: <1498220205.2063.0.camel@tycho.nsa.gov>
Subject: Re: [PATCH] mcstrans: Allow overriding libsepol.a location during
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 23 Jun 2017 08:16:45 -0400
In-Reply-To: <20170623082033.19291-1-plautrba@redhat.com>
References: <20170623082033.19291-1-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-23 at 10:20 +0200, Petr Lautrbach wrote:
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>  mcstrans/src/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index 709e1e02..3f4a89c3 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -4,6 +4,7 @@ LIBDIR ?= $(PREFIX)/lib
>  SBINDIR ?= $(DESTDIR)/sbin
>  INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
>  SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
> +LIBSEPOLA ?= $(LIBDIR)/libsepol.a
>  
>  PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
>  PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
> @@ -15,7 +16,7 @@ override CFLAGS += -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64
>  all: $(PROG)
>  
>  $(PROG): $(PROG_OBJS)
> -	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre
> $(LIBDIR)/libsepol.a
> +	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre
> $(LIBSEPOLA)
>  
>  %.o:  %.c 
>  	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
