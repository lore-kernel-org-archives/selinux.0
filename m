Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA29458
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 15:05:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA02036
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 20:05:28 GMT
Received: from dante.imagelinks.com (dante.imagelinks.com [208.24.120.33])
	by jazzband.ncsc.mil  with ESMTP id UAA02032
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 20:05:27 GMT
Received: from [208.24.120.15] (powerbook.imagelinks.com [208.24.120.15])
	by dante.imagelinks.com (8.9.3/8.9.3) with ESMTP id PAA13217
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 15:05:17 -0500
Mime-Version: 1.0
Message-Id: <p04320404b6d82173b391@[208.24.120.15]>
Date: Fri, 16 Mar 2001 15:04:04 -0500
To: selinux@tycho.nsa.gov
From: Mark Lucas <mlucas@imagelinks.com>
Subject: seLinux and ReiserFS
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Is anyone looking into seLinux implementations working with the 
Reiser File System?  I understand that the current implementation 
supports ext2 only, is that correct?

We are currently using a RAIDZONE for storage and as a master node 
for a BeoWulf cluster.  It uses a modified Redhat distro with the 
Reiser journaling file system.

Thanks in advance,

Mark
-- 
**********************
Mark R Lucas
Chief Technical Officer
ImageLinks Inc.
4450 W Eau Gallie Blvd
Suite 164
Melbourne Fl 32934

321 253 0011 (work)
321 253 5559 (fax)

mlucas@imagelinks.com
**********************

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
