Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LISigM029178
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 14:28:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k5LIShsk004644
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 18:28:43 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44985841.7080703@redhat.com>
References: <44985841.7080703@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 14:31:25 -0400
Message-Id: <1150914685.18657.155.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-20 at 16:19 -0400, Daniel J Walsh wrote:
> bootloader has gotten more powerfull, needs more privs

I'm merging this bit, but out of curiosity is this a new feature for
grub?

> Added allow_httpd_mod_auth_pam
>  boolean but can't use it because of limitation of policy compiler

Dropped the declaration until we can resolve this in some way.

> logwatch needs dac override privs
> 
> netutils binds to arbitrary udp ports.

This is just a node bind, what ports are used for name bind?

> prelink is changine location of log file.
> 
> Add ibmasmfs_t
> 
> Dontaudit restorecon walking some kernel types
> 
> I have made several changes to allow me to build a webadm_r.
> Label all httpd_$1_script_exec_t as httpd_script_exec_type
> 
> Then add that type to httpd_manage_all_content.
> 
> Add httpd_manage_config and httpd_manage_log
> 
> Add domain for rotatelogs (httpd_rotatelogs_t)
> 
> automount moved to 5.0 and needs a lot of privs that mount.te has.
> 
> New minor changes to cups
> 
> cups needs to read tmp files of hal
> 
> ntp needs to read network state for IPV6.
> 
> cron runs postfix
> 
> clamav reads postfix lib
> 
> More commands want to look at ldap

tftp using ldap doesn't make sense.  Maybe this is a nsswitch thing?

> spelling mistake on fglrx_drv


> Split base_user_template into two
> 
> base_user_template (This can be used by extended roles, some privs were 
> moved here from unpriv_userdomain also).
> 
> base_login_user_template
> 
> Also added some gen_require to get template working
> 
> Added role_change_template so we can change from one role to another.

Dropped this for now because I've been working on an infrastructure for
building up roles.

> xen needs more privs

The remainder should be merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
