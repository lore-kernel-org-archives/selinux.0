Received: from goalie.tycho.ncsc.mil (goalie.tycho.ncsc.mil [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w938IILw032645
 for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2018 04:18:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id w81-v6so3782138oiw.9
 for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2018 01:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181002111830.26342-1-omosnace@redhat.com>
 <20181002155810.GP32577@ZenIV.linux.org.uk>
In-Reply-To: <20181002155810.GP32577@ZenIV.linux.org.uk>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 3 Oct 2018 10:18:02 +0200
Message-ID: <CAFqZXNt08odr+3mqQFNk4Jt74e0JSotOjLEUpr8OUfJx1nDfgA@mail.gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: SElinux list <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: fix race when removing selinuxfs
 entries
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Al,

On Tue, Oct 2, 2018 at 5:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Oct 02, 2018 at 01:18:30PM +0200, Ondrej Mosnacek wrote:
>
> No.  With the side of Hell, No.  The bug is real, but this is
> not the way to fix it.
>
> First of all, it's still broken - e.g. mount something on a
> subdirectory and watch what that thing will do to it.  And
> anyone who has permission to reload policy _will_ have one
> for mount.

I have no doubts there are still tons of bugs left over, but having
processes traverse selinuxfs while load_policy is in progress is
something that can (and will) easily happen in practice. Mounting over
an selinuxfs subdirectory OTOH isn't something that you would normally
do. I think it is worth doing a quick but partial fix that fixes a
practical problem and then working towards a better long-term
solution.

I feel like you are assuming that I am trying to fix some security
problem here, but that's not true. It *may* be seen as a security
issue, but as you point out having permission to load policy will
usually imply you can do other kinds of damage anyway. I simply see
this as an annoying real-life bug (I know of at least one user that
is/was affected) that I want to fix (even if not in a perfect way for
now).

>
> And yes, debugfs_remove() suffers the same problem.  Frankly, the
> only wish debugfs_remove() implementation inspires is to shoot it
> before it breeds.  Which is the second problem with that approach -
> such stuff really shouldn't be duplicated in individual filesystems.
>
> Don't copy (let along open-code) d_walk() in there.  The guts of
> dcache tree handling are subtle enough (and had more than enough
> locking bugs over the years) to make spreading the dependencies
> on its details all over the tree an invitation for massive PITA
> down the road.

Right, I am now convinced that it is not a good idea at all. The
thought of adding a new function to dcache has crossed my mind, but I
dismissed it as I didn't want to needlessly touch other parts of the
kernel. Looking back now, it would have been a better choice indeed.

>
> I have beginnings of patch doing that for debugfs; the same thing
> should be usable for selinuxfs as well.  However, the main problem
> with selinuxfs wrt policy loading is different - what to do if
> sel_make_policy_nodes() fails halfway through?  And what to do
> with accesses to the unholy mix of old and new nodes we currently
> have left behind?

Again, this a big problem, too, but out of the scope I care about right now.

>
> Before security_load_policy() we don't know which nodes to create;
> after it we have nothing to fall back onto.  It looks like we
> need to split security_load_policy() into "load", "switch over" and
> "free old" parts, so that the whole thing would look like
>         load
>         create new directory trees, unconnected to the root so
> they couldn't be reached by lookups until we are done
>         switch over
>         move the new directory trees in place
>         kill the old trees (using that invalidate+genocide carefully
> combination)
>         free old data structures
> with failures upon the first two steps handled by killing whatever detached
> trees we'd created (if any) and freeing the new data structures.
>
> However, I'd really like to have the folks familiar with selinux guts to
> comment upon the feasibility of the above.  AFAICS, nobody has ever seriously
> looked at that code wrt graceful error handling, etc.[*], so I'm not happy
> with making inferences from what the existing code is doing.

Yes, that sounds like it could work. I'd be willing to work on that as
a longer term solution. Let's hope we get some feedback from them.

>
> If you are interested in getting selinuxfs into sane shape, that would
> be a good place to start.  As for the kernel-side rm -rf (which is what
> debugfs_remove() et.al. are trying to be)...
>         * it absolutely needs to be in fs/*.c - either dcache or libfs.
> It's too closely tied to dcache guts to do otherwise.
>         * as the first step it needs to do d_invalidate(), to get rid of
> anything that might be mounted on it and to prevent new mounts from appearing.
> It's rather tempting to unhash everything in the victim tree at the same
> time, but that needs to be done with care - I'm still not entirely happy
> with the solution I've got in that area.  Alternative is to unhash them
> on the way out of subtree.  simple_unlink()/simple_rmdir() are wrong
> there - we don't want to bother with the parent's timestamps as we go,
> for one thing; that should be done only once to parent of the root of
> that subtree.  For another, we bloody well enforce the emptiness ourselves,
> so this simple_empty() is pointless (especially since we have no choice other
> than ignoring it anyway).

Right, I was suspicious about the simple_*() functions anyway, I
simply wanted to stay close to what the old code and debugfs were
doing (turns out they were both wrong anyway).

So, it sounds like you are already working on a better fix... Should I
wait for your patch(es) or should I try again? There is no rush, I
just want to know if it makes sense for me to still work on it :)

>
> BTW, another selinuxfs unpleasantness is, the things like sel_write_enforce()
> don't have any exclusion against themselves, let alone the policy reloads.
> And quite a few of them obviously expect that e.g. permission check is done
> against the same policy the operation will apply to, not the previous one.
> That one definitely needs selinux folks involved.
>
> [*] not too unreasonably so - anyone who gets to use _that_ as an attack
> vector has already won, so it's not a security problem pretty much by
> definition and running into heavy OOM at the time of policy reload is
> almost certainly going to end up with the userland parts of the entire
> thing not handling failures gracefully.

Thanks a lot for your comments!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
