Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9MFjjXZ017432
	for <selinux@tycho.nsa.gov>; Fri, 22 Oct 2004 11:45:46 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9MFjiM5003165
	for <selinux@tycho.nsa.gov>; Fri, 22 Oct 2004 15:45:45 GMT
Date: Fri, 22 Oct 2004 16:56:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
Message-ID: <20041022155639.GA4986@lkcl.net>
References: <41782BBA.9090101@redhat.com> <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

or if it's a boolean (1 or 0) then store a char instead:

	char val;
	int err = getxattr(path, ..., &val, sizeof(val);
	*perm = val;
	return err;

On Fri, Oct 22, 2004 at 08:48:39AM -0400, Stephen Smalley wrote:

> On Thu, 2004-10-21 at 17:35, Daniel J Walsh wrote:
> > diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.17.15/src/getfilecon.c
> > --- nsalibselinux/src/getfilecon.c	2004-10-20 16:31:36.000000000 -0400
> > +++ libselinux-1.17.15/src/getfilecon.c	2004-10-20 16:35:52.000000000 -0400
> > @@ -4,7 +4,7 @@
> >  #include <selinux/selinux.h>
> >  #include <stdlib.h>
> >  #include <errno.h>
> > -#include <sys/xattr.h>
> > +#include <attr/xattr.h>
> >  #include "policy.h"
> 
> This is wrong; glibc directly provides [gs]etxattr for all modern glibc
> versions built against modern kernel headers; you don't need to use
> libattr.  We originally used attr/xattr.h and then migrated a long time
> ago.
> 
> > +int getfileconperm(const char *path, int *perm)
> > +{
> > +	*perm=0;
> > +	return getxattr(path, XATTR_NAME_SELINUX_PERM, perm, sizeof(*perm));
> > +}
> 
> Directly storing an integer in the xattr?  Endianness issues; you need
> to convert to a particular ordering before setting and convert back when
> getting.
> 
> -- 
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
