Subject: Re: libselinux does not compile on ia64
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: Janak Desai <jdesai@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <877jez41lm.fsf@glaurung.internal.golden-gryphon.com>
References: <877jez41lm.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 08:36:13 -0400
Message-Id: <1123504573.13654.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-08-06 at 08:49 -0500, Manoj Srivastava wrote:
> Hi,
> 
> 
> 	The latest libselinux fails to compile on IA64 with the
>  following error:
>  cc -Wall -I../include -D_GNU_SOURCE    setupns.c  -L../src -lselinux  -o setupn
>  setupns.c:17: error: syntax error before "clone"
>  setupns.c:22: warning: return type defaults to `int'
> 
>         Apparently, there is no clone on IA64.  There is an excerpt
>  from libc 2.3.2 that implements a clone look alike for IA64; however,
>  libc is LGPL'd , so the combination is no longer public domain.

At this point, I think setupns in libselinux is obsoleted by Janak's
patches for pam.  Right, Janak?  So we could just drop it altogether,
both utils/setupns.c (example utility) and src/setupns.c (libselinux
function).  There are no users of it yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
