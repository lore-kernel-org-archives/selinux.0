Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PFSZd6016097
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 11:28:35 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PFS2cl026036
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:28:03 GMT
Message-ID: <36282A1733C57546BE392885C0618592015736AE@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle
	 <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Mon, 25 Sep 2006 11:28:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
>     2) Domain (process) context transmission - essentially, making 
>        getpeercon work for non-local sockets. The important thing here 
>        is that this is separate and distinct from the label of the 
>        packet. getpeercon (which is not just a poorly named function - 
>        the semantic is intentional and useful) should return the full 
>        context of the process on the other end of the network 
>        connection.
> 

This is why we just introduced the getdatacon() notion. Regardless of
whether a packet arrived from a trusted or non-trusted host, we may have the
desire to utilize the label of the packet. An example of this would be a
trusted app, such as xinetd or a guard, which wants to use the label of the
traffic to launch a service or make a security decision.

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
