Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA24005
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 03:13:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA18341
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 07:13:11 GMT
Received: from flamingo.mail.pas.earthlink.net (flamingo.mail.pas.earthlink.net [207.217.120.232])
	by jazzswing.ncsc.mil  with ESMTP id HAA18337
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 07:13:11 GMT
Received: from crtntx1-ar7-4-35-055-006.crtntx1.elnk.dsl.genuity.net ([4.35.55.6] helo=donkey)
	by flamingo.mail.pas.earthlink.net with esmtp (Exim 3.33 #2)
	id 17NTTD-00060c-00
	for selinux@tycho.nsa.gov; Thu, 27 Jun 2002 00:13:36 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Configuration issues on a new installation
Date: Thu, 27 Jun 2002 02:13:37 -0500
Message-ID: <001701c21daa$28a60550$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0018_01C21D80.3FCFFD50"
In-Reply-To: <20020626224924.43C026E2@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C21D80.3FCFFD50
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

> Yes, they probably have.  But most of them seem to have suffered in 
> silence. It seems that I'm the only SE Linux user who is spending any
> time writing policy files and then publishing them.

Hah, tonight I've actually been working on policy files for Samba. This
is my first time dabbling with domains - could any of you who are much
more versed with SELinux take a quick look and tell me if everything
seems in order?

I haven't had anything denied recently, but that's when Samba's being
used for my purposes. Your mileage may vary. The above files also
required a small change to the dhcpc domain, adding:

allow dhcpc_t nmbd_t:packet_socket recvfrom;
allow dhcpc_t smbd_t:packet_socket recvfrom;
allow dhcpc_t tcp_socket_t:packet_socket recvfrom;

Feeback is highly appreciated. No better way to get used to SELinux than
jumping in head-first...

-Ryan

------=_NextPart_000_0018_01C21D80.3FCFFD50
Content-Type: application/octet-stream;
	name="smbd.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="smbd.te"

#=0A=
# Author: Ryan Bergauer (bergauer@rice.edu)=0A=
#=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the smbd_t domain.=0A=
#=0A=
type smbd_t, domain, privlog;=0A=
role system_r types smbd_t;=0A=
every_domain(smbd_t)=0A=
type smbd_exec_t, file_type, sysadmfile, exec_type;=0A=
domain_auto_trans(initrc_t, smbd_exec_t, smbd_t)=0A=
=0A=
type samba_etc_t, file_type, sysadmfile;=0A=
type samba_log_t, file_type, sysadmfile;=0A=
=0A=
# Use capabilities.=0A=
allow smbd_t smbd_t:capability { setgid setuid sys_resource =
net_bind_service lease };=0A=
=0A=
# Use the network.=0A=
can_network(smbd_t)=0A=
=0A=
# Read user home directories.=0A=
allow smbd_t home_type:dir r_dir_perms;=0A=
allow smbd_t home_type:file r_file_perms;=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow smbd_t samba_etc_t:file { write setattr getattr read lock };=0A=
allow smbd_t samba_etc_t:dir { search getattr };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow smbd_t var_t:dir { write remove_name add_name };=0A=
allow smbd_t var_t:file { unlink create write setattr };=0A=
=0A=
# Allow to use /dev/conole.=0A=
allow smbd_t init_t:fd { use };=0A=
=0A=
# Permissions to write log files.=0A=
allow smbd_t samba_log_t:file { append getattr };=0A=
allow smbd_t samba_log_t:dir { search };=0A=

------=_NextPart_000_0018_01C21D80.3FCFFD50
Content-Type: application/octet-stream;
	name="nmbd.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nmbd.fc"

# smbd scripts=0A=
/usr/sbin/nmbd			system_u:object_r:nmbd_exec_t=0A=

------=_NextPart_000_0018_01C21D80.3FCFFD50
Content-Type: application/octet-stream;
	name="nmbd.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nmbd.te"

#=0A=
# Author: Ryan Bergauer (bergauer@rice.edu)=0A=
#=0A=
=0A=
#################################=0A=
#=0A=
# Rules for the nmbd_t domain.=0A=
#=0A=
type nmbd_t, domain, privlog;=0A=
role system_r types nmbd_t;=0A=
every_domain(nmbd_t)=0A=
type nmbd_exec_t, file_type, sysadmfile, exec_type;=0A=
domain_auto_trans(initrc_t, nmbd_exec_t, nmbd_t)=0A=
=0A=
# Use capabilities.=0A=
allow nmbd_t nmbd_t:capability { net_bind_service };=0A=
=0A=
# Use the network.=0A=
can_network(nmbd_t)=0A=
=0A=
# Permissions for Samba files in /etc/samba=0A=
allow nmbd_t samba_etc_t:file { write getattr read };=0A=
allow nmbd_t samba_etc_t:dir { search };=0A=
=0A=
# Permissions for Samba cache files in /var/cache/samba=0A=
allow nmbd_t var_t:file { unlink rename create write setattr };=0A=
allow nmbd_t var_t:dir { write remove_name add_name };=0A=
=0A=
# Allow to use /dev/conole.=0A=
allow nmbd_t init_t:fd { use };=0A=
=0A=
# Permissions to write log files.=0A=
allow nmbd_t samba_log_t:file { append getattr };=0A=
allow nmbd_t samba_log_t:dir { search };=0A=
=0A=
# Initrc permissions.=0A=
allow nmbd_t initrc_t: packet_socket recvfrom;=0A=
allow nmbd_t initrc_t: udp_socket recvfrom;=0A=
=0A=
allow nmbd_t nmbd_t: udp_socket recvfrom;=0A=

------=_NextPart_000_0018_01C21D80.3FCFFD50
Content-Type: application/octet-stream;
	name="smbd.fc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="smbd.fc"

# smbd scripts=0A=
/usr/sbin/smbd			system_u:object_r:smbd_exec_t=0A=
/etc/samba(|/.*)		system_u:object_r:samba_etc_t=0A=
/var/log/samba(|/.*)		system_u:object_r:samba_log_t=0A=

------=_NextPart_000_0018_01C21D80.3FCFFD50--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
