Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96LYYTG010406
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 17:34:34 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96LXKQW006193
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 21:33:20 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFD1F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
        "'selinux@tycho.nsa.gov'"
	 <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Fri, 6 Oct 2006 17:34:06 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Venkat Yekkirala wrote:
> > Venkat Yekkirala wrote:
> > 
> >>Joshua Brindle wrote:
<snip>
> Just so it's clear in my mind, you're planning to set skb->secmark to
> SECSID_NULL/0 *after* the last access check in 
> selinux_ip_postroute_last()?

Yes, sir. Patch forthcoming in a few minutes.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
