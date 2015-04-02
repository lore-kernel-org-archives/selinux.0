Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t32CW8OI024124
 for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2015 08:32:08 -0400
Date: Thu, 2 Apr 2015 23:32:02 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
In-Reply-To: <1978116.cNUKEOv2T8@sifl>
Message-ID: <alpine.LRH.2.11.1504022331430.4811@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 1 Apr 2015, Paul Moore wrote:

> Hi James,
> 
> Five patches this time around: three patches to improve and enlarge the the 
> avtab hash table, one to cleanup some MLS label import code, and one to 
> cleanup some of the avc code.  All of the patches are pretty small and 
> straightforward.  The two cleanup patches are trivially understandable and the 
> avtab code is well documented.
> 
> As usual, all patches pass the SELinux testsuite.
> 
> Enjoy,
> -Paul
> 
> ---
> The following changes since commit 6436a123a147db51a0b06024a8350f4c230e73ff:
> 
>   selinux: fix sel_write_enforce broken return value
>            (2015-03-25 16:55:06 -0400)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux upstream
> 
> for you to fetch changes up to 9b43e04b188a1f715429604cca32b846e5a48cd2:
> 
>   Merge branch 'next' into upstream in preparation for v4.1
>   (2015-04-01 22:24:51 -0400)
> 

Is this branch downstream from my -next?


-- 
James Morris
<jmorris@namei.org>
