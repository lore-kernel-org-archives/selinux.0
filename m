Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t555L388017171
 for <selinux@tycho.nsa.gov>; Fri, 5 Jun 2015 01:21:03 -0400
Date: Fri, 5 Jun 2015 15:20:57 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 4.2
In-Reply-To: <2158515.KYehkOGLZJ@sifl>
Message-ID: <alpine.LRH.2.11.1506051520430.15998@namei.org>
References: <2158515.KYehkOGLZJ@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 4 Jun 2015, Paul Moore wrote:

> Hi James,
> 
> Six SELinux patches for 4.2: two to add better labeling support for three 
> pseudo filesystems, one netlink update, a __flush_signals() removal/fix, and a 
> couple of minor cleanup patches.  Nothing too scary or large this time.
> 
> All patches pass the SELinux testsuite and the selinux#upstream branch is 
> based on your linux-security#next branch as of about an hour ago.
> 

Thanks, pulled.


-- 
James Morris
<jmorris@namei.org>
