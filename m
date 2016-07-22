From: Daniel Jurgens <danielj@mellanox.com>
To: Paul Moore <paul@paul-moore.com>
CC: "chrisw@sous-sol.org" <chrisw@sous-sol.org>, Stephen Smalley
 <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 "dledford@redhat.com" <dledford@redhat.com>, "sean.hefty@intel.com"
 <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [PATCH v2 0/9] SELinux support for Infiniband RDMA
Date: Fri, 22 Jul 2016 16:02:59 +0000
Message-ID: <AM4PR0501MB22572EC9A6719DD910134F13C40A0@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1468537011-20407-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhRuSSdUEdA65KBbt50fkDAjd+vATagNhXN9dYojNNBFSw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/22/2016 10:46 AM, Paul Moore wrote:
> On Thu, Jul 14, 2016 at 6:56 PM, Dan Jurgens <danielj@mellanox.com> wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> The selinux next tree is missing some patches for IB/core.  This series
>> applies cleanly to ib-next, and should apply cleanly to selinux-next once
>> the IB patches are merged.
> Hi Dan,
>
> Thanks for the updated patchset, I'm taking a look at it today.  I do
> have one question, related but independent to your patches: is there a
> way to test the LSM controlled portions of the Infiniband stack
> without any IB hardware (e.g. is there an IB "loopback" device)?  I'm
> asking because we are really trying to make sure we have tests for any
> new code/functionality we add to SELinux, and requiring IB hardware to
> test the IB access controls would make this difficult.
>
> * https://github.com/SELinuxProject/selinux-testsuite
>
> -Paul
>
I found this: https://github.com/nminoru/pib but haven't used it.  I'll try playing with it and see if it can serve this purpose.
