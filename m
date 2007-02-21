Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LID1JS021118
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:13:01 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1LIEIpR010757
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 18:14:18 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l1LIEHJZ004591
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 13:14:17 -0500
Message-ID: <45DC8BF5.2020709@mentalrootkit.com>
Date: Wed, 21 Feb 2007 13:14:13 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [PATCH 0/2] sepolgen: update for the latest reference policy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patch series updates the sepolgen parser (refparser.py) to work 
with the latest reference policy. The first patch updates the parsing 
library (PLY) to a more recent version. The second patch updates the 
grammar and includes some general cleanups of the parser.

This highlights why I think that moving the interfaces and other 
reference policy language constructs into the language is a good idea. 
Tracking the reference policy is going to be time consuming and the 
current grammar is ambiguous in ways that are hard to fix. I also end up 
changing the parser to handle harmless "mistakes" in the reference 
policy (e.g., spurious semi-colons at the end of ifdefs). These would be 
caught by a compiler but are silently accepted by M4.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
