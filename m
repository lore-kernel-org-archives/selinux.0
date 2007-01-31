Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0VGgFPh020764
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 11:42:15 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0VGhHc1010263
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 16:43:18 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l0VGhGXx012221
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 11:43:16 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0VGhGXx027227
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 11:43:16 -0500
Received: from [10.11.14.132] (vpn-14-132.rdu.redhat.com [10.11.14.132])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0VGhFV7005693
	for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2007 11:43:16 -0500
Message-ID: <45C0C722.4030604@mentalrootkit.com>
Date: Wed, 31 Jan 2007 11:43:14 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] add sepolgen
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch at [1] adds the sepolgen python library for policy generation 
and a new implementation of audit2allow based on this library. The 
library has facilities for:

* parsing audit messages
* parsing and representing policy (including refpolicy interfaces)
* manipulating / transforming policy (e.g., adding require statements)
* generating policy from access requests / audit messages (including 
calls to refpolicy interfaces)
* outputting policy as text
* compiling policy modules

All of the requested updates from the previous review have been made.

Notes for packaging:

* This adds a new dependency between policycoreutils and sepolgen
* The tool sepolgen-ifgen needs to be run to extract information from 
the reference policy headers for audit2allow to generate refpolicy. The 
rpm spec file at 
http://hg.et.redhat.com/selinux/madison?f=b26375c7641a;file=madison.spec 
shows how I did this.
* Audit2allow currently has a few regressions from the old version. This 
will be fixed soon.

[1] 
http://people.redhat.com/kmacmill/patches/selinux/sepolgen-initial-submission.patch.gz

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
