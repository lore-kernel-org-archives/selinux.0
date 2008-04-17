Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HD6ZoN019681
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 09:06:35 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HD6Y6U015190
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:06:35 GMT
Received: by fg-out-1718.google.com with SMTP id 16so43943fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 06:06:08 -0700 (PDT)
Message-ID: <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
Date: Thu, 17 Apr 2008 08:00:03 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Fwd: adding a new security class
In-Reply-To: <48073FC6.6040908@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <48073FC6.6040908@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---------- Forwarded message ----------
From: Daniel J Walsh <dwalsh@redhat.com>
Date: Thu, Apr 17, 2008 at 7:17 AM
Subject: Re: adding a new security class
To: Xavier Toth <txtoth@gmail.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>


-----BEGIN PGP SIGNED MESSAGE-----
 Hash: SHA1



 Xavier Toth wrote:
 > I'm trying to add a new security class for x copy/paste but I'm not
 > sure if I doing it right. I patched some headers in libselinux but
 > then I noticed the "Do not edit..." how are they generated, it doesn't
 > happen when I build from the source rpm? At this point I'm a bit
 > confused about how the connection is made between the policy class
 > definition and libselinux.
 >
 > Ted
 You need to add the code to selinux-policy/module/flask directory and
 then use the Makefile to generate these files.

 You should ask questions like this on the list, so others would learn,
 and more knowledgeable people can answer.  :^)
 -----BEGIN PGP SIGNATURE-----
 Version: GnuPG v1.4.9 (GNU/Linux)
 Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

 iEYEARECAAYFAkgHP8IACgkQrlYvE4MpobMTswCeLROTHlz9qQXCe9X5t9Kt7xJA
 rhwAnjHUvTkdftQiqOKd9t4HRs1q+LjA
 =VfvF
 -----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
