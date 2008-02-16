Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G1h6nR030974
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:43:06 -0500
Received: from e33.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1G1h53r003980
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 01:43:05 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1G1h5eJ004097
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:43:05 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1G1h4PI186458
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:43:04 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1G1h4gh000450
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 18:43:04 -0700
Date: Fri, 15 Feb 2008 19:40:34 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200802160140.m1G1eY30025542@faith.austin.ibm.com>
To: mike.clarkson@baesystems.com
Subject: RE: Brindle example of labeled IPSec
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>I agree with everything that you've mentioned above, the only problem
>being that my brindle_client and brindle_server modules didn't call the
>ipsec_labeled interface. That's why I'm confused as to why it is
>working. It shouldn't be working.

It's been a while and I don't have the policy in front of me, 
so others may be better able to answer this...
The base reference policy (when using mls) contains this rule. It has a
rule, ipsec_labeled(domain). 


regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
