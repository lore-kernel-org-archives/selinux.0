Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PFsbwD017176
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 11:54:37 -0400
Received: from web36610.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8PFrZ2d029157
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:53:35 GMT
Message-ID: <20060925155421.74629.qmail@web36610.mail.mud.yahoo.com>
Date: Mon, 25 Sep 2006 08:54:21 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: RE: Labeled networking packets
To: Chad Hanson <chanson@TrustedCS.com>, Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <36282A1733C57546BE392885C06185920157367F@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Chad Hanson <chanson@TrustedCS.com> wrote:

> 
> The driving requirements for this work is to have
> the kernel enforce
> security policy on transient packets, i.e. forwarded
> traffic, which has been
> lacking since the original networking hooks were
> rejected. Secondly, the
> forwarded traffic enters the system as labeled
> traffic, say labeled IPSEC,
> and the label attached to this traffic (packet)
> should be enforced when it
> leaves the system. Note, the packet leaving the
> system is no longer
> encapsulated via IPSEC and is being transmitted to
> an single level host.
> 
> A simple statement of this would be a secret ipsec
> packet coming in on a
> ranged interface (systemlow-systemhigh) is forwarded
> as a regular packet out
> a single level secret interface. Note, if the packet
> was unclassified, the
> forwarding would fail to go through the secret
> interface. This is the
> desired behavior.
> 
> Also, this implementation is fielded today as part
> of solutions in real
> use....
> 
> -Chad  

Although no one is asking how it's been done
in the past, I'll toss the information into
the pot in the hope that it might be useful
in some way.

In the early days of CIPSO it became clear
that it was not sufficient to look at the
label passed in the IP header by CIPSO.
At the very least, something had to be done
about packets that arrived without CIPSO
data. There were also systems that would
crash (not Unix!) if they received packets
with IP options, so it had to be possible
to eschew labeling packets. You had to know
how to communicate with a particular host.
This became even clearer with the
introduction of CIPSO tag types and eventually
TSIX and SAMP.

Two technics were used to determine what
communication scheme to use when talking to
another system. Per-host identification
requires that each host be identified as
to what scheme should be used. Per-interface
defined how packets would go out on a
particular wire.

In either case, the scheme identifies what
is to be sent and what is to be expected
of any packet. If you're looking for an
unlabled packet, and you get CIPSO, it's
bad. If you're using a higher level protocol
and you get CIPSO you may just chuck the
CIPSO and use the higher level, or use
the CIPSO for range checking, based on what
you expect from that host/wire.

Of course, there's overhead to creating a
security communication specification for
each peer. Wildcards are necessary for
internet deployments.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
