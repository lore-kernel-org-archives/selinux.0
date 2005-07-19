Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JFTDgA007286
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 11:29:13 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JFDaZb011831
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 15:13:37 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6JFE8Ad004738
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 11:14:08 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6JFE8V24851
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 11:14:08 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6JFE7ll013257
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 11:14:07 -0400
Subject: Adding more NSCD constants
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 19 Jul 2005 11:11:49 -0400
Message-Id: <1121785909.22954.2.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How hard is it to add more constants to av_permissions.h?
This file says "automatically generated" but I'm not sure
what it's generated from.

If we add another NSCD cache (which is the plan... for the 
selinux_users nss service), then we need more constants for
NSCD.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
