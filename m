Subject: Re: setools, version 0.8
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20030411163225.GA1879@lukas>
References: <004901c2ff81$959a32d0$6600a8c0@columbia.tresys.com>
	 <200304111624.43830.russell@coker.com.au>
	 <20030411095457.3eefc135.vlaovic@libero.it>
	 <200304111922.23393.russell@coker.com.au>
	 <20030411135236.51ed6cff.vlaovic@libero.it>
	 <1050065686.3715.16.camel@moss-huskers.epoch.ncsc.mil>
	 <20030411163225.GA1879@lukas>
Content-Type: text/plain
Message-Id: <1050082150.1054.57.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Apr 2003 13:29:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-04-11 at 12:32, Andreas Schuldei wrote:
> i wanted to test selinux with the new 2.5. ipsec and ipv6. Do you
> have a timeframe for this?
> 
> i am aware that you are almost powerless about the rate at which
> your api is accepted, but do you have any expectations of any
> kind, for orientation? do you have a plan B if your /proc
> interface is not accepted?

I'm not sure what you are seeking to test, as the SELinux functionality
(mandatory access controls) is orthogonal to ipsec, except for possible
future integration for implicit packet labeling based on IPSEC SA and
policy-based negotiation.  There are known problems with using Selopt
labeled networking (CIPSO-based) with ipsec.  As for ipv6, the LSM patch
only provides hooks for ipv4, and those hooks were rejected for mainline
2.5.

Most of the SELinux network access control and labeling functionality
has been temporarily dropped from the mainline 2.5-based SELinux because
the existing implementation depended on the rejected networking security
fields and hooks.  We do plan on restoring aspects of the SELinux
network access control functionality in the future with the existing set
of hooks plus creative use of NetFilter, but that isn't likely to happen
until after the core SELinux functionality (i.e. mandatory access
controls for processes, files, System V IPC, and Unix domain socket IPC)
has been merged.

Sorry, I can't give a timeframe, as I don't know what to expect from the
kernel developer community.  With regard to the /proc/pid/attr
interface, it isn't a stumbling block if the objection is simply to
using proc (although that does seem to be a natural fit for a process
attribute API).  We could alternatively implement a pair of syscalls
(getprocattr and setprocattr, which happens to be the LSM hook interface
called by the proc filesystem code), or create a separate pseudo
filesystem type.  But we haven't actually received any objections yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
