Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6O5DvgA015810
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 01:13:59 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6O58tgA016298
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2005 05:08:55 GMT
Date: Sun, 24 Jul 2005 01:08:02 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Chad Hanson <chanson@TrustedCS.com>
cc: "'Karl MacMillan '" <kmacmillan@tresys.com>,
   "''Daniel J Walsh' '" <dwalsh@redhat.com>,
   "'gyurdiev@redhat.com '" <gyurdiev@redhat.com>,
   "''Joshua Brindle' '" <jbrindle@tresys.com>,
   "'selinux@tycho.nsa.gov '" <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
In-Reply-To: <36282A1733C57546BE392885C06185920572EB@chaos.tcs.tcs-sec.com>
Message-ID: <Lynx.SEL.4.62.0507240105060.16350@thoron.boston.redhat.com>
References: <36282A1733C57546BE392885C06185920572EB@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Jul 2005, Chad Hanson wrote:

> A simple web server example for say label unclass and confidential  would
> want to make sure that those servers no matter which port they listen, only
> communicate to nodes or the same label across an interface of the same label
> as well.
>
> A client example of a web browser is the same. If you are unclass, the
> browser should only communicate to unclass nodes and interfaces.

This would be a job for IPsec implicit labeling.

> iptables is complimentary and essential to solutions as it does the needed
> filtering.

In this case, IPsec would do its own filtering.

- James
-- 
James Morris
<jmorris@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
