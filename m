Subject: Re: rbacsep: type transition conflicts uncovered
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1214404243.19712.13.camel@gorn>
References: <1214233382.11146.256.camel@gorn>
	 <1214236357.32762.52.camel@moss-spartans.epoch.ncsc.mil>
	 <1214238773.32762.88.camel@moss-spartans.epoch.ncsc.mil>
	 <1214310308.11146.270.camel@gorn>  <1214404243.19712.13.camel@gorn>
Content-Type: text/plain
Date: Mon, 30 Jun 2008 08:24:50 -0400
Message-Id: <1214828690.22447.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-06-25 at 10:30 -0400, Christopher J. PeBenito wrote:
> On Tue, 2008-06-24 at 08:25 -0400, Christopher J. PeBenito wrote:
> > On Mon, 2008-06-23 at 12:32 -0400, Stephen Smalley wrote:
> > > On Mon, 2008-06-23 at 11:52 -0400, Stephen Smalley wrote:
> > > > On Mon, 2008-06-23 at 11:03 -0400, Christopher J. PeBenito wrote:
> > > > > I was going through and doing refactoring on the rbacsep with the goal
> > > > > of making the branch compilable again after doing all the derived type
> > > > > collapsing.  I ran into a problem with type transition conflicts.  There
> > > > > are several domains which have a type transition back to the caller
> > > > > domain, such as su, sudo, (session) dbus, ssh-agent.  But now that the
> > > > > derived types are collapsed, we get conflicts such as:
> > > > > 
> > > > > type_transition sudo_t shell_exec_t:process auditadm_t;
> > > > > type_transition sudo_t shell_exec_t:process secadm_t;
> > > > > type_transition sudo_t shell_exec_t:process staff_t;
> > > > > type_transition sudo_t shell_exec_t:process sysadm_t;
> > > > > type_transition sudo_t shell_exec_t:process user_t;
> > > > > 
> > > > > It would seem that there are two solutions for this:
> > > > > 
> > > > > 1. keep derived types for these affected domains
> > > > > 2. make these applications SELinux aware
> > > > > 
> > > > > We can't collapse user domains because of their vast differences.
> > > > 
> > > > I'd vote for (1).  Otherwise the application is a trusted subject that
> > > > can transition to any user role/domain.
> > >
> > > Although in this case, hasn't sudo been made SELinux aware lately,
> > > including the ability to transition to other roles/domains?
> > 
> > Yes, however, I suppose that we would still want to have a set of
> > type_transitions in case sudo doesn't have the SELinux awareness.
> 
> The final list on domains that have this problem are:
> 
> crontab_t
> su_t
> session_dbusd_t
> sudo_t
> ssh_agent_t
> screen_t
> userhelper_t
> 
> The crontab one was just executing helper programs in the user domain.
> I suspect that was a poor choice; my cursory investigation of vixie cron
> and fcron indicated that it was just the editor that was run for crontab
> -e.  I changed the transition to exec_no_trans,

Is that safe?  The reason for transitioning back to the user domain upon
editor invocation was that the user can shell out of the editor and/or
execute commands straight from the editor depending on his choice of
editor, and I didn't want those to run with the same permissions as
crontab itself (e.g. capabilities, ability to write to crontab spool
files, etc).

>  but it will take some
> more crontab testing to possibly catch other rules that need to be
> added.  The remainder will have to be restored to their derived-types
> design.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
