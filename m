Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8M24vji032753
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 22:04:57 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8M23vFq011996
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 02:03:58 GMT
Subject: RE: Labeled networking packets
Date: Thu, 21 Sep 2006 22:04:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573443@chaos.tcs.tcs-sec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>, "Paul Moore" <paul.moore@hp.com>,
        <latten@austin.ibm.com>, <jmorris@redhat.com>, <dwalsh@redhat.com>,
        "Darrel Goeddel" <DGoeddel@TrustedCS.com>,
        "Chad Hanson" <chanson@TrustedCS.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
<snip>
> > I agree that it doesn't matter whether the packet was 
> labeled on the 
> > current or sending machine - but it still says nothing about the 
> > context of the originating process.
> 
> It does when you use labeled-ipsec and when you convey BOTH 
> the packet Type and the process Type to the app in a single 
> sid. And we could change the name of getpeercon() to be more 
> meaningful/accurate to, say getdatacon(), if need be.
> 

I agree with Karl here. To say the least taking one kind of object
(association) and and another kind of object (packet) and using those
contexts to calculate a context for another kind of object (domain? Or
maybe something else?) seems fairly hacky to say the least.

And it also isn't what I (personally) want. I want the domain on the
other end, I don't want to have to have some incredibly complex setup of
associations and secmarks just to get recalculate the context we already
had on the other end, I just want it. That is what getpeercon() should
return. I don't care either way about getdatacon() but getpeercon should
stick around and should get the peer domain.

This is of interest to me for the policy management server. We need the
full context of the client in order to do access control checks on the
policy updates. That means the context I get from getpeercon() will be
the source of access checks. Source should always (in this context
anyway) be a domain. This transition scheme gives me some kind of object
type and I'm not sure it's a domain (or if its anything), just because I
can create crazy labeling to give the same context doesn't mean it's a
domain.

And this doesn't even begin to address what a mess managing all this
labeling is going to be. We haven't even decided how to handle secmark
rules in distros yet and now we are going to need a whole new set of
labels (that also have to interact with local non-selinux
configurations)

That said, I'm thinking that this scheme should be scrapped and instead
we do something like the following: secmark is totally non-relavent to
the peer context, it labels packets and I don't believe there is ever a
need to know the label of a packet (if there is we can add
getpacketcon()). Secmark will be used for enforcement of network flow
only. The security association can have a context, that context will be
used for enforcement of polmatch, just like now. The label won't be used
for getpeercon(), only to create associations and give access to them.
Then the actual domain making the connection can be sent to the remote
side by racoon, this should be the label that getpeercon() returns. Note
that racoon can send the domain context (default) or if necessary do
some sort of translation (eg., system_u:object_r:sysadm_t:s0 ->
system_u:object_r:sysadm_t) or similar, it will be up to the local
configuration to decide how that works though.

This is, IMO, a much cleaner, simpler and more pure implementation that
doesn't try mixing different kinds of objects, each object fits in its
own place and when we call getpeercon() we know we'll be getting a
domain that we can use in rule lookups or setexeccon(). 

If there is no ipsec then getpeercon() returns an error, as it should,
to let the application asking know that the peer context isn't available
(the reconciliation with unlabaled->secmark->somethingelse could be very
dangerous since the application can't know if it can really trust the
label)

Comments? I'm starting to look at Joy's racoon patch to see what we can
do there but I think this is the correct way to handle this problem.


Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
