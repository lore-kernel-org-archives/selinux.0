Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6TFIqeo032260
 for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2014 11:18:55 -0400
Date: Wed, 30 Jul 2014 01:18:56 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux fix for 3.16-rcX
In-Reply-To: <1696874.XicgDe8Om8@sifl>
Message-ID: <alpine.LRH.2.11.1407300118410.18973@namei.org>
References: <2092564.8lACVUTXtn@sifl> <1696874.XicgDe8Om8@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 28 Jul 2014, Paul Moore wrote:

> On Tuesday, July 15, 2014 10:38:19 PM Paul Moore wrote:
> > Hi James,
> > 
> > A single fix for the upcoming 3.16 release.  This patch is worth pushing up
> > for 3.16, despite the late stage of the release, because without this patch
> > SELinux systems with the latest version of cryptsetup may not be able to
> > access their encrypted volumes (more details in the patch description) which
> > could prevent the system from booting properly, users accessing their home
> > directories, etc.
> > 
> > The patch is fairly minor and passes the SELinux testsuite.
> 
> Hello again,
> 
> Below is a revert for the patch above, while it fixed AF_ALG, it killed 
> Bluetooth so we need to revert it.  I'll fix AF_ALG in a future patch.
> 
> ---
> The following changes since commit 4da6daf4d3df5a977e4623963f141a627fd2efce:
> 
>   selinux: fix the default socket labeling in sock_graft() (2014-07-10  
>            10:17:48 -0400)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux stable-3.16
> 

Pulled, thanks.

-- 
James Morris
<jmorris@namei.org>
