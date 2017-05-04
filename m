Message-ID: <1493930984.29203.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol: Add INCLUDEDIR to utils/Makefile
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Date: Thu, 04 May 2017 16:49:44 -0400
In-Reply-To: <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
References: <20170504140857.18863-1-plautrba@redhat.com>
 <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-04 at 16:22 +0200, Petr Lautrbach wrote:
> The patch is wrong, please disregard.
> 
> I'm not sure about the right fix in order not to break gentoo use
> case.
> I'd just revert fcb5d5c change in libsepol/utils/Makefile for now.

Can't you just specify CFLAGS to make, similar to what is done in the
top-level Makefile for building with DESTDIR set?

> 
> 
> 
> On 05/04/2017 04:08 PM, Petr Lautrbach wrote:
> > fcb5d5c removed ../include from CFLAGS from libsepol/utils/Makefile
> > so
> > that a build tool can't find sepol/sepol.h when libsepol is built
> > on a
> > system without sepol.h in standard paths.
> > 
> > Fixes:
> > chkcon.c:1:10: fatal error: sepol/sepol.h: No such file or
> > directory
> >  #include <sepol/sepol.h>
> > 
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >  libsepol/utils/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> > index a13164e1..f5097be7 100644
> > --- a/libsepol/utils/Makefile
> > +++ b/libsepol/utils/Makefile
> > @@ -1,6 +1,7 @@
> >  # Installation directories.
> >  PREFIX ?= $(DESTDIR)/usr
> >  BINDIR ?= $(PREFIX)/bin
> > +INCLUDEDIR ?= $(PREFIX)/include
> >  
> >  CFLAGS ?= -Wall -Werror
> >  LDFLAGS += -L../src
> > 
> 
> 
