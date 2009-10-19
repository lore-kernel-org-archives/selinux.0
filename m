Subject: Re: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <87k4yypls7.fsf@anzu.internal.golden-gryphon.com>
References: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
	 <4AD489A5.7010708@manicmethod.com>
	 <87k4yypls7.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Mon, 19 Oct 2009 10:20:53 -0400
Message-Id: <1255962053.3099.22.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-14 at 00:49 -0500, Manoj Srivastava wrote:
> On Tue, Oct 13 2009, Joshua Brindle wrote:
> 
> 
> > Yes, I'm not sure why you'd need libsemanage during early boot, we
> > probably should apply this:
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index cfb9558..c531a2f 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -1,7 +1,7 @@
> >  # Installation directories.
> >  PREFIX ?= $(DESTDIR)/usr
> >  LIBDIR ?= $(PREFIX)/lib
> > -SHLIBDIR ?= $(DESTDIR)/lib
> > +SHLIBDIR ?= $(PREFIX)/lib
> >  INCLUDEDIR ?= $(PREFIX)/include
> >  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" %
> > sys.version_info[0:2]')
> >  PYINC ?= /usr/include/${PYLIBVER}
> >
> 
>         I've applied this patch in Debian unstable.

My only concern with relocating libsemanage is whether it will create
any compatibility problems for existing binaries previously linked
against /lib/libsemanage.so.1.  Also it could get confusing if you build
and install the newer version and existing binaries keep using the old
library at the old location.  You likely need/want to
symlink /lib/libsemanage.so.1 to the new location.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
