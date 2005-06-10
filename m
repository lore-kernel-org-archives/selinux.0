Subject: Re: general selinux questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 15:59:06 -0400
Message-Id: <1118433546.3774.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 15:54 -0400, Stephen Smalley wrote:
> macros/global_macros.te.  Critical rules are:
> domain_auto_trans(sysadm_t, $1_exec_t, $1_t)
> role_transition sysadm_r $1_exec_t system_r;
> where $1 is each daemon domain.
> That's for direct execution of the daemons.
> For just running init scripts, you would only need:
> domain_auto_trans(sysadm_t, initrc_exec_t, initrc_t)
> role_transition sysadm_r initrc_exec_t system_r;

Note btw that you then need to authorize the user who does this for
system_r as well, as there is no way to automatically transition the
user identity to system_u.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
