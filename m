Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4K0OREp025591
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2008 20:24:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4K0OQV6003255
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2008 00:24:26 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4K0OQeT011647
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2008 20:24:26 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4K0OPcr022290
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2008 20:24:25 -0400
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m4K0OPRn011732
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2008 20:24:25 -0400
Message-ID: <48321A50.7080406@redhat.com>
Date: Mon, 19 May 2008 20:24:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Potential Memory leak in libselinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/show_bug.cgi?id=447410

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
