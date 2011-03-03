Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p23DlRbB001550
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2011 08:47:27 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p23DlPCB024750
	for <selinux@tycho.nsa.gov>; Thu, 3 Mar 2011 13:47:26 GMT
Message-ID: <4D6F9BEC.6000601@redhat.com>
Date: Thu, 03 Mar 2011 08:47:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: waqar afridi <afridi.waqar@gmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: Need Help Compiling Reference Policy on Mobile Device
References: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
In-Reply-To: <AANLkTinhRsFY0V-tjXCfsVz2D4kc5AK9MytnBzdh6Qk3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/03/2011 05:28 AM, waqar afridi wrote:
> Hello All
> 
> Its Me Again, Now I am compiling the Reference Policy on a mobile Device
> (Openmoko), I have also done this Before and that time it was successful but
> Now when I "make load" it, The Following happens
> 
> 
> Sorry I wasn't Able to Scroll up as it all went away...
> 
Might be memory constraints.  You can set flags in
/etc/selinux/semanage.conf to tell it how much memory to use look at

http://selinuxproject.org/page/GlobalConfigurationFiles
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1vm+wACgkQrlYvE4MpobMsNQCg2HcL20Ym+jeSNG/86isZ0vs4
Yz0AoNjY1KJrBdoB+YjAKrK/xyD5+C+w
=8Gdz
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
