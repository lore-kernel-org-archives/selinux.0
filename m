Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id rBO6lLsM008597
 for <selinux@tycho.nsa.gov>; Tue, 24 Dec 2013 01:47:22 -0500
Date: Tue, 24 Dec 2013 17:48:04 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
Subject: Re: [GIT PULL] SELinux fixes for 3.13 (part three)
In-Reply-To: <CACLa4ptKh-kkwz2u2bt3YQM-bqcw0R=nbq7_Jqm6-iZtUHQMow@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1312241747090.23615@tundra.namei.org>
References: <3917996.DVt9Qik8HG@sifl> <1678336.HYoZuQ9LME@sifl>
 <alpine.LRH.2.02.1312240933320.22187@tundra.namei.org>
 <CACLa4ptKh-kkwz2u2bt3YQM-bqcw0R=nbq7_Jqm6-iZtUHQMow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 23 Dec 2013, Eric Paris wrote:

> Why?  The SELinux tree should not be rebasing patches or merging
> random snapshots in Linus' tree...
> 

Yep, you're right.  I was needlessly worried about the revert clashing.


-- 
James Morris
<jmorris@namei.org>
