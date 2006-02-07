Subject: Re: Why cron doesn't work in strict policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43E8B1F0.5030208@cornell.edu>
References: <43E7C52E.601@cornell.edu> <43E7C804.3040507@cornell.edu>
	 <43E8B013.8000000@redhat.com>
	 <1139323414.2872.46.camel@moss-spartans.epoch.ncsc.mil>
	 <43E8B1F0.5030208@cornell.edu>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 09:55:41 -0500
Message-Id: <1139324141.2872.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-07 at 09:42 -0500, Ivan Gyurdiev wrote:
> >> Which causes cron jobs on strict policy and I would guess MLS to run at 
> >> user_u since system_u is not defined and would run at level s0. 
> >>     
> >
> > We should add system_u to seusers.
> >   
> Why? There's no such Linux user...
> This will cause problems with genhomedircon.

What kind of problem?  Other alternative is to have crond skip the
getseuserbyname() lookup if dealing with a system cron job (indicated by
use of system_u), which just means a special cased check in the crond
code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
