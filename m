Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OGn7rT028577
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 12:49:08 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OGmJMZ019676
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 16:48:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: named policy
Date: Wed, 25 Aug 2004 02:49:01 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>, Jason Vas Dias <jvdias@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <200408241840.58207.russell@coker.com.au> <1093349343.1800.57.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093349343.1800.57.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9F3KBfRod5b2rOr"
Message-Id: <200408250249.01418.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_9F3KBfRod5b2rOr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 24 Aug 2004 22:09, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2004-08-24 at 04:40, Russell Coker wrote:
> > The attached patch adjusts some comments in the named policy to match
> > what's being done, fixes up a lot of the type labelling (including some
> > ifdef's for distro specific stuff), removes rndc_conf_t references from
> > the policy (the typealias statement is only there for files that are
> > already labelled on the file system), and removes some access that should
> > not be needed.
> >
> > If ndc_t really needs to write to type named_zone_t then we probably have
> > a mis-labelling issue.
>
> Requires coordination with named maintainer:
> 1) You are reverting named_cache_t to being used for secondary zone
> files and being writable, whereas he (or Dan) was using it for named.ca
> files and keeping it read-only.  So what happens to the named.ca files?

They have to be relabeled.  named_conf_t is a read-only type for named_t to 
read which should do well for named.ca.

> 2) named maintainer claimed that ndc did need write access to /var/named
> (named_zone_t).  See his earlier email.

He is incorrect.  The command "rndc dumpdb" will instruct the named process to 
write the dump file to the location specified in the configuration.

options {
        directory "/var/named/";
        dump-file "/var/named/slaves/named_dump.db";
        statistics-file "/var/named/slaves/named.stats";
};

I have the above in my /etc/named.custom to make this work.  NB The default is 
to have it in /var/named, if we choose to stick with that then we need to 
have the following policy:
file_type_auto_trans(named_t, named_conf_t, named_cache_t, file)

This is something I would prefer to avoid.  But we'll have to do it if we want 
to support this operation with the old configuration.

The above changes also apply for "rndc stats" in the same manner.  They should 
also apply for memstats which appears in the named binary but which I haven't 
worked out how to trigger (maybe I'll have to read the source for that).

> 3) /var/named/chroot labeling changes seem wrong to me; the current .fc
> file provides consistent labels with a normal filesystem layout.

The .fc file in CVS does use more consistent labels with a normal file system.  
However I don't think that this is a benefit.

For example using tmp_t for the tmp directory is a bad idea IMHO.  If somehow 
(due to a mistake in policy or a policy which matches a configuration that's 
significantly altered from the default) a process in another gets access to 
the chroot then it would be allowed to create temporary files there even 
though the policy may correctly prevent it writing to all types associated 
with named.  I think that tmp_t should be reserved for directories that are 
designed for use by a large number of domains for temporary files.

The same applies for the dev directory, we don't need to allow all domains to 
search that directory, just named_t, sysadm_t, and a small number of others.

The only possible problem I can think of in regard to this is if someone uses 
bind mounts and then relabels.  If we want to be safe against this we would 
need to duplicate all entries for /dev.  To do this properly if we were to go 
down that path would require changing genhomedircon to duplicate /dev entries 
for different paths.  Incidentally I recently did some performance analysis 
on setfiles which showed that the /dev labels take so little time as to be 
insignificant (I was concerned that the "dev" -> "u?dev" change would hurt 
performance because of breaking stem compression, but as all device nodes are 
under the one directory the type checking removes the relevance of stem 
compression for this).  So this is a feasible option.

In any case with regard to bind mounts my proposed fc file won't break things 
any more than the one that's currently in CVS.  ;)


I have attached new named policy files which work well on my system including 
"rndc dumpdb".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_9F3KBfRod5b2rOr
Content-Type: text/plain;
  charset="iso-8859-1";
  name="named.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="named.te"

#DESC BIND - Name server
#
# Authors:  Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>,
#           Russell Coker
# X-Debian-Packages: bind bind9
# 
#

#################################
#
# Rules for the named_t domain.
#
type rndc_port_t, port_type;

daemon_domain(named)
tmp_domain(named)

# for /var/run/ndc used in BIND 8
file_type_auto_trans(named_t, var_run_t, named_var_run_t, sock_file)

# ndc_t is the domain for the ndc program
type ndc_t, domain, privlog;
role sysadm_r types ndc_t;
role system_r types ndc_t;

can_exec(named_t, named_exec_t)
allow named_t sbin_t:dir search;

allow named_t self:process setsched;

# A type for configuration files of named.
type named_conf_t, file_type, sysadmfile;
typealias named_conf_t alias rndc_conf_t;

# for primary zone files
type named_zone_t, file_type, sysadmfile;

# for secondary zone files
type named_cache_t, file_type, sysadmfile;

# Use capabilities. Surplus capabilities may be allowed.
allow named_t self:capability { chown dac_override fowner setgid setuid net_bind_service sys_chroot sys_nice sys_resource };

allow named_t etc_t:file { getattr read };
allow named_t etc_runtime_t:{ file lnk_file } { getattr read };

#Named can use network
can_network(named_t)
can_ypbind(named_t)
# allow UDP transfer to/from any program
can_udp_send(domain, named_t)
can_udp_send(named_t, domain)
can_tcp_connect(domain, named_t)

# Bind to the named port.
allow named_t dns_port_t:udp_socket name_bind;
allow named_t { dns_port_t rndc_port_t }:tcp_socket name_bind;

bool named_write_master_zones false;

#read configuration files
r_dir_file(named_t, named_conf_t)

if (named_write_master_zones) {
#create and modify zone files
create_dir_file(named_t, named_zone_t)
}
#read zone files
r_dir_file(named_t, named_zone_t)

#write cache for secondary zones
rw_dir_create_file(named_t, named_cache_t)

allow named_t self:unix_stream_socket create_stream_socket_perms;
allow named_t self:unix_dgram_socket create_socket_perms;

# Read sysctl kernel variables.
allow named_t sysctl_t:dir r_dir_perms;
allow named_t sysctl_kernel_t:dir r_dir_perms;
allow named_t sysctl_kernel_t:file r_file_perms;

# Read /proc/cpuinfo.
allow named_t proc_t:dir r_dir_perms;
allow named_t proc_t:file r_file_perms;

# Read /dev/random.
allow named_t device_t:dir r_dir_perms;
allow named_t random_device_t:chr_file r_file_perms;

# Use a pipe created by self.
allow named_t self:fifo_file rw_file_perms;

# Set own capabilities.
allow named_t self:process setcap;

#A type for /usr/sbin/ndc
type ndc_exec_t, file_type,sysadmfile, exec_type;
domain_auto_trans({ sysadm_t initrc_t }, ndc_exec_t, ndc_t)
uses_shlib(ndc_t)
can_network(ndc_t)
can_ypbind(ndc_t)
read_locale(ndc_t)
can_tcp_connect(ndc_t, named_t)

# for /etc/rndc.key
ifdef(`distro_redhat', `
allow { ndc_t initrc_t } named_conf_t:dir search;
')
allow { ndc_t initrc_t } named_conf_t:file { getattr read };

allow ndc_t etc_t:dir r_dir_perms;
allow ndc_t etc_t:file r_file_perms;
allow ndc_t self:unix_stream_socket create_stream_socket_perms;
allow ndc_t self:unix_stream_socket connect;
allow ndc_t self:capability { dac_override net_admin };
allow ndc_t named_var_run_t:sock_file rw_file_perms;
allow ndc_t named_t:unix_stream_socket connectto;
allow ndc_t { privfd init_t }:fd use;
# seems to need read as well for some reason
allow ndc_t { admin_tty_type initrc_devpts_t }:chr_file { getattr read write };
allow ndc_t fs_t:filesystem getattr;

# Read sysctl kernel variables.
allow ndc_t sysctl_t:dir r_dir_perms;
allow ndc_t sysctl_kernel_t:dir r_dir_perms;
allow ndc_t sysctl_kernel_t:file r_file_perms;

allow ndc_t self:process { fork signal_perms };
allow ndc_t self:fifo_file { read write getattr ioctl };
allow ndc_t named_zone_t:dir search;

# for chmod in start script
dontaudit initrc_t named_var_run_t:dir setattr;

# for ndc_t to be used for restart shell scripts
ifdef(`ndc_shell_script', `
system_crond_entry(ndc_exec_t, ndc_t)
allow ndc_t devtty_t:chr_file { read write ioctl };
allow ndc_t etc_runtime_t:file { getattr read };
allow ndc_t proc_t:dir search;
allow ndc_t proc_t:file { getattr read };
can_exec(ndc_t, { bin_t sbin_t shell_exec_t })
allow ndc_t var_t:dir search;
allow ndc_t named_var_run_t:file getattr;
allow ndc_t named_zone_t:dir { read getattr };
allow ndc_t named_zone_t:file getattr;
dontaudit ndc_t sysadm_home_t:dir { getattr search read };
')
allow ndc_t self:netlink_route_socket { bind create getattr nlmsg_read read write };

--Boundary-00=_9F3KBfRod5b2rOr
Content-Type: text/plain;
  charset="iso-8859-1";
  name="named.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="named.fc"

# named
/var/named(/.*)?		system_u:object_r:named_zone_t
/var/named/slaves(/.*)?		system_u:object_r:named_cache_t
/etc/named\.conf	--	system_u:object_r:named_conf_t
ifdef(`distro_debian', `
/etc/bind(/.*)?			system_u:object_r:named_zone_t
/etc/bind/named\.conf	--	system_u:object_r:named_conf_t
/etc/bind/rndc\.key	--	system_u:object_r:named_conf_t
/var/cache/bind(/.*)?		system_u:object_r:named_cache_t
')
/etc/rndc.*		--	system_u:object_r:named_conf_t
/usr/sbin/named.*      	--	system_u:object_r:named_exec_t
/usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
/var/run/ndc		-s	system_u:object_r:named_var_run_t
/var/run/bind(/.*)?		system_u:object_r:named_var_run_t
/var/run/named.*		system_u:object_r:named_var_run_t
/usr/sbin/lwresd	--	system_u:object_r:named_exec_t
ifdef(`distro_redhat', `
/var/named/chroot(/.*)?		system_u:object_r:named_conf_t
/var/named/chroot/dev/null   -c	system_u:object_r:null_device_t
/var/named/chroot/dev/random -c	system_u:object_r:random_device_t
/var/named/chroot/etc/named\.conf -- system_u:object_r:named_conf_t
/var/named/chroot/etc/rndc.* -- system_u:object_r:named_conf_t
/var/named/chroot/var/run/named.* system_u:object_r:named_var_run_t
/var/named/chroot/var/tmp(/.*)? system_u:object_r:named_cache_t
/var/named/slaves(/.*)?		system_u:object_r:named_cache_t
/var/named/chroot/var/named/slaves(/.*)? system_u:object_r:named_cache_t
/var/named/named\.ca	--	system_u:object_r:named_conf_t
')

--Boundary-00=_9F3KBfRod5b2rOr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
