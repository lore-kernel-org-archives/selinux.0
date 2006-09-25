Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PEjNjM014665
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 10:45:23 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PEiJ2d015270
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:44:20 GMT
Message-ID: <36282A1733C57546BE392885C06185920157367F@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: RE: Labeled networking packets
Date: Mon, 25 Sep 2006 10:45:11 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The driving requirements for this work is to have the kernel enforce
security policy on transient packets, i.e. forwarded traffic, which has been
lacking since the original networking hooks were rejected. Secondly, the
forwarded traffic enters the system as labeled traffic, say labeled IPSEC,
and the label attached to this traffic (packet) should be enforced when it
leaves the system. Note, the packet leaving the system is no longer
encapsulated via IPSEC and is being transmitted to an single level host.

A simple statement of this would be a secret ipsec packet coming in on a
ranged interface (systemlow-systemhigh) is forwarded as a regular packet out
a single level secret interface. Note, if the packet was unclassified, the
forwarding would fail to go through the secret interface. This is the
desired behavior.

Also, this implementation is fielded today as part of solutions in real
use....

-Chad  

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
