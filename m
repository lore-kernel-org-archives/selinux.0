Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t55Ie4Km006316
 for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2015 14:40:04 -0400
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Subject: SELinux tree updates
Date: Fri, 05 Jun 2015 14:40:01 -0400
Message-ID: <9892603.2N9PhGGyoM@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello All,

While I try to keep rebases to the SELinux tree at a minimum, they are 
occasionally necessary to sync with upstream development; Casey's LSM stacking 
patches merit a rebase.  You may have noticed this starting yesterday, but in 
case you haven't, this serves as notice that I've rebased the SELinux upstream 
and next branches.  I apologize for any inconvenience this may have caused.  
Once Linux 4.1 is released, I will resume my usual process of updating the 
SELinux tree (described below).

* SELinux Tree
  -> git://git.infradead.org/users/pcmoore/selinux
  -> http://git.infradead.org/users/pcmoore/selinux

* SELinux Tree Process

  1. Create a new branch, stable-X.XX, set to the upstream branch that
  was sent during the merge window.

  2. Reset the next branch to the upstream branch that was sent during
  the merge window.

  3. Accept new features into the next branch and fixes into the
  stable-X.XX branch.

  4. As necessary, merge stable-X.XX into upstream and send pull
  requests upstream.

  5. When vX.XX is released, merge next into upstream and send a pull
  request for the upstream branch.  Leave stable-X.XX untouched for
  future stable fixes.

  6. Goto step #1.

-- 
paul moore
security @ redhat
