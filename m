Message-ID: <1484776134.7073.4.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] Re-link programs after libsepol.a is updated
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Wed, 18 Jan 2017 16:48:54 -0500
In-Reply-To: <CAJfZ7=mNS_hEnR9R4GdD1NHjnqxNqiB-seRA6EeGMmccE1rz=g@mail.gmail.com>
References: <20170114143825.4592-1-nicolas.iooss@m4x.org>
 <1484689682.20454.26.camel@tycho.nsa.gov>
 <CAJfZ7=mNS_hEnR9R4GdD1NHjnqxNqiB-seRA6EeGMmccE1rz=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-01-17 at 23:01 +0100, Nicolas Iooss wrote:
> On Tue, Jan 17, 2017 at 10:48 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Sat, 2017-01-14 at 15:38 +0100, Nicolas Iooss wrote:
> > > After libsepol is modified (for example while developing new
> > features
> > > or
> > > fixing bugs), running "make install" in the top-level directory
> > does
> > > not
> > > update the programs which use libsepol.a. Add this static library
> > to
> > > the
> > > target dependencies in order to force their updates. This makes
> > > "make"
> > > use libsepol.a in the linking command without using LDLIBS.
> > >
> > > While at it, copy what commit 14d706434846 ("libselinux: Allow
> > > overriding libsepol.a location during build") introduced in
> > > libselinux
> > > Makefile by using a new LIBSEPOLA variable in all Makefiles.
> > 
> 
> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > index d17792c13350..5640a57d2768 100644
> > > --- a/libselinux/src/Makefile
> > > +++ b/libselinux/src/Makefile
> > > @@ -155,8 +155,8 @@ selinuxswig_python_exception.i:
> > > ../include/selinux/selinux.h
> > >  $(AUDIT2WHYLOBJ): audit2why.c
> > >       $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC
> > > -DSHARED -c -o $@ $<
> > >  
> > > -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> > > -     $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux
> > > $(LIBSEPOLA) $(PYLIBS) -L$(LIBDIR)
> > > +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> > > +     $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux
> > > $(PYLIBS) -L$(LIBDIR)
> > 
> > Why did you change this?
> 
> When libsepol.a is updated, $(AUDIT2WHYSO) (which is a Python
> extension, named something like python3audit2why.so and installed as
> module "selinux.audit2why") was not rebuilt. Adding $(LIBSEPOLA) to
> the dependencies (in order to fix this) makes libsepol.a appear in
> the command line through $^ so I removed $(LIBSEPOLA) from the
> "$(CC)..." line.

Ok, thanks.  Applied.
