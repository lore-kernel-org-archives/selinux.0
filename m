Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QK1Y6W028195
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 16:01:34 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QK10i9017394
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 20:01:01 GMT
Date: Tue, 26 Sep 2006 16:01:30 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: sds@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
In-Reply-To: <36282A1733C57546BE392885C061859201573856@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0609261554390.3978@d.namei>
References: <36282A1733C57546BE392885C061859201573856@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Sep 2006, Venkat Yekkirala wrote:

> In the example above, you would have "fine-grained security points"
> as given below:
> 
> All new connections INTO port 80: http_client_t default domain, with
> additional explicit "domains" fire_fox_t, rss_aggregator_t, etc.
> 
> allow httpd_t http_client_t:peer { sendto recvfrom }
> allow httpd_t fire_fox_t:peer { sendto recvfrom }
> ...
> 
> Now, a compromised httpd_t isn't able initiate OUTGOING connections
> to port 80 (other than to itself for graceful shutdown in conjunction
> with additional policy).
> 
> For connections to postgres:
> 
> All new OUTGOING connections from port 80 to postgres-port: postgres_t
> default
> 
> allow httpd_t postgres_t:peer { sendto recvfrom }

What do the iptables rules look like for this?

> > 3) A single packet may have different types on the output side and the
> > input side.
> 
> This is very non-intuitive, as opposed to defining security check points
> with just the "domains" that can be received from and sent to.

What do the policy and labeling rules look like in this case for secpoint?

> >  But you
> > also lose the stateful benefits of secmark here,
> 
> Nope, you still are leveraging the stateful benefits of iptables.

Ditto.


> Votes? :)

It may seem more intuitive to people combining external and internal 
labeling, but I'm concerned that the common case (internal labeling only) 
will be less understandable.  A security point is an abstraction -- a 
labeled packet is more concrete in that it is an actual kernel object with 
a label on it, which can be manipulated based upon the label.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
