Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85B9DHY009935
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 07:09:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so3295035pfn.13
 for <selinux@tycho.nsa.gov>; Wed, 05 Sep 2018 04:08:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
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
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 5 Sep 2018 13:08:35 +0200
Message-ID: <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
 tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Jeffrey Vander Stoep <jeffv@google.com>,
 SELinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
 Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 5, 2018 at 3:21 AM, Paul Moore <paul@paul-moore.com> wrote:
>> >>>> So why not ask for help from the SELinux community? I've cc'd the selinux
>> >>>> list and a couple of folks involved in Debian selinux.  I see a couple of
>> >>>> options but I don't know your constraints for syzbot:
>> >>>>
>> >>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>> >>>> out
>> >>>> of the box like Fedora. Then you don't have to fight with SELinux and can
>> >>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>> >>>>
>> >>>> 2) Report the problems you are having with enabling SELinux on newer
>> >>>> Debian
>> >>>> to the selinux list and/or the Debian selinux package maintainers so that
>> >>>> someone can help you resolve them.
>> >>>>
>> >>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>> >>>> rebuild
>> >>>> it, and install that.  We could help provide guidance on that. I think
>> >>>> you'll need to rebuild the base policy on wheezy; in distributions with
>> >>>> modern SELinux userspace, one could do it just by adding a CIL module
>> >>>> locally.
>> >>>
>> >>>
>> >>> Thanks, Stephen!
>> >>>
>> >>> I would like to understand first if failing mount(2) for unknown fs is
>> >>> selinux bug or not. Because if it is and it is fixed, then it would
>> >>> resolve the problem without actually doing anything (well, at least on
>> >>> our side :)).
>> >>
>> >>
>> >> Yes, I think that's a selinux kernel regression, previously reported here:
>> >> https://lkml.org/lkml/2017/10/6/658
>> >>
>> >> Unfortunately I don't think it has been fixed upstream.  Generally people
>> >> using SELinux with a newer kernel are also using a newer policy. That said,
>> >> I agree it is a regression and ought to be fixed.
>> >
>> >
>> > How hard is it to fix it? We are on upstream head, so once it's in we
>> > are ready to go.
>> > Using multiple images is somewhat problematic (besides the fact that I
>> > don't know how to build a fedora image) because syzbot does not
>> > capture what image was used, and in the docs we just provide the
>> > single image, so people will start complaining that bugs don't
>> > reproduce but they are just using a wrong image.
>>
>> I'll take a look and see if I can provide a trivial fix.
>
> As a FYI, Stephen provided a patch and it has been merged into the
> selinux/next tree.


Thanks! I've re-enabled selinux on syzbot:
https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
Now we will have instances with apparmor and with selinux.



> * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>
>   Author: Stephen Smalley <sds@tycho.nsa.gov>
>   Date:   Tue Sep 4 16:51:36 2018 -0400
>
>    selinux: fix mounting of cgroup2 under older policies
>
>    commit 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
>    broke mounting of cgroup2 under older SELinux policies which lacked
>    a genfscon rule for cgroup2.  This prevents mounting of cgroup2 even
>    when SELinux is permissive.
>
>    Change the handling when there is no genfscon rule in policy to
>    just mark the inode unlabeled and not return an error to the caller.
>    This permits mounting and access if allowed by policy, e.g. to
>    unconfined domains.
>
>    I also considered changing the behavior of security_genfs_sid() to
>    never return -ENOENT, but the current behavior is relied upon by
>    other callers to perform caller-specific handling.
>
>    Fixes: 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
>    CC: <stable@vger.kernel.org>
>    Reported-by: Dmitry Vyukov <dvyukov@google.com>
>    Reported-by: Waiman Long <longman@redhat.com>
>    Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>    Tested-by: Waiman Long <longman@redhat.com>
>    Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> --
> paul moore
> www.paul-moore.com
