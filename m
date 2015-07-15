Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FN4uqi010614
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 19:04:56 -0400
Message-ID: <55A6E708.2050405@schaufler-ca.com>
Date: Wed, 15 Jul 2015 16:04:40 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com> <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <20150715214813.GB76420@ubuntu-hedt>
In-Reply-To: <20150715214813.GB76420@ubuntu-hedt>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/15/2015 2:48 PM, Seth Forshee wrote:
> On Wed, Jul 15, 2015 at 04:06:35PM -0500, Eric W. Biederman wrote:
>> Casey Schaufler <casey@schaufler-ca.com> writes:
>>
>>> On 7/15/2015 12:46 PM, Seth Forshee wrote:
>>>> These are the first in a larger set of patches that I've been working on
>>>> (with help from Eric Biederman) to support mounting ext4 and fuse
>>>> filesystems from within user namespaces. I've pushed the full series to:
>>>>
>>>>   git://kernel.ubuntu.com/sforshee/linux.git userns-mounts
>>>>
>>>> Taking the series as a whole, the strategy is to handle as much of the
>>>> heavy lifting as possible in the vfs so the filesystems don't have to
>>>> handle weird edge cases. If you look at the full series you'll find that
>>>> the changes in ext4 to support user namespace mounts turn out to be
>>>> fairly minimal (fuse is a bit more complicated though as it must deal
>>>> with translating ids for a userspace process which is running in pid and
>>>> user namespaces).
>>>>
>>>> The patches I'm sending today lay some of the groundwork in the vfs and
>>>> related code. They fall into two broad groups:
>>>>
>>>>  1. Patches 1-2 add s_user_ns and simplify MNT_NODEV handling. These are
>>>>     pretty straightforward, and Eric has expressed interest in merging
>>>>     these patches soon. Note that patch 2 won't apply cleanly without
>>>>     Eric's noexec patches for proc and sys [1].
>>>>
>>>>  2. Patches 2-7 tighten down security for mounts with s_user_ns !=
>>>>     &init_user_ns. This includes updates to how file caps and suid are
>>>>     handled and LSM updates to ignore security labels on superblocks
>>>>     from non-init namespaces.
>>>>
>>>>     The LSM changes in particular may not be optimal, as I don't have a
>>>>     lot of familiarity with this code, so I'd be especially appreciative
>>>>     of review of these changes and suggestions on how to improve them.
>>> Lukasz Pawelczyk <l.pawelczyk@samsung.com> proposed
>>> LSM support in user namespaces ([RFC] lsm: namespace hooks)
>>> that make a whole lot more sense than just turning off
>>> the option of using labels on files. Gutting the ability
>>> to use MAC in a namespace is a step down the road of
>>> making MAC and namespaces incompatible.
>> This is not "turning off the option to use labels on files".
>>
>> This is supporting mounting filesystems like ext4 by unprivileged users
>> and not trusting the labels they set in the same way as we trust labels
>> on filesystems mounted by privileged users.
>>
>> The first step needs to be not trusting those labels and treating such
>> filesystems as filesystems without label support.  I hope that is Seth
>> has implemented.
>>
>> In the long run we can do more interesting things with such filesystems
>> once the appropriate LSM policy is in place.
> Yes, this exactly. Right now it looks to me like the only safe thing to
> do with mounts from unprivileged users is to ignore the security labels,
> so that's what I'm trying to do with these changes. If there's some
> better thing to do, or some better way to do it, I'm more than happy to
> receive that feedback.

If you ignore Smack labels you get a system that is broken.
Without specifying Smack mount options (requires CAP_MAC_ADMIN)
all your files will be labeled with the floor ("_") label. Unless
you're running with the floor label (Smack systems generally don't)
there won't be anything you can write to. You will be able to read
everything, which is also something you're unlikely to want. Like
I said, broken.

Personally, I don't believe that the goal of supporting
unprivileged mounts is especially sane. I am willing to
be educated, but I don't see a rational solution.

> Seth
