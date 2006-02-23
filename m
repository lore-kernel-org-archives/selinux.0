Subject: Re: libselinux CVS doesn't honor DESTDIR
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1140700506.10547.6.camel@wintermute.xmldesign.de>
References: <1140700506.10547.6.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 08:35:07 -0500
Message-Id: <1140701707.21179.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-23 at 14:15 +0100, Erich Schubert wrote:
> Hello Stephen,
> libselinux CVS doesn't honor $(DESTDIR). Here's the patch
> (I'm not sure it's perfect, but thats how the makefile of libsemanage
> looks like. ;-) )
> 
> --- src/Makefile~	2006-02-23 04:24:45.000000000 +0100
> +++ src/Makefile	2006-02-23 14:04:30.000000000 +0100
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -PREFIX ?= /usr
> +PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include

I'm confused; I see the following in the selinux sourceforge CVS tree:
1.1          (ssmalley 14-Aug-03): # Installation directories.
1.1          (ssmalley 14-Aug-03): PREFIX ?= $(DESTDIR)/usr
1.1          (ssmalley 14-Aug-03): LIBDIR ?= $(PREFIX)/lib
1.3          (ssmalley 20-Oct-03): SHLIBDIR ?= $(DESTDIR)/lib
1.16         (ssmalley 13-Oct-05): INCLUDEDIR ?= $(PREFIX)/include

> On a side note: libselinux CVS is required for current semanage, due to
> the fix in the swig interface in
> http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/libselinux/src/selinuxswig.i?r1=1.1&r2=1.2
> Which is not in the latest libselinux release.

Ok.  semanage in that release wasn't very mature anyway.  We should be
able to make an updated release soon, as Fedora development has finally
slowed down for final testing.  Need to make sure that everything works
without MCS/MLS first (which requires at least the patch posted by Dan
Walsh for policycoreutils, and I think it needs a further fix).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
