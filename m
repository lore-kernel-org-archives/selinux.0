Date: Mon, 17 Dec 2001 08:40:25 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Vanuxem <gvanuxem@club-internet.fr>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: TR: Trans_domain and MLS (small error)
In-Reply-To: <ADEEIKPBIEHIINPOFGAOAEFCCAAA.gvanuxem@club-internet.fr>
Message-ID: <Pine.GSO.4.33.0112170832200.10438-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 17 Dec 2001, Vanuxem wrote:

> I have the pppd domain that work under the user or sysadm role for example :
>
> 'greg:user_r:user_pppd_t'
>
> I want allow to trans to the system role and system user:
> system_u:system_r:portsentry_t
> If  use the macro domain_auto_trans : domain_auto_trans ($1_pppd,
> portsentry_exec_t,portsentry_t)
> The resulting context is greg:user_r:portsentry_t
>
> Is it possible without using newrole??

See the run_init utility program and its domain.  It transitions to the
system_u:system_r:initrc_t domain and then runs the user-specified init
script, which ensures that any daemons are started with the appropriate
user identity, role, and domain (because domain transitions are already
defined from initrc_t for the daemon processes).  The run_init program,
like newrole, reauthenticates the user to ensure that the user wants to
perform the transition (to help protect against invocation by malicious
code).

> -	I want to know if you continue your work about MLS

We aren't actively developing the MLS code or policy at present.  To date,
we have focused on the RBAC and TE policy components, since these are
viewed as being of greater interest to the Linux community.  See the
README.MLS file for a description of what needs to be done to make the MLS
policy useable.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
