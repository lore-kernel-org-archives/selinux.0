Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HG8sHF023340
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 11:08:54 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HG8pPl014475
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 16:08:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k1HG7mb8024926
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 11:07:48 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k1HG7mbA024925
	for selinux@tycho.nsa.gov; Fri, 17 Feb 2006 11:07:48 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1HFhIK2022225
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 10:43:18 -0500
Received: from e36.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1HFfU1d022702
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 15:41:31 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1HFdqRU001471
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 10:39:52 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1HFbUXP252346
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 08:37:34 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k1HFdlT1023441
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 08:39:47 -0700
Subject: ipsec in reference policy
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, selinux-dev@tresys.com
Content-Type: text/plain
Date: Fri, 17 Feb 2006 09:32:22 -0600
Message-Id: <1140190343.3137.189.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to stress test ipsec and nethooks. setkey utility complains
about permissions when I try to install policy though. I noticed that
there is an ipsec.if in /usr/share/selinux/refpolicy/include. I noticed
an ipsec module in the source. However, none of my ipsec utilities or
config files appear to be labeled according to .fc so I am thinking
ipsec module itself has not been installed in base policy?? Since I
would like to stress test ipsec nethooks, I can somewhat test this
module and make any corrections. But first I would like to verify that
it has not been installed as base policy but future plan is to do so. If
I am misunderstanding it all, please correct me so I can proceed in
right direction.

Also, is there a way to see which modules are in base policy?
I saw the semodule -l, but it is for non-base modules...

Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
