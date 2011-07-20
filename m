Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6KJmNXF013012
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 15:48:23 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6KJmMi2018225
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 19:48:23 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6KJmM4x023682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2011 15:48:22 -0400
Message-ID: <4E273105.9020707@redhat.com>
Date: Wed, 20 Jul 2011 15:48:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 08/93] restorecond: Ignore IN_IGNORED inotify events
Content-Type: multipart/mixed;
 boundary="------------020101090609030903080802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020101090609030903080802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


This patch looks good to me. acked.


I Believe we need to re-add because the inode changes?

--------------020101090609030903080802
Content-Type: text/plain;
 name="0008-restorecond-Ignore-IN_IGNORED-inotify-events.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0008-restorecond-Ignore-IN_IGNORED-inotify-events.patch"


--------------020101090609030903080802--
