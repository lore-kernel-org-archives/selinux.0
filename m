Subject: Re: [PATCH 1/1] Makefile: make distclean target work
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20160928214032.22092-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f459147a-5871-88f0-70c7-93ea41f3cbb7@tycho.nsa.gov>
Date: Thu, 29 Sep 2016 10:50:49 -0400
MIME-Version: 1.0
In-Reply-To: <20160928214032.22092-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 05:40 PM, Nicolas Iooss wrote:
> A mispelling in the Makefile in the root directory prevented "make
> distclean" to go into subdirectories.
> 
> In libsemanage/src/, semanageswig_python_exception.i was not cleaned by
> "make distclean" because the target did not use $(GENERATED) and this
> variable was being redefined in the Makefile.
> 
> Fix these two bugs.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied

> ---
>  Makefile                 | 2 +-
>  libsemanage/src/Makefile | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 93e10dee4820..bed16498d0e7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,6 @@
>  SUBDIRS=libsepol libselinux libsemanage sepolgen checkpolicy secilc policycoreutils # policy
>  PYSUBDIRS=libselinux libsemanage
> -DISTCLEANSUBIDRS=libselinux libsemanage
> +DISTCLEANSUBDIRS=libselinux libsemanage
>  
>  ifeq ($(DEBUG),1)
>  	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 96ee652d06a9..68aab72cb619 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -51,7 +51,7 @@ SWIGFILES=$(SWIGSO) semanage.py
>  SWIGRUBYSO=$(RUBYPREFIX)_semanage.so
>  LIBSO=$(TARGET).$(LIBVERSION)
>  
> -GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i
> +GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i $(wildcard conf-*.[ch])
>  SRCS= $(filter-out $(GENERATED),$(sort $(wildcard *.c)))
>  
>  OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
> @@ -68,8 +68,6 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
>  
>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
>  
> -GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(wildcard conf-*.[ch])
> -
>  all: $(LIBA) $(LIBSO) $(LIBPC)
>  
>  pywrap: all $(SWIGSO)
> @@ -163,7 +161,7 @@ clean:
>  	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
>  
>  distclean: clean
> -	rm -f $(SWIGCOUT) $(SWIGFILES)
> +	rm -f $(GENERATED) $(SWIGFILES)
>  
>  indent:
>  	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
> 
