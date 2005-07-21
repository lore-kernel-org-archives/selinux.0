Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LKsYgA000490
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 16:54:34 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LKntrg018729
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 20:49:55 GMT
Subject: RE: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 16:47:29 -0400
Message-Id: <1121978850.15334.2.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Like I said, I'm not opposed in principal just wondering whether the payoff will
> really come.

It might, once all the non-parsing code from checkpolicy finds 
itself over in libsepol where it belongs. I am now thinking of how
to implement an API for adding allow rules on the fly for more
dynamic policy customization. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
