Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1RM96Th019866
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 17:09:06 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1RM5Ye0003549
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2009 22:05:34 GMT
Message-ID: <49A8646A.5050604@redhat.com>
Date: Fri, 27 Feb 2009 17:08:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to libsemanage to remove labeling of /root
References: <496C9A96.1080805@redhat.com> <499C2D9F.4040806@manicmethod.com> <499C32C8.2020700@redhat.com> <200902271322.18928.russell@coker.com.au>
In-Reply-To: <200902271322.18928.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell Coker wrote:
> On Thu, 19 Feb 2009, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> The problem with treating /root as the same as every other homedir, is
>> confined daemons all consider /root their home dir, so they want to be
>> able to read/write contents in the homedir.
> 
> We should not be allowing confined daemons to write to /root.
> 
> There is little point in confining a daemon if it can write to a file such 
> as /root/.bashrc which is likely to be executed as unconfined_t.
> 
> The only reason a confined daemon should access /root is if the sysadmin 
> starts it immediately after logging in without changing directory.  A daemon 
> starting with a cwd that is not accessible should not be a problem, if it is 
> then there are other usage cases that will get you.
> 
There is potential to allow confine domains to write to subdirs of
/root. or at least read it.

sshd_t needs to be able to read /root/.ssh/*

Others like xauth_t need to be able to write but this is more a confined
helper app then a real confined app.

In current targeted policy I see the following

# sesearch --allow -t admin_home_t  -c dir | grep write | awk '{ print
$2 " " $3 }'
sysadm_t admin_home_t
rpm_t admin_home_t
rpm_script_t admin_home_t
xauth_t admin_home_t
nfsd_t admin_home_t
nmbd_t admin_home_t
smbd_t admin_home_t
ftpd_t admin_home_t
kernel_t admin_home_t

Where these are either an unconfined_domain or have a boolean that
allows them to write anywhere.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmoZGoACgkQrlYvE4MpobPtjQCfYRtnQvjRxdEwk5Fugev1fs+M
33sAoN+LFFJS37gpGNAY/MIMSr5vlick
=DiAa
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
