Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LAidgA024440
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 06:44:39 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LAdJBa025585
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 10:39:19 GMT
Received: from [192.168.1.102] (c-24-61-202-223.hsd1.ma.comcast.net [24.61.202.223])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j6LAe2Bv000695
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 06:40:03 -0400 (EDT)
Subject: Sepol related questions
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 21 Jul 2005 06:42:31 -0400
Message-Id: <1121942551.19675.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1) What purpose does user_datum_t->cache serve,
and how is it different from the list of authorized roles
(user_datum_t->roles.roles) I can't remember this field 
being there - is this something recently added as part of 
the modules patch. I ask because my user loading code does 
not set any bits in this cache, and neither does genusers... 
after which policydb_context_is_valid fails in this path:

if (!ebitmap_get_bit(&usrdatum->cache, c->role - 1))
	/* user may not be associated with role */
	return 0;

2) What is the proper fallback user
mls level and mls range on an mls-enabled system
when the user hasn't configured those parameters.

What is the proper fallback mls field,
in a context where it's missing, on an mls-enabled
system.

3) Is the context string as returned by 
context_struct_to_string (services.c) supposed
to be null terminated - and also is
the string passed to sepol_context_to_sid 
supposed to be null terminated. If so,
what purpose does the buffer size serve?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
