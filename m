Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6FLp84K006145
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 17:51:08 -0400
Received: by laem6 with SMTP id m6so32724001lae.0
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 14:51:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150715214848.GA24204@mail.hallyn.com>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 15 Jul 2015 14:50:46 -0700
Message-ID: <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
To: "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset=UTF-8
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 2:48 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> On Wed, Jul 15, 2015 at 02:46:04PM -0500, Seth Forshee wrote:
>> Capability sets attached to files must be ignored except in the
>> user namespaces where the mounter is privileged, i.e. s_user_ns
>> and its descendants. Otherwise a vector exists for gaining
>> privileges in namespaces where a user is not already privileged.
>>
>> Add a new helper function, in_user_ns(), to test whether a user
>> namespace is the same as or a descendant of another namespace.
>> Use this helper to determine whether a file's capability set
>> should be applied to the caps constructed during exec.
>>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>
> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
>
> I think it's an ok behavior, though let's just go over the
> alternatives.
>
> It might actually be ok to simply require that the user_ns be
> equal.  If I unshare a new userns in which a different uid is
> mapped to root, I may not want file capabilities to be granted
> to tasks in that ns.  (On the other hand, I might be creating
> a new user_ns specifically to not have a uid 0 mapped into it
> at all, and only have file capabilities grant privilege)
>
> Conversely, if I unshare one user_ns with a MS_SHARED mnt_ns, mount
> an ext4fs, and then (from the parent shell) unshare another user_ns
> with the same mapping, intending it to be a "peer" to the first one
> I'd unshared and be able to use the ext4fs it mounted.  This won't
> work here.  That's probably best - the appropriate thing to do was
> to attach to the existing user_ns.  But it could end up being
> limiting in some special cases, so I'm bringing it up here.
>
> Again I think what you have here is the simplest and most sensible
> choice, so ack.
>

I think I'm missing something.  Why is this separate from mount_may_suid?

I can see why it would make sense to check s_user_ns (or maybe
s_user_ns *and* the vfsmount namespace) in mount_may_suid, but I don't
see why we need separate checks.

--Andy
