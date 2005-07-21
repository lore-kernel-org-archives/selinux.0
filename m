Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LLWZgA000904
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:32:35 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LLR9Ba021976
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 21:27:10 GMT
Subject: Re: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E0105F.9030607@tresys.com>
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>
	 <1121978850.15334.2.camel@celtics.boston.redhat.com>
	 <42E00E51.7050001@tresys.com>
	 <1121979985.15334.5.camel@celtics.boston.redhat.com>
	 <42E0105F.9030607@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 17:25:31 -0400
Message-Id: <1121981131.15334.13.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I don't think thats such a great idea. Really alot of the meat of the 
> define_* functions has already moved to declare_symbol. The stuff that 
> is remaining is really parser specific such as handling where things can 
> be declared, handling multiple declarations, etc. It serves no purpose 
> to generalize this code as it really is about how to parse the policy 
> and not how to build up these structures.

How can I add te_avtab rules to policy at the moment, without
using checkpolicy?






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
