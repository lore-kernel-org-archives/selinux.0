Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PBDErT004447
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 07:13:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PBCQLV025180
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 11:12:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patch to automount
Date: Wed, 25 Aug 2004 21:13:09 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823220933.GF13677@lkcl.net>
In-Reply-To: <20040823220933.GF13677@lkcl.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FRHLBHkYMhU6duT"
Message-Id: <200408252113.09123.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_FRHLBHkYMhU6duT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 24 Aug 2004 08:09, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> okay.
>
> this one requires some explanation.
>
> i modified the usb-mount script i found [google search] to,
> instead of manually mounting and unmounting the drive, to
> update autofs files, do an /etc/init.d/autofs reload, that
> sort of thing.

I've updated the policy in my tree to do things similar to what you are doing.

I've attached the files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_FRHLBHkYMhU6duT
Content-Type: text/plain;
  charset="iso-8859-1";
  name="automount.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="automount.te"

#DESC Automount - Automount daemon
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil>
# Modified by Russell Coker <russell@coker.com.au>
# X-Debian-Packages: amd am-utils autofs
#

#################################
#
# Rules for the automount_t domain.
#
daemon_domain(automount)

etc_domain(automount)

# for SSP
allow automount_t urandom_device_t:chr_file read;

# for if the mount point is not labelled
allow automount_t file_t:dir getattr;
allow automount_t default_t:dir getattr;

allow automount_t autofs_t:dir { create_dir_perms ioctl };
allow automount_t fs_type:dir getattr;

allow automount_t { etc_t etc_runtime_t }:file { getattr read };
allow automount_t proc_t:file { getattr read };
allow automount_t self:process { setpgid setsched };
allow automount_t self:capability { sys_nice };
allow automount_t self:unix_stream_socket create_socket_perms;
allow automount_t self:unix_dgram_socket create_socket_perms;

# because config files can be shell scripts
can_exec(automount_t, { etc_t automount_etc_t })

can_network(automount_t)
can_ypbind(automount_t)

ifdef(`fsadm.te', `
domain_auto_trans(automount_t, fsadm_exec_t, fsadm_t)
')

lock_domain(automount)

tmp_domain(automount)
allow automount_t self:fifo_file rw_file_perms;

# Run mount in the mount_t domain.
domain_auto_trans(automount_t, mount_exec_t, mount_t)
allow mount_t autofs_t:dir { search mounton read };
allow mount_t automount_tmp_t:dir mounton;

ifdef(`apmd.te',
`domain_auto_trans(apmd_t, automount_exec_t, automount_t)
can_exec(automount_t, bin_t)')

allow automount_t { bin_t sbin_t }:dir search;
can_exec(automount_t, mount_exec_t)

allow mount_t autofs_t:dir getattr;
dontaudit automount_t var_t:dir write;

allow userdomain autofs_t:dir r_dir_perms;
allow kernel_t autofs_t:dir { getattr ioctl read search };

allow automount_t home_root_t:dir { getattr };
allow automount_t mnt_t:dir { getattr search };

allow initrc_t automount_etc_t:file getattr;

--Boundary-00=_FRHLBHkYMhU6duT
Content-Type: text/plain;
  charset="iso-8859-1";
  name="automount.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="automount.fc"

# automount
/usr/sbin/automount	--	system_u:object_r:automount_exec_t
/etc/apm/event\.d/autofs --	system_u:object_r:automount_exec_t
/var/run/autofs(/.*)?		system_u:object_r:automount_var_run_t
/etc/auto\..+		--	system_u:object_r:automount_etc_t

--Boundary-00=_FRHLBHkYMhU6duT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
