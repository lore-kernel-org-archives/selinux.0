Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LNdigA001524
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 19:39:44 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LNZ0rg028121
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 23:35:04 GMT
Message-ID: <42E0310B.5070404@tresys.com>
Date: Thu, 21 Jul 2005 19:34:35 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [ libsepol 2/6] Ports
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>	<1121978850.15334.2.camel@celtics.boston.redhat.com>	<42E00E51.7050001@tresys.com>	<1121979985.15334.5.camel@celtics.boston.redhat.com>	<42E0105F.9030607@tresys.com> <1121981131.15334.13.camel@celtics.boston.redhat.com>
In-Reply-To: <1121981131.15334.13.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>I don't think thats such a great idea. Really alot of the meat of the 
>>define_* functions has already moved to declare_symbol. The stuff that 
>>is remaining is really parser specific such as handling where things can 
>>be declared, handling multiple declarations, etc. It serves no purpose 
>>to generalize this code as it really is about how to parse the policy 
>>and not how to build up these structures.
>>    
>>
>
>How can I add te_avtab rules to policy at the moment, without
>using checkpolicy?
>  
>
All the te_avtab code has been removed from checkpolicy for the modules. 
In fact, aside from checking type transition conflicts, checkpolicy 
doesn't add any rules at all to the avtab, this is done at expand time.

further, avtab_insert, avtab_search, etc have always been in libsepol, 
in avtab.c

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
