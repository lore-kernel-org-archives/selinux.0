Subject: Re: trouble with ssh in today's rawhide + refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1193144985.9466.53.camel@gorn>
References: <471D1596.8070900@tycho.nsa.gov> <1193144985.9466.53.camel@gorn>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 09:23:19 -0400
Message-Id: <1193145799.2179.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-23 at 13:09 +0000, Christopher J. PeBenito wrote:
> On Mon, 2007-10-22 at 17:26 -0400, Eamon Walsh wrote:
> > On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
> > mode, I get the following after rebooting the box and logging in over ssh:
> > 
> > $ id -Z
> > sysadm_u:sysadm_r:system_chkpwd_t:s0
> 
> Do you have ssh_sysadm_login on?  Also, it seems odd that this would
> happen, since this combination doesn't show up in default_contexts, and
> the only auto transition to system_chkpwd_t from sshd_t is via
> chkpwd_exec_t.

We've seen this kind of behavior before when the
get_ordered_context_list() logic fails to get any contexts from
security_compute_user() that correspond with any of the partial contexts
in default_contexts - it then falls back to just returning the entire
reachable list.

get_ordered_context_list() really needs to be overhauled and replaced
with a mostly userland solution, only consulting the kernel to get the
list of roles and the default level for the user.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
