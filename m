Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3AB9O69016089
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 07:09:24 -0400
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3AB9NYN014009
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 11:09:24 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	by ladon.golden-gryphon.com (8.13.8/8.13.8/Debian-3) with ESMTP id m3A9aG2R023120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 04:36:18 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.2/8.14.2/Debian-3) with ESMTP id m3A9VpR1022546
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 04:31:52 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] setools 3.3.4: Fix build failure with gcc-4.3.X
Date: Thu, 10 Apr 2008 04:31:51 -0500
Message-ID: <87d4oyqcmw.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

