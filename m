Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBFLA3Od003955
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 16:10:03 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBFLA01e015808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 16:10:00 -0500
Received: from sifl.localnet (vpn-60-189.rdu2.redhat.com [10.10.60.189])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 sBFL9xFf011039
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 16:10:00 -0500
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Process changes for the SELinux tree
Date: Mon, 15 Dec 2014 16:09:59 -0500
Message-ID: <8254330.NvBnhe8fDV@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello all,

Due to a few reasons, the most notable being a need to stop back-merging from 
Linus' tree, I'm changing the way I manage the SELinux tree.  I apologize for 
any confusion this may cause, but this is a necessary change.

First off, the SELinux tree remains in the same place:

 * git://git.infradead.org/users/pcmoore/selinux
 * http://git.infradead.org/users/pcmoore/selinux

... the changes are limited to the branches and how they will be managed 
moving forward.  Ignoring master and the working-kdbus branches, there are 
presently three branches in the SELinux tree: stable-3.18, next, and upstream.

The stable-3.18 branch holds patches that were submitted during the v3.18-rcX 
window.

The next branch holds patches that were developed for v3.19 during the v3.18 
window.

The upstream branch is currently based off James' linux-security next branch 
after he merged the SELinux changes for v3.19.

Moving forward I'm going to adopt the following process:

1. Create a new branch, stable-3.XX, set to the upstream branch that was sent 
during the merge window.

2. Reset the next branch to the upstream branch that was sent during the merge 
window.

3. Accept new features into the next branch and fixes into the stable-3.XX 
branch.

4. As necessary, merge stable-3.XX into upstream and send pull requests to 
Linus.

5. When v3.XX is released, merge next into upstream and send a pull request 
for the upstream branch to James.  Leave stable-3.XX untouched for future 
stable fixes.

6. Goto step #1.

The big change here is the new upstream branch, but it is important to note 
that the next branch will now be reset/rebased on a regular basis (step #2 
above).  The reset is unfortunate, but necessary to get the stable fixes.  It 
is also worth mentioning that while I don't expect to reset/rebase the 
upstream branch often, it will likely happen on occasion so we can avoid back-
merging.  When this happens I'll be sure to send notice to the list.

Thanks for your understanding, if you've got any questions, let's hear 'em.

-Paul
-- 
paul moore
security and virtualization @ redhat
