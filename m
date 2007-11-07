Message-ID: <47323856.6050501@manicmethod.com>
Date: Wed, 07 Nov 2007 17:12:38 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [patch 2/2] Peersid capability support
References: <20071107205047.102519666@manicmethod.com>	 <20071107205333.697495852@manicmethod.com> <1194469634.3956.174.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1194469634.3956.174.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-11-07 at 15:50 -0500, Joshua Brindle wrote:
>   
>> plain text document attachment (peersid_cap.patch)
>> Peersid capability support, keys the peersid capability on the peer object class.
>>     
>
> I'm uneasy about this approach, as it is similar to what we originally
> tried for secmark - tying the compat_net setting to the presence of the
> packet class in the policy, except there we were doing it at policy load
> time.  As it turned out, we had policies that defined the packet class
> well before we had usable rule sets for them, and even if we had covered
> that angle, presence/absence of a class definition doesn't reflect
> policy writer intent (e.g. does he want legacy network controls or
> secmark irrespective of whether he is using a modern policy), so we went
> back to manual setting of compat_net.
>
>   

With the unknown perms support can we basically require that defining a 
class means using it? Unfortunately that means we have to defer adding 
newer classes until the support is put in for the older ones.

> What if the base.conf / policy.conf itself had an explicit declaration
> of the capabilities to be enabled?  We can certainly do sanity checks
> too (e.g. if they ask for this capability but haven't defined the
> requisite class, that's a bug in their policy), but that would let
> someone use the latest policy flask definitions but still select what
> they want to enable/disable explicitly, and no unwitting enabling of
> capabilities by side effect.
>
>   

I would also hate to add more base-only options as eventually I think 
we'd like to get rid of  (at least I would) the base altogether and get 
everything into modules, assuming we get the necessary infrastructure in 
place like kernel class discovery.

I'm not adverse to putting capabilities in the policy though, I just 
don't know if thats the only place where it is appropriate to put them.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
