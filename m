Message-ID: <36282A1733C57546BE392885C061859201103C90@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley
	 <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito"
	 <cpebenito@tresys.com>,
        Russell Coker <rcoker@redhat.com>, SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: Problem with semodule mls policy
Date: Wed, 15 Mar 2006 13:53:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Some comments inline below...

> -----Original Message-----
> From: Joshua Brindle [mailto:jbrindle@tresys.com]
> Sent: Wednesday, March 15, 2006 12:01 PM
> To: Stephen Smalley
> Cc: Daniel J Walsh; Christopher J. PeBenito; Russell Coker; SE Linux
> Subject: Re: Problem with semodule mls policy
>  
> >> The entire module store (/etc/selinux/<type>/modules/*) should be 
> >> entirely inaccessible except by an semanage_t domain (and 
> >> policy server later) via type enforcement, so those shouldn't be
> >> a concern. The policy.20 shouldn't really contain any sensitive 
> >> information so I think the only necessary modification is to 
> >> label seusers differently, correct?
> > 

Other than any range_transitions or any other rule definitions that would
call MLS labels directly I would agree. 

/etc/selinux/mls/contexts/files(/*) should be at SystemHigh since it is
basically a database of the on-disk configuration. 

> > I wasn't sure whether the fact that e.g. netif eth0 is assigned
> > SystemHigh and netif eth1 is assigned SystemLow in interfaces.local
> > (which is then compiled into policy.20) might be considered sensitive.
> > If so, that would make the final policy.20 sensitive as well.
> > 
> 
> I can buy this, as well as nodecons having different levels. The strange 
> thing is that you don't know what the levels are exactly, you just know 
> their relationships to each other. ie: eth0 is s1 and eth1 is s5 so eth1 
> is higher sensitivity even though I don't know what that sensitivity 
> means. How big of an issue is this? Chad?
> 

This information should be at SystemHigh since we are talking about levels.
I think IP addresses could possibly thought of in the same way.... So both
netif/nodecon rules should be protected.

> writing down files of different levels from within libsemanage means any 
> libsemanage client must be mls trusted, which may or may not be an 
> issue, I'm not sure.
> 
> So, if this is an issue then both seusers and policy.20 need to be 
> labeled differently.. should this be done through libsemanage config or 
> some appconfig in the policy?
> 

seusers should be at SystemHigh as well since it MLS labels inside of it. If
on MLS the seusers was purely just a user mapping and the real user labels
were in the policy, this wouldn't be an issue.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
