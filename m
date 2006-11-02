MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 12:53:28 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588514A65@exchange.columbia.tresys.com>
In-Reply-To: <001801c6fea5$baee0da0$cc0a010a@tcssec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <vyekkirala@TrustedCS.com>, "Paul Moore" <paul.moore@hp.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Venkat Yekkirala [mailto:vyekkirala@trustedcs.com] 
> 
> > using the packet label (either secmark or external, how do you 
> > decide?)
> 
> Both.

It calls avc_has_perm for both labels? How will netlabel fit in? What do
you expect the performance hit to be with so many avc lookups?

> > to see if it should drop (or is it
> > reject? Can
> > you choose?). 
> 
> Yes. You should be able to.
> 

So you just pass an additional parameter to the selinux module? I assume
you aren't going to try to use TE policy to choose.

<snip>
> 
> > With these
> > filter rules if
> > they aren't in place the policy becomes less restrictive (right?)..
> 
> We could also be restrictive or leave it up to the policy entirely.
> 

So if there is no rule present it would always check against unlabeled
(or some initial SID)? Can you force the selinux module to be called
under all circumstances? 

This is starting to sound pretty reasonable. The filter rules really are
policy they just aren't TE policy, and they are also tightly bound to a
particular TE policy.

This is different from other object managers because their "policy" is
static, they always ask the question at some point in the codepath
wheras you want to implement a dynamic policy to query the security
server. I don't think there is anything wrong with it but the
ramifications need to be examined, synchronicity is probably going to be
the hardest thing to solve. 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
