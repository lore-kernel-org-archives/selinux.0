Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>, "Paul Moore" <paul.moore@hp.com>
Cc: "James Morris" <jmorris@namei.org>, <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>, <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 11:38:37 -0600
Message-ID: <001801c6fea5$baee0da0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588514A55@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > No. I am using the FILTER table to FILTER a packet.
> > 
> 
> Ok, I think I'm beginning to get it (I'm a bit slow lately 
> :\).. You are
> defining a condition where iptables will call into the security server

Correct.

> using the packet label (either secmark or external, how do 
> you decide?)

Both.

> and some abstract object

a filter point defined in the filter table

> to see if it should drop (or is it 
> reject? Can
> you choose?). 

Yes. You should be able to.

> 
> It is interesting, I'm a little dubious, iptables basically becomes an
> object manager and uses iptables rules to determine whether or not to
> call into the security server, which isn't inappropriate, per se. The
> iptables filter rules must be included as part of the policy or the
> expected filtering would occur, the same is true for secmark 
> though.

Yes.

> The
> difference is that secmark is labeling packets and if the 
> labels aren't
> in place a restrictive policy will drop them.

this will continue to hold true.

> With these 
> filter rules if
> they aren't in place the policy becomes less restrictive (right?)..

We could also be restrictive or leave it up to the policy entirely.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
