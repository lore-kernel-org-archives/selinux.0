Subject: Re: Problem with semodule mls policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <rcoker@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <441842C2.8070706@tresys.com>
References: <44182410.1030003@redhat.com>
	 <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>
	 <44183A48.7010005@tresys.com>
	 <1142440539.4933.6.camel@moss-spartans.epoch.ncsc.mil>
	 <441842C2.8070706@tresys.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 11:58:06 -0500
Message-Id: <1142441886.4933.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-15 at 11:37 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > Possibly local customizations are in view here, e.g. the contents of
> > interfaces.local, that are then fed into the final policy.20 emitted by
> > libsemanage?  seusers is the more likely concern, as you note, and it is
> > harder to transparently label it separately since it doesn't live in its
> > own dedicated subdirectory (so range_transition wouldn't help with it;
> > you'd need libsemanage code modification).
> >  
> The entire module store (/etc/selinux/<type>/modules/*) should be 
> entirely inaccessible except by an semanage_t domain (and policy server 
> later) via type enforcement, so those shouldn't be a concern. The 
> policy.20 shouldn't really contain any sensitive information so I think 
> the only necessary modification is to label seusers differently, correct?

I wasn't sure whether the fact that e.g. netif eth0 is assigned
SystemHigh and netif eth1 is assigned SystemLow in interfaces.local
(which is then compiled into policy.20) might be considered sensitive.
If so, that would make the final policy.20 sensitive as well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
