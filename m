Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PK2vEr026427
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 16:02:57 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PK1rAk014824
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 20:01:55 GMT
Message-ID: <36282A1733C57546BE392885C061859201573762@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle
	 <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Mon, 25 Sep 2006 16:02:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


In the absence of any other labeling, I would the secmark label would be
equivalent to the old selinux network labels. If I have guard that sits
between two unlabeled networks, I still want to be able to get the label of
a packet. Since these networks are unlabeled and thus don't speak IPSEC or
CIPSO, why wouldn't I use the MLS label that is in the secmark, as it is the
best information I have for the label of the data.

-Chad

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> 
> The problem is that the secmark labeling is generally not suitable as a
> subject label or as a data origin label, so you can't use it in the way
> you described.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
