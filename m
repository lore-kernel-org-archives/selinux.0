Date: Thu, 22 Aug 2013 17:50:17 -0500
From: Dan Pou <danielp@sgi.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
Subject: Re: Programmatic domain change to unprivileged role
Message-ID: <20130822225017.GS28332@localhost>
References: <20130805190732.GT18909@localhost>
 <52015950.9010906@tycho.nsa.gov>
 <20130806203751.GA14875@localhost>
 <52023D7D.7040409@tycho.nsa.gov>
 <52024071.4000206@tycho.nsa.gov>
 <20130808195857.GB23152@localhost>
 <5204E5C5.1050802@tycho.nsa.gov>
 <20130820200546.GL28332@localhost>
 <5214CD24.3050506@tycho.nsa.gov>
 <5214CE68.8050108@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5214CE68.8050108@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you everyone for all the information.  I did manage to get
transitions working successfully (it seems part of the problem was
related to the policy install process I was using).  Most of the
remaining issues I face are related to RPM packaging a module, which I
can check the Fedora list for, if necessary.

Thanks again, for the help with setexeccon vs default transitions.
-Dan


On Wed, Aug 21, 2013 at 10:27:52AM -0400, Stephen Smalley wrote:
> On 08/21/2013 10:22 AM, Stephen Smalley wrote:
> > On 08/20/2013 04:05 PM, Dan Pou wrote:
> >> On Fri, Aug 09, 2013 at 08:51:17AM -0400, Stephen Smalley wrote:
> >>> On 08/08/2013 03:58 PM, Dan Pou wrote:
> >>>> Thanks for the suggestion about strace, that is pointing to the problem.
> >>>> I need to check the policy rules I have been adding to see how I got
> >>>> here:
> >>>>
> >>>> write(3, "user_u:sysadm_r:sysadm_t:s0\0", 28) = -1 EINVAL (Invalid
> >>>> argument)
> >>>>
> >>>> This is the second write.  When I test the same code with sshd_t to
> >>>> <username> transition, I get one write, with a successful return of
> >>>> default_context_with_level.
> >>>>
> >>>> Thanks, this gives me something to go off of.
> >>>
> >>> Could be that security_compute_user() (which writes to
> >>> /sys/fs/selinux/user) is getting an error or no results and thus the
> >>> code is trying to fall back to the failsafe context (as specified in
> >>> /etc/selinux/$SELINUXTYPE/contexts/failsafe_context), which isn't legal
> >>> for user_u.
> >>> The failsafe is to permit root / admin logins under such a situation.
> >>>
> >>> I'd look to see what the result of writing to /sys/fs/selinux/user was
> >>> and what was written to it in the strace output.  You can also directly
> >>> call security_compute_user via the compute_user tool under
> >>> libselinux/utils if you obtain and build the sources yourself.  That
> >>> utility doesn't appear to get included in the libselinux-utils rpm though.
> >>>
> >>>
> >>
> >> I addeded the system_r:my_daemon_t:s0 user_r:user_t:s0 role transition
> >> to /etc/selinux/mls/contexts/default_contexts.
> >> This got me to actually writing user_u:user_r:user_t:s0 for setexeccon,
> >> but I am still failing.  It looks like it is failing in the
> >> selinux_trans_to_raw_context.  I was thinking this was an issue with
> >> declaring the transition.
> >> What steps do I need to setup a role_transition and/or type_transistion?
> >>
> >> I tried adding the following to no avail:
> >> type_transition my_daemon_t non_security_file_type:process user_t;
> >> Do I need more type_transitions, or addition role_transition
> >> declarations (aside from /etc/selinux/mls/contexts/default_context)?
> >>
> >> Other info:
> >> The daemon (without SELinux) just sets the euid/egid to match the user
> >> requesting the job. So I inserted calls to
> >> getseuserbyname
> >> get_default_context_with_rolelevel or get_default_context_with_level
> >> then setexeccon
> >> the returned context before execve'ing.
> > 
> > If you are getting to the point of setexeccon() with the correct
> > security context, then you are past the point of any type transition or
> > role transition rules.  The transition rules are just to define defaults
> > in the absence of an explicit setexeccon(); it is the allow rules that
> > govern what is permitted.  You do need both role allow and TE allow
> > rules in your policy, of course.  Did you add the interface calls that I
> > listed earlier for your daemon domain?  However, lack of permission
> > there should show up as an AVC denial; you might re-test with dontaudit
> > rules stripped to confirm (semodule -DB).
> > 
> > If the error truly lies during the trans_to_raw_context, then maybe you
> > have a problem in your label translation daemon?  Are you running
> > mcstransd or something else?  What happens if you simply stop the label
> > daemon (it isn't required for operation; it just provides translation of
> > MLS labels to and from more human-readable form and deals with complex
> > label encodings ala the old MITRE label encodings format).
> 
> Also, in addition to the interfaces I listed earlier, you likely need
> mls_process_set_level(X_t)
> to permit the daemon to set the current/low level.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
