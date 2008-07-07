Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m67IhDhg028228
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 14:43:13 -0400
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m67IhC8f013602
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 18:43:13 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67IjQsJ003908
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 14:45:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m67Igqun239000
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 14:42:52 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m67IgpEI032570
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2008 14:42:52 -0400
Date: Mon, 7 Jul 2008 13:42:52 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: ltp-list@lists.sourceforge.net, SELinux <selinux@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Andrew Morgan <morgan@kernel.org>,
        Stephen Smalley <sds@epoch.ncsc.mil>
Subject: running filecaps ltp test
Message-ID: <20080707184252.GC22937@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It looks like unconfined_t is not granted setfcap capability.  So
when running ltp as unconfined_t, the file capabilities test fails.
I'm just wondering what the right answer is:

	1. require running ltp as an administrative type
	2. give ltp a custom policy module to create an ltp_t
	3. give setfcap to unconfined_t

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
