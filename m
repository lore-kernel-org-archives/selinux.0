Message-ID: <47CFFD4F.4000706@redhat.com>
Date: Thu, 06 Mar 2008 09:18:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Ronald van den Blink <selinux@a61.nl>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Unreserved portnumbers in corenetwork
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>	 <1204730645.14217.39.camel@gorn>	 <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>	 <1204733123.14217.48.camel@gorn>	 <DE51A2D4-4153-4E12-BAA8-0D2711553ECF@a61.nl>	 <1204735380.14217.60.camel@gorn>	 <6507AB86-A6D5-4314-BC06-86458D15C786@a61.nl> <47CF034E.2010407@redhat.com> <1204749406.1397.136.camel@moss-spartans.epoch.ncsc.mil> <47CF1616.1010201@redhat.com> <C5C7FABD-BA26-403D-82D2-8F5066620298@nall.com>
In-Reply-To: <C5C7FABD-BA26-403D-82D2-8F5066620298@nall.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joe Nall wrote:
> Why not just decouple the ports from the application by giving them
> names like port8080_t? This would allow multiple policies to be written
> to manage that resource, only one of which should be active at a time. 
> I think the real issue is the assumption that only one application will
> own ports like 80, 8080, 443 and 8443.
> 
> joe
I think the problem here is 65000 types.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfP/U8ACgkQrlYvE4MpobOkSACeO4El2XE56Vdunau/rTpggGjH
y3gAoMZ3c2QBfO37XKZg5p6jGUt5an/D
=UUGs
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
