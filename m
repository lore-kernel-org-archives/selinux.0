Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j24AJDDo022505
	for <selinux@tycho.nsa.gov>; Fri, 4 Mar 2005 05:19:13 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j24ACndV005806
	for <selinux@tycho.nsa.gov>; Fri, 4 Mar 2005 10:12:49 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j24AFGcg029676
	for <selinux@tycho.nsa.gov>; Fri, 4 Mar 2005 05:15:16 -0500 (EST)
Subject: Question - dac_override/dac_read_search
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 04 Mar 2005 05:19:07 -0500
Message-Id: <1109931547.5232.1.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've seen these before, and here they are again.
What causes those denials, and how can I fix them in general?

This specific case is running depmod -a as root.

audit(1109930761.807:0): avc:  denied  { dac_override } for  pid=4678
exe=/sbin/depmod capability=1 scontext=root:sysadm_r:depmod_t
tcontext=root:sysadm_r:depmod_t tclass=capability

audit(1109930761.807:0): avc:  denied  { dac_read_search } for  pid=4678
exe=/sbin/depmod capability=2 scontext=root:sysadm_r:depmod_t
tcontext=root:sysadm_r:depmod_t tclass=capability

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
