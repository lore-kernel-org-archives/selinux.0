Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HLNjQ2003529
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 17:23:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id y10so6622265wmh.0
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 14:23:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRE+bkPAnFgqOOQQQZwA8U0tSWHdeM5+LiadXfN63kS=g@mail.gmail.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhSB6AORJf_8cBGt-AynMsEh3snKU5SpsmNXoy9hDSrGaA@mail.gmail.com>
 <VI1PR05MB167880A4D79F8FC3F8C740A9C4160@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <CAHC9VhRE+bkPAnFgqOOQQQZwA8U0tSWHdeM5+LiadXfN63kS=g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 May 2017 17:23:38 -0400
Message-ID: <CAHC9VhTkOVN6KHQQY42QUTuBYO7D52A07aJjo_SiQs1o=Q0uzg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] SELinux support for Infiniband RDMA
To: Daniel Jurgens <danielj@mellanox.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, May 4, 2017 at 11:51 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, May 3, 2017 at 3:45 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>> On 5/3/2017 9:41 AM, Paul Moore wrote:
>>> On Wed, Nov 23, 2016 at 9:17 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>>
>>>> Infiniband applications access HW from user-space -- traffic is generated
>>>> directly by HW, bypassing the kernel. Consequently, Infiniband Partitions,
>>>> which are associated directly with HW transport endpoints, are a natural
>>>> choice for enforcing granular mandatory access control for Infiniband. QPs may
>>>> only send or receives packets tagged with the corresponding partition key
>>>> (PKey). The PKey is not a cryptographic key; it's a 16 bit number identifying
>>>> the partition ...
>>>>
>>> Hi Dan,
>>>
>>> I haven't heard anything from you in a while, where do things stand
>>> with this effort?  Unless I missed them, I believe we are still
>>> waiting on the userspace, SELinux reference policy, and
>>> selinux-testsuite patches.
>>>
>> Hi Paul,
>>
>>     I got distracted for a while.  I've just rebased the kernel and userspace.  I'll do some testing and submit the userspace code in the next couple days.  I still have to write the selinux-testsuite tests, I'll work on those concurrently with the userspace review cycle.
>
> Great, thanks for the update.  We'll look forward to the patches.

I took a closer look at the patchset and I think it looks fine,
coupled with the recent progress on the SELinux userspace and test
suite I think it would be good to get this into the selinux/next tree
so we can start playing with it.  Dan, I know there were some IB merge
conflicts with this patch could you do a respin against the current
selinux/next tree?

* git://git.infradead.org/users/pcmoore/selinux
* http://git.infradead.org/users/pcmoore/selinux

Thanks.

-- 
paul moore
www.paul-moore.com
