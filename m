Subject: Re: Failed to get default security context?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Pax Dickinson <pax@guardiandigital.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <42E65ACD.1030805@guardiandigital.com>
References: <42E65ACD.1030805@guardiandigital.com>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 09:53:25 -0400
Message-Id: <1122558805.5058.22.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 11:46 -0400, Pax Dickinson wrote:
> I'm using a slightly modified version of the reference policy and I'm 
> having trouble getting regular users logged in under the correct context.
> 
> When I log in as root over ssh, everything is OK and my context is 
> root:sysadm_r:sysadm_t.  However if I create a regular user and log in 
> over ssh I'm given a system_u:system_r:sshd_t context and the system log 
> reads :
[cut]
> Jul 26 11:32:36 salle2 sshd[2713]: error: Failed to get default security 
> context for pax. Continuing in permissve mode

Some policy related to the transitions to user domains are still TODO.
I'll look again at which interfaces are needed.

> I tried adding an entry to local.users and specifying a role for that 
> username, but it doesn't seem to help.  If I log in at the console as 
> root I'm given a context of system_u:system_r:local_login_t which may be 
> part of the same problem or something completely different.

I've not been able to reproduce this; perhaps pam_selinux is not
enabled?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
