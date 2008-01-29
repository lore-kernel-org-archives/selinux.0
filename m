Subject: Re: Patch to add python audit2why bindings.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080129103040.GB21672@bobek.pm.i.cz>
References: <4787936A.8030803@redhat.com>
	 <20080129103040.GB21672@bobek.pm.i.cz>
Content-Type: text/plain; charset=utf-8
Date: Tue, 29 Jan 2008 08:19:32 -0500
Message-Id: <1201612772.2823.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-01-29 at 11:30 +0100, Václav Ovsík wrote:
> Hi,
> 
> On Fri, Jan 11, 2008 at 11:03:54AM -0500, Daniel J Walsh wrote:
> > ...
> > --- nsalibselinux/src/audit2why.c	1969-12-31 19:00:00.000000000 -0500
> > +++ libselinux-2.0.46/src/audit2why.c	2008-01-11 10:51:10.000000000 -0500
> > @@ -0,0 +1,460 @@
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <ctype.h>
> > +#include <errno.h>
> > +#include <getopt.h>
> > +#include <limits.h>
> > +#include <sepol/sepol.h>
> > +#include <sepol/policydb/services.h>
> > +#include <Python.h>
> > +#include <selinux/selinux.h>
> > +
> 
> I had a bit problem with headers order on Debian Etch.
> 
> zito@bobek:~/proj/iczlinux/selinux/libselinux/src$ cc -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -I../include -I/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64  -I/usr/include/python2.5 -fPIC -DSHARED -c -o audit2why.lo audit2why.c
> In file included from /usr/include/python2.5/Python.h:8,
>                  from audit2why.c:9:
> /usr/include/python2.5/pyconfig.h:932:1: error: "_POSIX_C_SOURCE" redefined
> In file included from /usr/include/unistd.h:26,
>                  from audit2why.c:1:
> /usr/include/features.h:150:1: error: this is the location of the previous definition
> 
> 
> After moving `#include <Python.h>' on the first line, compilation succeded.

Ok, fixed in the svn trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
