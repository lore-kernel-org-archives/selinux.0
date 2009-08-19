Subject: Re: checking user status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Larry Ross <selinux.larry@gmail.com>, selinux@tycho.nsa.gov,
        Steve Grubb <sgrubb@redhat.com>
In-Reply-To: <4A8AEE9E.1020102@redhat.com>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
	 <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
	 <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
	 <1250599197.3629.210.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908181015j71ce6b62tdc5f5251220d84a9@mail.gmail.com>
	 <4A8AEE9E.1020102@redhat.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 10:34:21 -0400
Message-Id: <1250692461.3629.309.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-18 at 14:10 -0400, Daniel J Walsh wrote:
> On 08/18/2009 01:15 PM, Larry Ross wrote:
> > On Tue, Aug 18, 2009 at 5:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > 
> >> On Tue, 2009-08-18 at 08:19 -0400, Stephen Smalley wrote:
> >>> If this is another manifestation of the same problem, then the easiest
> >>> approach would be to grab the libselinux .src.rpm, patch
> >>> libselinux/src/checkAccess.c to syslog() a message whenever there is a
> >>> denial, build and install your patched libselinux, and then retry and
> >>> look for the log message.
> >>
> >> Something like this patch (un-tested, against the current upstream
> >> libselinux):
> >>
> >> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> >> index c1982c7..cae1626 100644
> >> --- a/libselinux/src/checkAccess.c
> >> +++ b/libselinux/src/checkAccess.c
> >> @@ -2,6 +2,7 @@
> >>  #include <sys/types.h>
> >>  #include <stdlib.h>
> >>  #include <errno.h>
> >> +#include <syslog.h>
> >>  #include "selinux_internal.h"
> >>  #include <selinux/flask.h>
> >>  #include <selinux/av_permissions.h>
> >> @@ -29,7 +30,15 @@ int selinux_check_passwd_access(access_vector_t
> >> requested)
> >>
> >>                if ((retval == 0) && ((requested & avd.allowed) ==
> >> requested)) {
> >>                        status = 0;
> >> +               } else {
> >> +                       syslog(LOG_ERR,
> >> +                              "avc:  denied { %s } for scontext=%s "
> >> +                              "tcontext=%s tclass=passwd\n",
> >> +                              security_av_perm_to_string(passwd_class,
> >> +                                                         requested),
> >> +                              user_context, user_context);
> >>                }
> >> +
> >>                freecon(user_context);
> >>         }
> >>
> > 
> > Where does the passwd_class come from?
> > 
> >   -- Larry
> > 
> > 
> > 
> > 
> >>
> >>
> >>
> >> --
> >> Stephen Smalley
> >> National Security Agency
> >>
> >>
> > 
> 
> This is not the responsibility of the library to log this fact, it is the responsibility of the tool (passwd) to log 
> any denials.  I am surprised that we do not audit this event.  Since I think a MAC denial on changing a security sensitive object should probably be audited.

But only the library function has all the necessary information to
generate an audit or log record that can be processed by e.g.
audit2allow (the source and target contexts, class, and permission).

I do agree that the callers should be modified to use the userspace AVC;
then they would pick up the normal avc auditing support (but would need
to set up the proper callback to invoke the audit interfaces, just like
dbusd does).

I think the bug would be against shadow-utils.  Did anyone already open
it?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
