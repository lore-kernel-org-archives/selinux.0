Message-ID: <4757073B.70907@manicmethod.com>
Date: Wed, 05 Dec 2007 15:16:59 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [patch 0/2] policy capability support
References: <20071205184848.180973622@tresys.com>	 <200712051421.39624.paul.moore@hp.com>	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com> <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-12-05 at 14:30 -0500, Todd Miller wrote:
>> Paul Moore wrote:
>>> The discussion for this appears to have gone quiet (at least I
>>> haven't seen anything else on this list).  Where do things currently
>>> stand?
>> At this point I'd be OK with requiring equivalence and throwing an error
>> otherwise.  I do think that this will result in usability issues that we
>> will have to address once people start using the caps.  However, with
>> only
>> a single cap defined so far it is not really possible to know how these
>> will end up being used.
> 
> We could try to come up with a solution at least for allowing clean
> upgrades from F8 (w/o any caps) to F9 (likely w/ peer cap defined)
> without requiring manual user intervention for dealing with local
> modules.
> 

This was my exact objection to using an intersection or equivalence. IMO 
it is incompatible to require all modules to be the same and to also 
require upgrades to work without manual intervention.

Do you still think unioning is wrong?

> There are however plenty of other ways in which a policy upgrade can
> break at present.  
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
