Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA20462
	for <selinux@tycho.nsa.gov>; Fri, 23 Aug 2002 16:51:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07404
	for <selinux@tycho.nsa.gov>; Fri, 23 Aug 2002 20:50:47 GMT
Received: from mx.nas-smoothtransition.com ([66.95.157.155])
	by jazzswing.ncsc.mil  with ESMTP id UAA07400
	for <selinux@tycho.nsa.gov>; Fri, 23 Aug 2002 20:50:47 GMT
Received: from acme ([66.200.42.2])
	by mx.nas-smoothtransition.com (8.11.4/8.9.3) with SMTP id g7NKugg32659
	for <selinux@tycho.nsa.gov>; Fri, 23 Aug 2002 16:56:42 -0400
From: "david caplan" <dac@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: ipop3d policy
Date: Fri, 23 Aug 2002 16:53:48 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGOEKKCEAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0055_01C24AC5.A698F510"
In-Reply-To: <20020823134009.D43578C4C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0055_01C24AC5.A698F510
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Attached is a .te file for ipop3d.  I didn't see any policy for a pop
daemon, other than in Russell's courier.te.  Any comments would be
appreciated.

As far as file contexts go, I just have file_contexts/program/ipop3d.fc:

/usr/local/sbin/ipop3d          system_u:object_r:popd_exec_t

Also, in testing, I found that I needed to add the following to sendmail.te:

allow sendmail_t user_home_t:dir r_dir_perms;

I'm not sure if this is just how this particular machine was set up, or if
that should be added to the base policy file.

David


------=_NextPart_000_0055_01C24AC5.A698F510
Content-Type: application/octet-stream;
	name="ipop3d.te"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ipop3d.te"

#
# Author: Tresys Technology, LLC.=20
#         selinux@tresys.com
#

#################################
#
# Rules for the popd_t domain.
#
# Much of the networking capabilities were not included as this
# is handled through the xinetd interface.  If pop were not run
# through xinetd, then some networking access needs to be added.

# don't need the port def because we're using xinetd to fire off
#type popds_port_t, port_type;

type popd_t, domain, privlog, auth;
role system_r types popd_t;

# testing -- for keys
type pem_t, file_type, sysadmfile;
allow popd_t pem_t:file { read getattr };

every_domain(popd_t)
type popd_exec_t, file_type, sysadmfile, exec_type;
# allow xinetd to fire off pop daemon
domain_auto_trans(inetd_t, popd_exec_t, popd_t)

# Inherit and use descriptors from xinetd.
allow popd_t inetd_t:fd use;

# Use sockets inherited from xinetd.
allow popd_t inetd_t:tcp_socket rw_stream_socket_perms;

# Use capabilities.
# don't seem to need: { net_bind_service setuid setgid fowner fsetid =
chown sys_resource sys_chroot };
allow popd_t popd_t:capability {  setuid setgid  };


# make sure pop has its own tmp/lock files
type popd_tmp_t, file_type, sysadmfile, tmpfile;
allow popd_t popd_tmp_t:dir create_dir_perms;
allow popd_t popd_tmp_t:file create_file_perms;
# for tmp files
file_type_auto_trans(popd_t, tmp_t, popd_tmp_t)
# for mbox lock files in home dirs
file_type_auto_trans(popd_t, user_home_t, popd_tmp_t)

# Use the network.
# Is this excessive? (probably)
can_network(popd_t)

# Connect to xinetd.
can_tcp_connect(popd_t,inetd_t)

# Send SIGCHLD to xinetd on death.
allow popd_t inetd_t:process sigchld;

# Write to /var/spool/mail=20
allow popd_t mail_spool_t:dir rw_dir_perms;
allow popd_t mail_spool_t:file create_file_perms;

# need to define file type for mbox to restrict this further
# though this is also used for .forward (and .procmailrc?)
allow popd_t user_home_t:file rw_file_perms;
allow popd_t user_home_t:dir rw_dir_perms;


------=_NextPart_000_0055_01C24AC5.A698F510--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
