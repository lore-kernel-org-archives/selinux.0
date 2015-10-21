Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9LNuoP0026517
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 19:56:50 -0400
Date: Thu, 22 Oct 2015 10:56:44 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux patches for 4.4
In-Reply-To: <2506963.zmKhoxexGn@sifl>
Message-ID: <alpine.LRH.2.20.1510221056310.16831@namei.org>
References: <2506963.zmKhoxexGn@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 21 Oct 2015, Paul Moore wrote:

> Hi James,
> 
> Nine SELinux patches in total for v4.4, although six of those patches are 
> either trivial, minor cleanups, or both.  The remaining three patches aren't 
> too bad: one changes the CHECKREQPROT default to check the actual memory 
> protections, one stops us from checking file:open on ftruncate() calls, and 
> one converts the file_security_struct over to kmem_cache.
> 
> All pass the SELinux testsuite and should apply cleanly on top of your next 
> branch.
> 

Pulled, thanks.


-- 
James Morris
<jmorris@namei.org>
