Message-ID: <55A7ADD0.9040002@tycho.nsa.gov>
Date: Thu, 16 Jul 2015 09:12:48 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com> <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <20150715214813.GB76420@ubuntu-hedt> <87wpy1dpjg.fsf@x220.int.ebiederm.org>
 <CALCETrXhVtR3oCPPHK1CfswBZNzMFYJAvdQr8FeckxWF-1A-NA@mail.gmail.com>
In-Reply-To: <CALCETrXhVtR3oCPPHK1CfswBZNzMFYJAvdQr8FeckxWF-1A-NA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/15/2015 09:05 PM, Andy Lutomirski wrote:
> On Jul 15, 2015 3:34 PM, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>>
>> Seth Forshee <seth.forshee@canonical.com> writes:
>>
>>> On Wed, Jul 15, 2015 at 04:06:35PM -0500, Eric W. Biederman wrote:
>>>> Casey Schaufler <casey@schaufler-ca.com> writes:
>>>>
>>>>> On 7/15/2015 12:46 PM, Seth Forshee wrote:
>>>>>> These are the first in a larger set of patches that I've been working on
>>>>>> (with help from Eric Biederman) to support mounting ext4 and fuse
>>>>>> filesystems from within user namespaces. I've pushed the full series to:
>>>>>>
>>>>>>   git://kernel.ubuntu.com/sforshee/linux.git userns-mounts
>>>>>>
>>>>>> Taking the series as a whole, the strategy is to handle as much of the
>>>>>> heavy lifting as possible in the vfs so the filesystems don't have to
>>>>>> handle weird edge cases. If you look at the full series you'll find that
>>>>>> the changes in ext4 to support user namespace mounts turn out to be
>>>>>> fairly minimal (fuse is a bit more complicated though as it must deal
>>>>>> with translating ids for a userspace process which is running in pid and
>>>>>> user namespaces).
>>>>>>
>>>>>> The patches I'm sending today lay some of the groundwork in the vfs and
>>>>>> related code. They fall into two broad groups:
>>>>>>
>>>>>>  1. Patches 1-2 add s_user_ns and simplify MNT_NODEV handling. These are
>>>>>>     pretty straightforward, and Eric has expressed interest in merging
>>>>>>     these patches soon. Note that patch 2 won't apply cleanly without
>>>>>>     Eric's noexec patches for proc and sys [1].
>>>>>>
>>>>>>  2. Patches 2-7 tighten down security for mounts with s_user_ns !=
>>>>>>     &init_user_ns. This includes updates to how file caps and suid are
>>>>>>     handled and LSM updates to ignore security labels on superblocks
>>>>>>     from non-init namespaces.
>>>>>>
>>>>>>     The LSM changes in particular may not be optimal, as I don't have a
>>>>>>     lot of familiarity with this code, so I'd be especially appreciative
>>>>>>     of review of these changes and suggestions on how to improve them.
>>>>>
>>>>> Lukasz Pawelczyk <l.pawelczyk@samsung.com> proposed
>>>>> LSM support in user namespaces ([RFC] lsm: namespace hooks)
>>>>> that make a whole lot more sense than just turning off
>>>>> the option of using labels on files. Gutting the ability
>>>>> to use MAC in a namespace is a step down the road of
>>>>> making MAC and namespaces incompatible.
>>>>
>>>> This is not "turning off the option to use labels on files".
>>>>
>>>> This is supporting mounting filesystems like ext4 by unprivileged users
>>>> and not trusting the labels they set in the same way as we trust labels
>>>> on filesystems mounted by privileged users.
>>>>
>>>> The first step needs to be not trusting those labels and treating such
>>>> filesystems as filesystems without label support.  I hope that is Seth
>>>> has implemented.
>>>>
>>>> In the long run we can do more interesting things with such filesystems
>>>> once the appropriate LSM policy is in place.
>>>
>>> Yes, this exactly. Right now it looks to me like the only safe thing to
>>> do with mounts from unprivileged users is to ignore the security labels,
>>> so that's what I'm trying to do with these changes. If there's some
>>> better thing to do, or some better way to do it, I'm more than happy to
>>> receive that feedback.
>>
>> Ugh.
>>
>> This made me realize that we have an interesting problem here.  An
>> unprivileged mount of tmpfs probably needs to have
>> s_user_ns == &init_user_ns.
>>
>> Otherwise we will break security labels on tmpfs for no good reason.
>> ramfs and sysfs also seem to have similar concerns.
>>
>> Because they have no backing store we can trust those filesystems with
>> security labels.  Plus for at least sysfs there is the security label
>> bleed through issue, that we need to make certain works.
>>
>> Perhaps these filesystems with trusted backing store need to call
>> "sget_userns(..., &init_user_ns)".
>>
>> If we don't get this right we will have significant regressions with
>> respect to security labels, and that is not ok.
> 
> That's only a problem if there's anyone who sets security labels on
> such a mount.  You need global caps to do that (I hope), which
> requires someone outside the userns to help, which means there's a
> good chance that literally no one does this.

Setting of security.selinux attributes is governed by SELinux permission
checks, not by capabilities.

Also, files are always assigned a label at creation time; a tmpfs inode
will be labeled based on its creator without any userspace entity ever
calling setxattr() at all.
