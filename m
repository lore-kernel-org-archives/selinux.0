Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1NH1lZn005846
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 12:01:48 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux fixes for 4.5 (#2)
Date: Tue, 23 Feb 2016 12:01:43 -0500
Message-ID: <2007254.ryXfPbMQOT@sifl>
In-Reply-To: <alpine.LRH.2.20.1602232237530.428@namei.org>
References: <2013440.Fs5UDgiGs4@sifl>
 <alpine.LRH.2.20.1602232237530.428@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, February 23, 2016 10:39:26 PM James Morris wrote:
> On Mon, 22 Feb 2016, Paul Moore wrote:
> > Hi James,
> > 
> > One more straightforward patch to fix a problem with the inode
> > invalidation changes.  The fix passes the selinux-testsuite and applies
> > cleanly on top of your current linux-security#next branch; please apply.
> 
> Where is patch '#1' ?

Where is said it was in the pull request ... ?  It is in the usual SELinux 
kernel repo, in the stable-4.5 branch.  It looks okay on my end, are you 
having problems fetching the branch/commit?

git://git.infradead.org/users/pcmoore/selinux stable-4.5
http://git.infradead.org/users/pcmoore/selinux/shortlog/refs/heads/stable-4.5

  commit e817c2f33efb4aa7f02c98dfab9a5f8ff383ea7e
  Author: Andreas Gruenbacher <agruenba@redhat.com>
  Date:   Thu Feb 18 12:04:08 2016 +0100

    selinux: Don't sleep inside inode_getsecid hook
    
    The inode_getsecid hook is called from contexts in which sleeping is not
    allowed, so we cannot revalidate inode security labels from there. Use
    the non-validating version of inode_security() instead.
    
    Reported-by: Benjamin Coddington <bcodding@redhat.com>
    Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
    Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
    Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
security @ redhat
