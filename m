Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MHlsDL028158
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 13:47:54 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MHlO3K003173
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 17:47:24 GMT
Message-ID: <451421C6.5050003@hp.com>
Date: Fri, 22 Sep 2006 13:47:50 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> OK, here's what we will do:
> 
> 1. We will have getpeercon() fail if there's no labeled-SA.

... or NetLabel :)  What do you propose we do if there is both a SA and
NetLabel label, bearing in mind that NetLabel may be a full context?

> 2. We will do a getdatacon() or something similar to retrieve the
>    secmark (as reconciled in the proposed reconciliation logic, of course).

Since the getdatacon *could* change from one packet to the next, I
wonder if it might make more sense to handle the "data context" as an
ancillary messags similar to IP_PASSSEC.

Also, didn't Karl have an objection to the proposed reconciliation logic?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
