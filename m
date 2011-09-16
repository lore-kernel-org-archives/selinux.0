Subject: Re: [PATCH v5] Fix includes for userspace tools and libraries
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Date: Fri, 16 Sep 2011 14:50:29 +0200
In-Reply-To: <1316176744.20456.5.camel@moss-pluto>
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
	 <1316116803.16483.106.camel@moss-pluto>  <1316118750.2202.115.camel@vortex>
	 <1316176744.20456.5.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316177429.2211.34.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-16 at 08:39 -0400, Stephen Smalley wrote:
> On Thu, 2011-09-15 at 22:32 +0200, Guido Trentalancia wrote:
> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > index 7680008..4651616 100644
> > > --- a/libselinux/src/Makefile
> > > +++ b/libselinux/src/Makefile
> > > @@ -7,7 +7,8 @@ PYPREFIX ?= $(notdir $(PYTHON))
> > >  # Installation directories.
> > >  PREFIX ?= $(DESTDIR)/usr
> > >  LIBDIR ?= $(PREFIX)/lib
> > > -SHLIBDIR ?= $(PREFIX)/lib
> > > +LIBSEPOLSTATIC ?= $(LIBDIR)/libsepol.a
> > 
> > Hopefully the above won't override the exported one from top-level...
> 
> It won't, because we use the ?= operator above.  So it will take effect
> if building in the libselinux directory, as for a per-package build, not
> if building from top-level.
> 
> > > @@ -54,7 +55,7 @@ SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
> > >  OBJS= $(patsubst %.c,%.o,$(SRCS))
> > >  LOBJS= $(patsubst %.c,%.lo,$(SRCS))
> > >  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn -Wmissing-format-attribute
> > > -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
> > > +override CFLAGS += -I../include -I$(INCLUDEDIR) $(EXTRA_INCLUDES) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(EMFLAGS)
> > 
> > It seems to me that you are giving the precedence to the system-wide
> > includes. We want the EXTRA/LOCAL ones to have precedence over the
> > system-wide ones, with the fall-back only for released components (which
> > won't have EXTRA/LOCAL passed to them from a top-level Makefile).
> 
> See the description of -I in the man page for gcc.  The above will have
> the desired effect.
> 
> > > @@ -102,7 +103,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
> > >  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
> > >  
> > >  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> > > -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
> > > +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux $(LIBSEPOLSTATIC) -L$(LIBDIR) -Wl,-soname,$@
> > 
> > As long as the locally-defined LIBSEPOLSTATIC did not override the
> > top-level exported one for builds from the whole git bundle (see
> > above)...
> 
> It won't.

Yes, excellent, let's go for that then.

Guido



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
