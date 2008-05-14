Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EDeaU8004490
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 09:40:36 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EDeZpO006646
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 13:40:35 GMT
Message-ID: <482AEBA8.7090604@redhat.com>
Date: Wed, 14 May 2008 09:39:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@tanso.net>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RHEL5 initrc_t vs. unconfined_t
References: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com>
In-Reply-To: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan-Frode Myklebust wrote:
| I'm running IBM's GPFS filesystem on RHEL5, and am having some
| problems with selinux blocking some ifconfig's the GPFS daemons wants
| to launch. GPFS works fine if launched manually, but not when started
| from the initscripts. So, is there any way to say that this initscript
| should run unconfined, instead of as initrc_t where things might
| transition to other domains ?
|
The problem is exactly the opposite of what you are asking.
unconfined_t transitions to very few domains currently while initrc_t
transitions to many.  unconfined_t is a logged in user domain.  So I
would not run init scripts as unconfined_t.

The better answer is to fix the avc's that you are seeing when trying to
run ifconfig from initrc.  What avc's are you seeing?
Dan
|
|   -jf
|
| --
| This message was distributed to subscribers of the selinux mailing list.
| If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
| the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgq66gACgkQrlYvE4MpobNknACeIgsW7idj8zE+QQJXTvHN333H
y4wAoIG1cYKwU2zfhpGB5YWJqOjJHtYI
=CrWK
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
