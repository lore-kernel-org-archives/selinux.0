Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MCkJRa016389
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 08:46:20 -0400
Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 08:47:31 -0400
Message-Id: <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 22:04 -0400, Joshua Brindle wrote:
> > -----Original Message-----
> > From: Venkat Yekkirala [mailto:vyekkirala@TrustedCS.com] 
> <snip>
> > > I agree that it doesn't matter whether the packet was 
> > labeled on the 
> > > current or sending machine - but it still says nothing about the 
> > > context of the originating process.
> > 
> > It does when you use labeled-ipsec and when you convey BOTH 
> > the packet Type and the process Type to the app in a single 
> > sid. And we could change the name of getpeercon() to be more 
> > meaningful/accurate to, say getdatacon(), if need be.
> > 
> 
> I agree with Karl here. To say the least taking one kind of object
> (association) and and another kind of object (packet) and using those
> contexts to calculate a context for another kind of object (domain? Or
> maybe something else?) seems fairly hacky to say the least.

Yes, that would be like computing a process label from an old process
label and an executable file label.  Or like computing a new file label
from a process label and a parent directory label.  Who could imagine
such a thing?  ;)

Seriously, there isn't anything wrong with the notion of using label
transitions to capture state from multiple labels, and we do that all
the time for _object_ labels.  Where we run into a problem here is the
fact that the user of getpeercon() wants a subject label, not an object
label.  If the label transition function had an inverse, that might be
workable, although I'd hate to require applications to deal with it, but
it doesn't have an inverse (in general; specific policy may permit such
inversion, but the function itself provides no such guarantee).

> And it also isn't what I (personally) want. I want the domain on the
> other end, I don't want to have to have some incredibly complex setup of
> associations and secmarks just to get recalculate the context we already
> had on the other end, I just want it. That is what getpeercon() should
> return. I don't care either way about getdatacon() but getpeercon should
> stick around and should get the peer domain.

Yes, we don't want to change the getpeercon() interface, and we want
consistent semantics between AF_LOCAL and AF_INET.

> That said, I'm thinking that this scheme should be scrapped and instead
> we do something like the following: secmark is totally non-relavent to
> the peer context, it labels packets and I don't believe there is ever a
> need to know the label of a packet (if there is we can add
> getpacketcon()). Secmark will be used for enforcement of network flow
> only.

That may be the right approach given the divergent purposes of secmark
vs. labeled networking, but it doesn't resolve what motivated the secid
reconciliation work in the first place.

>  The security association can have a context, that context will be
> used for enforcement of polmatch, just like now. The label won't be used
> for getpeercon(), only to create associations and give access to them.
> Then the actual domain making the connection can be sent to the remote
> side by racoon, this should be the label that getpeercon() returns.

If you just mean that the SA context would come from the flow's context
rather than the SPD rule, then I think we all agreed to that.  But the
context is still ultimately stored in the SA and obtained from it by
getpeercon().  That doesn't change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
