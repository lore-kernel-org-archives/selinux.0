Subject: Re: [PATCH v5] Fix includes for userspace tools and libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Thu, 15 Sep 2011 22:32:30 +0200
In-Reply-To: <1316116803.16483.106.camel@moss-pluto>
References: <1315587716.2170.16.camel@vortex>
	 <1315588656.2170.26.camel@vortex>
	 <CACLa4pu2eN1OM_ni5Zssb8O9d0S49CoAZnS4-XKoALNdqunCsA@mail.gmail.com>
	 <1315832253.17035.5.camel@moss-pluto> <1315859373.2223.19.camel@vortex>
	 <4E6E8149.30702@redhat.com> <1315917697.12522.1.camel@moss-pluto>
	 <1315931495.2248.29.camel@vortex> <1315934421.12522.46.camel@moss-pluto>
	 <1315938784.2218.14.camel@vortex> <1315939689.12522.51.camel@moss-pluto>
	 <1315941501.2218.26.camel@vortex>  <1315941958.12522.77.camel@moss-pluto>
	 <1315942469.12522.81.camel@moss-pluto> <1315944244.2218.41.camel@vortex>
	 <1315945618.2738.13.camel@localhost>  <1315951507.2218.91.camel@vortex>
	 <1316004965.26965.9.camel@moss-pluto>  <1316054641.23290.48.camel@vortex>
	 <1316091385.16483.13.camel@moss-pluto>  <1316102675.2202.23.camel@vortex>
	 <1316104531.16483.26.camel@moss-pluto>  <1316106206.2202.33.camel@vortex>
	 <1316106992.16483.35.camel@moss-pluto>  <1316107603.2202.43.camel@vortex>
	 <1316110489.16483.68.camel@moss-pluto>  <1316113928.2202.76.camel@vortex>
	 <1316116803.16483.106.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316118750.2202.115.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen.

On Thu, 2011-09-15 at 16:00 -0400, Stephen Smalley wrote:
> On Thu, 2011-09-15 at 21:12 +0200, Guido Trentalancia wrote:
> > I did hit other issues too. Lesson learned was: add -lbz2 -lustr to
> > LDLIBS in policycoreutils/{semodule,setsebool}/Makefile and replace =
> > with ?= in checkpolicy/test/Makefile
> > 
> > Unfortunately none of the above is exactly what I am looking for...
> > 
> > I am looking to install directly under the root live filesystem. So
> > DESTDIR is not going to be used in my specific case. And I need
> > LIBDIR=SHLIBDIR=/usr/lib64. Also, I'd like to first type "make" to build
> > only and then type "make install" to get things installed.
> > 
> > rm -rf /usr/include/selinux/ ; rm -rf /usr/include/semanage/ ; rm
> > -rf /usr/include/sepol/ ; rm -f /usr/lib64/libsepol.* ; rm
> > -f /usr/lib64/libsemanage.* ; CFLAGS="-O3 -march=corei7 -mtune=corei7"
> > LIBDIR=/usr/lib64 SHLIBDIR=/usr/lib64 make install
> > 
> > Works with "install" target only with latest git. So it is not possible
> > to build only first and then install.
> 
> Yes, if you want that, you'll need further changes.  

It's not me specifically wanting that, I think...

> But rather than
> changing the component Makefiles in a manner that won't work for
> separate builds, how about defining some top-level variables and using
> them throughout, with conditional definitions (?=) within the individual
> Makefiles so that the separate builds still work.  Like the following
> (incomplete, but gives the idea):
> 
> diff --git a/Makefile b/Makefile
> index 09c2c1e..f68a2b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,10 @@ ifeq ($(DEBUG),1)
>  	export LDFLAGS = -g
>  endif
>  
> +export LIBSEPOLSTATIC=$(CURDIR)/libsepol/src/libsepol.a
> +export EXTRA_INCLUDES=-I$(CURDIR)/libsepol/include -I$(CURDIR)/libselinux/include -I$(CURDIR)/libsemanage/include
> +export EXTRA_LIBS=-L$(CURDIR)/libsepol/src -L$(CURDIR)/libselinux/src -L$(CURDIR)/libsemanage/src

Yes, I like the idea. I would only really change EXTRA to LOCAL for
better readability.

>  all install relabel clean test indent:
>  	@for subdir in $(SUBDIRS); do \
>  		(cd $$subdir && $(MAKE) $@) || exit 1; \
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 7680008..4651616 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -7,7 +7,8 @@ PYPREFIX ?= $(notdir $(PYTHON))
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> -SHLIBDIR ?= $(PREFIX)/lib
> +LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a

Hopefully the above won't override the exported one from top-level...

> +SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
>  PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
> @@ -54,7 +55,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
>  OBJS= $(patsubst %.c,%.o,$(SRCS))
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS))
>  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
> -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
> +override CFLAGS += -I../include -I$(INCLUDEDIR) $(EXTRA_INCLUDES) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)

It seems to me that you are giving the precedence to the system-wide
includes. We want the EXTRA/LOCAL ones to have precedence over the
system-wide ones, with the fall-back only for released components (which
won't have EXTRA/LOCAL passed to them from a top-level Makefile).

>  RANLIB=ranlib
>  
>  ARCH := $(patsubst i%86,i386,$(shell uname -m))
> @@ -102,7 +103,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux $(LIBSEPOLSTATIC) -L$(LIBDIR) -Wl,-soname,$@

As long as the locally-defined LIBSEPOLSTATIC did not override the
top-level exported one for builds from the whole git bundle (see
above)...

>  %.o:  %.c policy.h
>  	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index d9120c0..44962e6 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -55,7 +55,7 @@ OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
>  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
>  
> -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE 
> +override CFLAGS += -I../include -I$(INCLUDEDIR) $(EXTRA_INCLUDES) -D_GNU_SOURCE 

See above for precedence of flags (search order).

>  RANLIB=ranlib
>  
>  SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
> @@ -87,7 +87,7 @@ $(LIBA): $(OBJS)
>  	$(RANLIB) $@
>  
>  $(LIBSO): $(LOBJS)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr $(EXTRA_LIBS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs

You already reminded me that the order does not matter to ld, I hope the
same is true for cpp and -I (see above).

>  	ln -sf $@ $(TARGET)
>  
>  $(LIBPC): $(LIBPC).in

If you decide to go for this solution there might be other minor things
from my original patch that might be worth importing.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
