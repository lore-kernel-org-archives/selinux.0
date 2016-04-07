Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u37LuClx024727
 for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2016 17:56:12 -0400
From: Daniel Jurgens <danielj@mellanox.com>
To: "leon@leon.nu" <leon@leon.nu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 11/13] ib/core: Enforce Infiniband device SMI
 security
Date: Thu, 7 Apr 2016 21:55:48 +0000
Message-ID: <DB5PR05MB11113536C2E232E4F44B128BC4900@DB5PR05MB1111.eurprd05.prod.outlook.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <1459985638-37233-12-git-send-email-danielj@mellanox.com>
 <20160407204456.GB12844@leon.nu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/7/2016 3:54 PM, Leon Romanovsky wrote:
> On Thu, Apr 07, 2016 at 02:33:56AM +0300, Dan Jurgens wrote:
>> +			dev_err(&device->dev,
>> +				"%s: Access Denied. Err: %d\n",
> 
> Please convert it to lower case.
> Can malicious user flood the system with this print?
>

>> +			dev_err(&device->dev,
>> +				"%s: Access Denied. Err: %d\n",
> 
> The same as above.
> 

I will just remove the prints unless you object.  The denial will be
captured in the audit log.
