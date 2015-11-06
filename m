Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6Fbra3014390
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 10:37:53 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id D37E4264B
 for <selinux@tycho.nsa.gov>; Fri,  6 Nov 2015 15:37:36 +0000 (UTC)
Received: from sifl.localnet (vpn-232-48.phx2.redhat.com [10.3.232.48])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 tA6FbZXa004271
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 10:37:36 -0500
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: New SELinux userspace release supporting extended ioctl permissions?
Date: Fri, 06 Nov 2015 10:37:35 -0500
Message-ID: <1852496.Nbh2u1K4Uk@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Now that Linux 4.3 has been released with the extended ioctl permissions, are 
we planning to make a new userspace release so that we can take advantage of 
this new functionality?  I believe all the necessary patches have been merged, 
no?

-- 
paul moore
security @ redhat
