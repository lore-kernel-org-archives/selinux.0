Message-ID: <1498227282.2063.2.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/4] libselinux, libsemanage: link Ruby wrapper with -lruby
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Zaman <jason@perfinion.com>, Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Fri, 23 Jun 2017 10:14:42 -0400
In-Reply-To: <20170621142749.GA27536@meriadoc.perfinion.com>
References: <20161114212817.15781-1-nicolas.iooss@m4x.org>
 <20161114212817.15781-2-nicolas.iooss@m4x.org>
 <d0922e29-f6ab-6302-ec8d-8e22ec2368b8@debian.org>
 <1498052525.32258.0.camel@tycho.nsa.gov>
 <CAJfZ7=mTrdKT0o62-O_FwX6d4E7805w77=bKqOge=BQY6OFXaQ@mail.gmail.com>
 <20170621142749.GA27536@meriadoc.perfinion.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-06-21 at 22:27 +0800, Jason Zaman wrote:
> On Wed, Jun 21, 2017 at 04:02:29PM +0200, Nicolas Iooss wrote:
> > On Wed, Jun 21, 2017 at 3:42 PM, Stephen Smalley <sds@tycho.nsa.gov
> > > wrote:
> > > On Wed, 2017-06-21 at 11:38 +0200, Laurent Bigonville wrote:
> > > > Hello,
> > > > 
> > > > Le 14/11/16 à 22:28, Nicolas Iooss a écrit :
> > > > > When linking with -Wl,-no-undefined in LDFLAGS (in order to
> > > > > find
> > > > > possible link-time errors), the Ruby wrapper module needs to
> > > > > be
> > > > > linked
> > > > > with the libruby.so which is used by $(RUBY). Introduce a new
> > > > > RUBYLIBS
> > > > > variable to find this library.
> > > > > 
> > > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > > ---
> > > > >   libselinux/src/Makefile  | 3 ++-
> > > > >   libsemanage/src/Makefile | 3 ++-
> > > > >   2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/libselinux/src/Makefile
> > > > > b/libselinux/src/Makefile
> > > > > index 4fe1f7002181..82a1010af2d8 100644
> > > > > --- a/libselinux/src/Makefile
> > > > > +++ b/libselinux/src/Makefile
> > > > > @@ -15,6 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
> > > > >   PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> > > > >   PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site;
> > > > > print(site.getsitepackages()[0])')
> > > > >   RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" +
> > > > > RbConfig::CONFIG["rubyarchhdrdir"] + " -I" +
> > > > > RbConfig::CONFIG["rubyhdrdir"]')
> > > > > +RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" +
> > > > > RbConfig::CONFIG["libdir"] + " -lruby"')
> > > > 
> > > > I'm trying to package 2.7-rc2 in debian and unfortunately this
> > > > is
> > > > not
> > > > working out of the box for me. The library is not installed as
> > > > -lruby
> > > > but as -lruby-2.3 (for ruby 2.3). In addition the lib is not
> > > > installed
> > > > in /usr/lib.
> > > > 
> > > > I can see in the RbConfig::CONFIG hash a key called
> > > > LIBRUBYARG_SHARED
> > > > or
> > > > LIBRUBYARG which contains "-lruby-2.3". Also I see a
> > > > "archlibdir" or
> > > > "sitearchlibdir" key which contains the correct path to the lib
> > > > (the
> > > > multiarch path)
> > > > 
> > > > RUBYLIBS ?= $(shell $@ -e 'puts "-L" +
> > > > RbConfig::CONFIG["archlibdir"]
> > > > +
> > > > " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
> > > > 
> > > > Could this be a possible alternatives for the other
> > > > distributions?
> > > 
> > > Assuming you mean $(RUBY) rather than $@ above, that works for me
> > > on
> > > Fedora:
> > > $ ruby -e 'puts "-L" + RbConfig::CONFIG["archlibdir"] + " " +
> > > RbConfig::CONFIG["LIBRUBYARG_SHARED"]'
> > > -L/usr/lib64 -lruby
> > 
> > On Arch Linux:
> > 
> > $ ruby -e 'puts RbConfig::CONFIG["LIBRUBYARG"]'
> > -lruby
> > $ ruby -e 'puts RbConfig::CONFIG["LIBRUBYARG_SHARED"]'
> > -lruby
> > $ ruby -e 'puts RbConfig::CONFIG["archlibdir"]'
> > /usr/lib/x86_64-linux
> > $ ls -l /usr/lib/x86_64-linux/libruby.so
> > ls: cannot access '/usr/lib/x86_64-linux/libruby.so': No such file
> > or directory
> > $ ruby -e 'puts RbConfig::CONFIG["libdir"]'
> > /usr/lib
> > $ ls -l /usr/lib/libruby.so
> > lrwxrwxrwx 1 root root 16 2017-04-22 15:40 /usr/lib/libruby.so ->
> > libruby.so.2.4.1*
> > 
> > So replacing -lruby with RbConfig::CONFIG["LIBRUBYARG_SHARED"] and
> > adding "-L" + RbConfig::CONFIG["archlibdir"] in RUBYLIBS definition
> > seem to work fine.
> > 
> > Nicolas
> 
> Heres gentoo:
> $ ruby -e 'puts RbConfig::CONFIG["LIBRUBYARG"]'
> -lruby21
> $ ruby -e 'puts RbConfig::CONFIG["LIBRUBYARG_SHARED"]'
> -lruby21
> $ ruby -e 'puts RbConfig::CONFIG["archlibdir"]'
> /usr/lib64/x86_64-linux
> $ stat /usr/lib64/x86_64-linux
> stat: cannot stat '/usr/lib64/x86_64-linux': No such file or
> directory
> $ ruby -e 'puts RbConfig::CONFIG["libdir"]'
> /usr/lib64
> $ ls -l /usr/lib64/libruby2*
> -rw-r--r--. 1 root root 4078832 May  8 16:27 /usr/lib64/libruby21-
> static.a
> lrwxrwxrwx. 1 root root      18 May  8 16:27 /usr/lib64/libruby21.so
> -> libruby21.so.2.1.0*
> lrwxrwxrwx. 1 root root      18 May  8 16:27
> /usr/lib64/libruby21.so.2.1 -> libruby21.so.2.1.0*
> -rwxr-xr-x. 1 root root 2506160 May  8 16:27
> /usr/lib64/libruby21.so.2.1.0*
> -rw-r--r--. 1 root root 4588894 May  6 12:28 /usr/lib64/libruby22-
> static.a
> lrwxrwxrwx. 1 root root      18 May  6 12:28 /usr/lib64/libruby22.so
> -> libruby22.so.2.2.0*
> lrwxrwxrwx. 1 root root      18 May  6 12:28
> /usr/lib64/libruby22.so.2.2 -> libruby22.so.2.2.0*
> -rwxr-xr-x. 1 root root 2622488 May  6 12:28
> /usr/lib64/libruby22.so.2.2.0*
> 
> $ qlist -Iv ruby
> ...
> dev-lang/ruby-2.1.9
> dev-lang/ruby-2.2.6

So, what's the conclusion?  Do we have a consensus on replacing it as
proposed?  Looks like from the output above that archlibdir doesn't
actually work on gentoo or arch since the file doesn't exist there?
