Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA24DPAY012733
 for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2016 00:13:25 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Reply-To: russell@coker.com.au
Cc: Chris PeBenito <pebenito@ieee.org>, refpolicy <refpolicy@oss.tresys.com>
Subject: Re: ANN: Reference Policy Release
Date: Wed, 02 Nov 2016 15:13:07 +1100
Message-ID: <8799489.dRRxGQOAEO@russell.coker.com.au>
In-Reply-To: <6f8bd54a-758b-01ba-0958-16bd6c5b15ed@ieee.org>
References: <6f8bd54a-758b-01ba-0958-16bd6c5b15ed@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, 23 October 2016 5:29:25 PM AEDT Chris PeBenito wrote:
> A new release of the SELinux Reference Policy is now available on the
> GitHub site, https://github.com/TresysTechnology/refpolicy.

https://github.com/TresysTechnology/refpolicy/wiki/DownloadRelease

The archive at the above page has the files policy.28 and policy.30.orig which 
comprise more than half the compressed archive size.

Could you make a new release without them?  Otherwise we are going to have 
that in all the distribution archives and mirror sites.

Also in future could we have more frequent releases?  More frequent upstream 
releases makes it easier for distribution people to send changes upstream and 
gives a greater incentive to do so.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
