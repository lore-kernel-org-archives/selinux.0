Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7U01Z7M014313
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 20:01:35 -0400
Received: by mail-oi0-f41.google.com with SMTP id c15so4869689oig.0
 for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2016 17:00:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB24297FF784A085DC0AAE2C1EC4E10@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <1469800416-125043-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhS1Tg3qr2Nncd_eq_eUXrf-wMickoeoF978Q7L+gN7J1g@mail.gmail.com>
 <VI1PR0501MB24297FF784A085DC0AAE2C1EC4E10@VI1PR0501MB2429.eurprd05.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Aug 2016 20:00:32 -0400
Message-ID: <CAHC9VhTEOvZ76dNJp35WEhr+r84eZZ6_ZmuaznGLakzZGcXhUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
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

On Mon, Aug 29, 2016 at 5:48 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
> On 8/29/2016 4:40 PM, Paul Moore wrote:
>> On Fri, Jul 29, 2016 at 9:53 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>>> From: Daniel Jurgens <danielj@mellanox.com>
>> ...
>>
>>> Daniel Jurgens (9):
>>>   IB/core: IB cache enhancements to support Infiniband security
>>>   IB/core: Enforce PKey security on QPs
>>>   selinux lsm IB/core: Implement LSM notification system
>>>   IB/core: Enforce security on management datagrams
>>>   selinux: Create policydb version for Infiniband support
>>>   selinux: Allocate and free infiniband security hooks
>>>   selinux: Implement Infiniband PKey "Access" access vector
>>>   selinux: Add IB Port SMP access vector
>>>   selinux: Add a cache for quicker retreival of PKey SIDs
>> Hi Daniel,
>>
>> My apologies for such a long delay in responding to this latest
>> patchset; conferences, travel, and vacation have made for a very busy
>> August.  After you posted the v2 patchset we had an off-list
>> discussion regarding testing the SELinux/IB integration; unfortunately
>> we realized that IB hardware would be needed to test this (no IB
>> loopback device), but we agreed that having tests would be beneficial.
>>
>> Have you done any work yet towards adding SELinux/IB tests to the
>> selinux-testsuite project?
>>
>> * https://github.com/SELinuxProject/selinux-testsuite
>
> Hi Paul, I've not started doing that yet.  I've been waiting for feedback of any kind from the RDMA list.  I thought the test updates would be more appropriate around the time I'm submitting the changes to the user space utilities to allow labeling the new types.

Okay, no problem.  I just want the tests in place and functional when
we merge the kernel code.

-- 
paul moore
www.paul-moore.com
