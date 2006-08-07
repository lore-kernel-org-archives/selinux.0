Subject: Re: mrtg policy addons
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan <stefan@sf-net.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <10DF1BC8-13BA-4A7A-ADF9-036A237186B7@sf-net.com>
References: <10DF1BC8-13BA-4A7A-ADF9-036A237186B7@sf-net.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 13:14:25 -0400
Message-Id: <1154970866.31522.245.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-08-05 at 14:42 +0200, Stefan wrote:
> the mrtg policy module from cvs (refpolicy last updated on  
> 2006-08-04)

The refpolicy repo has been moved from sourceforge to oss.tresys.com
(svn).

>  needs an update when the mrtg program runs as a daemon  
> and not via cron.
> 
> mrtg.te
> type mrtg_var_run_t;
> files_pid_file(mrtg_var_run_t)
> files_pid_filetrans(mrtg_t,mrtg_var_run_t,file)
> allow mrtg_t mrtg_var_run_t:file create_file_perms;
> allow mrtg_t lo_netif_t:netif { udp_recv udp_send };
> allow mrtg_t nscd_var_run_t:dir search;
> allow mrtg_t self:capability chown;
> 
> mrtg.fc
> /var/run/mrtg\.pid               gen_context 
> (system_u:object_r:mrtg_var_run_t,s0)

Merged.  In the future, a patch would be preferable, and also use
interfaces.

> With these addings mrtg is ready to run as a standalone server.
> The nscd_var_run_t could also be a dontaudit rule. I think that  
> doesn't make any difference.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
