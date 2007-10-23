Subject: Re: trouble with ssh in today's rawhide + refpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <471D1596.8070900@tycho.nsa.gov>
References: <471D1596.8070900@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 13:09:45 +0000
Message-Id: <1193144985.9466.53.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-22 at 17:26 -0400, Eamon Walsh wrote:
> On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
> mode, I get the following after rebooting the box and logging in over ssh:
> 
> $ id -Z
> sysadm_u:sysadm_r:system_chkpwd_t:s0

Do you have ssh_sysadm_login on?  Also, it seems odd that this would
happen, since this combination doesn't show up in default_contexts, and
the only auto transition to system_chkpwd_t from sshd_t is via
chkpwd_exec_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
