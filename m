Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1BNqhVK021986
 for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2015 18:52:43 -0500
Date: Thu, 12 Feb 2015 10:52:36 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux fixes for 3.20 #1
In-Reply-To: <1658002.ETCiBgy66R@sifl>
Message-ID: <alpine.LRH.2.11.1502121052280.11564@namei.org>
References: <1658002.ETCiBgy66R@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 11 Feb 2015, Paul Moore wrote:

> Hi James,
> 
> A small pull request, just one patch, but an important patch.  This patch 
> fixes a nasty problem in NetLabel/CIPSO that causes CIPSO options to go 
> undetected, affecting both SELinux and Smack.  Please pull for v3.20.
> 
> Thanks,
> -Paul
> 


Pulled.


-- 
James Morris
<jmorris@namei.org>
