Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA03750
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 13:21:36 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA23012
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 18:21:29 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzband.ncsc.mil  with ESMTP id SAA23008
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 18:21:28 GMT
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA05749
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 10:20:24 -0800 (PST)
	mail_from (casey@sgi.com)
Received: from sgi.com (sgigate.sgi.com [198.29.75.75])
	by cthulhu.engr.sgi.com (SGI-8.9.3/8.9.3) with ESMTP id KAA25282
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2001 10:21:27 -0800 (PST)
Message-ID: <3A9558A6.DC8A5E30@sgi.com>
Date: Thu, 22 Feb 2001 10:21:26 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: questions...
References: <Pine.SOL.3.95.1010222090308.12837C-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Stephen Smalley wrote:

> At some point, we may experiment with extending
> the mandatory access control architecture to permit the mandatory
> access control policy to override discretionary access denials
> to provide a similar mechanism to the Linux capabilities.

I guess I'm a little slow today. How would having MAC access
superceding DAC access be anything like the capabilities scheme?

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
