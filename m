Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j67GktgA012929
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 12:46:55 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j67Gif3a024241
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 16:44:41 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j67Gigbg002312
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 12:44:42 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j67GifV08025
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 12:44:41 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j67Gifcs015484
	for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2005 12:44:41 -0400
Subject: Should usermod restorecon HOME_DIR on role change
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 07 Jul 2005 12:42:00 -0400
Message-Id: <1120754520.30014.3.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When usermod changes the uid (-u),
it changes the uid of all files rooted under the home 
directory, but does not change it for files elsewhere. 

Should it also operate the same way
when changing the selinux user/class?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
