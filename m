Subject: Re: I think this is equivalent to what we have
	now	and	more	efficient.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200702221156.49050.sgrubb@redhat.com>
References: <45DDAA80.80603@redhat.com>
	 <1172159012.14363.404.camel@moss-spartans.epoch.ncsc.mil>
	 <45DDBEFA.3050901@redhat.com>  <200702221156.49050.sgrubb@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 07:34:52 -0500
Message-Id: <1172234092.14363.468.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 11:56 -0500, Steve Grubb wrote:
> On Thursday 22 February 2007 11:04:10 Daniel J Walsh wrote:
> >     fp = fopen("/proc/filesystems", "r");
> >     if (fp == NULL)
> >         return -1;
> 
> This avoids speedups if selinux_mnt already determined that selinux file 
> system is mounted.

I don't think he was incorporating your optimizations yet, just trying
to address the original concern about short reads.

> >     while ((read = getline(&line, &len, fp)) != -1) {
> 
> calls malloc/realloc sometimes. Do we want to use this or just use 
> fgets_unlocked?

I'd prefer to convert all uses of fgets* to getline and let glibc handle
the allocations; we are already performing allocation on that code path
(just prior to the loop), and getline can handle it more intelligently
and dynamically based on the actual sizes.  Ulrich originally introduced
use of getline into libselinux and converted some functions, so
remaining cases of fgets* are legacy.

> >         if (strstr(line, "selinuxfs")) {
> >             enabled=1;
> >             break;
> >         }
> >     }
> 
> check for policy loaded ?

He dropped that per our discussion on list on the view that it was just
a legacy predating the runtime disable support for SELinux, which does
unregister selinuxfs too.  However, on second thought, this is likely
not a good idea (sorry Dan), as it could lead to application misbehavior
if a system is booted in permissive mode with missing or corrupted
policy, which might be necessary for recovery.  At that point, with no
policy loaded and thus no contexts defined, any calls to e.g.
setexeccon() will fail, which could break login, and applications that
try to preserve contexts on files could end up mislabeling them due to
the lack of defined contexts.

So I suppose we need to retain the getcon() test.  Or institute a more
direct test of whether policy is loaded, e.g. new selinuxfs node that is
accessible to all so that it can always be read to see whether policy
has been loaded.

> 
> >     free(line);
> >     fclose(fp);
> >     return enabled;
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
