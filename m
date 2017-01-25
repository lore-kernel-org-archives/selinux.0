Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0P7wpcH026113
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 02:58:52 -0500
Received: by mail-ua0-f193.google.com with SMTP id 96so18508453uaq.2
 for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2017 23:58:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485294015.43764.91.camel@redhat.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
 <a56c4be8-f908-4774-dd1c-c6bbab5c1b03@tycho.nsa.gov>
 <DB6PR0501MB2422DCC01A577CDA280C2C82C49B0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <CAHC9VhTdntem1hK0arEo4p1MWPH5sjzDN0yG_=1S7ui=C4i8Yg@mail.gmail.com>
 <1485294015.43764.91.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Jan 2017 02:58:46 -0500
Message-ID: <CAHC9VhTfuftm1oyiBOa4Fx4L-12eX8MCySiS1H98yroCuuoieA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] SELinux support for Infiniband RDMA
To: Doug Ledford <dledford@redhat.com>
Cc: Daniel Jurgens <danielj@mellanox.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 24, 2017 at 4:40 PM, Doug Ledford <dledford@redhat.com> wrote:
> On Tue, 2016-12-13 at 17:17 -0500, Paul Moore wrote:
>> On Tue, Dec 13, 2016 at 11:25 AM, Daniel Jurgens <danielj@mellanox.co
>> m> wrote:
>> >
>> > On 12/13/2016 9:01 AM, Stephen Smalley wrote:
>> > >
>> > > For the LSM/SELinux bits,
>> > > Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> > >
>> > > Note that there will be a merge conflict on classmap.h due to
>> > > commits in
>> > > the selinux next branch, but that should be easy to resolve.
>> > >
>> > > We'll need the patches for the selinux userspace and refpolicy.
>> >
>> > Thanks Stephen, I need to rebase the user space and do some patch
>> > breakup.  I'll start on that soon.
>>
>> Sorry, I haven't had a chance to look at v6, but considering all our
>> discussions on the previous versions I don't expect any issues from
>> me.  I was hoping for some more generic hooks/controls, but that
>> doesn't look to be possible given the nature of RDMA.  I also want to
>> mention again the need for tests; we've talked about this in the past
>> and while it isn't possible to run the tests without IB hardware, I
>> would like to see us merge tests into the selinux-testsuite so that
>> those who do have the required h/w available could run the tests.
>>
>> Assuming we can sort out the SELinux userspace and and tests by the
>> end of January, I see no reason why this couldn't go in for v4.11.
>
> Daniel, can you work with people on the userspace and tests?  I'll pull
> this into a branch (I assume by Paul's and Stephen's comments that they
> expect it to go through my tree) ready to go, but hold actually
> submitting it in the merge window until I've heard more from you all
> that userspace is ready.

I don't have a problem pulling this in via the SELinux tree, assuming
you are okay with that Doug.  I'm just waiting to see tests for the
selinux-testsuite first.

-- 
paul moore
www.paul-moore.com
