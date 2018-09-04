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
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
Date: Tue, 4 Sep 2018 08:57:15 -0400
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: WARNING in apparmor_secid_to_secctx
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/31/2018 06:38 PM, Dmitry Vyukov wrote:
> On Fri, Aug 31, 2018 at 9:17 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 08/31/2018 12:16 PM, Stephen Smalley wrote:
>>>
>>> On 08/31/2018 12:07 PM, Paul Moore wrote:
>>>>
>>>> On Fri, Aug 31, 2018 at 12:01 PM Stephen Smalley <sds@tycho.nsa.gov>
>>>> wrote:
>>>>>
>>>>> On 08/29/2018 10:21 PM, Dmitry Vyukov wrote:
>>>>>>
>>>>>> On Wed, Aug 29, 2018 at 7:17 PM, syzbot
>>>>>> <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com> wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> syzbot found the following crash on:
>>>>>>>
>>>>>>> HEAD commit:    817e60a7a2bb Merge branch 'nfp-add-NFP5000-support'
>>>>>>> git tree:       net-next
>>>>>>> console output:
>>>>>>> https://syzkaller.appspot.com/x/log.txt?x=1536d296400000
>>>>>>> kernel config:
>>>>>>> https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
>>>>>>> dashboard link:
>>>>>>> https://syzkaller.appspot.com/bug?extid=21016130b0580a9de3b5
>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>
>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>
>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>>> commit:
>>>>>>> Reported-by: syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com
>>>>>>
>>>>>>
>>>>>> Hi John, Tyler,
>>>>>>
>>>>>> I've switched syzbot from selinux to apparmor as we discussed on lss:
>>>>>>
>>>>>> https://github.com/google/syzkaller/commit/2c6cb254ae6c06f61e3aba21bb89ffb05b5db946
>>>>>
>>>>>
>>>>> Sorry, does this mean that you are no longer testing selinux via syzbot?
>>>>>     That seems unfortunate.  SELinux is default-enabled and used in
>>>>> Fedora, RHEL and all derivatives (e.g. CentOS), and mandatory in Android
>>>>> (and seemingly getting some use in ChromeOS now as well, at least for
>>>>> the Android container and possibly wider), so it seems unwise to drop it
>>>>> from your testing altogether.  I was under the impression that you were
>>>>> just going to add apparmor to your testing matrix, not drop selinux
>>>>> altogether.
>>>>
>>>>
>>>> It is also important to note that testing with SELinux enabled but no
>>>> policy loaded is not going to be very helpful (last we talked that is
>>>> what syzbot is/was doing).  While syzbot did uncover some issues
>>>> relating to the enabled-no-policy case, those are much less
>>>> interesting and less relevant than the loaded-policy case.
>>>
>>>
>>> I had thought that they had switched over to at least loading a policy but
>>> possibly left it in permissive mode because the base distribution didn't
>>> properly support SELinux out of the box.  But I may be mistaken.
>>> Regardless, the right solution is to migrate to testing with a policy
>>> loaded not to stop testing altogether.
>>>
>>> Optimally, they'd test on at least one distribution/OS where SELinux is in
>>> fact supported out of the box, e.g. CentOS, Android, and/or ChromeOS.
>>
>>
>> Or Fedora, of course.
> 
> Hi,
> 
> Yes, we switched from selinux to apparmor. The thing is that we
> effectively did not test selinux lately, so it's more like just
> enabling apparmor rather than disabling selinux.
> 
> The story goes as follows.
> We enabled selinux, but did not have policy and selinux wasn't enabled.
> Then Paul (I think) pointer that out. After some debugging I figured
> out that our debian wheezy actually has a policy, it's just that
> selinux utilities were not installed, so init could not load the
> policy.
> I installed the tools, and we started loading policy.
> But then it turned out that wheezy policy does not allows mounting
> cgroup2 fs and maybe some others even in non-enforcing mode. As far as
> I understand that's because the policy does not have definition for
> the fs, and so loading bails out with an error.
> We need cgroup2 both for testing and for better sandboxing (no other
> way to restrict e.g. memory consumption). Moreover, we did not test
> any actual interesting interactions with selinux (there must be some?
> but I don't know what are they).
> So I had to uninstall the tool and policy is not loaded again.
> I investigated building a newer debian image with debootstrap (which
> should have newer policy I guess). But they don't work, some cryptic
> errors in init. Other people reported the same.
> So that's we are. I don't have any ideas left...

So why not ask for help from the SELinux community?  I've cc'd the 
selinux list and a couple of folks involved in Debian selinux.  I see a 
couple of options but I don't know your constraints for syzbot:

1) Run an instance of syzbot on a distro that supports SELinux enabled 
out of the box like Fedora. Then you don't have to fight with SELinux 
and can just focus on syzbot, while still testing SELinux enabled and 
enforcing.

2) Report the problems you are having with enabling SELinux on newer 
Debian to the selinux list and/or the Debian selinux package maintainers 
so that someone can help you resolve them.

3) Back-port the cgroup2 policy definitions to your wheezy policy, 
rebuild it, and install that.  We could help provide guidance on that. 
I think you'll need to rebuild the base policy on wheezy; in 
distributions with modern SELinux userspace, one could do it just by 
adding a CIL module locally.

As for exercising SELinux, you'll exercise SELinux just by enabling it 
and loading a policy, since it will perform permission checking on all 
object accesses.   But you can get more extensive coverage by running 
the selinux-testsuite.  We only test that on Fedora and RHEL however, so 
getting it to work on Debian might take some effort.
