Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OBqerT025472
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:52:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OBpqMZ028676
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patch for freshclam (live update)
Date: Tue, 24 Aug 2004 21:52:34 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823214535.GB13677@lkcl.net>
In-Reply-To: <20040823214535.GB13677@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CwyKBTEwJv31mkQ"
Message-Id: <200408242152.34675.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_CwyKBTEwJv31mkQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 24 Aug 2004 07:45, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> here is a patch which gets the freshclam "live update" package working
> a bit more.
>
> it's what i've seen so far, mostly this is boot-up time stuff rather
> than cron job stuff (i think).

# allow freshclam to do logging...
allow freshclam_t var_t:dir { search };
allow freshclam_t freshclam_log_t:dir { search write add_name };
allow freshclam_t var_run_t:dir { search };

The above is all in my latest clamav.te (attached).  It's been a while since I 
released a Debian package, so I've put a snap-shot on 
http://www.coker.com.au/selinux/policy.tgz

+allow freshclam_t clamd_var_run_t:dir { write };
+       #EXE=/usr/bin/freshclam  NAME=clamav   :  write
+
+allow freshclam_t clamd_var_run_t:file { getattr write create };
+allow freshclam_t clamd_var_run_t:dir { add_name };
+       #EXE=/usr/bin/freshclam  NAME=freshclam.pid   :  add_name

Why exactly does it do this?  This isn't really what we want to have happen.  
If there's no way of avoiding this level of interaction between the domains 
then we will have to consider merging freshclam_t and clamd_t into a single 
domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_CwyKBTEwJv31mkQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="clamav.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="clamav.te"

#DESC CLAM - Anti-virus program
#
# Author:  Brian May <bam@snoopy.apana.org.au>
# X-Debian-Packages: clamav
#

#################################
#
# Rules for the clamscan_t domain.
#

# Virus database
type clamav_var_lib_t, file_type, sysadmfile;

# clamscan_t is the domain of the clamscan virus scanner
type clamscan_exec_t, file_type, sysadmfile, exec_type;

daemon_base_domain(freshclam)
read_locale(freshclam_t)

# not sure why it needs this
allow freshclam_t sysctl_kernel_t:dir search;
allow freshclam_t sysctl_kernel_t:file { getattr read };

can_network(freshclam_t)

# Access virus signatures
allow freshclam_t { var_t var_lib_t }:dir search;
rw_dir_create_file(freshclam_t, clamav_var_lib_t)

allow freshclam_t devtty_t:chr_file { read write };
allow freshclam_t devpts_t:dir search;
allow freshclam_t etc_t:file { getattr read };
allow freshclam_t proc_t:file { getattr read };

allow freshclam_t urandom_device_t:chr_file { getattr read };
dontaudit freshclam_t urandom_device_t:chr_file ioctl;

# for nscd
dontaudit freshclam_t var_run_t:dir search;

# setuid/getuid used (although maybe not required...)
allow freshclam_t self:capability { setgid setuid };

allow freshclam_t sbin_t:dir search;

# Allow notification to daemon that virus database has changed
can_clamd_connect(freshclam)

allow freshclam_t etc_runtime_t:file { read getattr };
allow freshclam_t self:unix_stream_socket create_stream_socket_perms;
allow freshclam_t self:unix_dgram_socket create_socket_perms;
allow freshclam_t self:fifo_file rw_file_perms;

# Log files for freshclam executable
logdir_domain(freshclam)
allow initrc_t freshclam_log_t:file append;

system_crond_entry(freshclam_exec_t, freshclam_t)
domain_auto_trans(logrotate_t, freshclam_exec_t, freshclam_t)

domain_auto_trans(sysadm_t, freshclam_exec_t, freshclam_t)
role sysadm_r types freshclam_t;

# macros/program/clamav_macros.te.
user_clamscan_domain(sysadm)

# clamd executable
daemon_domain(clamd)

tmp_domain(clamd)
logdir_domain(clamd)

file_type_auto_trans(clamd_t, var_run_t, clamd_var_run_t, sock_file)

allow clamd_t self:capability { kill setgid setuid };

allow clamd_t var_lib_t:dir search;
r_dir_file(clamd_t, clamav_var_lib_t)
r_dir_file(clamd_t, etc_t)
allow clamd_t sysctl_t:dir r_dir_perms;
# allow access /proc/sys/kernel/version
r_dir_file(clamd_t, sysctl_kernel_t);
allow clamd_t self:unix_stream_socket create_stream_socket_perms;
allow clamd_t self:unix_dgram_socket create_stream_socket_perms;
allow clamd_t self:fifo_file rw_file_perms;

allow clamd_t { random_device_t urandom_device_t }:chr_file { getattr read };
dontaudit clamd_t { random_device_t urandom_device_t }:chr_file ioctl;

--Boundary-00=_CwyKBTEwJv31mkQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
