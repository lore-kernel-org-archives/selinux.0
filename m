Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FMfrvN009282
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 18:41:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Lutomirski <luto@amacapital.net>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
Date: Wed, 15 Jul 2015 17:35:24 -0500
In-Reply-To: <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 (Andy Lutomirski's message of "Wed, 15 Jul 2015 14:50:46 -0700")
Message-ID: <87wpy1camr.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Andy Lutomirski <luto@amacapital.net> writes:

> On Wed, Jul 15, 2015 at 2:48 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> On Wed, Jul 15, 2015 at 02:46:04PM -0500, Seth Forshee wrote:
>>> Capability sets attached to files must be ignored except in the
>>> user namespaces where the mounter is privileged, i.e. s_user_ns
>>> and its descendants. Otherwise a vector exists for gaining
>>> privileges in namespaces where a user is not already privileged.
>>>
>>> Add a new helper function, in_user_ns(), to test whether a user
>>> namespace is the same as or a descendant of another namespace.
>>> Use this helper to determine whether a file's capability set
>>> should be applied to the caps constructed during exec.
>>>
>>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>>
>> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
>>
>> I think it's an ok behavior, though let's just go over the
>> alternatives.
>>
>> It might actually be ok to simply require that the user_ns be
>> equal.  If I unshare a new userns in which a different uid is
>> mapped to root, I may not want file capabilities to be granted
>> to tasks in that ns.  (On the other hand, I might be creating
>> a new user_ns specifically to not have a uid 0 mapped into it
>> at all, and only have file capabilities grant privilege)
>>
>> Conversely, if I unshare one user_ns with a MS_SHARED mnt_ns, mount
>> an ext4fs, and then (from the parent shell) unshare another user_ns
>> with the same mapping, intending it to be a "peer" to the first one
>> I'd unshared and be able to use the ext4fs it mounted.  This won't
>> work here.  That's probably best - the appropriate thing to do was
>> to attach to the existing user_ns.  But it could end up being
>> limiting in some special cases, so I'm bringing it up here.
>>
>> Again I think what you have here is the simplest and most sensible
>> choice, so ack.
>>
>
> I think I'm missing something.  Why is this separate from mount_may_suid?
>
> I can see why it would make sense to check s_user_ns (or maybe
> s_user_ns *and* the vfsmount namespace) in mount_may_suid, but I don't
> see why we need separate checks.

So I don't quite understand your concerns that lead to the mnt_may_suid
patch.  But in my limited understanding there are two distinct issues.

1) What do file capabilities mean on a filesystem mounted with user
   namespace privileges.  Where the unprivileged user can control what
   resides on disk.

   That is what this patch should be about.

   Meaning and restricting those permissions to unprivileged users.

2) The second issue that I think your mnt_may_suid patch is about seems
   to be what to do if a mount winds up in a place we never intended.

   Aka leaks.  I don't think any changes to mnt_may_suid are necessary
   in that sense.  However they may be useful.

   So I think your mnt_may_suid change may be worth having but so far it
   seems unnecessary.

Which is a long way of saying this patch is fundamentally necessary,
and I am not certain about  the mnt_may_suid patch.

Am I right in understanding it's purpose?  Or does this patch actually
succeed in obsoleting it?

Eric
