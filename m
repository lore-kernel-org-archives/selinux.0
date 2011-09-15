Subject: Re: [PATCH 2/2] libselinux: do not use relative path when creating
 libselinux symlinks
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Date: Thu, 15 Sep 2011 04:01:14 +0200
In-Reply-To: <1316027881.26965.15.camel@moss-pluto>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
	 <1316026239-27148-2-git-send-email-eparis@redhat.com>
	 <1316027881.26965.15.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316052075.23290.26.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-09-14 at 15:18 -0400, Stephen Smalley wrote:
> On Wed, 2011-09-14 at 14:50 -0400, Eric Paris wrote:
> > At the moment we create a symlink:
> > 
> > /usr/lib/libselinux.so -> ../../lib/libselinux.so.1
> > 
> > This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
> > ../../.  Instead create a symlink from
> > 
> > $LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1
> > 
> > Thus it works no matter what values one might use for LIBDIR and
> > SHLIBDIR.
> 
> I'm not sure this works the way you would want.  Consider rpm build of
> libselinux - it does:
> make DESTDIR="%{buildroot}" LIBDIR="%{buildroot}%{_libdir}"
> SHLIBDIR="%{buildroot}/%{_lib}" BINDIR="%{buildroot}%{_sbindir}" install
> 
> And then rpm collects up the files into the package.

Yes, for example, as we were speculating earlier on in a different but
related thread, Fedora generally sorts out things in standard and
development packages at least for the libraries (because the libraries
can be both used "passively" or "actively" for further development).

So the executable belongs to the standard package and the link belongs
to the development package. Many other distributions also split
libraries in two packages (a standard one and a development one).

> But if the symlink encodes the full pathname used at make install time,
> then it will be wrong on the final system when the rpm is installed.

Ideally the link should be (re)created by the spec file. Otherwise, I
agree, a relative link should be used.

> Haven't actually tested that theory, but I think it is true.  Welcome to
> hell.

We can use a relative link instead of an absolute path and we could
install the link both in SHLIBDIR and LIBDIR. The rest would need to be
sorted out by distributions' automated build systems or individual
installers.

What do you say ?

Guido

> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> >  libselinux/src/Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 78874be..bccc777 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -126,7 +126,7 @@ install: all
> >  	install -m 755 $(LIBSO) $(SHLIBDIR)
> >  	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
> >  	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> > -	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
> > +	ln -sf $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
> >  
> >  install-pywrap: pywrap
> >  	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
