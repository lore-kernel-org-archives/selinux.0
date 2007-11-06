Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6HwEj4010920
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 12:58:14 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA6HwChJ024673
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 17:58:13 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: RE: security context for SPD entries of labeled IPsec
Date: Tue, 6 Nov 2007 12:56:23 -0500
Message-ID: <D709A20F2164C84E8B7014B0301F5EF87C71E3@HAVOC.tcs-sec.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>, <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<SNIP>

> There are 2 aspects:
> 
> 1. IPsec policy matching discussed above:
>    allow domain-that-should-use-labeled-ipsec 
> ipsec_spd_t:association { polmatch };
> 
> 2. Use of IPsec associations themselves:
> 
>    For sending:
>    allow 
> domain-that-should-use-labeled-ipsec-to-label-its-packets 
> self:association { sendto };
> 
>    For receiving:
>    allow domain-that-should-received-from-peer  peer-domain 
> self:association { recvfrom };

If you ignore the typos in the above rule, it would be:
allow domain-that-should-receive-from-peer  peer-domain:association { recvfrom };

<snip>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
