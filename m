Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0C1bZW0018125
 for <selinux@tycho.nsa.gov>; Sat, 11 Jan 2014 20:37:35 -0500
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
Date: Sun, 12 Jan 2014 12:37:30 +1100
Message-ID: <25734134.uy91zhLtTd@russell.coker.com.au>
In-Reply-To: <2516775.9uuOuGk0G5@sifl>
References: <52CF1A53.9080501@redhat.com> <52D006E2.5030906@tycho.nsa.gov>
 <2516775.9uuOuGk0G5@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Reply-To: russell@coker.com.au
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 10 Jan 2014 09:49:28 Paul Moore wrote:
> Do we really need to worry about being able to load new policy into a old 
> kernel?  In general I thought the backward compatible issue was that newer 
> kernels needed to support older userspace, not the other way around.

Yes.  One case is when you have a Xen server that uses the kernel from the 
Dom0 for the DomUs (which is easier than taking the DomU kernel to the Dom0).

Another case is hardware compatability issues, being able to upgrade all user-
space before dealing with hardware issues is a good option to have.

Finally allowing the possibility of downgrading the kernel in case of 
discovering a bug in the new kernel is a good thing.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
