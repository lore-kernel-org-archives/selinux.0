Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA02594
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 01:05:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA20790
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 05:05:27 GMT
Received: from snipe.mail.pas.earthlink.net (snipe.mail.pas.earthlink.net [207.217.120.62])
	by jazzswing.ncsc.mil  with ESMTP id FAA20786
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 05:05:26 GMT
Received: from crtntx1-ar7-4-35-055-006.crtntx1.elnk.dsl.genuity.net ([4.35.55.6] helo=donkey)
	by snipe.mail.pas.earthlink.net with esmtp (Exim 3.33 #2)
	id 17NnxA-000019-00
	for selinux@tycho.nsa.gov; Thu, 27 Jun 2002 22:05:52 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Configuration issues on a new installation
Date: Fri, 28 Jun 2002 00:05:55 -0500
Message-ID: <001c01c21e61$7c297d30$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001D_01C21E37.93537530"
In-Reply-To: <20020628001449.268C12CE3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_001D_01C21E37.93537530
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On 6/27/02, Russell Coker wrote:
> nmbd needs UDP, smbd needs TCP.  smbd needs read/write access to all
user 
> files, nmbd doesn't.
>
> If nmbd has a bug (it's had one before) then you're better off with 
> different domains.

Done. The updated files are attached.

-Ryan

------=_NextPart_000_001D_01C21E37.93537530
Content-Type: application/octet-stream;
	name="samba.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="samba.te"

#=0A=
# Author: Ryan Bergauer (bergauer@rice.edu)=0A=
#=0A=
=0A=
#################################=0A=
#=0A=
# Declarations for Samba=0A=
#=0A=
=0A=
daemon_domain(smbd)=0A=
daemon_domain(nmbd)=0A=
type samba_etc_t, file_type, sysadmfile;=0A=
type samba_log_t, file_type, sysadmfile;=0A=
type samba_var_t, file_type, sysadmfile;=0A=
type samba_share_t, file_type, sysadmfile;=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the smbd_t domain.=0A=
#=0A=
=0A=
# Permissions normally found in every_domain.=0A=
general_domain_access(smbd_t)=0A=
general_file_read_access(smbd_t)=0A=
general_proc_read_access(smbd_t)=0A=
allow smbd_t console_device_t:chr_file { read write };=0A=
allow smbd_t null_device_t:chr_file { read write ioctl };=0A=
=0A=
# Use capabilities.=0A=
allow smbd_t smbd_t:capability { setgid setuid sys_resource =
net_bind_service lease };=0A=
=0A=
# Use the network.=0A=
can_network(smbd_t)=0A=
=0A=
# Read/Write user home directories.=0A=
allow smbd_t user_home_t:dir create_dir_perms;=0A=
allow smbd_t user_home_t:file create_file_perms;=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow smbd_t samba_etc_t:file { write setattr getattr read lock };=0A=
allow smbd_t samba_etc_t:dir { search getattr };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow smbd_t samba_var_t:dir { write remove_name add_name lock getattr =
search };=0A=
allow smbd_t samba_var_t:file { lock unlink create write setattr read =
getattr rename };=0A=
=0A=
# Allow to use /dev/console.=0A=
allow smbd_t init_t:fd { use };=0A=
=0A=
# Permissions to write log files.=0A=
allow smbd_t samba_log_t:file { append getattr create };=0A=
allow smbd_t samba_log_t:dir { search };=0A=
=0A=
# Access Samba shares.=0A=
allow smbd_t samba_share_t:dir create_dir_perms;=0A=
allow smbd_t samba_share_t:file create_file_perms;=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the nmbd_t domain.=0A=
#=0A=
=0A=
# Permissions normally found in every_domain.=0A=
general_domain_access(nmbd_t)=0A=
general_file_read_access(nmbd_t)=0A=
general_proc_read_access(nmbd_t)=0A=
allow nmbd_t console_device_t:chr_file { read write };=0A=
allow nmbd_t null_device_t:chr_file { read write ioctl };=0A=
=0A=
# Use capabilities.=0A=
allow nmbd_t nmbd_t:capability { net_bind_service };=0A=
=0A=
# Use the network.=0A=
can_network(nmbd_t)=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow nmbd_t samba_etc_t:file { getattr read };=0A=
allow nmbd_t samba_etc_t:dir { search getattr };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow nmbd_t samba_var_t:dir { write remove_name add_name lock getattr =
search };=0A=
allow nmbd_t samba_var_t:file { lock unlink create write setattr read =
getattr rename };=0A=
=0A=
# Permissions to write log files.=0A=
allow nmbd_t samba_log_t:file { append getattr create };=0A=
allow nmbd_t samba_log_t:dir { search };=0A=
=0A=
allow nmbd_t nmbd_t: udp_socket recvfrom;=0A=

------=_NextPart_000_001D_01C21E37.93537530
Content-Type: application/octet-stream;
	name="samba.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="samba.fc"

# samba scripts=0A=
/usr/sbin/smbd			system_u:object_r:smbd_exec_t=0A=
/usr/sbin/nmbd			system_u:object_r:nmbd_exec_t=0A=
/etc/samba(|/.*)		system_u:object_r:samba_etc_t=0A=
/var/log/samba(|/.*)		system_u:object_r:samba_log_t=0A=
/var/cache/samba(|/.*)		system_u:object_r:samba_var_t=0A=
/net/music(|/.*)		system_u:object_r:samba_share_t=0A=
/net/pub(|/.*)			system_u:object_r:samba_share_t=0A=

------=_NextPart_000_001D_01C21E37.93537530--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
