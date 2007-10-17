Date: Wed, 17 Oct 2007 09:03:25 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
        Andrew Morgan <morgan@kernel.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: Dealing with 64-bit capabilities
Message-ID: <20071017140325.GC25692@sergelap.austin.ibm.com>
References: <1192549264.8702.113.camel@moss-spartans.epoch.ncsc.mil> <20071016193411.GC4115@sergelap.austin.ibm.com> <1192626011.20908.1.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192626011.20908.1.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2007-10-16 at 14:34 -0500, Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > Given that Serge has put out a RFC patch on lsm and lkml for extending
> > > capabilities to 64 bits, we should likely finalize how we want to handle
> > > them in SELinux.
> > > 
> > > Extending the access vector to 64-bits isn't a good idea IMHO, as it
> > > will waste quite a bit of space throughout the AVC and the security
> > > server policydb.
> > > 
> > > In the past we've talked about introducing a second capability class and
> > > access vector for the higher 32 capabilities, and optionally providing
> > > syntactic sugar in checkpolicy so the user doesn't have to think about
> > > it as two separate classes.
> > > 
> > > Possible kernel patch below to define the new class and change
> > > task_has_capability to use it for the higher capabilities.  Comments?
> > 
> > Looks reasonable.  Note that if STRICT_CAP_T_TYPECHECKS were
> > set your use of kernel_cap_t would trigger errors.  near as
> > I can tell that isn't ever done, but still to get around that
> > you'd just do
> 
> Ok..I didn't bother originally because the kernel doesn't build with
> that defined (I did try it) - there is at least one fatal error over in
> the nfsd code and warnings even from the capability code.

I'd wondered about that :)

Judging by
http://www.uwsg.iu.edu/hypermail/linux/kernel/9810.2/0705.html,
the option was actually introduced in 1998 because the use of
the struct was broken.  Given that, are there any objections to the
following patch?

thanks,
-serge
