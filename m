Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1555im3028950
 for <selinux@tycho.nsa.gov>; Thu, 5 Feb 2015 00:05:44 -0500
Date: Thu, 5 Feb 2015 16:05:38 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.20
In-Reply-To: <5744455.kXAUaHeggX@sifl>
Message-ID: <alpine.LRH.2.11.1502051605230.23535@namei.org>
References: <5744455.kXAUaHeggX@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 4 Feb 2015, Paul Moore wrote:

> Hi James,
> 
> This time around we've got four SELinux patches for 3.20.  All four patches 
> are fairly small, see the diffstat below, with two of the patches being 
> trivial (remove some dead code, squelch a notification message).  The two 
> patches that are substantive are straightforward: one fixes a problem where we 
> weren't propagating an error code and one adds in-core xattr support for 
> pstore and debugfs.
> 
> All patches pass the SELinux testsuite and are based on the security#next 
> branch.
> 

Thanks, pulled.


-- 
James Morris
<jmorris@namei.org>
