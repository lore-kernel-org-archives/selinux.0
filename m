Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1KEindW013775
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 09:44:49 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1KEeWli019950
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 14:40:32 GMT
Subject: Java Legacy problem
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Sun, 20 Feb 2005 09:45:13 -0500
Message-Id: <1108910713.3610.18.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 

As previously discussed on this list, Java does not work properly. 
It's a legacy domain that produces all kinds of execmod/execute denials.
Stephen Smalley suggested that it be placed in its own domain.

Daniel Walsh's Java policy, however, only works for the Mozilla plugin.
I think the argument was that a Java policy would have to permit most
things in the user domain.

So, what is the recommended strategy for dealing with Java, so
that those denials will go away?

user_t (java):
denied { execute } ld_so_cache_t:file (/etc/ld.so.cache) 
denied { execute } locale_t:file      (/usr/lib/locale/locale-archive)
denied { execmod } shlib_t:file       (/lib/libc-2.3.4.so)
denied { execmod } ld_so_t:file       (/lib/ld-2.3.4.so)


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
