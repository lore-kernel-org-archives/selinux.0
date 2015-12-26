Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBQ9JZG8008260
 for <selinux@tycho.nsa.gov>; Sat, 26 Dec 2015 04:19:38 -0500
Date: Sat, 26 Dec 2015 20:19:08 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux patches for 4.5
In-Reply-To: <1964478.KPgA55cFSS@sifl>
Message-ID: <alpine.LRH.2.20.1512262018580.14073@namei.org>
References: <1964478.KPgA55cFSS@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 24 Dec 2015, Paul Moore wrote:

> Hi James,
> 
> Nine patches for v4.5; there are a handful of minor fixes (constify 
> parameters, warning rate-limits, etc.) but there are a couple of significant 
> patches that invalidate/revalidate inode labels (needed for gfs2) and make 
> validate_trans decisions visible via selinuxfs.  All the patches pass the 
> selinux-testsuite and have been included in the pcmoore/kernel-secnext Fedora 
> COPR repository[1] for some time now, all looks good.
> 
> As of about five minutes ago, selinux#upstream applied cleanly on top of 
> linux-security#next so I don't expect you should have any problems merging the 
> code.

Applied.

-- 
James Morris
<jmorris@namei.org>
