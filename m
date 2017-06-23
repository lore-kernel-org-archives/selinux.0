Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5N29vVM020772
 for <selinux@tycho.nsa.gov>; Thu, 22 Jun 2017 22:09:57 -0400
Date: Fri, 23 Jun 2017 12:09:39 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux patches for v4.13
In-Reply-To: <CAHC9VhQBMBgH16Lo8dFYvLZ5k3zhr0ENXThzTtY=WWtQSqxHmg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1706231209230.17128@namei.org>
References: <CAHC9VhQBMBgH16Lo8dFYvLZ5k3zhr0ENXThzTtY=WWtQSqxHmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 22 Jun 2017, Paul Moore wrote:

> Hi James,
> 
> While we're down to 21 patches for v4.13 (it was 31 for v4.12), the
> diffstat jumps up tremendously with over 2k of line changes.  Almost
> all of these changes are the SELinux/IB work done by Daniel Jurgens;
> some other noteworthy changes include a NFS v4.2 labeling fix, a new
> file:map permission, and reporting of policy capabilities on policy
> load.  As usual, everything passes the selinux-testsuite and merges
> cleanly with your current linux-security/next branch; please apply.
> 

Thanks, pulled to -next.

-- 
James Morris
<jmorris@namei.org>
