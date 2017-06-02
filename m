Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v52K1flJ006590
 for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2017 16:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43B4B7F6AA
 for <selinux@tycho.nsa.gov>; Fri,  2 Jun 2017 20:01:39 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-16.brq.redhat.com
 [10.40.204.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97E5477C0A
 for <selinux@tycho.nsa.gov>; Fri,  2 Jun 2017 20:01:38 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: 
Date: Fri,  2 Jun 2017 22:01:29 +0200
Message-Id: <20170602200131.16718-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The following patches fix sepolicy python3 issues found by
`make test` in python/sepolicy 
