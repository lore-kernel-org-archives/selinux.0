Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v812N078020788
 for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2017 22:23:01 -0400
Date: Fri, 1 Sep 2017 12:22:49 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <CAHC9VhRCnJAHLA8o7t0kF4a=KtA-mrmr5=okLODvb4WEntPTrQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1709011222340.6889@namei.org>
References: <CAHC9VhRCnJAHLA8o7t0kF4a=KtA-mrmr5=okLODvb4WEntPTrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [GIT PULL] SELinux patches for v4.14
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 31 Aug 2017, Paul Moore wrote:

> Hi James,
> 
> A relatively quiet period for SELinux, 11 patches with only two/three
> having any substantive changes.  These noteworthy changes include
> another tweak to the NNP/nosuid handling, per-file labeling for
> cgroups, and an object class fix for AF_UNIX/SOCK_RAW sockets; the
> rest of the changes are minor tweaks or administrative updates
> (Stephen's email update explains the file explosion in the diffstat).
> Everything passes the selinux-testsuite and merged cleanly on top of
> the linux-security/next branch from earlier today.
> 
> Please apply.

Merged, thanks.

-- 
James Morris
<jmorris@namei.org>
