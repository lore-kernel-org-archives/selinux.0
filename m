Subject: Re: [PATCH 1/1] mcstrans: fix global "make install"
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161117214210.22625-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <67a2d9f5-9cc9-7a7e-bc8b-3d90ea248cf6@tycho.nsa.gov>
Date: Thu, 17 Nov 2016 16:50:47 -0500
MIME-Version: 1.0
In-Reply-To: <20161117214210.22625-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2016 04:42 PM, Nicolas Iooss wrote:
> When running "make install" in the root directory of the project, with
> variable DESTDIR set and while being on a system without SELinux, the
> compiler complains while building:
> 
>     fatal error: selinux/selinux.h: No such file or directory
> 
> Other subdirectories add -I$(PREFIX)/include to CFLAGS and -L$(LIBDIR)
> to the linking command line, in order to find libselinux headers and .so
> file. Do this too in mcstrans.
> 
> While at it, mcstrans Makefile uses -I../include but this directory does
> not exist. Remove this option.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  mcstrans/src/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index ae74a16d278d..ea463bc1ec6f 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -10,12 +10,12 @@ PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
>  PROG=mcstransd
>  INITSCRIPT=mcstrans
>  CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
> -override CFLAGS += -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> +override CFLAGS += -I$(PREFIX)/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
>  
>  all: $(PROG)
>  
>  $(PROG): $(PROG_OBJS)
> -	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
> +	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a -L$(LIBDIR)
>  
>  %.o:  %.c 
>  	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
> 
