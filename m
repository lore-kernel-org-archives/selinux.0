Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RBwfgA023195
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 07:58:41 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5RBvZMC025331
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 11:57:35 GMT
Subject: Re: Execmem boolean
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1119822163.4357.9.camel@localhost.localdomain>
References: <1119822163.4357.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 07:59:01 -0400
Message-Id: <1119873541.12716.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> P.S. Please remove the gift port from types/network.te,
> because otherwise the gift domain won't compile - this port is 
> restricted to gift.te.

Never mind this, it's a configuration problem - my gift.te is not
properly updating.  (although there's really no reason for that 
port to be in network.te).

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
