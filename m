Subject: Re: rbacsep: type transition conflicts uncovered
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1214238773.32762.88.camel@moss-spartans.epoch.ncsc.mil>
References: <1214233382.11146.256.camel@gorn>
	 <1214236357.32762.52.camel@moss-spartans.epoch.ncsc.mil>
	 <1214238773.32762.88.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 24 Jun 2008 08:25:08 -0400
Message-Id: <1214310308.11146.270.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-23 at 12:32 -0400, Stephen Smalley wrote:
> On Mon, 2008-06-23 at 11:52 -0400, Stephen Smalley wrote:
> > On Mon, 2008-06-23 at 11:03 -0400, Christopher J. PeBenito wrote:
> > > I was going through and doing refactoring on the rbacsep with the goal
> > > of making the branch compilable again after doing all the derived type
> > > collapsing.  I ran into a problem with type transition conflicts.  There
> > > are several domains which have a type transition back to the caller
> > > domain, such as su, sudo, (session) dbus, ssh-agent.  But now that the
> > > derived types are collapsed, we get conflicts such as:
> > > 
> > > type_transition sudo_t shell_exec_t:process auditadm_t;
> > > type_transition sudo_t shell_exec_t:process secadm_t;
> > > type_transition sudo_t shell_exec_t:process staff_t;
> > > type_transition sudo_t shell_exec_t:process sysadm_t;
> > > type_transition sudo_t shell_exec_t:process user_t;
> > > 
> > > It would seem that there are two solutions for this:
> > > 
> > > 1. keep derived types for these affected domains
> > > 2. make these applications SELinux aware
> > > 
> > > We can't collapse user domains because of their vast differences.
> > 
> > I'd vote for (1).  Otherwise the application is a trusted subject that
> > can transition to any user role/domain.
>
> Although in this case, hasn't sudo been made SELinux aware lately,
> including the ability to transition to other roles/domains?

Yes, however, I suppose that we would still want to have a set of
type_transitions in case sudo doesn't have the SELinux awareness.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
