Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TMpigA004884
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 18:51:47 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TMiphF010818
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 22:44:52 GMT
Subject: Re: [ libsemanage ] Key extract function
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1122670387.28860.43.camel@celtics.boston.redhat.com>
References: <1122658154.28860.19.camel@celtics.boston.redhat.com>
	 <1122665303.28860.30.camel@celtics.boston.redhat.com>
	 <1122670387.28860.43.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 18:48:24 -0400
Message-Id: <1122677304.14130.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Note that the port key will create problems - I might need to change 
> that, because the same key can match many different records, 
> which breaks the definition of a key, and causes chaos in 
> the libsemanage processing layer. I think for now leave it as is, 
> and we'll fix it later if necessary - I am not entirely 
> clear how libsemanage will work in order to select a proper key.

Actually because shadowing is not allowed, this will work exactly as it 
should. Multiple keys can match the same value, but that's 
not a problem - that's a feature.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
