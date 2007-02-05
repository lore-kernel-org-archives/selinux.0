Subject: Re: provoking fsetfilecon failure in a test case
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>
In-Reply-To: <873b5q7ui6.fsf@rho.meyering.net>
References: <87y7nk8g3a.fsf@rho.meyering.net>
	 <1170261007.12293.64.camel@moss-spartans.epoch.ncsc.mil>
	 <87iren6rag.fsf@rho.meyering.net>
	 <1170267927.12293.89.camel@moss-spartans.epoch.ncsc.mil>
	 <873b5q7ui6.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 09:48:30 -0500
Message-Id: <1170686910.12293.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-31 at 22:32 +0100, Jim Meyering wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2007-01-31 at 18:26 +0100, Jim Meyering wrote:
> ...
> >> In the interest of reproducing the conditions of the "cp -a" failure
> >> for my test script, I'd prefer to run as non-root: far fewer users run
> >> coreutils' root-requiring tests.  But so far, even with your list above,
> >> unless the test can find a writable NFS partition, it looks like having
> >> a non-root test is not feasible.  Can you see a way?
> >
> > Only by running the test in a confined domain that lacks the necessary
> > permissions to the file type.  Which would either require finding a
> > suitable domain to which you can transition in the existing policy or
> > creating a small test policy module (which would have to be preloaded by
> > a root process, of course).
> 
> Thanks for the continued (quick!) feedback.
> 
> This sounds like it could be less invasive than mounting a temporary
> file system.  Especially if I can find an existing confined domain
> that works.  What do you think?  If you're running coreutils'
> "make check-root" rule, which would you prefer it to use:
>   - a temporary loopback file system, or
>   - create/load a test policy module, assuming I can unload it,
>       leaving no trace, when done, or
>   - (maybe best?) use some commonly-available confined domain
>     that's suitable.  Then I don't have to worry about
>     creating/loading one.
> 
> If the test-policy route sounds better, can you give a small demo?
> Like how to find a suitable confined domain and, if needed,
> how to create and preload a small test policy.

Sorry for not responding sooner.  Offhand, I don't see a good
domain/type pair to re-use from current policy, and rolling your own
test policy is no easier than the temporary loopback filesystem (and
both require privilege to load/mount), so I'd stay with the loopback
filesystem approach at least for now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
