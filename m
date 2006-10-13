Subject: Re: context_sensitivity_{get|set}
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matt Anderson <mra@hp.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <452E955F.2050407@hp.com>
References: <452E955F.2050407@hp.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 10:04:07 -0400
Message-Id: <1160748247.14346.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-12 at 15:19 -0400, Matt Anderson wrote:
> For my latest CUPS patch I needed to include code that set the
> sensitivity of the spool file storing the to that of the client's
> context when they queued the job.  I used context_range_get() to
> retrieve the MLS range, but then had to use strtok() to get the lower bound.
> 
> Is context_sensitivity_get() or context_sensitivity_set() a function
> that other consumers might need?  Should it be included in libselinux?

Providing functions to get/set the low and high would make sense (and
newrole already has to do similar processing internally for newrole -l),
but I don't follow the function names above - do you want just the low
sensitivity (i.e. no categories) or the entire low level?  And you need
to indicate whether you are operating on the low or the high levels in
the interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
