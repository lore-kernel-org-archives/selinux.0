Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBmcBf021553
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:48:38 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 08B14B6E60
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:48:36 +0000 (UTC)
Received: from deimos.redhat.com (ovpn-204-20.brq.redhat.com [10.40.204.20])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t6GBmYSp015324
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:48:35 -0400
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: 
Date: Thu, 16 Jul 2015 13:48:10 +0200
Message-Id: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

These patches aims to bring Python3 support to sepolgen module.
They're made from the patch I've sent earlier which was a little
bit big for a single review so I cut it into smaller patches.
