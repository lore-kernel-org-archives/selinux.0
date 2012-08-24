Message-ID: <1345809625.18849.9.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: sepol help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Date: Fri, 24 Aug 2012 08:00:25 -0400
In-Reply-To: <CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
References: 
	<CAFftDdrcyjQ53iEjQBK=tHROVR5fZVEPvC8wRxTT9ddx2j6FVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-23 at 19:01 -0700, William Roberts wrote:
> I am working on a tool for parsing, and allowing overrides to occur in
> seapp_contexts. I also want it to check the output selectors against
> the compiled binary. After looking at sepol, it wasn't quite clear to
> me how to get going with it. Can anyone give me function calls to do
> something like this?
> 
> 1. Load the compiled binary
> 2. Check to see if a boolean exists

When possible, try to use the shared library interfaces and exported
data structures (look for sepol_ prefixes) rather than the private ones.
For that reason, checkpolicy isn't a good example to use.

libsemanage uses only the shared library APIs.
libselinux/src/load_policy.c (in upstream selinux) uses only the shared
library APIs.
policycoreutils/setfiles/setfiles.c uses only the shared library APIs.

If that doesn't quite get you there, you can look at
libselinux/src/audit2why.c, which although it does use the static lib,
it at least tries to use the sepol_ data types and interfaces wherever
possible.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
