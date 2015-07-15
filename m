Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FLD5Lv003644
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 17:13:05 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com>
Date: Wed, 15 Jul 2015 16:06:35 -0500
In-Reply-To: <55A6C448.5050902@schaufler-ca.com> (Casey Schaufler's message of
 "Wed, 15 Jul 2015 13:36:24 -0700")
Message-ID: <87vbdlf7vo.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 7/15/2015 12:46 PM, Seth Forshee wrote:
>> These are the first in a larger set of patches that I've been working on
>> (with help from Eric Biederman) to support mounting ext4 and fuse
>> filesystems from within user namespaces. I've pushed the full series to:
>>
>>   git://kernel.ubuntu.com/sforshee/linux.git userns-mounts
>>
>> Taking the series as a whole, the strategy is to handle as much of the
>> heavy lifting as possible in the vfs so the filesystems don't have to
>> handle weird edge cases. If you look at the full series you'll find that
>> the changes in ext4 to support user namespace mounts turn out to be
>> fairly minimal (fuse is a bit more complicated though as it must deal
>> with translating ids for a userspace process which is running in pid and
>> user namespaces).
>>
>> The patches I'm sending today lay some of the groundwork in the vfs and
>> related code. They fall into two broad groups:
>>
>>  1. Patches 1-2 add s_user_ns and simplify MNT_NODEV handling. These are
>>     pretty straightforward, and Eric has expressed interest in merging
>>     these patches soon. Note that patch 2 won't apply cleanly without
>>     Eric's noexec patches for proc and sys [1].
>>
>>  2. Patches 2-7 tighten down security for mounts with s_user_ns !=
>>     &init_user_ns. This includes updates to how file caps and suid are
>>     handled and LSM updates to ignore security labels on superblocks
>>     from non-init namespaces.
>>
>>     The LSM changes in particular may not be optimal, as I don't have a
>>     lot of familiarity with this code, so I'd be especially appreciative
>>     of review of these changes and suggestions on how to improve them.
>
> Lukasz Pawelczyk <l.pawelczyk@samsung.com> proposed
> LSM support in user namespaces ([RFC] lsm: namespace hooks)
> that make a whole lot more sense than just turning off
> the option of using labels on files. Gutting the ability
> to use MAC in a namespace is a step down the road of
> making MAC and namespaces incompatible.

This is not "turning off the option to use labels on files".

This is supporting mounting filesystems like ext4 by unprivileged users
and not trusting the labels they set in the same way as we trust labels
on filesystems mounted by privileged users.

The first step needs to be not trusting those labels and treating such
filesystems as filesystems without label support.  I hope that is Seth
has implemented.

In the long run we can do more interesting things with such filesystems
once the appropriate LSM policy is in place.

Getting s_user_ns present on struct super, properly set, and all of the
appropriate checks against it present in the vfs so that filesystems
don't need to duplicate logic is important if we are going do more
interesting things with user namespaces (as users have been asking for).

It is important for things as small as making it safe to allow
truly unprivileged users to mount fuse filesystems.

I am on the fence with Lukasz Pawelczyk's patches.  Some parts I liked
some parts I had issues with.  As I recall one of my issues was that
those patches conflicted in detail if not in principle with this
appropach.

If these patches do not do a good job of laying the ground work for
supporting security labels that unprivileged users can set than Seth
could really use some feedback.  Figuring out how to properly deal with
the LSMs has been one of his challenges.

I am hoping I can finishing working through the patches to fix the
semantics of rename and bind mounts before the next merge window opens,
so I can have enough cycles to lift the feature freeze on user
namespaces.  Except for maybe his first two patches (which fix a small
userspace API breakage) none of Seth's patches get to go in until I lift
the freeze.

Which is probably too much information but I hope this makes it clear
that the point of this work is as an enabler for future developments,
not as something to make user namespaces and LSMs incompatible.

Eric
