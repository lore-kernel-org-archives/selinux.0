Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3LKOqJD028399
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2008 16:24:52 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3LKOph6029285
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2008 20:24:52 GMT
Message-ID: <480CF80B.5020103@redhat.com>
Date: Mon, 21 Apr 2008 16:24:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Herv=E9_WERNER?= <herve.werner@ensi-bourges.fr>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SELinux with NFSv4
References: <56222.82.246.196.177.1208808724.squirrel@webmail.ensi-bourges.fr>
In-Reply-To: <56222.82.246.196.177.1208808724.squirrel@webmail.ensi-bourges.fr>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hervé WERNER wrote:
> Hello,
> 
> 
> I'm a French student working on NFSv4 through SELinux. I would like to
> know where I could find information about this. Is there something I could
> try to make files labeling working with NFSv4? Is there a patch I could
> try?
> 
> I am especially looking for a simple method that makes me able to limit
> permissions for users through NFSv4, for exemple :
> - allowing only sysadm_t to read write and execute a file and not to
> normal users
> - allowing access to everybody
> 
> 
> 
> I would appreciate any advice.
> 
> 
> Hervé WERNER
> 
> 
NFS extended attribute discussion is happing on the SELinux NSA Mail
list <selinux@tycho.nsa.gov>

You can add a label to the NFS mount and make this not accessable by
normal users which would get you what you want.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgM+AsACgkQrlYvE4MpobNpmgCeNDDclNrFAesCwY6kTM8se2e7
CdoAnRNlBZPB4mtpzhodKMSW3sp5aQMW
=hPK3
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
