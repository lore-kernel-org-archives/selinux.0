Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6LHtiwU022140
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 13:55:44 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6LHth7s006049
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2007 17:55:44 GMT
Date: Sat, 21 Jul 2007 13:55:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Anthony Liguori <anthony@codemonkey.ws>
cc: David Windsor <dwindsor@gmail.com>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        David Windsor <dwindsor@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
In-Reply-To: <46A22C37.5030004@codemonkey.ws>
Message-ID: <Line.LNX.4.64.0707211354410.5867@d.namei>
References: <C2C7258F.36C9%dwindsor@gmail.com> <46A22C37.5030004@codemonkey.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 21 Jul 2007, Anthony Liguori wrote:

> Can you already write an selinux policy that changes the label of a 
> process when it open()s a different file?

No, and you normally want to do this over an exec anyway, to ensure the 
new execution state is clean.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
