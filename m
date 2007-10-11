Subject: Re: Question about domain transition and MLS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <p0600201ec333f539728d@[192.168.50.32]>
References: <p0600201ec333f539728d@[192.168.50.32]>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 13:18:17 -0400
Message-Id: <1192123097.608.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-10-11 at 12:08 -0400, Rosalie Hiebel wrote:
> I am writing policy for an application which runs in a domain with a
> SystemHigh range and attempts to launch (via fork/exec) an application
> (/bin/df) having it run in a domain with SystemLow range.  My
> application performs a setexeccon, passing it the domain
> root:sysadm_r:sysadm_t:SystemLow,  prior to the fork and exec.
> 
> 
> My policy contains a rule to allow the application's domain type to do
> a process dyntransition to sysadm_t, but I continue to get an audit
> message indicating it cannot perform a dyntransition from its domain,
> system_u:system_r:my_app_t:SystemHigh to
> root:sysadm_r:sysadm_t:SystemLow.
> 
> 
> I have added numerous mls macros to try to allow the process
> transition, such as mls_rangetrans_source, mls_rangetrans_target, and
> mls_process_set_level, but I still get the dyntransition audit
> message.  Any suggestions for what mls attributes my application
> needs?

A few observations:
- If using setexeccon() and fork/exec to launch the application,
dyntransition is not the right permission at all.  dyntransition is for
dynamic context transitions within the process via setcon(3), not for
regular context transitions upon exec (which would be governed by
transition).
- Why would you transition from your application domain to the domain
for a system administrator shell to run df?  I doubt that you truly want
your application to be able to spawn sysadm_t processes at all, and you
certainly don't need df to run with all of sysadm_t's permissions.
- Aside from MLS constraints (which it sounds like you have covered),
there are constraints on user and role to prevent most domains from
switching to another user identity or role.  These are in the
policy/constraints file in the source and there are interfaces for
allowing a domain to override them, but I'm not sure you really want to
be doing that here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
