Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9TCTQUh023151
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 08:29:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9TCRsnM009623
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 12:27:54 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m9TCTOE7032410
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 08:29:24 -0400
Message-ID: <49085722.7010901@redhat.com>
Date: Wed, 29 Oct 2008 08:29:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: user guide draft: "Examples: Booleans for NFS"
References: <4905320C.4090807@redhat.com>
In-Reply-To: <4905320C.4090807@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murray McAllister wrote:
> Hi,
> 
> The following is a draft for the "Booleans" section. Any comments or
> corrections are appreciated:
> 
> Examples: Booleans for NFS and CIFS
> 
> By default, NFS mounts on the client side are labeled with a default
> context defined by policy for NFS file systems. In common policies, this
> default context uses the nfs_t type. Also, by default, Samba shares
> mounted on the client side are labeled with a default context defined by
> policy. In common policies, this default context uses the cifs_t type.
> 
> Depending on policy configuration, services, such as Apache HTTP Server
> and Samba, may not be able to read files labeled with the nfs_t or
> cifs_t types. This may prevent file systems labeled with these types
> from being mounted and then read or exported by other services. Booleans
> can be turned on or off to control which services are allowed to access
> the nfs_t and cifs_t types.
> 
> The setsebool and semanage commands must be run as the Linux root user.
> The setsebool -P command makes persistent changes. Do not use the -P
> option if you do not want changes to persist across reboots:
> 
> Apache HTTP Server
> 
> To allow access to NFS file systems (files labeled with the nfs_t type):
> /usr/sbin/setsebool -P httpd_use_nfs on
> 
> To allow access to Samba file systems (files labeled with the cifs_t type):
> /usr/sbin/setsebool -P httpd_use_cifs on
> 
> Samba
> 
> To export NFS file systems:
> /usr/sbin/setsebool -P samba_share_nfs on
> 
> FTP (vsftpd)
> 
> To allow access to NFS file systems:
> /usr/sbin/setsebool -P allow_ftpd_use_nfs on
> 
> Other Services
> 
> For a list of NFS related Booleans for other services:
> /usr/sbin/semanage boolean -l | grep nfs
> 
> For a list of Samba related Booleans for other services:
> /usr/sbin/semanage boolean -l | grep cifs
> 
> Thanks.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Looks good, only problem with describing booleans is that they might not
exist on all versions of policy.  The description above will require 5.3
policy on RHEL5.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkIVyIACgkQrlYvE4MpobONxgCePfsQzcXhWMt2vn6hFsS4QWbZ
3QYAn17S7SzQ7AmbXEwQP9x+ymkthqgW
=m5MJ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
