Message-ID: <43D4F8DD.30705@tresys.com>
Date: Mon, 23 Jan 2006 10:40:13 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>	<1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>	<1137784500.31152.6.camel@twoface.columbia.tresys.com>	<1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>	<43D1553B.3090701@tresys.com>	<1138026975.20815.62.camel@moss-spartans.epoch.ncsc.mil>	<43D4ED7A.3090805@tresys.com> <1138030160.20815.97.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138030160.20815.97.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-01-23 at 09:51 -0500, Joshua Brindle wrote:
> 
>>yes, looking at setsebool it seems correct wrt is_managed. Which warning 
>>are you speaking of? In is_managed == 0 it uses 
>>selinux_set_boolean_list() and on success goes to out which destroys the 
>>handle and returns.
> 
> 
> I just mean the old libsemanage warning from the old
> is_managed()->create_store() code path, which is eliminated by your
> patch.  That is a good thing, not a problem.
> 
speaking of the create_store code path, That function is no longer in 
use and it was primarily used for bootstrapping non-managed systems so I 
didn't remove it yet but we can probably just require the package 
manager or make scripts to initialize the store and remove this from the 
library entirely.

> 
>>Hrm.. an interesting problem. How can we determine when the fallback 
>>should happen? It seems difficult to differenciate the 'not managed' and 
>>'no permission to see store' cases, which means setsebool can't know 
>>when to fallback and when not to. I'm not sure there is a solution to 
>>this problem except to encapsulate access to booleans through 
>>libsemanage clients, even in the targeted policy, which might not be 
>>acceptable.
> 
> 
> I suspect it isn't a real issue in practice, but if we thought it was
> truly crucial, we could introduce an explicit definition of is_managed
> rather than inferring it from active module store existence, whether via
> a definition in /etc/selinux/config or some other indicator (e.g. an
> enable/disable flag in semanage.conf analogous to the one for
> setrans.conf).
> 

I'd rather punt on that for now, in the case that it really matters 
(policy server) the store and boolean access will all be encapsulated 
and accessible only by the server.

Aside from the error string changes and the policy directory permission 
check removal does anything else need to be changed before resubmission? 
Should I go ahead and remove create_store?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
