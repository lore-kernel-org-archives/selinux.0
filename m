Subject: Re: sudo selinux patch has been removed.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43D79DF0.2010506@redhat.com>
References: <43D79DF0.2010506@redhat.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 11:39:26 -0500
Message-Id: <1138207166.13075.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 10:49 -0500, Daniel J Walsh wrote:
> This means that for mls/strict policy you need to newrole before 
> executing sudo.
> 
> Sudo policy needs to be written to handle the transition from
> 
> staff_t -> staff_sudo_t -> staff_t
> or
> sysadm_t->sysadm_sudo_t->sysadm_t

Should be covered by:
# By default, revert to the calling domain when a shell is executed.
corecmd_shell_domtrans($1_sudo_t,$2)
which is already in sudo.if.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
