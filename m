Subject: RE: Labeled networking packets
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015736AE@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015736AE@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 12:41:44 -0400
Message-Id: <1159202504.4367.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 11:28 -0400, Chad Hanson wrote: 
> > 
> >     2) Domain (process) context transmission - essentially, making 
> >        getpeercon work for non-local sockets. The important thing here 
> >        is that this is separate and distinct from the label of the 
> >        packet. getpeercon (which is not just a poorly named function - 
> >        the semantic is intentional and useful) should return the full 
> >        context of the process on the other end of the network 
> >        connection.
> > 
> 
> This is why we just introduced the getdatacon() notion. Regardless of
> whether a packet arrived from a trusted or non-trusted host, we may have the
> desire to utilize the label of the packet. An example of this would be a
> trusted app, such as xinetd or a guard, which wants to use the label of the
> traffic to launch a service or make a security decision.
> 

I think that getting the label of packets is a good idea, but this is
separate from getpeercon. Venkat suggested in the past that getpeercon
should be replaced by getdatacon - "And we could change the name of
getpeercon() to be more meaningful/accurate to, say getdatacon(), if
need be."

Is the suggestion now for parallel interfaces not replacing getpeercon?

Also, how would this work for non-connection oriented protocols? I
haven't seen a proposed syntax, but a getpeercon style interface would
not seem to work for udp, etc., correct?

Karl

> -Chad
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
