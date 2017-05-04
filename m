Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44Fqilu030444
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 11:52:44 -0400
Received: by mail-lf0-f53.google.com with SMTP id h4so10574740lfj.3
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 08:51:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB167880A4D79F8FC3F8C740A9C4160@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhSB6AORJf_8cBGt-AynMsEh3snKU5SpsmNXoy9hDSrGaA@mail.gmail.com>
 <VI1PR05MB167880A4D79F8FC3F8C740A9C4160@VI1PR05MB1678.eurprd05.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 May 2017 11:51:37 -0400
Message-ID: <CAHC9VhRE+bkPAnFgqOOQQQZwA8U0tSWHdeM5+LiadXfN63kS=g@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] SELinux support for Infiniband RDMA
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, May 3, 2017 at 3:45 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 5/3/2017 9:41 AM, Paul Moore wrote:
>> On Wed, Nov 23, 2016 at 9:17 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>
>>> Infiniband applications access HW from user-space -- traffic is generated
>>> directly by HW, bypassing the kernel. Consequently, Infiniband Partitions,
>>> which are associated directly with HW transport endpoints, are a natural
>>> choice for enforcing granular mandatory access control for Infiniband. QPs may
>>> only send or receives packets tagged with the corresponding partition key
>>> (PKey). The PKey is not a cryptographic key; it's a 16 bit number identifying
>>> the partition ...
>>>
>> Hi Dan,
>>
>> I haven't heard anything from you in a while, where do things stand
>> with this effort?  Unless I missed them, I believe we are still
>> waiting on the userspace, SELinux reference policy, and
>> selinux-testsuite patches.
>>
> Hi Paul,
>
>     I got distracted for a while.  I've just rebased the kernel and userspace.  I'll do some testing and submit the userspace code in the next couple days.  I still have to write the selinux-testsuite tests, I'll work on those concurrently with the userspace review cycle.

Great, thanks for the update.  We'll look forward to the patches.

-- 
paul moore
www.paul-moore.com
