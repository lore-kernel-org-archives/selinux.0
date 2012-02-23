Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1NMbo73016861
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 17:37:50 -0500
Received: from blv-av-01.boeing.com (blv-av-01.boeing.com [130.247.48.231])
	by slb-smtpout-01.ns.cs.boeing.com (8.14.4/8.14.4/8.14.4/SMTPOUT) with ESMTP id q1NMblLg027580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 14:37:48 -0800 (PST)
Received: from blv-av-01.boeing.com (localhost [127.0.0.1])
	by blv-av-01.boeing.com (8.14.4/8.14.4/DOWNSTREAM_RELAY) with ESMTP id q1NMbkk8013957
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 14:37:46 -0800 (PST)
Received: from XCH-SWHT-03.sw.nos.boeing.com (xch-swht-03.sw.nos.boeing.com [129.172.160.44])
	by blv-av-01.boeing.com (8.14.4/8.14.4/UPSTREAM_RELAY) with ESMTP id q1NMbjgL013940
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 14:37:45 -0800 (PST)
From: "Vu, Joseph" <joseph.vu@boeing.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Thu, 23 Feb 2012 14:37:44 -0800
Subject: Policy to Allowing another process to only read a UDP port
Message-ID: <7790C0F7745DEB4CB90F90914584AAB140D349D6E7@XCH-SW-03V.sw.nos.boeing.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I am trying to create a policy  with a port type. I want to control another process type allowing it to connect to a port and  read only.  No writing is allowed.

Does the port type has other control beside name_bind?

Joe Vu

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
