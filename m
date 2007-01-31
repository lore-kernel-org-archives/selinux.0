Subject: Re: provoking fsetfilecon failure in a test case
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>
In-Reply-To: <87iren6rag.fsf@rho.meyering.net>
References: <87y7nk8g3a.fsf@rho.meyering.net>
	 <1170261007.12293.64.camel@moss-spartans.epoch.ncsc.mil>
	 <87iren6rag.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 13:25:27 -0500
Message-Id: <1170267927.12293.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-31 at 18:26 +0100, Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > On Tue, 2007-01-30 at 20:33 +0100, Jim Meyering wrote:
> >> I'm adding a test case for the 'cp -a' failure reported here:
> >>
> >>   http://bugzilla.redhat.com/219900
> >>
> >> In my comment there, I asked this:
> >>
> >>   I'd like to add a test script to exercise this fix, but depending on
> >>   the existence of a writable, NFS-mounted partition is not a recipe for
> >>   good coverage. Can anyone suggest an easier way to provoke fsetfilecon
> >>   failure on a file we've just opened (but not created -- it already
> >>   existed) for writing?
> >>
> >> Any ideas?
> >
> > fsetfilecon will fail if any of the following apply:
> > - the filesystem was mounted with a context= option or the filesystem
> > doesn't support setxattr for the security namespace (EOPNOTSUPP),
> > - the process fsuid doesn't match the file's uid and the process lacks
> > CAP_FOWNER (EPERM),
> > - the process lacks relabelfrom permission to the old file context,
> > - the new context isn't valid (EINVAL),
> > - the process lacks relabelto permission to the new file context,
> > - the relationship between the old and new file contexts violates a
> > validatetrans constraint,
> > - the new file context is not allowed to be associated with the
> > filesystem context.
> 
> Thank you for the reply.
> In the interest of reproducing the conditions of the "cp -a" failure
> for my test script, I'd prefer to run as non-root: far fewer users run
> coreutils' root-requiring tests.  But so far, even with your list above,
> unless the test can find a writable NFS partition, it looks like having
> a non-root test is not feasible.  Can you see a way?

Only by running the test in a confined domain that lacks the necessary
permissions to the file type.  Which would either require finding a
suitable domain to which you can transition in the existing policy or
creating a small test policy module (which would have to be preloaded by
a root process, of course).

> However, I've just confirmed that I can reproduce the conditions
> (as root, of course) by creating a temporary partition mounted via
> "mount -oloop,context=system_u:object_r:removable_t".  So at least
> a root-only test won't also require NFS.
> 
> Interestingly, when trying to copy one file from that
> partition to another location on the same partition, fsetxattr
> failed to set the context of the destination file, even though
> the desired context is the default one (specified by context=... above).
> Would it make sense to allow fsetxattr to succeed in that special case?
> Probably not, just as it's probably not right for cp to detect
> the condition and skip the fsetxattr call.

I would tend to say no, as the attribute hasn't been set in any
persistent sense and if the filesystem were later mounted with a
different context=, it wouldn't be preserved.

>     $ echo foo > f; cp f ff; /bin/cp -a f ff; ls -ng f ff
>     -rw-r--r-- 1 4 Jan 31 18:03 f
>     -rw-r--r-- 1 0 Jan 31 18:03 ff
>     $ echo foo > f; cp f ff; $cp --preserve=context f ff; ls -l f ff
>     /t/coreutils-6.7-dirty/src/cp: failed to set the security context of `ff' \
>         to `user_u:object_r:removable_t': Operation not supported
>     -rw-r--r-- 1 4 Jan 31 18:08 f
>     -rw-r--r-- 1 0 Jan 31 18:08 ff
>     $ echo foo > f; cp f ff; $cp -a f ff; ls -ng f ff
>     -rw-r--r-- 1 4 Jan 31 18:08 f
>     -rw-r--r-- 1 4 Jan 31 18:08 ff
>     $ /t/coreutils-6.7-dirty/src/ls -1Z f ff
>     user_u:object_r:removable_t f
>     user_u:object_r:removable_t ff


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
