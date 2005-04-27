Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3RDsPgA016759
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 09:54:25 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3RDsEES025369
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 13:54:14 GMT
Subject: /tmp
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Wed, 27 Apr 2005 09:54:03 -0400
Message-Id: <1114610043.21998.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What should be done about /tmp.
The types of things like:
/tmp/scrollkeeper-$USER
/tmp/hsperfdata_$USER
/tmp/orbit-$USER
/tmp/gconfd-$USER

- are not stored in the policy, and cannot be "restored" - I am trying
to introduce a new gconfd domain, and change the /tmp/gconfd folder to
ROLE_gconfd_tmp_t, but I have to chcon it manually - this seems like a
bad thing.

- are set according to the first user - for example, I click on HELP
in some random gnome app, and all of the sudden a scrollkeeper folder 
is created, and its type is set to the parent's tmp_domain(). Then the
next app can't access this folder if it doesn't have a matching context.

==================

It seems like all those folders should be created ahead of time (login
script? tmp could be on tmpfs), and their context set to the right thing
- but the right thing should be in the policy - should be able to use
restorecon on those files. Couldn't such tmp files be made to work
similarly to the home directories? Any suggestions?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
