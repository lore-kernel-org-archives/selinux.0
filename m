Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA13124
	for <selinux@tycho.nsa.gov>; Thu, 25 Jul 2002 23:45:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA00791
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:44:38 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id DAA00787
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 03:44:36 GMT
Date: Fri, 26 Jul 2002 13:45:14 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Attributes vs Macro
Message-ID: <20020726034514.GE27354@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Out of these, why would you choose one over the other?


1. macro

type mydomain1_t domain;
type mydomain2_t domain;

define(`xyz_domain',`
allow $1_t ...
...
')

xyz_domain(mydomain1_t)
xyz_domain(mydomain2_t)


2. attribute

type mydomain1_t domain, xyz;
type mydomain2_t domain, xyz;

allow xyz ...
...


Are there any perfomance considerations when
choosing one other the other?
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
