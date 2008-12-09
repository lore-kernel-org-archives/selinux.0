Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB9L3EHk029156
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2008 16:03:14 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mB9L11KC013032
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2008 21:01:01 GMT
Message-ID: <493EDD04.4050909@redhat.com>
Date: Tue, 09 Dec 2008 16:03:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: erahul29@yahoo.com
CC: selinux@tycho.nsa.gov
Subject: Re: Non root user cannot execute semanage, semodule
References: <829347.35568.qm@web50202.mail.re2.yahoo.com>
In-Reply-To: <829347.35568.qm@web50202.mail.re2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rahul Jain wrote:
> Hi All,
>  
> I am currently developing a Role Based Access Solution on Montavista linux using SELiunx. I started my implementaion with the reference policy from Tresys. In this implementation I had assigned a role of security officer to one of my non root Linux user. This user is resposible for maintaining SELinux related tasks such as creation, building of policy etc. But this user of mine, being a non root user is not able to execute some priviledged commands such as semodule and semanage. 
> Is there any in which I can permit a non root user execute these commands.
>  
> Thanks and Regards
> Rahul Jain
> 
> 
>       
sudo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkk+3QQACgkQrlYvE4MpobOgwgCdHCpxAP2hqRPSI17OLLy0tO4a
FAoAmwZa914C1wlLGPV2HZ3+BGPmv9ZG
=zE1X
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
