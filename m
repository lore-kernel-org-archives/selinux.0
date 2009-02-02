Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n12JtpS5012748
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 14:55:51 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n12JqhcS015334
	for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2009 19:52:44 GMT
Message-ID: <49874FBD.7020907@redhat.com>
Date: Mon, 02 Feb 2009 14:55:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: filesystem mount AVC denial
References: <7b4dai$ejec6@dmzms99901.na.baesystems.com>
In-Reply-To: <7b4dai$ejec6@dmzms99901.na.baesystems.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clarkson, Mike R (US SSA) wrote:
> I got the following AVC denial in the audit logs and I'm wondering what
> would cause this:
> 
> type=AVC msg=audit(1232734163.528:997720):avc: denied { mount } for
> pid=28016 comm="find" name="/" dev=0:1c ino=0
> scontext=root:staff_r:libstart_t:s0-s4:c0.c255
> tcontext=system_u:object_r:nfs_t:s0 tclass=filesystem
> 
> The program running in the libstart_t domain is using the "find" cmd,
> and find is requiring the "mount" permission. Could this be caused by
> "find" traversing into an automounted (NFS) directory? But in that case
> I would expect the automount daemon, which is running in the automount_t
> domain, to do the mounting.
> 
> Thanks
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

The autofs maintainers have asked me to ask you to file a bug on autofs
and include the data requested on

http://people.redhat.com/jmoyer/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmHT7wACgkQrlYvE4MpobNqzACdHuAdi31QNzlp8bASxiQaLp0/
VtwAn0kAZG1Zm0kYSxqTJleKEubo/GpV
=BZQV
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
