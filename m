MIME-Version: 1.0
In-Reply-To: <20160830074607.GN594@leon.nu>
References: <1469800416-125043-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhS1Tg3qr2Nncd_eq_eUXrf-wMickoeoF978Q7L+gN7J1g@mail.gmail.com>
 <VI1PR0501MB24297FF784A085DC0AAE2C1EC4E10@VI1PR0501MB2429.eurprd05.prod.outlook.com>
 <CAHC9VhTEOvZ76dNJp35WEhr+r84eZZ6_ZmuaznGLakzZGcXhUw@mail.gmail.com>
 <20160830074607.GN594@leon.nu>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 30 Aug 2016 18:02:44 +0300
Message-ID: <CAJ3xEMh=DLafFGu4WCBDMidWUOaEPjsWN_kBE2ofU1GrhDoVxg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] SELinux support for Infiniband RDMA
To: Leon Romanovsky <leonro@mellanox.com>,
 Daniel Jurgens <danielj@mellanox.com>
Cc: Paul Moore <paul@paul-moore.com>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
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

On Tue, Aug 30, 2016 at 10:46 AM, Leon Romanovsky <leon@kernel.org> wrote:
> On Mon, Aug 29, 2016 at 08:00:32PM -0400, Paul Moore wrote:
>> On Mon, Aug 29, 2016 at 5:48 PM, Daniel Jurgens <danielj@mellanox.com> wrote:
>> > On 8/29/2016 4:40 PM, Paul Moore wrote:
>> >> On Fri, Jul 29, 2016 at 9:53 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>> >>> From: Daniel Jurgens <danielj@mellanox.com>
>> >> ...
>> >>
>> >>> Daniel Jurgens (9):
>> >>>   IB/core: IB cache enhancements to support Infiniband security
>> >>>   IB/core: Enforce PKey security on QPs
>> >>>   selinux lsm IB/core: Implement LSM notification system
>> >>>   IB/core: Enforce security on management datagrams
>> >>>   selinux: Create policydb version for Infiniband support
>> >>>   selinux: Allocate and free infiniband security hooks
>> >>>   selinux: Implement Infiniband PKey "Access" access vector
>> >>>   selinux: Add IB Port SMP access vector
>> >>>   selinux: Add a cache for quicker retreival of PKey SIDs
>> >> Hi Daniel,
>> >>
>> >> My apologies for such a long delay in responding to this latest
>> >> patchset; conferences, travel, and vacation have made for a very busy
>> >> August.  After you posted the v2 patchset we had an off-list
>> >> discussion regarding testing the SELinux/IB integration; unfortunately
>> >> we realized that IB hardware would be needed to test this (no IB
>> >> loopback device), but we agreed that having tests would be beneficial.
>> >>
>> >> Have you done any work yet towards adding SELinux/IB tests to the
>> >> selinux-testsuite project?
>> >>
>> >> * https://github.com/SELinuxProject/selinux-testsuite
>> >
>> > Hi Paul, I've not started doing that yet.  I've been waiting for feedback of any kind from the RDMA list.  I thought the test updates would be more appropriate around the time I'm submitting the changes to the user space utilities to allow labeling the new types.

>> Okay, no problem.  I just want the tests in place and functional when
>> we merge the kernel code.

> Hi Paul,
> IMHO, you can use Soft RoCE (RXE) [1] for it.

If I got it right, little if not nothing of this patch set is
applicable to RoCE ports, this is about IB ports, Daniel, can you
comment?

Or.
