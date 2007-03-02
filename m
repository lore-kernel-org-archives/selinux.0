Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l22G57BC001647
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 11:05:07 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l22G6VRx010215
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2007 16:06:31 GMT
Subject: Re: Added application_exec_type patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E70963.601@redhat.com>
References: <45E5E54F.1@redhat.com>
	 <1172763878.11157.104.camel@sgc.columbia.tresys.com>
	 <45E70963.601@redhat.com>
Content-Type: text/plain
Date: Fri, 02 Mar 2007 11:06:50 -0500
Message-Id: <1172851610.19169.89.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-01 at 12:12 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Wed, 2007-02-28 at 15:25 -0500, Daniel J Walsh wrote:
> >   
> >> This patch  an attribute  of application_exec_type to any executable 
> >> that can be executed by a user. 
> >>     
> >
> > The domains also need to be collected (minus the ones that we discussed
> > on IRC, like cvs and rsync) into an attribute.  Then we should be able
> > to apply that towards fixing the ssh command line/sockets problem (where
> > the incoming client has done something like "ssh
> > myserver /usr/bin/passwd").
> >
> >   
> >> I have only patched the executables that currently transition to a 
> >> domain if run under inetd or init, but do not transition if run by a user.
> >>     
> >
> > The stuff in the apps layer will have to be covered too.  They may have
> > policies, but they're still applications.  Their domain transitions will
> > still happen.
> >
> >   
> >> Also changed corecommand_exec_any to only execute executables that a 
> >> user is supposed to run.  So if sysadm_t tries to execute a dameon 
> >> directly it will get a permission denied.
> >>     
> >
> > This interface has to remain the same.  "All executables" actually has
> > to mean all executables for the semantics of the interface to be
> > maintained.  If we want sysadm's behavior to be the above, it is the one
> > that needs to change.
> >
> >   
> How about something like the attached
> 
> I have just converted selinuxutil.te for now.

Comments inline:

> +interface(`application_type',`
> +       gen_require(`
> +               attribute application_type;
> +       ')
> +
> +       typeattribute $1 application_type;
> +
> +       # start with basic domain
> +       domain_type($1)
> +')

I don't think this will work.  Having the attribute and interface with
the same name will cause problems, since m4 will treat the attribute
references as macro calls with no parameters.  This will turn the above
interface into a recursive interface.  I suggest the attribute be named
application_domain_type.

> +interface(`application_exec_all',`
> +       # Need this dontaudit or command completion fires hundreds of avcs
> +       corecmd_dontaudit_exec_all_executables($1)
> +       corecmd_exec_bin($1)
> +       corecmd_exec_sbin($1)
> +       corecmd_exec_shell($1)
> +       corecmd_exec_ls($1)
> +       corecmd_exec_chroot($1)
> +       application_exec($1)
> +')

Not sure how I feel on this yet.

> +interface(`application_domain',`
> +
> +       application_type($1)
> +       application_executable_file($2)
> +       domain_entry_file($1,$2)
> +       role system_r types $1;
> +
> +       optional_policy(`
> +               ssh_sigchld($1)
> +               ssh_rw_stream_sockets($1)
> +       ')
> +
> +')

I don't think the role statement belongs at all.  I think the ssh part
should be moved to the TE file and use the attribute:

optional_policy(`
	ssh_sigchld(application_domain_type)
	ssh_rw_stream_sockets(application_exec_type)
')

> --- nsaserefpolicy/policy/modules/system/selinuxutil.te 2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.7/policy/modules/system/selinuxutil.te      2007-03-01 12:03:00.000000000 -0500
> @@ -83,30 +73,34 @@
>  type restorecon_exec_t;
>  domain_obj_id_change_exemption(restorecon_t)
>  init_system_domain(restorecon_t,restorecon_exec_t)
> -role system_r types restorecon_t;
> +application_type($1)

Is there a particular reason that this didn't use application_domain()?
 
>  type run_init_t;
>  type run_init_exec_t;
> -domain_type(run_init_t)
> -domain_entry_file(run_init_t,run_init_exec_t)
> +application_domain(run_init_t)

Looks like this is missing a 2nd parameter.
 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
