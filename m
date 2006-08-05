Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <10DF1BC8-13BA-4A7A-ADF9-036A237186B7@sf-net.com>
From: Stefan <stefan@sf-net.com>
Subject: mrtg policy addons
Date: Sat, 5 Aug 2006 14:42:39 +0200
To: SELinux List <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

the mrtg policy module from cvs (refpolicy last updated on  
2006-08-04) needs an update when the mrtg program runs as a daemon  
and not via cron.

mrtg.te
type mrtg_var_run_t;
files_pid_file(mrtg_var_run_t)
files_pid_filetrans(mrtg_t,mrtg_var_run_t,file)
allow mrtg_t mrtg_var_run_t:file create_file_perms;
allow mrtg_t lo_netif_t:netif { udp_recv udp_send };
allow mrtg_t nscd_var_run_t:dir search;
allow mrtg_t self:capability chown;

mrtg.fc
/var/run/mrtg\.pid               gen_context 
(system_u:object_r:mrtg_var_run_t,s0)

With these addings mrtg is ready to run as a standalone server.
The nscd_var_run_t could also be a dontaudit rule. I think that  
doesn't make any difference.

-Stefan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
