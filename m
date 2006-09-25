Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015736AE@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015736AE@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 14:00:12 -0400
Message-Id: <1159207212.15305.54.camel@moss-spartans.epoch.ncsc.mil>
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

But your example is precisely how getpeercon() is used, so the
distinction between getdatacon() and getpeercon() seems artificial to
me.  The real problem is figuring out how to reconcile secmark with
labeled networking, not getpeercon vs. getdatacon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
