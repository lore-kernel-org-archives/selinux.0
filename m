Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PLrWlE029322
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 17:53:32 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PLqvaU017262
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 21:52:59 GMT
Message-ID: <36282A1733C57546BE392885C0618592015737C5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Chad Hanson
	 <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore
	 <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Mon, 25 Sep 2006 17:53:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > I thin the only real choices are:
> > 1) Add a separate field to the sk_buff for use by labeled 
> networking so
> > that we don't have to overload secmark in this manner, or
> 
> This won't fly upstream.

Do you think the life-cycle management associated with a security
pointer will unacceptable even when we do it ONLY in the
SECURITY_NETWORK case?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
