Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3E3e67C014544
	for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2005 23:40:06 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3E3aST4029437
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 03:36:28 GMT
Subject: Re: [ PATCH ] Cumulative patch - various fixes,
	untrusted_content_t, mozilla, gnome types
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1113445869.6139.52.camel@cobra.ivg2.net>
References: <1113445869.6139.52.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 23:42:33 -0400
Message-Id: <1113450153.10622.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok I see the first thing that's wrong with this patch...
ROLE_t can't access ROLE_untrusted_content_t.

ROLE_untrusted_content_t is marked both $1_file_type and customizable.
It seems to me that one of those things should imply access (at least
read, getattr, relabelto, relabelfrom) by the ROLE_t type, or is that
not the case? Which one? 

Also, is there a reason why certain types are declared in both
admin_macros and user_macros? I put this new type in both, following 
a pattern with the other types, but I don't see why this stuff can't
go into base_user_macros for a single copy. 

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
