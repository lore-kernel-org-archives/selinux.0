Subject: Re: Small patch to allow semodule_deps to build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45CB3EC4.7000103@mentalrootkit.com>
References: <45CA4A0E.7000500@redhat.com>
	 <45CB3EC4.7000103@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 10:59:33 -0500
Message-Id: <1170950373.11912.276.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-08 at 10:16 -0500, Karl MacMillan wrote:
> Daniel J Walsh wrote:
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > --- nsapolicycoreutils/semodule_deps/semodule_deps.c	2007-02-07 12:11:49.000000000 -0500
> > +++ policycoreutils-2.0.0/semodule_deps/semodule_deps.c	2007-02-07 16:46:18.000000000 -0500
> > @@ -16,7 +16,7 @@
> >   * of avrule_blocks - even in an ABI safe way - seems undesirable.
> >   */
> >  #include <sepol/module.h>
> > -#include <sepol/errno.h>
> > +#include <sepol/errcodes.h>
> >  #include <sepol/policydb/policydb.h>
> >  
> >  #include <getopt.h>
> 
> This shouldn't be necessary - errcodes.h should be included via 
> policydb.h -> symtab.h -> hashtab.h. Also, I can't reproduce this locally.

Actually, Dan is correct at least in removing #include <sepol/errno.h> -
that was what you had originally called the header, but renamed to
errcodes.h in response to my comments.  So you (and I) had a lingering
errno.h left around from previous builds that obscured the broken build.
cd trunk/
rm -rf ~/obj
make DESTDIR=~/obj install
to reproduce.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
