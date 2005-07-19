Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JIbBgA009165
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 14:37:11 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JIWr3G015224
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 18:32:53 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF2872@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: RE: init running at s9 by default on a MLS system?
Date: Tue, 19 Jul 2005 14:34:52 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> >
> How do you specify in policy that kernel_t transitions to 
> init_t but at 
> level s0?
> 

Like as follows:

# run init_t at OS_LO-OS_HI
range_transition kernel_t init_exec_t s0 - s9:c0.c127;

-Chad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
