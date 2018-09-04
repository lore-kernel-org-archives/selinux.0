Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w84FpA2l004272
 for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2018 11:51:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so1875049pfi.10
 for <selinux@tycho.nsa.gov>; Tue, 04 Sep 2018 08:38:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
 <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
 <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
 <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 4 Sep 2018 17:38:27 +0200
Message-ID: <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>,
 syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
 tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, SELinux <selinux@tycho.nsa.gov>,
 "russell@coker.com.au" <russell@coker.com.au>,
 Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 4, 2018 at 5:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> So why not ask for help from the SELinux community? I've cc'd the selinux
>>> list and a couple of folks involved in Debian selinux.  I see a couple of
>>> options but I don't know your constraints for syzbot:
>>>
>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>>> out
>>> of the box like Fedora. Then you don't have to fight with SELinux and can
>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>>>
>>> 2) Report the problems you are having with enabling SELinux on newer
>>> Debian
>>> to the selinux list and/or the Debian selinux package maintainers so that
>>> someone can help you resolve them.
>>>
>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>>> rebuild
>>> it, and install that.  We could help provide guidance on that. I think
>>> you'll need to rebuild the base policy on wheezy; in distributions with
>>> modern SELinux userspace, one could do it just by adding a CIL module
>>> locally.
>>
>>
>> Thanks, Stephen!
>>
>> I would like to understand first if failing mount(2) for unknown fs is
>> selinux bug or not. Because if it is and it is fixed, then it would
>> resolve the problem without actually doing anything (well, at least on
>> our side :)).
>
>
> Yes, I think that's a selinux kernel regression, previously reported here:
> https://lkml.org/lkml/2017/10/6/658
>
> Unfortunately I don't think it has been fixed upstream.  Generally people
> using SELinux with a newer kernel are also using a newer policy. That said,
> I agree it is a regression and ought to be fixed.


How hard is it to fix it? We are on upstream head, so once it's in we
are ready to go.
Using multiple images is somewhat problematic (besides the fact that I
don't know how to build a fedora image) because syzbot does not
capture what image was used, and in the docs we just provide the
single image, so people will start complaining that bugs don't
reproduce but they are just using a wrong image.


>>> As for exercising SELinux, you'll exercise SELinux just by enabling it
>>> and
>>> loading a policy, since it will perform permission checking on all object
>>> accesses.   But you can get more extensive coverage by running the
>>> selinux-testsuite.  We only test that on Fedora and RHEL however, so
>>> getting
>>> it to work on Debian might take some effort.
>>
>>
>> That's good.
>> I just thought that there is some potential in making the policy
>> interact more with what the fuzzer does. With respect to fs accesses,
>> it works within own temp directory, and I guess the policy is actually
>> all the same for everything it does in that directory. There also may
>> be something related to extended attributes, context changes, etc?
>
>
> Yes, by default, your fuzzer is going to just run in a single security
> context and all files it creates will have a single security context. So the
> policy side of things won't be interesting and probably everything will be
> allowed (if it runs in the unconfined context), but you'll still exercise
> many code paths.  The selinux-testsuite would trigger many process context
> changes and create files under varying contexts, so that would be more
> complete in its coverage.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/b2b38348-f3a4-6498-c9b8-1090532f6a23%40tycho.nsa.gov.
>
> For more options, visit https://groups.google.com/d/optout.
