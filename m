Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7JCMmqw009236
 for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2016 08:22:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id s207so6005230oie.0
 for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2016 05:22:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdquOxV-1jU9Ra5s85KRfq4KOOHzor7if=SfcbR2Sgc=qw@mail.gmail.com>
References: <1471290132-26336-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhR9A6cZT5OxXTf1wyD+z+Er8EXX1Bzz4G5PA6s-=HZ1ag@mail.gmail.com>
 <CAFftDdquOxV-1jU9Ra5s85KRfq4KOOHzor7if=SfcbR2Sgc=qw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 Aug 2016 08:22:44 -0400
Message-ID: <CAHC9VhRCOZeMqSGwTkQeWWJMbhsOeo81nMx4=3qg80916spZ5Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop SECURITY_SELINUX_POLICYDB_VERSION_MAX
To: William Roberts <bill.c.roberts@gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 18, 2016 at 8:27 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Aug 18, 2016 17:07, "Paul Moore" <paul@paul-moore.com> wrote:
>>
>> On Mon, Aug 15, 2016 at 3:42 PM,  <william.c.roberts@intel.com> wrote:
>> > From: William Roberts <william.c.roberts@intel.com>
>> >
>> > Remove the SECURITY_SELINUX_POLICYDB_VERSION_MAX Kconfig option
>> >
>> > Per: https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo
>> >
>> > This was only needed on Fedora 3 and 4 and just causes issues now,
>> > so drop it.
>> >
>> > The MAX and MIN should just be whatever the kernel can support.
>> >
>> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>> > ---
>> >  security/selinux/Kconfig            | 38
>> > -------------------------------------
>> >  security/selinux/include/security.h |  4 ----
>> >  2 files changed, 42 deletions(-)
>>
>> Merged, thanks for the help!
>
> I plan on tinkering with some of the things on that list, hopefully I can
> help whittle it down.

That would be great, thank you.

-- 
paul moore
www.paul-moore.com
