Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9H7gsq028946
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 12:07:42 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9H7f9Z000554
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 17:07:41 GMT
Message-ID: <473493D3.9030200@redhat.com>
Date: Fri, 09 Nov 2007 12:07:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
CC: selinux@tycho.nsa.gov
Subject: Re: type class key
References: <1194529933.3293.7.camel@vogon>  <47336D33.4010606@redhat.com> <1194627412.3630.2.camel@vogon>
In-Reply-To: <1194627412.3630.2.camel@vogon>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefan Schulze Frielinghaus wrote:
> On Thu, 2007-11-08 at 15:10 -0500, Daniel J Walsh wrote:
> [...]
>> The avc's you are reporting above are very strange.  They look like
>> dovecot created a keyring, probably though pam_keyinit.  And now sshd is
>> trying to access it.  I think you are running in permissive mode and
>> your context is messed up.
>>
>> When you login are you getting user_t or staff_t?
> 
> Yeah your right. There is a different. The AVCs are only generated when
> I log in as a staff_t. I created a test user logged in as user_t and no
> AVCs where generated.
> 
> Hope you have more ideas because I run out of them ;-)
> 
Well for now I would just ignore or dontaudit them.  Since I believe
nothing used keyrings and the way it is setup in pam is all wrong right
now.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHNJPSrlYvE4MpobMRAtwOAJ4lVduXNjmMGp+BD+/sO1b2H66GIgCg46rN
7b1lN9q9nynOZwCa6+4LUJI=
=mlVE
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
