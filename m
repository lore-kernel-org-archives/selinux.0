To: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul Moore <paul@paul-moore.com>,
 syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
 tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
 James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Jeffrey Vander Stoep <jeffv@google.com>, SELinux <selinux@tycho.nsa.gov>,
 "russell@coker.com.au" <russell@coker.com.au>,
 Laurent Bigonville <bigon@debian.org>
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
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
Date: Tue, 4 Sep 2018 13:02:27 -0400
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/04/2018 11:38 AM, Dmitry Vyukov wrote:
> On Tue, Sep 4, 2018 at 5:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> So why not ask for help from the SELinux community? I've cc'd the selinux
>>>> list and a couple of folks involved in Debian selinux.  I see a couple of
>>>> options but I don't know your constraints for syzbot:
>>>>
>>>> 1) Run an instance of syzbot on a distro that supports SELinux enabled
>>>> out
>>>> of the box like Fedora. Then you don't have to fight with SELinux and can
>>>> just focus on syzbot, while still testing SELinux enabled and enforcing.
>>>>
>>>> 2) Report the problems you are having with enabling SELinux on newer
>>>> Debian
>>>> to the selinux list and/or the Debian selinux package maintainers so that
>>>> someone can help you resolve them.
>>>>
>>>> 3) Back-port the cgroup2 policy definitions to your wheezy policy,
>>>> rebuild
>>>> it, and install that.  We could help provide guidance on that. I think
>>>> you'll need to rebuild the base policy on wheezy; in distributions with
>>>> modern SELinux userspace, one could do it just by adding a CIL module
>>>> locally.
>>>
>>>
>>> Thanks, Stephen!
>>>
>>> I would like to understand first if failing mount(2) for unknown fs is
>>> selinux bug or not. Because if it is and it is fixed, then it would
>>> resolve the problem without actually doing anything (well, at least on
>>> our side :)).
>>
>>
>> Yes, I think that's a selinux kernel regression, previously reported here:
>> https://lkml.org/lkml/2017/10/6/658
>>
>> Unfortunately I don't think it has been fixed upstream.  Generally people
>> using SELinux with a newer kernel are also using a newer policy. That said,
>> I agree it is a regression and ought to be fixed.
> 
> 
> How hard is it to fix it? We are on upstream head, so once it's in we
> are ready to go.
> Using multiple images is somewhat problematic (besides the fact that I
> don't know how to build a fedora image) because syzbot does not
> capture what image was used, and in the docs we just provide the
> single image, so people will start complaining that bugs don't
> reproduce but they are just using a wrong image.

I'll take a look and see if I can provide a trivial fix.
