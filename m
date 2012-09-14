Message-ID: <1347648545.11029.93.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [RFC] Add initial clipboard access control implementation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 14 Sep 2012 14:49:05 -0400
In-Reply-To: <5053727C.5000303@tresys.com>
References: <1347636256-4457-1-git-send-email-jbrindle@tresys.com>
	 <1347645105.11029.77.camel@moss-pluto.epoch.ncsc.mil>
	 <5053727C.5000303@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 14:07 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> <snip>
> > Likely of greater concern are the edge cases for Binder.getCallingPid()
> > and SELinux.getPidContext().
> >
> 
> Are there plans to upstream Binder.getContext()?

No, as per the Middleware MAC talk that we gave at LSS (slides available
from the wiki).

Anyway, I'd suggest adding some instrumentation to detect whether you
are encountering any of the interesting cases, e.g.
Binder.getCallingPid() equals Process.myPid() or SELinux.getPidContext()
returns NULL.  The former can happen for a service-internal binder call
or if the service explicitly clears the calling identity because it is
trying to do something that requires more privilege than the caller, and
the latter can happen if the caller has died.   In the former case, try
to get a traceback and see whether it is the correct behavior for that
situation.  
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
