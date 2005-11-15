Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4379F431.1070908@redhat.com>
References: <BF9A263D.7FFA%csellers@tresys.com>
	 <4374BDEC.4050600@redhat.com> <200511111717.16542.csellers@tresys.com>
	 <200511141041.49643.csellers@tresys.com>
	 <1131983537.5415.137.camel@moss-spartans.epoch.ncsc.mil>
	 <4378B88B.6040003@redhat.com> <4378C285.3080005@tresys.com>
	 <4378D6F9.5070301@redhat.com>
	 <1131997064.5415.241.camel@moss-spartans.epoch.ncsc.mil>
	 <1132053434.5415.269.camel@moss-spartans.epoch.ncsc.mil>
	 <1132062002.5415.350.camel@moss-spartans.epoch.ncsc.mil>
	 <4379F431.1070908@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 09:57:38 -0500
Message-Id: <1132066658.5415.379.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 09:44 -0500, Daniel J Walsh wrote:
> > - Drop the notion of a defrole entirely from the sepol interface and
> > code, and handle determination of the default role for users defined in
> > the policy in semanage in some manner (possibly paralleling the logic
> > used by libselinux to compute the default context, but using the policy
> > object rather than the kernel to query reachable contexts, which
> > requires encapsulating and exporting the corresponding libsepol
> > interface).
> >
> >   
> I would think the latter,  Some logic that takes into account what the 
> login program would do. 
> Since this also relies on the default_context file, correct?

Yes.  In the short term, we may be able to just use the default_contexts
file to find the first role listed there for login that is authorized
for the user.  We don't want to call the libselinux interface
(get_default_context/get_ordered_context_list) itself, as that is based
on the currently running policy and libsemanage may be dealing with a
different policy at the time.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
