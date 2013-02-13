Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1DDgB7i002498
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2013 08:42:11 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r1DDg8rp027304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2013 08:42:09 -0500
Received: from [10.10.61.131] (vpn-61-131.rdu2.redhat.com [10.10.61.131])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r1DDg8Nj003012
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2013 08:42:08 -0500
Message-ID: <511B982F.3050502@redhat.com>
Date: Wed, 13 Feb 2013 08:42:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Monitoring the Openshift Logs each day for AVCs I am struct by how
 often we get AVC's for stuff that is blocked by DAC.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This causes SELinux to have a bad name, and we really need to cleanup the
kernel to make sure MAC Checks happen after DAC Checks.

Here is an example, of a UID running a program that attempts to create a file
in a directory which would be denied by dac.

type=PATH msg=audit(02/12/13 05:53:32.462:691259) : item=0
name=/var/run/netreport/3243 inode=258591 dev=ca:42 mode=dir,775 ouid=root
ogid=root rdev=00:00 obj=system_u:object_r:var_run_t:s0
type=CWD msg=audit(02/12/13 05:53:32.462:691259) :
cwd=/var/lib/openshift/c323ad7c3b48426eaa8bb13f4234a5e1/diy-0.1/logs
type=SYSCALL msg=audit(02/12/13 05:53:32.462:691259) : arch=x86_64
syscall=open success=no exit=-13(Permission denied) a0=7fff294849b0 a1=202c1
a2=0 a3=d items=1 ppid=3243 pid=12586 auid=c323ad7c3b48426eaa8bb13f4234a5e1
uid=c323ad7c3b48426eaa8bb13f4234a5e1 gid=c323ad7c3b48426eaa8bb13f4234a5e1
euid=c323ad7c3b48426eaa8bb13f4234a5e1 suid=c323ad7c3b48426eaa8bb13f4234a5e1
fsuid=c323ad7c3b48426eaa8bb13f4234a5e1 egid=root sgid=root fsgid=root tty=pts4
ses=37928 comm=netreport exe=/sbin/netreport
subj=unconfined_u:system_r:openshift_t:s0:c5,c283 key=(null)
type=AVC msg=audit(02/12/13 05:53:32.462:691259) : avc:  denied  { write } for
 pid=12586 comm=netreport name=netreport dev=xvde2 ino=258591
scontext=unconfined_u:system_r:openshift_t:s0:c5,c283
tcontext=system_u:object_r:var_run_t:s0 tclass=dir

As a policy writer I either have to add a bogus dontaudit on this or have
customers,

I have seen regularly seen Capability checks, rawip_sockets, mmap_zero etc
that would be blocked by DAC, and yet we generate an ugly MAC AVC.

I realize in some cases we might want to know if users are trying to do evil
things, but almost all cases the user just is executing applications that
generate an AVC for something that without SELinux turned on would have been
blocked and the user would not be aggravated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEbmCwACgkQrlYvE4MpobMWlQCfaF7D0FFKGjdOF1etM/sm4iSm
4gsAoJaxASgOxmdwnevzOzj5yUzTAhv4
=Geca
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
