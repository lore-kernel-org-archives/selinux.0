Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u351VhuM019295
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 21:31:43 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: James Morris <jmorris@namei.org>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH 0/7] SELinux support for Infiniband RDMA
Date: Tue, 5 Apr 2016 01:31:26 +0000
Message-ID: <DB5PR05MB111126C8AB59CDA4674A068BC49E0@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459806504-16135-1-git-send-email-danielj@mellanox.com>
 <alpine.LRH.2.20.1604051110390.9906@namei.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/4/2016 8:13 PM, James Morris wrote:
> On Tue, 5 Apr 2016, Dan Jurgens wrote:
> 
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Currently there is no way to provide granular access control to an Infiniband
>> fabric.  By providing an ability to restrict user access to specific virtual
>> subfabrics administrators can limit access to bandwidth and isolate users on
>> the fabric.
> 
> Where are the LSM hooks placed?
> 
> 
> 
The LSM hooks are defined in patch 1/7 of this series.  There are 4 that
will be called from ib_core, and one that's implemented by ib_core to be
called by a security module if the policy or enforcement setting change
(infiniband_flush).  That call from SELinux is added in patch 3/7 of
this series.
