Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAEKJlDP024589
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 15:19:47 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAEKJkYJ007379
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 20:19:46 GMT
Message-ID: <473B5856.4020901@redhat.com>
Date: Wed, 14 Nov 2007 15:19:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: w.chimiak@ieee.org
CC: selinux@tycho.nsa.gov
Subject: Re: allow statement OK?
References: <200711091238.34883.w.chimiak@ieee.org>
In-Reply-To: <200711091238.34883.w.chimiak@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Chimiak wrote:
> I got a
> 
> 	avc: denied { search } for comm="pam_console_app" dev=sdb6 egid=650 euid=0 
> exe="/sbin/pam_console_apply" exit=-13 fsgid=650 fsuid=0 gid=650 items=0 
> name="gdm" pid=2693 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 
> sgid=650 subj=system_u:system_r:pam_console_t:s0-s0:c0.c1023 suid=0 
> tclass=dir tcontext=system_u:object_r:xserver_log_t:s0 tty=(none) uid=0 
> 
> 
> audit2allow recommended:
> 
> 	allow pam_console_t xserver_log_t:dir search;
> 
> Is this a reasonable module for me to add?  To me it seems benign.
> 
This is probably caused by a redirection stdout/stderr to the
xserver.log.  So when a confined app starts, the kernel checks the
access and closes the open file descriptors.  You could safely dontaudit
this access.

dontaudit pam_console_t xserver_log_t:dir search_dir_perms;


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHO1hWrlYvE4MpobMRAjxyAJwPIFbm633wiAhlJ2oe2oRGjuiomgCglo4B
ZnHgA1mLj3kaIDUlMe8XR6A=
=KEes
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
