Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LEgKDa015156
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:42:24 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4LEgKxd006094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:42:20 -0400
Received: from localhost.localdomain (ovpn-200-30.brq.redhat.com
 [10.40.200.30])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t4LEgIrY020272
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 10:42:19 -0400
Message-ID: <555DEECA.1010409@redhat.com>
Date: Thu, 21 May 2015 16:42:18 +0200
From: Miroslav Grepl <mgrepl@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: CIL: migrate_store issues with MLS policy
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We try to get working Fedora SELinux policy builds with migrated store.
But we get some issues with MLS policy. We needed to add the following
fixes to make it working.

https://github.com/mgrepl/selinux-policy/commit/daad0252400284027e8a5c300addf6226f74e312

and

https://github.com/mgrepl/selinux-policy/commit/113792a78ac27e8a05b4e3b550d7bc40c3c937db

Please check my commit messages.

Regards,
Miroslav
-- 
Miroslav Grepl
Software Engineering, SELinux Solutions
Red Hat, Inc.
