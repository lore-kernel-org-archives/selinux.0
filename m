Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA7GUFCp029765
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 11:30:15 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA7GUCwW023753
	for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 16:30:13 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: RE: security context for SPD entries of labeled IPsec
Date: Wed, 7 Nov 2007 11:07:32 -0500
Message-ID: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: <cpebenito@tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>
> > There are 2 aspects:
> > 
> > 1. IPsec policy matching discussed above:
> >    allow domain-that-should-use-labeled-ipsec 
> ipsec_spd_t:association { polmatch };
> > 
> > 2. Use of IPsec associations themselves:
> > 
> >    For sending:
> >    allow 
> domain-that-should-use-labeled-ipsec-to-label-its-packets 
> self:association { sendto };
> > 
> >    For receiving:
> >    allow domain-that-should-received-from-peer  peer-domain 
> self:association { recvfrom };
> 
> When we consider the case unconfined_t process tries to 
> communicate with a postgresql_t
> process running on another host via labeled IPsec, the 
> following policy will be needed.
> 
> 1.  allow unconfined_t ipsec_spd_t : association { polmatch };

Also, allow postgresql_t ipsec_spd_t : association { polmatch };
since the incoming packet labeled postgresql_t should be checked
against IPsec policy (SPD) rule labeled with ipsec_spd_t.

> 2s. allow unconfined_t self : association { sendto };

OK.

> 2r. allow postgresql_t unconfined_t : association { recvfrom };

This should actually be:

allow unconfined_t postgresql_t : association { recvfrom };

since it would be the unconfined_t socket that would be receiving
a packet using the postgresql_t association.

> 
> Is it correct?
> 
<snip>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
