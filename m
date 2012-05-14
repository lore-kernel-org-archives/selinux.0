Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4EGg648018165
	for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 12:42:06 -0400
From: Chad Hanson <chanson@TrustedCS.com>
To: Paul Moore <paul@paul-moore.com>,
        "Christopher J. PeBenito"
	<cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: RE: RFC: packet checks always on option
Date: Mon, 14 May 2012 16:42:06 +0000
Message-ID: <C42CE43E0E13AB44A299B62E255003740CC39B@TCSEXCH1.tcs-sec.com>
References: <4FA95098.1050201@tresys.com> <1540303.QUZeuyPSRI@sifl>
 <4FB1000D.4040403@tresys.com> <2254819.3TiCjlmuru@sifl>
In-Reply-To: <2254819.3TiCjlmuru@sifl>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > >> * during boot and shutdown you can guarantee no network access
> > > 
> > > You can do this through a variety of other mechanisms that have 
> > > nothing to do with secmark labels.
> > 
> > No, you can't.
> 
> Yes, you can. See "netif:{ ingress egress }".
> 

This assumes you have netlabel rules enabled. I would like to see the configuration option noted as a possibility in netlbl_enabled() to be 1 without a kernel patch. This then would assure that there are always netif checks are active in the absence of secmark rules is this is desired.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
