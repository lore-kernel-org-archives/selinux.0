Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h674POHa011347
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 00:25:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h674PHH5008461
	for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 04:25:17 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h674PHRX008458 for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2003 04:25:17 GMT
Subject: rssh.{te,fc}
From: Colin Walters <walters@verbum.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-47VJpgPtu7NHM8rcP/tP"
Message-Id: <1057551740.1241.10.camel@columbia>
Mime-Version: 1.0
Date: 07 Jul 2003 00:22:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-47VJpgPtu7NHM8rcP/tP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've written a quick rssh.te; this is for the rssh program:
http://pizzashack.org/rssh/

Basically rssh is a restricted shell that just allows people to execute
scp.

This is my first from-scratch .te file, so I'd appreciate if people
could give it a sanity check.  To set this all up, I added another user
(in this case named haskelluser), then added:

user haskelluser roles { rssh_r };

to /etc/selinux/users.  Make sense?

--=-47VJpgPtu7NHM8rcP/tP
Content-Disposition: attachment; filename=rssh.te
Content-Type: text/plain; name=rssh.te; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

#DESC Rssh - Restricted (scp/sftp) only shell
#
# Authors: Colin Walters <walters@verbum.org>
# X-Debian-Package: rssh
#

type rssh_t, domain, privlog, privfd;

role rssh_r types rssh_t;
allow system_r rssh_r;

type rssh_exec_t, file_type, sysadmfile, exec_type;
type rssh_archive_t, file_type, sysadmfile;
type rssh_home_t, file_type, sysadmfile;

general_domain_access(rssh_t);
uses_shlib(rssh_t);
base_file_read_access(rssh_t);
r_dir_file(rssh_t, etc_t);
r_dir_file(rssh_t, etc_runtime_t);
r_dir_file(rssh_t, locale_t);
can_exec(rssh_t, bin_t);

r_dir_file(rssh_t, rssh_home_t);
rw_dir_create_file(rssh_t, rssh_archive_t);

ifdef(`ssh.te',`
allow rssh_t sshd_t:fd use;
allow rssh_t sshd_t:tcp_socket rw_stream_socket_perms;
allow rssh_t sshd_t:unix_stream_socket rw_stream_socket_perms;
domain_auto_trans(sshd_t, rssh_exec_t, rssh_t);
r_dir_file(sshd_t, rssh_home_t);
')


--=-47VJpgPtu7NHM8rcP/tP
Content-Disposition: attachment; filename=rssh.fc
Content-Type: text/plain; name=rssh.fc; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

# rssh
/usr/bin/rssh			system_u:object_r:rssh_exec_t

--=-47VJpgPtu7NHM8rcP/tP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
