Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37FhxNf028360
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 11:43:59 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: "leon@leon.nu" <leon@leon.nu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 08/13] ib/core: IB cache enhancements to support
 Infiniband security
Date: Thu, 7 Apr 2016 15:43:52 +0000
Message-ID: <DB5PR05MB1111B265CD502DE355348EF2C4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-9-git-send-email-danielj@mellanox.com>
 <20160407025314.GA20789@leon.nu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/6/2016 9:53 PM, Leon Romanovsky wrote:
> On Thu, Apr 07, 2016 at 02:33:53AM +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> +	int ret = 0;
> 
> It is not needed, just return 0 directly.

Okay

On 4/7/2016 10:24 AM, Leon Romanovsky wrote:
> On Thu, Apr 07, 2016 at 02:33:53AM +0300, Dan Jurgens wrote:
>> pr_warn("Couldn't allocate cache for %s\n", device->name);
>
> Please remove this print. You won't miss failure in memory allocation.

Sure, I can do that.
