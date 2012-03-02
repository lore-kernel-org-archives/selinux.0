Subject: Re: Suggestion on fixing a old libselinux problem.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <1330710361.2616.52.camel@moss-pluto>
References: <4F4E8EDF.1030405@redhat.com>
	 <1330550573.20078.24.camel@moss-pluto>
	 <1330551258.20078.28.camel@moss-pluto>  <4F4F8AE8.5080703@redhat.com>
	 <1330710361.2616.52.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Mar 2012 16:14:27 -0500
Message-ID: <1330722867.2616.106.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-02 at 12:46 -0500, Stephen Smalley wrote:
> On Thu, 2012-03-01 at 09:42 -0500, Daniel J Walsh wrote:
> > On 02/29/2012 04:34 PM, Stephen Smalley wrote:
> > > I don't think we want to introduce greater complexity and more
> > > possible failures causes into the mix for determining user
> > > contexts.  Simplest option would be to change
> > > get_ordered_context_list() to return the empty list / fail in that
> > > case rather than return the full reachable list from 
> > > security_compute_user.  But I'd like to get rid of / replace 
> > > security_compute_user with a solution that is mostly userspace, at
> > > most getting the user's authorized roles and default level
> > > information from selinuxfs but not asking the kernel to compute
> > > reachability.
> > > 
> > 
> > 
> > Meaning we should read the contents of
> > /etc/selinux/TYPE/contexts/users/SELINUXUSER and get the types from
> > there that match the type of the login program.
> > If that file does not exist, then fall back to
> > /etc/selinux/TYPE/contexts/default_context and get the type from there.
> > 
> > Then just check with the kernel if LOGINTYPE_T can transition to
> > USERTYPE_T and choose that context. Else go to the next context.  If
> > no context is available to transition return failure.
> 
> You can use security_check_context() to see if the context is valid
> (e.g. valid user:role pair) before performing a transition check.
> You'll have to decide how you want it to operate in permissive mode; the
> current security_compute_user() logic ignores permissive mode (via
> AVC_STRICT) and thus will return the same contexts you would get in
> enforcing mode.  Otherwise permissive mode may lead to users logging in
> as sysadm_r rather than user_r if authorized for both.
> 
> There is also the MLS aspect, which is more complex. See
> mls_setup_user_range() in the kernel.

That might not be relevant anymore though, as I think we are taking the
level/range from seusers and using that to bound the computation.  Thus
in the common case, we end up with the seusers level/range.  So you may
not need to replicate mls_setup_user_range() in userspace.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
