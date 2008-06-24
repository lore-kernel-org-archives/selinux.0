Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5ODMori018014
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2008 09:22:50 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5ODMoEB008656
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2008 13:22:50 GMT
Subject: Re: [refpolicy] postfix 2.5.2 - data dir /var/lib/postfix
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080618154139.GA24178@bobek.pm.i.cz>
References: <20080618154139.GA24178@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 24 Jun 2008 09:21:48 -0400
Message-Id: <1214313708.13260.0.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-06-18 at 17:41 +0200, Václav Ovsík wrote:
> I am running Debian Sid and the latest Postfix 2.5.2 uses data_directory
> (/var/lib/postfix by default) not covered by the latest Refpolicy now.
> 
> Postfix 2.5.2 RELEASE_NOTES file:
> | [Incompat 20071206] The "make install" and "make upgrade" procedures
> | now create a Postfix-owned directory for Postfix-writable data files
> | such as caches and random numbers. The location is specified with
> | the "data_directory" parameter (default: "/var/lib/postfix"), and
> | the ownership is specified with the "mail_owner" parameter.
> 
> 
> Postfix brought SE Linux messages during startup:
> 
> Jun 10 18:02:17 sid kernel: [   19.867231] type=1400 audit(1213113737.501:3): avc:  denied  { read write } for  pid=1573 comm="master" name="master.lock" dev=hda2 ino=57530 scontext=system_u:system_r:postfix_master_t:s0 tcontext=system_u:object_r:var_lib_t:s0 tclass=file
> Jun 10 18:02:17 sid kernel: [   19.868060] type=1300 audit(1213113737.501:3): arch=40000003 syscall=5 success=yes exit=10 a0=8e29b58 a1=8002 a2=0 a3=8002 items=0 ppid=1553 pid=1573 auid=4294967295 uid=0 gid=0 euid=102 suid=0 fsuid=102 egid=106 sgid=0 fsgid=106 tty=(none) ses=4294967295 comm="master" exe="/usr/lib/postfix/master" subj=system_u:system_r:postfix_master_t:s0 key=(null)
> Jun 10 18:02:17 sid kernel: [   19.872453] type=1400 audit(1213113737.513:4): avc:  denied  { getattr } for  pid=1573 comm="master" path="/var/lib/postfix/master.lock" dev=hda2 ino=57530 scontext=system_u:system_r:postfix_master_t:s0 tcontext=system_u:object_r:var_lib_t:s0 tclass=file
> Jun 10 18:02:17 sid kernel: [   19.876056] type=1300 audit(1213113737.513:4): arch=40000003 syscall=197 success=yes exit=0 a0=a a1=bf92fbfc a2=b7bb0ff4 a3=bf92fbfc items=0 ppid=1553 pid=1573 auid=4294967295 uid=0 gid=0 euid=102 suid=0 fsuid=102 egid=106 sgid=0 fsgid=106 tty=(none) ses=4294967295 comm="master" exe="/usr/lib/postfix/master" subj=system_u:system_r:postfix_master_t:s0 key=(null)
> Jun 10 18:02:17 sid kernel: [   19.880395] type=1400 audit(1213113737.521:5): avc:  denied  { lock } for  pid=1573 comm="master" path="/var/lib/postfix/master.lock" dev=hda2 ino=57530 scontext=system_u:system_r:postfix_master_t:s0 tcontext=system_u:object_r:var_lib_t:s0 tclass=file
> Jun 10 18:02:17 sid kernel: [   19.883860] type=1300 audit(1213113737.521:5): arch=40000003 syscall=143 success=yes exit=0 a0=a a1=6 a2=b7ede2cc a3=8e2adf8 items=0 ppid=1553 pid=1573 auid=4294967295 uid=0 gid=0 euid=102 suid=0 fsuid=102 egid=106 sgid=0 fsgid=106 tty=(none) ses=4294967295 comm="master" exe="/usr/lib/postfix/master" subj=system_u:system_r:postfix_master_t:s0 key=(null)
> 
> 
> As mentioned in release notes, the data directory is also used by tlsmgr
> for caching TLS sessions and so on. Tlsmgr runs under postfix_master_t,
> so I tried to write the attached patch.

Merged.
> 
> 
> 
> 
> 
> 
> plain text document attachment (postfix)
> 
> Index: refpolicy-svn/policy/modules/services/postfix.fc
> ===================================================================
> --- refpolicy-svn.orig/policy/modules/services/postfix.fc       2008-06-18 11:51:52.000000000 +0200
> +++ refpolicy-svn/policy/modules/services/postfix.fc    2008-06-18 11:52:05.000000000 +0200
> @@ -50,3 +50,4 @@
>  /var/spool/postfix/public(/.*)? gen_context(system_u:object_r:postfix_public_t,s0)
>  /var/spool/postfix/bounce(/.*)? gen_context(system_u:object_r:postfix_spool_bounce_t,s0)
>  /var/spool/postfix/flush(/.*)? gen_context(system_u:object_r:postfix_spool_flush_t,s0)
> +/var/lib/postfix(/.*)?         gen_context(system_u:object_r:postfix_data_t,s0)
> Index: refpolicy-svn/policy/modules/services/postfix.te
> ===================================================================
> --- refpolicy-svn.orig/policy/modules/services/postfix.te       2008-06-18 11:51:52.000000000 +0200
> +++ refpolicy-svn/policy/modules/services/postfix.te    2008-06-18 12:05:28.000000000 +0200
> @@ -83,6 +83,9 @@
>  type postfix_var_run_t;
>  files_pid_file(postfix_var_run_t)
>  
> +type postfix_data_t;
> +files_type(postfix_data_t)
> +
>  postfix_server_domain_template(virtual)
>  mta_mailserver_delivery(postfix_virtual_t)
>  
> @@ -104,6 +107,9 @@
>  
>  can_exec(postfix_master_t,postfix_exec_t)
>  
> +allow postfix_master_t postfix_data_t:dir manage_dir_perms;
> +allow postfix_master_t postfix_data_t:file manage_file_perms;
> +
>  allow postfix_master_t postfix_map_exec_t:file { mmap_file_perms ioctl lock };
>  
>  allow postfix_master_t postfix_postdrop_exec_t:file getattr;
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
