Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1SFDDxI001736
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:13:13 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1SFD73D014675
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 15:13:07 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1SFD2nI019327
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:13:02 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SFD28U006022
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:13:02 -0500
Received: from [10.11.14.203] (vpn-14-203.rdu.redhat.com [10.11.14.203])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SFD2qp014282
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:13:02 -0500
Subject: Why does checkpolicy need libsepol-static
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 10:13:01 -0500
Message-Id: <1204211581.3206.71.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I noticed while working on open permissions that checkmodule actually is
being linked statically to libsepol.a.  Why?  This means that when
adding a new capability in libsepol we have to recompile checkpolicy.
Just wondering why we do it this way.

-Eric 'does not know the toolchain' Paris


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
