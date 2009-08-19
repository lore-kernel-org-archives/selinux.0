Subject: Re: checking user status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry <selinux@8martialartsforhealth.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <47aa07810908181210r52b93313u12109b239470cef1@mail.gmail.com>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
	 <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
	 <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
	 <1250599197.3629.210.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908181015j71ce6b62tdc5f5251220d84a9@mail.gmail.com>
	 <47aa07810908181210r52b93313u12109b239470cef1@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 07:33:37 -0400
Message-Id: <1250681617.3629.262.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-18 at 12:10 -0700, Larry wrote:
> On Tue, Aug 18, 2009 at 10:15 AM, Larry Ross <selinux.larry@gmail.com>
> wrote:
>         
>         On Tue, Aug 18, 2009 at 5:39 AM, Stephen Smalley
>         <sds@tycho.nsa.gov> wrote:
>                 On Tue, 2009-08-18 at 08:19 -0400, Stephen Smalley
>                 wrote:
>                 > If this is another manifestation of the same
>                 problem, then the easiest
>                 > approach would be to grab the libselinux .src.rpm,
>                 patch
>                 > libselinux/src/checkAccess.c to syslog() a message
>                 whenever there is a
>                 > denial, build and install your patched libselinux,
>                 and then retry and
>                 > look for the log message.
>                 
>                 
>                 Something like this patch (un-tested, against the
>                 current upstream
>                 libselinux):
>                 
>                 diff --git a/libselinux/src/checkAccess.c
>                 b/libselinux/src/checkAccess.c
>                 index c1982c7..cae1626 100644
>                 --- a/libselinux/src/checkAccess.c
>                 +++ b/libselinux/src/checkAccess.c
>                 @@ -2,6 +2,7 @@
>                  #include <sys/types.h>
>                  #include <stdlib.h>
>                  #include <errno.h>
>                 +#include <syslog.h>
>                  #include "selinux_internal.h"
>                  #include <selinux/flask.h>
>                  #include <selinux/av_permissions.h>
>                 @@ -29,7 +30,15 @@ int
>                 selinux_check_passwd_access(access_vector_t requested)
>                 
>                                if ((retval == 0) && ((requested &
>                 avd.allowed) == requested)) {
>                                        status = 0;
>                 +               } else {
>                 +                       syslog(LOG_ERR,
>                 +                              "avc:  denied { %s }
>                 for scontext=%s "
>                 +                              "tcontext=%s
>                 tclass=passwd\n",
>                 +
>                  security_av_perm_to_string(passwd_class,
>                 +
>                 requested),
>                 +                              user_context,
>                 user_context);
>  
> Looks like this should have been:
>                         syslog(LOG_ERR,
>                               "avc:  denied { %s } for scontext=%s "
>                               "tcontext=%s tclass=passwd\n",
> 
> security_av_perm_to_string(SECCLASS_PASSWD,
>                                                requested),
>                               user_context, user_context);
>  
>  
> Where should the reference to "security_av_perm_to_string'" come from?
>  
> checkAccess.lo: In function `selinux_check_passwd_access':
> checkAccess.c:(.text+0x9d): undefined reference to
> `security_av_perm_to_string'

My patch was relative to the latest version of libselinux from
http://userspace.selinuxproject.org.  The one shipped in RHEL5 is
obviously much older and may lack that function.  The older function
would have been print_access_vector() and/or avc_dump_av(), but you'd
have to adjust them to syslog() the output.  Or you could patch, build,
and install the latest libselinux from userspace.selinuxproject.org.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
