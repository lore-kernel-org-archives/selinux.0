Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6G1FE4k017304
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 21:15:14 -0400
Received: by oige126 with SMTP id e126so40735408oig.0
 for <selinux@tycho.nsa.gov>; Wed, 15 Jul 2015 18:15:12 -0700 (PDT)
Date: Wed, 15 Jul 2015 20:14:10 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/7] fs: Ignore file caps in mounts from other user
 namespaces
Message-ID: <20150716011410.GA74046@ubuntu-hedt>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-4-git-send-email-seth.forshee@canonical.com>
 <20150715214848.GA24204@mail.hallyn.com>
 <CALCETrVTGC8NJdpOhkqDaE8HdD95y-K2-VnsL+Oo4NjVUyovsA@mail.gmail.com>
 <87wpy1camr.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wpy1camr.fsf@x220.int.ebiederm.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 15, 2015 at 05:35:24PM -0500, Eric W. Biederman wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
> 
> > On Wed, Jul 15, 2015 at 2:48 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >> On Wed, Jul 15, 2015 at 02:46:04PM -0500, Seth Forshee wrote:
> >>> Capability sets attached to files must be ignored except in the
> >>> user namespaces where the mounter is privileged, i.e. s_user_ns
> >>> and its descendants. Otherwise a vector exists for gaining
> >>> privileges in namespaces where a user is not already privileged.
> >>>
> >>> Add a new helper function, in_user_ns(), to test whether a user
> >>> namespace is the same as or a descendant of another namespace.
> >>> Use this helper to determine whether a file's capability set
> >>> should be applied to the caps constructed during exec.
> >>>
> >>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> >>
> >> Acked-by: Serge Hallyn <serge.hallyn@canonical.com>
> >>
> >> I think it's an ok behavior, though let's just go over the
> >> alternatives.
> >>
> >> It might actually be ok to simply require that the user_ns be
> >> equal.  If I unshare a new userns in which a different uid is
> >> mapped to root, I may not want file capabilities to be granted
> >> to tasks in that ns.  (On the other hand, I might be creating
> >> a new user_ns specifically to not have a uid 0 mapped into it
> >> at all, and only have file capabilities grant privilege)
> >>
> >> Conversely, if I unshare one user_ns with a MS_SHARED mnt_ns, mount
> >> an ext4fs, and then (from the parent shell) unshare another user_ns
> >> with the same mapping, intending it to be a "peer" to the first one
> >> I'd unshared and be able to use the ext4fs it mounted.  This won't
> >> work here.  That's probably best - the appropriate thing to do was
> >> to attach to the existing user_ns.  But it could end up being
> >> limiting in some special cases, so I'm bringing it up here.
> >>
> >> Again I think what you have here is the simplest and most sensible
> >> choice, so ack.
> >>
> >
> > I think I'm missing something.  Why is this separate from mount_may_suid?
> >
> > I can see why it would make sense to check s_user_ns (or maybe
> > s_user_ns *and* the vfsmount namespace) in mount_may_suid, but I don't
> > see why we need separate checks.
> 
> So I don't quite understand your concerns that lead to the mnt_may_suid
> patch.  But in my limited understanding there are two distinct issues.
> 
> 1) What do file capabilities mean on a filesystem mounted with user
>    namespace privileges.  Where the unprivileged user can control what
>    resides on disk.
> 
>    That is what this patch should be about.
> 
>    Meaning and restricting those permissions to unprivileged users.
> 
> 2) The second issue that I think your mnt_may_suid patch is about seems
>    to be what to do if a mount winds up in a place we never intended.
> 
>    Aka leaks.  I don't think any changes to mnt_may_suid are necessary
>    in that sense.  However they may be useful.
> 
>    So I think your mnt_may_suid change may be worth having but so far it
>    seems unnecessary.
> 
> Which is a long way of saying this patch is fundamentally necessary,
> and I am not certain about  the mnt_may_suid patch.
> 
> Am I right in understanding it's purpose?  Or does this patch actually
> succeed in obsoleting it?

The only part that's absolutely needed is the restriction on file caps,
otherwise it will be trivial to get root through a user namespace mount.
I've become convinced that the safest and most logical thing to do is to
restrict file capabilites to the user namespaces where the mounter
already has privileges, which is what the patch does.

mnt_may_suid would also restrict the namespaces where the capabilities
would be honored, but not to only namespaces where the mounter is
already privileged. Of course it does require a user privileged in
another namespace to perform a mount, but that still leaves me feeling a
bit uncomfortable.

suid doesn't require quite so strict a check because (jumping ahead to
the patches I haven't sent yet) ids in a user namespace mount of a
normal filesystem are constrained to ids in that namespace. So users
could only exploit this to suid to ids they already control, or if they
managed to somehow bypass other kernel protections they could possibly
gain access to user ns mounts belonging to another user.

So if we have the s_user_ns check in get_file_caps the mnt_may_suid pass
isn't strictly necessary, but I still think it is useful as a mitigation
to the "leaks" Eric mentions. It _should_ be impossible for a user to
gain access to another user's mount namespace, and it _should_ be
impossible for a user to clear MNT_NOSUID in a bind mount from
init_user_ns. But if someone does find a way to do either then the patch
stops them from being able to gain privileges via suid, and I think
that's worth adding the check.

Andy alludes to the possibility of checking s_user_ns or both s_user_ns
and the mount namespace in mnt_may_suid, and those are certainly
possibilities that would work equally well (though checking both is
probably unnecessary). One thing I came away with from conversing with
Eric though is that he wants to see a clear and explicit check in
get_file_caps, not something implicit from may_mnt_suid. And I can see
his point - there is a concern with file capabilities independent of the
question of whether suid is allowed, and having a separate check does
make that clearer.

Seth
