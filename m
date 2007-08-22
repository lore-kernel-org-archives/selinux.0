Subject: Re: weird mprotect error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <FDD03592-C4AE-4066-B866-90B830235880@nall.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158818654C@exchange.columbia.tresys.com>
	 <1187380020.909.358.camel@moss-spartans.epoch.ncsc.mil>
	 <D38FAD33-E7B4-4A2A-909E-892800350EFE@nall.com>
	 <1187705925.1451.123.camel@moss-spartans.epoch.ncsc.mil>
	 <FDD03592-C4AE-4066-B866-90B830235880@nall.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 11:06:37 -0400
Message-Id: <1187795197.1451.368.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 08:18 -0500, Joe Nall wrote:
> On Aug 21, 2007, at 9:18 AM, Stephen Smalley wrote:
> 
> > On Mon, 2007-08-20 at 21:09 -0500, Joe Nall wrote:
> >> Any recommendations on how to start an unprivileged non SystemLow
> >> daemon? This seems broken.
> >
> > Maybe I don't understand the actual problem.
> 
> We couldn't make a non SystemLow, unprivileged daemon run in  
> enforcing mode.
> 
> > Is it reproducible with an upstream (or Fedora) kernel?
> 
> Tried to reproduce it on F7 yesterday and ran into login issues.
> 
> > What's the exact test case?  Trying to run an /etc/init.d script that
> > calls that mlstest program using run_init?
> 
> chcon system_u:object_r:mlstest_exec_t mlstest
> run_init ./mlstest
> 
> The test case was derived from a more complicated daemon and init  
> script.

Ok, so I brought up F7 with its -mls policy in permissive to workaround
the broken login policy, logged in, newrole'd to sysadm_r, and switched
to enforcing mode.  Created the mlstest policy module and inserted it,
created the mlstest program, labeled it, tried the above with run_init.
No unexpected avc messages about ld.*so, and no obvious problems (but no
output, of course, since it doesn't have access to the pty).

I'll try stracing it too, but that will require further policy rules to
let that happen across all the relevant domain transitions there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
