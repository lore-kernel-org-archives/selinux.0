Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6ALjl23002490
 for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2015 17:45:48 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 975ACA0CDC
 for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2015 21:45:31 +0000 (UTC)
Received: from sifl.localnet (vpn-49-237.rdu2.redhat.com [10.10.49.237])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t6ALjUFf005120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2015 17:45:31 -0400
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: SELinux tree updates
Date: Fri, 10 Jul 2015 17:45:30 -0400
Message-ID: <1961931.A6H4iH4IVc@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello All,

Just a quick heads-up that I've rebased selinux#next to the current 
selinux#upstream and added the SELinux next-queue on top of that.  Please take 
a look and make sure I haven't forgotten your favorite patch, if I have, let 
me know; bonus points for the most creative use of the word "shenanigans" in 
the reply.

Here is what is currently in selinux#next:

    selinux: Create a common helper to determine an inode label [ver #3]
    selinux: Augment BUG_ON assertion for secclass_map.
    selinux: initialize sock security class to default value
    selinux: reduce locking overhead in inode_free_security()
    selinux: extended permissions for ioctls
    security: add ioctl specific auditing to lsm_audit
    selinux: do not remap unknown SIDs to the unlabeled context

-- 
paul moore
security @ redhat
