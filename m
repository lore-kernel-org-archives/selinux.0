Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7Q7XNrT011402
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 03:33:25 -0400 (EDT)
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7Q7XL0g005361
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 07:33:22 GMT
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1C0El8-0004n3-00
	for selinux@tycho.nsa.gov; Thu, 26 Aug 2004 09:33:22 +0200
Received: from pd953a87a.dip.t-dialin.net ([217.83.168.122] helo=localhost)
	by mrelayng.kundenserver.de with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 3.35 #1)
	id 1C0El6-0008Tn-00
	for selinux@tycho.nsa.gov; Thu, 26 Aug 2004 09:33:20 +0200
Date: Thu, 26 Aug 2004 09:33:21 +0200
From: Stefan SF <stefan@sf-net.com>
To: selinux@tycho.nsa.gov
Subject: Re: policy for scponly - need help
Message-ID: <20040826073321.GA16772@crux.sternplastic>
References: <20040819173620.GA8543@crux.localdomain> <1092967183.29540.30.camel@nexus.verbum.private> <20040820080156.GA8602@crux.sternplastic> <1093009277.4336.11.camel@nexus.verbum.private> <20040820162215.GA15914@crux.sternplastic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
In-Reply-To: <20040820162215.GA15914@crux>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

ok, I've altered the rules and hope that there is no big hole in it ;-)
So here are the files:



domains/program/scponly.te
#DESC scponly - A shell which provides only scp/sftp access
#
# It's based on Colin Walters "rssh" policy

type scponly_exec_t, file_type, exec_type, sysadmfile;

ifdef(`ssh.te',`
allow sshd_t scponly_exec_t:file { getattr execute read };
allow trade_t scponly_exec_t:file { entrypoint };
')



macros/program/scponly_macros.te
#DESC scponly - A shell which provides only scp/sftp access
#
# It's based on Colin Walters "rssh" policy

undefine(`scponly_domain')
ifdef(`scponly.te', `
define(`scponly_domain',`
type scponly_$1_t, domain, userdomain, privlog, privfd;
role scponly_$1_r types scponly_$1_t;
allow system_r scponly_$1_r;

# types for correct labeling
type scponly_$1_home_dir_t, file_type, sysadmfile;
type scponly_$1_home_t, file_type, sysadmfile;
type scponly_$1_home_ssh_t, file_type, sysadmfile;

# types for read and write
type scponly_$1_rw_t, file_type, sysadmfile;
type scponly_$1_ro_t, file_type, sysadmfile;

general_domain_access(scponly_$1_t);
uses_shlib(scponly_$1_t);
base_file_read_access(scponly_$1_t);
r_dir_file(scponly_$1_t, etc_t);
r_dir_file(scponly_$1_t, etc_runtime_t);
can_exec(scponly_$1_t, bin_t);

# basic read/write
r_dir_file(scponly_$1_t, scponly_$1_ro_t);
create_dir_file(scponly_$1_t, scponly_$1_rw_t);

# scponlyc needs to chroot
allow scponly_$1_t scponly_$1_t:capability { dac_override dac_read_search setuid sys_chroot };
allow scponly_$1_t scponly_$1_home_dir_t:dir { getattr read search };
allow scponly_$1_t scponly_$1_ro_t:file { execute execute_no_trans };

ifdef(`ssh.te',`
allow scponly_$1_t sshd_t:unix_stream_socket rw_stream_socket_perms;
r_dir_file(sshd_t, scponly_$1_ro_t);
domain_trans(sshd_t, scponly_exec_t, scponly_$1_t);
')
')

', `

define(`scponly_domain',`')

')



file_contexts/program/scponly.fc
/usr/bin/scponly                system_u:object_r:scponly_exec_t
/usr/sbin/scponlyc              system_u:object_r:scponly_exec_t



domains/misc/local.te
scponly_domain(user)



ciao, Stefan

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLZJBUEn3BeoPvtwRAjSdAJ9luFYYZyHigmzbhgaAKL5rxYdrSQCeIhVO
tX32fchEsBMziFAVm/fJdYo=
=rIgU
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
