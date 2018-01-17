Date: Wed, 17 Jan 2018 11:43:58 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Message-ID: <20180117104358.GA18334@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-9-marcus.folkesson@gmail.com>
 <20180117101135.GA22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117101135.GA22270@pl-rpi.tpb.lab.eng.brq.redhat.com>
Subject: Re: [PATCH v2 08/14] python: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

On Wed, Jan 17, 2018 at 11:11:35AM +0100, Petr Lautrbach wrote:
> On Tue, Jan 16, 2018 at 09:23:21PM +0100, Marcus Folkesson wrote:
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  python/audit2allow/Makefile           | 10 ++++------
> >  python/chcat/Makefile                 |  8 ++++----
> >  python/semanage/Makefile              | 13 ++++++-------
> >  python/sepolgen/src/sepolgen/Makefile |  3 ++-
> >  python/sepolicy/Makefile              | 18 +++++++++---------
> >  5 files changed, 25 insertions(+), 27 deletions(-)
> > 
> > diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> > index 8db8075f..a73c8c68 100644
> > --- a/python/audit2allow/Makefile
> > +++ b/python/audit2allow/Makefile
> > @@ -1,12 +1,10 @@
> >  PYTHON ?= python
> >  
> >  # Installation directories.
> > -PREFIX ?= $(DESTDIR)/usr
> > -BINDIR ?= $(PREFIX)/bin
> > -LIBDIR ?= $(PREFIX)/lib
> > -MANDIR ?= $(PREFIX)/share/man
> > -LOCALEDIR ?= /usr/share/locale
> > -INCLUDEDIR ?= $(PREFIX)/include
> > +PREFIX ?= /usr
> > +BINDIR ?= $(DESTDIR)$(PREFIX)/bin
> > +LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
> > +MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
> >  LIBSEPOLA ?= $(LIBDIR)/libsepol.a
> >  
> >  CFLAGS ?= -Werror -Wall -W
> > diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> > index 0fd12d6d..947734a0 100644
> > --- a/python/chcat/Makefile
> > +++ b/python/chcat/Makefile
> > @@ -1,8 +1,8 @@
> >  # Installation directories.
> > -PREFIX ?= $(DESTDIR)/usr
> > -BINDIR ?= $(PREFIX)/bin
> > -MANDIR ?= $(PREFIX)/share/man
> > -LOCALEDIR ?= $(PREFIX)/share/locale
> > +PREFIX ?= /usr
> > +BINDIR ?= $(DESTDIR)$(PREFIX)/bin
> > +MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
> > +LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
> >  
> >  .PHONY: all
> >  all: chcat
> > diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> > index 132162bc..70759087 100644
> > --- a/python/semanage/Makefile
> > +++ b/python/semanage/Makefile
> > @@ -1,13 +1,12 @@
> >  PYTHON ?= python
> >  
> >  # Installation directories.
> > -PREFIX ?= $(DESTDIR)/usr
> > -LIBDIR ?= $(PREFIX)/lib
> > -SBINDIR ?= $(PREFIX)/sbin
> > -MANDIR = $(PREFIX)/share/man
> > -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
> > -PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
> > -BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
> > +PREFIX ?= /usr
> > +SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
> > +MANDIR = $(DESTDIR)$(PREFIX)/share/man
> > +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> > +PACKAGEDIR ?= $(DESTDIR)$(PYTHONLIBDIR)
> > +BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
> >  
> >  TARGETS=semanage
> >  
> > diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
> > index d3aa7715..2121a955 100644
> > --- a/python/sepolgen/src/sepolgen/Makefile
> > +++ b/python/sepolgen/src/sepolgen/Makefile
> > @@ -1,5 +1,6 @@
> > +PREFIX ?= /usr
> >  PYTHON ?= python
> > -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(1))")
> > +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> >  PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen
> >  
> >  all:
> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > index 5a56e6c8..c528ae43 100644
> > --- a/python/sepolicy/Makefile
> > +++ b/python/sepolicy/Makefile
> > @@ -1,14 +1,14 @@
> >  PYTHON ?= python
> >  
> >  # Installation directories.
> > -PREFIX ?= $(DESTDIR)/usr
> > -LIBDIR ?= $(PREFIX)/lib
> > -BINDIR ?= $(PREFIX)/bin
> > -DATADIR ?= $(PREFIX)/share
> > -MANDIR ?= $(PREFIX)/share/man
> > -LOCALEDIR ?= /usr/share/locale
> > -BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
> > -SHAREDIR ?= $(PREFIX)/share/sandbox
> > +PREFIX ?= /usr
> > +LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
> > +BINDIR ?= $(DESTDIR)$(PREFIX)/bin
> > +DATADIR ?= $(DESTDIR)$(PREFIX)/share
> > +MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
> > +LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
> > +BASHCOMPLETIONDIR ?= $(DESTDIR)$(PREFIX)/share/bash-completion/completions
> > +SHAREDIR ?= $(DESTDIR)$(PREFIX)/share/sandbox
> >  CFLAGS ?= -Wall -Werror -Wextra -W
> >  override CFLAGS += -DPACKAGE="policycoreutils" -DSHARED -shared
> >  
> > @@ -30,7 +30,7 @@ test:
> >  	@$(PYTHON) test_sepolicy.py -v
> >  
> >  install:
> > -	$(PYTHON) setup.py install `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
> > +	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)$(PREFIX)" && echo --root $(DESTDIR)$(PREFIX)`
> 
> --root $(DESTDIR)$(PREFIX) seems to duplicate prefix from  --prefix=$(PREFIX)
> 
> $ cd python
> $ make \
>   DESTDIR=/home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.20180117103354.x86_64 \
>   LIBSEPOLA=/usr/lib64/libsepol.a install
> 
> $ find /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.20180117103354.x86_64/usr/ -type d -name sepolicy
> /home/build/rpmbuild/BUILDROOT/policycoreutils-2.7-99.fc28.20180117103354.x86_64//usr/usr/lib/python2.7/site-packages/sepolicy
> 

Thank you for discovering this!
I take it with me to v3.

Another thing; 
I have tried to get rid of the LIBSEPOLA variable and instead let the
linker look in default locations after libsepol.a.
This to get rid of DESTDIR during compile time.

For example:
	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS) -l:libsepol.a

Do you think we should keep LIBSEPOLA as variable (but default to
$(PREFIX)/lib/libsepol.a) or let it go with default path?


Thank you


> >  	[ -d $(BINDIR) ] || mkdir -p $(BINDIR)
> >  	install -m 755 sepolicy.py $(BINDIR)/sepolicy
> >  	(cd $(BINDIR); ln -sf sepolicy sepolgen)
> > -- 
> > 2.15.1
> > 
> > 


Best regards
Marcus Folkesson
