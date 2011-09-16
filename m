Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GFwcxg027117
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 11:58:38 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GFwbej012302
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 15:58:37 GMT
Message-ID: <4E737223.1060601@redhat.com>
Date: Fri, 16 Sep 2011 11:58:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@yahoo.com>
CC: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com> <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
In-Reply-To: <4E7369AF.3000709@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/16/2011 11:22 AM, Justin P. Mattock wrote:
> On 09/16/2011 07:59 AM, Daniel J Walsh wrote:
>> ps -eZ |grep sshd
> I dont have sshd running, but here is ps auxZ to give you an idea
> of what I am seeing: http://fpaste.org/u6IB/
> 
> if I adjust /etc/pam.d/login and add select_context to
> pam_selinux.so then do init 3 in lilo I am able to have the
> context justin:staff_r:staff_t:s0  the way it should. but as soon
> as I init 5 gdm starts up, and everything goes back to
> name:staff_r:insmod_t:s0
> 
> I think I am either missing a boolean to have the transisiton
> runing properly, and/or pam.d or some config file somewhere needs
> to be adjusted. keep in mind refpolicy has no patches added to
> it(not sure if I need any for systemd), just plain git pull
> etc...
> 
> Justin P. Mattock
Well since you don't have a init_t running, I think your problem
starts there.  Looks like your system is badly mislabeled or something
in init is broken.   I take it this is not a Red Hat Based OS?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5zciMACgkQrlYvE4MpobOs4wCcD/KSvuhb5GxhPCZcMEDGI1dD
X70AnR2OLyUzsaLlDRmP0jm7ABwzFHBj
=aH02
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
