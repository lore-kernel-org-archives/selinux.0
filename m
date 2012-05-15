Message-ID: <4FB25904.5020401@tresys.com>
Date: Tue, 15 May 2012 09:24:20 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List
	<selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
References: <4FA95098.1050201@tresys.com> <1337015850.28157.43.camel@moss-pluto> <12617452.LZMSpbtozB@sifl>
In-Reply-To: <12617452.LZMSpbtozB@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/14/12 17:15, Paul Moore wrote:
> On Monday, May 14, 2012 01:17:30 PM Stephen Smalley wrote:
>> Didn't the old behavior lead to the undesirable result that refpolicy
>> allows every domain (or at least every domain that does networking) to
>> send/recv unlabeled packets, such that you cannot effectively employ
>> SECMARK unless you first modify and rebuild your entire policy to take
>> away the unlabeled packet access?  Whereas with the new behavior one
>> could drop those rules and then when someone does enable SECMARK, they
>> get to fully define the allowable network traffic?
> 
> Yep.

Not any worse than with the old networking checks.  Refpolicy has netif_t and node_t access for every networking domain too.  If you fully define your SECMARK rules, then there wouldn't be any unlabeled_t packets.  Similarly, if you fully described everything with netifcons and nodecons, you wouldn't get checks on netif_t and node_t.  My argument is for the people that care about this and would likely be modifying their policy to strip out the unlabeled packet access anyway.
  
>> I'm not adverse to making it optional/configurable, but I think a policy
>> capability is how you should do it.  That is what they are for, and they
>> are supposed to provide a more explicit mechanism than either the
>> handle_unknown logic or the old compat_net logic ...
> 
> *If* we decide to go this route, I agree, policy capabilities seem to be the 
> best fit.
> 
> However, as I said earlier in my emails to Chris, I'm still not certain this 
> actually accomplishes anything useful.

I don't understand how you can say this doesn't accomplish anything useful.  You don't want an *option* for changing the behavior of an enabled mechanism (SECMARK), and then in another email you're suggesting adding an additional mechanism (labeled ipsec/netlabel), which would otherwise be unused (assuming you're turning it on just to handle the situations I'm mentioning).

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
