Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA00985
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 17:14:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA12509
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 21:13:31 GMT
Received: from snipe.mail.pas.earthlink.net (snipe.mail.pas.earthlink.net [207.217.120.62])
        by jazzband.ncsc.mil  with ESMTP id VAA12505 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 21:13:31 GMT
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: "'Stephen Smalley'" <sds@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: RE: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 16:14:56 -0500
Message-ID: <000e01c21e1f$b04952d0$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01C21DF5.C7734AD0"
In-Reply-To: <Pine.GSO.4.33.0206271424450.21230-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C21DF5.C7734AD0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On 6/27/02, Stephen Smalley wrote:

> Thanks for contributing.  A few questions/suggestions:
> 1) You may want to be more restrictive in granting read access to
> smbd/nmbd than what is currently permitted under every_domain() and by
> your allow rules to home_type.  Ideally, we'd like to see all of the
> domains reworked to move away from using every_domain in order to
> provide true least privilege.  Notice that every_domain is already
> partitioned into some smaller macros that you can use and that
> you could easily define even finer-grained subset macros. 
> 2) You can pick up some common declarations and rules for daemons from
> the daemon_domain macro in global_macros.te, contributed by Russell.

Done. It still gets quite a few permissions, but it's better than using
every_domain(). I also changed it to work with user_home_t in place of
home_type.

> 3) It would be a good idea to define a separate type for
/var/cache/samba
> and only grant smbd/nmbd access to it rather than the generic var_t
type.

I actually did that last night after I submitted. I also created a
samba_share_t to allow Samba to share only those files that I intend it
to (outside of the user homes). 
 
> 4) Why does nmbd_t need recvfrom permission to initrc_t?  Are any of
your
> system processes being left in initrc_t due to a lack of a domain?
Check
> your ps -e --context output.

Very good question. That confused me last night but I included it
anyway. I've since switched to a single samba.te file (per Russell's
suggestion), left out the initrc_t recvfrom permission, and haven't had
it pop up again. Strange.

I've attached samba.te and samba.fc with all of the changes. Nothing is
labeled with samba_share_t by default. 

-Ryan





------=_NextPart_000_000F_01C21DF5.C7734AD0
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
# Rules for the samba_t domain.=0A=
#=0A=
daemon_domain(samba)=0A=
type samba_etc_t, file_type, sysadmfile;=0A=
type samba_log_t, file_type, sysadmfile;=0A=
type samba_var_t, file_type, sysadmfile;=0A=
type samba_share_t, file_type, sysadmfile;=0A=
=0A=
# Permissions normally found in every_domain.=0A=
general_domain_access(samba_t)=0A=
general_file_read_access(samba_t)=0A=
general_proc_read_access(samba_t)=0A=
allow samba_t console_device_t:chr_file { read write };=0A=
allow samba_t null_device_t:chr_file { read write ioctl };=0A=
=0A=
# Use capabilities.=0A=
allow samba_t samba_t:capability { setgid setuid sys_resource =
net_bind_service lease };=0A=
=0A=
# Use the network.=0A=
can_network(samba_t)=0A=
=0A=
# Read/Write user home directories.=0A=
allow samba_t user_home_t:dir create_dir_perms;=0A=
allow samba_t user_home_t:file create_file_perms;=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow samba_t samba_etc_t:file { write setattr getattr read lock };=0A=
allow samba_t samba_etc_t:dir { search getattr };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow samba_t samba_var_t:dir { write remove_name add_name lock getattr =
search };=0A=
allow samba_t samba_var_t:file { lock unlink create write setattr read =
getattr rename };=0A=
=0A=
# Allow to use /dev/console.=0A=
allow samba_t init_t:fd { use };=0A=
=0A=
# Permissions to write log files.=0A=
allow samba_t samba_log_t:file { append getattr };=0A=
allow samba_t samba_log_t:dir { search };=0A=
=0A=
# Access Samba shares.=0A=
allow samba_t samba_share_t:dir create_dir_perms;=0A=
allow samba_t samba_share_t:file create_file_perms;=0A=
=0A=
allow samba_t samba_t: udp_socket recvfrom;=0A=

------=_NextPart_000_000F_01C21DF5.C7734AD0
Content-Type: application/octet-stream;
	name="samba.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="samba.fc"

# samba scripts=0A=
/usr/sbin/smbd			system_u:object_r:samba_exec_t=0A=
/usr/sbin/nmbd			system_u:object_r:samba_exec_t=0A=
/etc/samba(|/.*)		system_u:object_r:samba_etc_t=0A=
/var/log/samba(|/.*)		system_u:object_r:samba_log_t=0A=
/var/cache/samba(|/.*)		system_u:object_r:samba_var_t=0A=

------=_NextPart_000_000F_01C21DF5.C7734AD0--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
