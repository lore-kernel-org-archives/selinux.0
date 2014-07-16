Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6GGsaOj016654
 for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2014 12:54:36 -0400
Date: Thu, 17 Jul 2014 02:54:32 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux fix for 3.16-rcX
In-Reply-To: <2092564.8lACVUTXtn@sifl>
Message-ID: <alpine.LRH.2.11.1407170254210.22946@namei.org>
References: <2092564.8lACVUTXtn@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 15 Jul 2014, Paul Moore wrote:

> Hi James,
> 
> A single fix for the upcoming 3.16 release.  This patch is worth pushing up 
> for 3.16, despite the late stage of the release, because without this patch 
> SELinux systems with the latest version of cryptsetup may not be able to 
> access their encrypted volumes (more details in the patch description) which 
> could prevent the system from booting properly, users accessing their home 
> directories, etc.
> 
> The patch is fairly minor and passes the SELinux testsuite.

Pulled, thanks.


-- 
James Morris
<jmorris@namei.org>
