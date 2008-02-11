Subject: Re: newrole transition problems w/ local user domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202507600.3577.51.camel@bluejay.goodinassociates.com>
References: <1202507600.3577.51.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Mon, 11 Feb 2008 09:06:26 -0500
Message-Id: <1202738786.24250.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-02-08 at 15:53 -0600, Jeremiah Jahn wrote:
> for some reason, I can't seem to get newrole to do it's thing. 
> 
> example:
> [bob@XXXX ~]$ newrole -r monetra_admin_r -t monetra_admin_t
> Authenticating bob.
> Password: 
> failed to exec shell
> : Permission denied
> 
> audit log has:
> type=USER_AUTH msg=audit(1202507011.151:2157): user pid=21599 uid=504 auid=504 subj=monetra_adm_u:monetra_adm_r:newrole_t:s0 msg='PAM: authentication acct="bob" : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/3 res=success)'
> type=USER_ACCT msg=audit(1202507011.151:2158): user pid=21599 uid=504 auid=504 subj=monetra_adm_u:monetra_adm_r:newrole_t:s0 msg='PAM: accounting acct="bob" : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/3 res=success)'
> type=USER_START msg=audit(1202507011.152:2159): user pid=21600 uid=504 auid=504 subj=monetra_adm_u:monetra_adm_r:newrole_t:s0 msg='PAM: session open acct="bob" : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=pts/3 res=success)'
> type=USER_ROLE_CHANGE msg=audit(1202507011.152:2160): user pid=21600 uid=504 auid=504 subj=monetra_adm_u:monetra_adm_r:newrole_t:s0 msg='newrole: old-context=monetra_adm_u:monetra_adm_r:monetra_adm_t:s0 new-context=monetra_adm_u:monetra_admin_r:monetra_admin_t:s0
> : exe="/usr/bin/newrole" (hostname=?, addr=?, terminal=/dev/pts/3 res=success)'
> type=AVC msg=audit(1202507011.152:2161): avc:  denied  { transition } for  pid=21600 comm="newrole" path="/bin/bash" dev=sda1 ino=327714 scontext=monetra_adm_u:monetra_adm_r:newrole_t:s0 tcontext=monetra_adm_u:monetra_admin_r:monetra_admin_t:s0 tclass=process
> type=SYSCALL msg=audit(1202507011.152:2161): arch=40000003 syscall=11 success=no exit=-13 a0=9cbe010 a1=bff58a64 a2=9cc4fc0 a3=0 items=0 ppid=21599 pid=21600 auid=504 uid=504 gid=504 euid=504 suid=504 fsuid=504 egid=504 sgid=504 fsgid=504 tty=pts3 comm="newrole" 
> exe="/usr/bin/newrole" subj=monetra_adm_u:monetra_adm_r:newrole_t:s0 key=(null)
> 
> and yet my te file has:
> allow newrole_t monetra_admin_t:process transition;

So the denial is due to something other than TE, e.g. RBAC or a
constraint. audit2why would give you a hint as to the cause.

Looking at your denial, I see that not only are you changing domain but
also role, from monetra_admin_r to monetra_adm_r.  Not sure how those
two roles are supposed to differ (the names sound the same conceptually,
even if they are different), but you'd need a rbac allow rule:
	allow monetra_admin_r monetra_adm_r;

Normally I think that kind of thing gets covered by a call to
userdom_role_change_template(), see userdomain.te for examples.

> 
> I added a role to no avail:
> role monetra_admin_r types newrole_t;
> 
> 
> this just produced errors about old TE rules an new te rule conflicts:
> domain_type(monetra_admin_t)
> #domain_entry_file(monetra_admin_t , newrole_exec_t )
> #domain_auto_trans(monetra_adm_t,newrole_exec_t,monetra_admin_t)
> 
> could it be I need to use somthing other than:
> userdom_unpriv_user_template(monetra_adm)?
> 
> 
> thanx
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
