Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5ALNeTV027383
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 17:23:40 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5ALNdi4006665
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 21:23:39 GMT
Subject: rbacsep: home/tmp polyinstantiation
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 17:23:23 -0400
Message-Id: <1213133003.27496.50.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was working through collapsing the user home and temp directories when
I hit the polyinstantiation bits.  It looks like a role_member statement
may need to be added.  However, polyinstantiation is still a little
fuzzy to me, so I'm not sure.  Thoughts?

If so, that makes the list of code changes for rbacsep:
* role attributes
* role_transition on objects
* objects correctly inherit role
* role_change (similar to type_change)
* role_member (similar to type_member)
* genhomedircon updated for role

not specifically required but may be more useful in the future now that
we're using roles more:
* working role dominance

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
