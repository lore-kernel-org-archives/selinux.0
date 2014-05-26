Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4QCc2bG000561
 for <selinux@tycho.nsa.gov>; Mon, 26 May 2014 08:38:02 -0400
Date: Mon, 26 May 2014 22:38:27 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 3.16
In-Reply-To: <5872296.eRu4qP8SMB@sifl>
Message-ID: <alpine.LRH.2.02.1405262238150.24604@tundra.namei.org>
References: <5872296.eRu4qP8SMB@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 22 May 2014, Paul Moore wrote:

> Hi James,
> 
> Here are the SELinux patches for 3.16.  A total of four patches: two to fix a 
> problem when loading policy on slow machines, one to make it easier to 
> determine permissive mode in the AVC audit messages, and one to block cause 
> setexeccon() to fail on filesystems mounted with nosuid.  None of the patches 
> are very substantial (see the diffstat below), all pass the SELinux testsuite, 
> and the branch applied cleanly on top of your current #next.
> 
> Enjoy,
> -Paul
> 
> ---
> The following changes since commit 6d32c850621b0be75777b9102b14f6268bbd9f0f:
> 
>   Merge tag 'v3.14' into next (2014-03-31 09:49:07 -0400)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux next

Thanks, pulled.


-- 
James Morris
<jmorris@namei.org>
