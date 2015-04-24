Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3OErE66010686
 for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2015 10:53:15 -0400
Received: by obbeb7 with SMTP id eb7so39378450obb.3
 for <selinux@tycho.nsa.gov>; Fri, 24 Apr 2015 07:53:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.11.1504241023280.13918@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <14c8ec61728.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <alpine.LRH.2.11.1504070004170.7027@namei.org>
 <47618041.M4z7H003Sc@sifl>
 <alpine.LRH.2.11.1504082055100.32381@namei.org>
 <CAHC9VhQu=U51b85U74xhP+x+4VCOrm9W8WVAw=vW6s0FdSNPxw@mail.gmail.com>
 <alpine.LRH.2.11.1504131142390.774@namei.org>
 <CAHC9VhSAVxo2wkOpMj1QcM-=HvBVhOvVGyTG-JGQHKJhn-rvYw@mail.gmail.com>
 <alpine.LRH.2.11.1504241023280.13918@namei.org>
Date: Fri, 24 Apr 2015 10:53:05 -0400
Message-ID: <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Apr 23, 2015 at 8:24 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 23 Apr 2015, Paul Moore wrote:
>
>> On Sun, Apr 12, 2015 at 9:46 PM, James Morris <jmorris@namei.org> wrote:
>> > On Wed, 8 Apr 2015, Paul Moore wrote:
>> >
>> >> On Wed, Apr 8, 2015 at 6:57 AM, James Morris <jmorris@namei.org> wrote:
>> >> > On Mon, 6 Apr 2015, Paul Moore wrote:
>> >> >
>> >> >> Removed the patch, it should now just contain the five patches described at
>> >> >> the start, and shown again below.  It's based again the current security#next
>> >> >> branch so there should be no problems, at least there haven't been in my test
>> >> >> pulls.
>> >> >
>> >> > Ok, I'll pull it on the weekend when I get back from PTO.
>> >>
>> >> Okay, thanks.  When you get back I'd still be curious to hear how you
>> >> manage the security tree; my process works *ok* but I'm always looking
>> >> for new approaches that may work better.
>> >
>> > Currently I merge my next branch with Linus at -rc1 or -rc2, after
>> > experimenting with other approaches.  I pull into that from security
>> > subsystems and push to Linus during the merge window.  Do you need any
>> > more info?  Not sure what else there is to add.
>> >
>> > For urgent fixes, I branch from Linus current (e.g. for-linus) and use
>> > that to push to Linus. This is a volatile branch which should not be
>> > tracked.
>>
>> So no long running branches then?  You simply recreate your next
>> branch every release?
>
> The next branch is long running.

I guess I misunderstood your merge with -rc1/-rc2 comment, I thought
you meant you rebased at each -rc1/-rc2.

-- 
paul moore
www.paul-moore.com
