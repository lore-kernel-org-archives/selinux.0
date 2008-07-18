Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IDRrnU017157
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 09:27:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IDRrAI005559
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 13:27:53 GMT
Subject: Re: pam_mount
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1214248539.5486.10.camel@vogon>
References: <1214047062.30904.13.camel@vogon>
	 <1214226750.11146.232.camel@gorn>  <1214248539.5486.10.camel@vogon>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 09:27:26 -0400
Message-Id: <1216387646.21191.129.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-06-23 at 21:15 +0200, Stefan Schulze Frielinghaus wrote:
> Attached patch solves a problem of local logins while using pam_mount.
> In xserver.te GDM already has this permission to
> manage /var/run/pam_mount. Therefore GDM logins which use pam_mount to
> e.g. decrypt a partition work. But local logins not.
> 
> I also had a lot of strange { getattr search } requests of mount. I
> dontaudit everyone and the login still works. I'm not sure if we should
> add these ones to mount_t:
> 
> domain_dontaudit_search_all_domains_state(mount_t)
> dontaudit mount_t pam_var_console_t:file write;
> dontaudit mount_t self:process ptrace;
> dontaudit mount_t proc_net_t:lnk_file read;
> 
> Nevertheless with the attached patch local logins via pam_mount work.
> 
> I cc'd Dan in the hope that he will add the patch to the upstream policy
> of Fedora. Then I don't have to install a local policy for every
> installation. Lazy me ;-)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
