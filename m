Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l62EiLAU006819
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 10:44:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l62EiKgI026114
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 14:44:20 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l62EiKbN029902
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 10:44:20 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62EiJ4a008251
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 10:44:19 -0400
Received: from [10.11.14.241] (vpn-14-241.rdu.redhat.com [10.11.14.241])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l62EiJHI010494
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 10:44:19 -0400
Subject: Allowing apache to read custom types
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 10:44:18 -0400
Message-Id: <1183387458.16330.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had a coworker ask about how to allow apache to read a custom type for
a policy that he wrote. Essentially, the policy is not focused on web
pages so it is not really ideal for the types to be generated from the
apache templates. I couldn't find any interfaces to allow apache to read
external types (I understand that these would be "reverse" interfaces -
but it seems like the most convenient way).

Am I just missing the best approach here?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
