Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6QLXhEd016556
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2013 17:33:44 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6QLXTcN005382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2013 17:33:30 -0400
Received: from redsox.boston.devel.redhat.com (redsox.boston.devel.redhat.com [10.19.60.53])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r6QLXTSP012544
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2013 17:33:29 -0400
Message-ID: <51F2EB28.10501@redhat.com>
Date: Fri, 26 Jul 2013 17:33:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: This patch stops semanage from removing user records that are still
 in use.
Content-Type: multipart/mixed;
 boundary="------------070404040002070300070404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070404040002070300070404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------070404040002070300070404
Content-Type: text/x-patch;
 name="0045-Patch-stops-semanage-from-removing-user-record-while.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0045-Patch-stops-semanage-from-removing-user-record-while.pa";
 filename*1="tch"


--------------070404040002070300070404--
