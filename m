Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA01314
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 18:22:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA15952
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 22:21:32 GMT
Received: from snipe.mail.pas.earthlink.net (snipe.mail.pas.earthlink.net [207.217.120.62])
        by jazzband.ncsc.mil  with ESMTP id WAA15947 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 22:21:31 GMT
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: "'Russell Coker'" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 17:22:44 -0500
Message-ID: <001201c21e29$28ce5b20$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C21DFF.3FF85320"
In-Reply-To: <20020627221358.E813A7D5A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C21DFF.3FF85320
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On 6/27/02, Russell Coker wrote:

> Using a single file does not require using a single domain.  You can
have 
> separate domains for nmbd and smbd in the same file.

Good point. Although they require very close to the same privileges, so
I don't believe it matters too much in this case.

> Also better allow it to create it's log files...

Whoops. Yes, good point.

Ok, updated samba.te is attached.

-Ryan

------=_NextPart_000_0013_01C21DFF.3FF85320
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
allow samba_t samba_log_t:file { append getattr create };=0A=
allow samba_t samba_log_t:dir { search };=0A=
=0A=
# Access Samba shares.=0A=
allow samba_t samba_share_t:dir create_dir_perms;=0A=
allow samba_t samba_share_t:file create_file_perms;=0A=
=0A=
allow samba_t samba_t: udp_socket recvfrom;=0A=

------=_NextPart_000_0013_01C21DFF.3FF85320--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
