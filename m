Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u351D4EE015349
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 21:13:04 -0400
Date: Tue, 5 Apr 2016 11:12:57 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Dan Jurgens <danielj@mellanox.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
Subject: Re: [RFC PATCH 0/7] SELinux support for Infiniband RDMA
In-Reply-To: <1459806504-16135-1-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1604051110390.9906@namei.org>
References: <1459806504-16135-1-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 5 Apr 2016, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Currently there is no way to provide granular access control to an Infiniband
> fabric.  By providing an ability to restrict user access to specific virtual
> subfabrics administrators can limit access to bandwidth and isolate users on
> the fabric.

Where are the LSM hooks placed?



-- 
James Morris
<jmorris@namei.org>
