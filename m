Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j21DwBDo001143
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 08:58:12 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j21DqHt4025851
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 13:52:18 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j21DsgtW016347
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 08:54:42 -0500 (EST)
Subject: Proposed policy feature: $1_domain attribute
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 01 Mar 2005 08:58:38 -0500
Message-Id: <1109685518.764.9.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd like to mark all role-dependent domains with a new attribute
$1_domain (analogous to $1_file_type), and then do the following in
base_user_macros.te:

can_ps($1, $1_domain)
can_ptrace($1, $1_domain)

Objections?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
