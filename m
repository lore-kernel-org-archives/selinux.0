Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hARMkERb025370
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 17:46:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hARMjcp5014893
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 22:45:38 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hARMjct0014890
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 22:45:38 GMT
Date: Thu, 27 Nov 2003 22:46:06 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Policy error of the day
Message-ID: <20031127224606.GB12418@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The policy build error for today is:

make: *** No rule to make target `file_contexts/program/redhat-config-users.fc', needed by `file_contexts/file_contexts'.  Stop.
dpkg: error processing selinux-policy-default (--configure):
 subprocess post-installation script returned error exit status 2
Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned an error code (1)

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
