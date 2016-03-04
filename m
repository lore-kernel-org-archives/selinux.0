Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u240EKdT011222
 for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2016 19:14:20 -0500
Date: Fri, 4 Mar 2016 11:14:11 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux patches for 4.6
In-Reply-To: <3791404.FF7yCft6NU@sifl>
Message-ID: <alpine.LRH.2.20.1603041114001.12497@namei.org>
References: <3791404.FF7yCft6NU@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 3 Mar 2016, Paul Moore wrote:

> Hi James,
> 
> Just a single SELinux patch for 4.6, and it's a trivial build patch too.  The 
> patch passes the selinux-testsuite (surprise, surprise) and merges cleanly 
> with the current linux-security#next branch; please apply.
> 
> -Paul
> 
> ---
> The following changes since commit 76319946f321e30872dd72af7de867cb26e7a373:
> 
>   selinux: rate-limit netlink message warnings in selinux_nlmsg_perm() 
>            (2015-12-24 11:09:41 -0500)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux stable-4.6
> 
> for you to fetch changes up to 9090a2d5e3e6f1f1f1aabd44f9335ff873239b60:
> 
>   selinux: use absolute path to include directory (2016-01-28 10:37:15 -0500)

Pulled to next.


-- 
James Morris
<jmorris@namei.org>
