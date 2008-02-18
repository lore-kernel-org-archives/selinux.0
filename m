Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1IBdTSO013536
	for <selinux@tycho.nsa.gov>; Mon, 18 Feb 2008 06:39:29 -0500
Received: from web32205.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1IBdS9G011245
	for <selinux@tycho.nsa.gov>; Mon, 18 Feb 2008 11:39:28 GMT
Date: Mon, 18 Feb 2008 03:39:13 -0800 (PST)
From: Hal <hal_bg@yahoo.com>
Subject: xguest LDAP authentication
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <504340.31062.qm@web32205.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,
I have a selinux question concerning xguest and ldap user authentication. 
I want to achieve two goals:

1. All the users are authenticated by LDAP (I have several machines that share
the same users and same user home dirs on the common storage.) and I want to
convert most of the users to Selinux xguest users.

2. I want all the new users created in the LDAP to be assumed as xguest users
on all machines by default. 

How can this be done?
I am running Fedora 8. 

Regrards
Hal


      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
