Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PIutrW023970
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:56:55 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PItlAk002533
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 18:55:50 GMT
Message-ID: <36282A1733C57546BE392885C061859201573731@chaos.tcs.tcs-sec.com>
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
Date: Mon, 25 Sep 2006 14:56:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Correct, I just wanted to state that we need to have an interface to get the
packet context, no matter if it is from a labeled network connection or just
an implicit context from secmark labeling. If getpeercon() can do this,
there is no need for getdatacon().

-Chad

> 
> But your example is precisely how getpeercon() is used, so the
> distinction between getdatacon() and getpeercon() seems artificial to
> me.  The real problem is figuring out how to reconcile secmark with
> labeled networking, not getpeercon vs. getdatacon.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
