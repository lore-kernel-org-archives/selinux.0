Subject: Re: rawhide targeted vs. refpolicy rpm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
   Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437B3D53.1090401@cornell.edu>
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
	 <1132066658.5415.379.camel@moss-spartans.epoch.ncsc.mil>
	 <1132067431.5415.383.camel@moss-spartans.epoch.ncsc.mil>
	 <1132067881.5415.391.camel@moss-spartans.epoch.ncsc.mil>
	 <1132081420.28124.80.camel@moss-spartans.epoch.ncsc.mil>
	 <437A3BFA.1080901@cornell.edu>
	 <1132146675.12540.16.camel@moss-spartans.epoch.ncsc.mil>
	 <437B374B.8040401@cornell.edu>
	 <1132148567.12540.28.camel@moss-spartans.epoch.ncsc.mil>
	 <437B3D53.1090401@cornell.edu>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:14:43 -0500
Message-Id: <1132150483.3425.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-16 at 09:08 -0500, Ivan Gyurdiev wrote:
> >> One thing I am still not clear about is why we need a labeling prefix 
> >> that's not related to a role.. how is targeted using the system role, 
> >> and labeling things with the user prefix? Isn't the whole point of the 
> >> labeling prefix to prevent that type of thing (cross-role communication).
> >>     
> >
> > Targeted policy has no notion of user roles/domains.  There is
> > effectively only one SELinux user identity and role in targeted policy;
> > the others are purely for compatibility with strict policy in file
> > contexts and application configuration files.  Targeted policy only uses
> > TE domains to confine particular processes.
> >   
> So why don't we label files in targeted as system_home_t, which seems 
> more correct and workaround this issue. The only change that seems 
> necessary to me is to move the defrole functions from sepol and into 
> semanage, since they don't do anything in sepol, and are misleading - 
> that would be additive divergence on the semanage side. If the user 
> wants to query sepol, and write records into semanage, he/she would have 
> to set the default role in addition to the other data.

Targeted policy and strict policy share many of the same macro
definitions, .te files, and .fc files, and we also want to allow easy
conversion from targeted to strict which means we want a high degree of
on-disk xattr compatibility.  Using a different set of types on /home in
targeted would not be helpful there, although one might be able to work
around the issue via type aliases.

Even in semanage, defrole is potentially misleading, as the actual
default role is context-dependent, e.g. root can be set up to login as
staff_r by default for ssh logins (so that acquiring sysadm_r access
requires a further step via newrole or su) while logging in as sysadm_r
by default for console logins.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
