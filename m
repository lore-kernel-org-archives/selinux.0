Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SDFRWx003305
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 09:15:27 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux fix for 3.16-rcX
Date: Mon, 28 Jul 2014 09:15:27 -0400
Message-ID: <1466375.GopY4LG4WC@sifl>
In-Reply-To: <alpine.LRH.2.11.1407170254210.22946@namei.org>
References: <2092564.8lACVUTXtn@sifl>
 <alpine.LRH.2.11.1407170254210.22946@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, July 17, 2014 02:54:32 AM James Morris wrote:
> On Tue, 15 Jul 2014, Paul Moore wrote:
> > Hi James,
> > 
> > A single fix for the upcoming 3.16 release.  This patch is worth pushing
> > up for 3.16, despite the late stage of the release, because without this
> > patch SELinux systems with the latest version of cryptsetup may not be
> > able to access their encrypted volumes (more details in the patch
> > description) which could prevent the system from booting properly, users
> > accessing their home directories, etc.
> > 
> > The patch is fairly minor and passes the SELinux testsuite.
> 
> Pulled, thanks.

Hi James,

I haven't seen this patch in the last two 3.16-rcX releases from Linus, is 
there a reason this isn't being pushed further up?

-Paul

-- 
paul moore
security and virtualization @ redhat
