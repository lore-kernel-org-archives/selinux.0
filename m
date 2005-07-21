Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LILPgA028707
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:21:25 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIGlrg000918
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:16:48 GMT
Subject: Re: [ libsepol 0/6] Context reorganization
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFE4CA.1070707@tresys.com>
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
	 <42DFE2A7.9020200@tresys.com>
	 <1121969017.9844.50.camel@celtics.boston.redhat.com>
	 <42DFE4CA.1070707@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 14:14:23 -0400
Message-Id: <1121969663.9844.63.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> well, that is because the cache bitmap is empty. I'm not sure exactly 
> what the order you do things in but you'll need to either call 
> policydb_index_others after you've loaded all the users 

I specifically don't want to do that - that's why I use realloc
and index users one by one... 

Notice how the new API deals with single users, and
does not provide a way to load many users at once. 
It's supposed to be used as part of an iterator
in libsemanage, and I don't want to loop over
the entire set of users every time I modify a single
one. 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
