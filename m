Subject: Re: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87pr8gvo6r.fsf@anzu.internal.golden-gryphon.com>
References: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
	 <4AD489A5.7010708@manicmethod.com>
	 <87k4yypls7.fsf@anzu.internal.golden-gryphon.com>
	 <1255962053.3099.22.camel@moss-pluto.epoch.ncsc.mil>
	 <87pr8gvo6r.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 10:29:29 -0400
Message-Id: <1256135369.4061.190.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-21 at 09:03 -0500, Manoj Srivastava wrote:
> On Mon, Oct 19 2009, Stephen Smalley wrote:
> 
> > On Wed, 2009-10-14 at 00:49 -0500, Manoj Srivastava wrote:
> >> On Tue, Oct 13 2009, Joshua Brindle wrote:
> >> 
> >> 
> >> > Yes, I'm not sure why you'd need libsemanage during early boot, we
> >> > probably should apply this:
> >> >
> >> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> >> > index cfb9558..c531a2f 100644
> >> > --- a/libsemanage/src/Makefile
> >> > +++ b/libsemanage/src/Makefile
> >> > @@ -1,7 +1,7 @@
> >> >  # Installation directories.
> >> >  PREFIX ?= $(DESTDIR)/usr
> >> >  LIBDIR ?= $(PREFIX)/lib
> >> > -SHLIBDIR ?= $(DESTDIR)/lib
> >> > +SHLIBDIR ?= $(PREFIX)/lib
> >> >  INCLUDEDIR ?= $(PREFIX)/include
> >> >  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" %
> >> > sys.version_info[0:2]')
> >> >  PYINC ?= /usr/include/${PYLIBVER}
> >> >
> >> 
> >>         I've applied this patch in Debian unstable.
> >
> > My only concern with relocating libsemanage is whether it will create
> > any compatibility problems for existing binaries previously linked
> > against /lib/libsemanage.so.1.  Also it could get confusing if you
> > build and install the newer version and existing binaries keep using
> > the old library at the old location.  You likely need/want to symlink
> > /lib/libsemanage.so.1 to the new location.
> 
>         As long as the new library location is in the ld.so path, there
>  is no issue, is there?  At run time, ld.so searches the path, loads the
>  shared libraries from the new location, prepares the program to run,
>  and then runs it. At worst, there might be two copies of the library
>  loaded into memory, in case there are programs already running linked
>  with libsemanage.
> 
>         If I am wrong, and long running programs might be affected when
>  the library location is yanked out from under them, some mitigating
>  action may be taken. I am not sure there are any daemons yet linked
>  with libsemanage, but I can arrange for any such daemons to be
>  restarted during installation, once I get any bug report.

No, I think my concern was misplaced.  As long as we ensure that we
don't leave a stale copy of the library around in the old location, we
should be fine.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
