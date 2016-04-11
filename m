Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3BKBxhl021780
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 16:11:59 -0400
Date: Mon, 11 Apr 2016 14:11:55 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Message-ID: <20160411201155.GC371@obsidianresearch.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 07, 2016 at 02:33:45AM +0300, Dan Jurgens wrote:

> Currently there is no way to provide granular access control to an Infiniband
> fabric.  By providing an ability to restrict user access to specific virtual
> subfabrics administrators can limit access to bandwidth and isolate users on
> the fabric.

Do you actually have a concrete use case for this?

This seems superficially similar to netlabel, which I guess targets a
certain niche, but I'm really wondering with all the other container
patches if this was supposed to be done with namespaces...

> An Infiniband device (ibdev) is labeled by name and port number.  There is a
> single access vector for ibdevs as well, called "smi".

This is called an End Port (SMI is something else in the IB
spec). Please use the standard terminology.

Jason
