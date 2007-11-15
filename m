Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFG5Nwl003115
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 11:05:23 -0500
Received: from palrel11.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAFG5Mff013421
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 16:05:23 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH] IPsec SPD default security context (Re: security context for SPD entries of labeled IPsec)
Date: Thu, 15 Nov 2007 11:05:11 -0500
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com> <473BB437.3070005@ak.jp.nec.com> <1195136813.13737.67.camel@gorn.columbia.tresys.com>
In-Reply-To: <1195136813.13737.67.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711151105.11514.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 15 November 2007 9:26:53 am Christopher J. PeBenito wrote:
> Perhaps.  Though I thought that dropping the sendto check was being
> considered, since it really doesn't gain anything.

Yes, Darrel and Venkat (both added to the CC line) proposed removing the IPsec 
sendto check and it sounds reasonable to me.  I believe this will be part of 
the upcoming flow control patches, if not we should probably make this change 
for 2.6.25 so we can trigger it with the new netpeer capability.

Regardless, the refpol will most likely need to continue to support the sendto 
check for some time to preserve proper behavior with older kernels.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
