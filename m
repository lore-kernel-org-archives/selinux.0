Subject: Re: Existence of "helper" functions (specifcally MLS)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Joe Nall <joe@nall.com>, selinux@tycho.nsa.gov
In-Reply-To: <20060724162559.84696.qmail@web36607.mail.mud.yahoo.com>
References: <20060724162559.84696.qmail@web36607.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 14:15:49 -0400
Message-Id: <1153764949.6122.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-07-24 at 09:25 -0700, Casey Schaufler wrote:
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > Also, in general, we try to avoid MLS-specific logic
> > outside of the
> > policy engine; in many cases, applications that
> > might historically have
> > done a specific MLS dominance check on a traditional
> > trusted OS should
> > instead be performing a SELinux permission check via
> > avc_has_perm or
> > security_compute_av, and then you can internally map
> > that permission to
> > a MLS relationship via the mlsconstrain statements
> > in the policy.  So
> > the first question is whether this application
> > should be performing a
> > MLS label comparison at all, or whether we can
> > abstract that to a
> > service permission check.
> 
> Are you making the assumption that the
> objects involved are among those protected
> by the kernel?

No, this applies to userspace object managers aka policy-enforcing
applications as well.

>  Application objects (e.g.
> print jobs, mail messages, X11 windows, cron
> jobs) may be maintained strictly by an
> application that enforces policy. In such
> cases the application requires access to
> mechanism to determine on its own if an
> access should be permitted.

Yes; that is what security_compute_av(3) or avc_has_perm(3) provides;
both functions are provided by libselinux for this purpose.  Already in
use by several applications (e.g. dbusd, crond) and the
not-yet-upstreamed XACE/XSELinux work.

>  In the context
> of an evaluation it will be very important
> for the MLS policy enforcement on application
> objects to be concise and clearly defined.
> I expect that, as you mention above,
> security_compute_av(3) is the "right" choice
> for doing this. It does put the burden
> of proof on the lower level function. I'd
> be concerned regarding performance, but
> I'm sure that issue will recieve all the
> attention it needs.

The userspace AVC deals with the performance overhead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
