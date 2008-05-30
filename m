Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4UJSlrT004849
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 15:28:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4UJSj4l027716
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 19:28:46 GMT
Message-ID: <48405512.2040503@redhat.com>
Date: Fri, 30 May 2008 15:27:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: Matthew Hammer <matthewhammer89@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: question about security
References: <dd18b0c30805301004h5c9bbf7fmb4bfced81264b8c2@mail.gmail.com>	 <20080530135146.11fa7b83@matthew-laptop> <dd18b0c30805301157x661896c4j65655167ba22df07@mail.gmail.com>
In-Reply-To: <dd18b0c30805301157x661896c4j65655167ba22df07@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Justin Mattock wrote:
| On Fri, May 30, 2008 at 5:51 PM, Matthew Hammer
| <matthewhammer89@gmail.com> wrote:
|> On Fri, 30 May 2008 17:04:41 +0000
|> "Justin Mattock" <justinmattock@gmail.com> wrote:
|>
|>> Hello; First I need to start with a status: SELinux seems to be
|>> handling nicely with the latest git, and refpolicy. You guys really do
|>> a good job.
|>> Now for the question: I noticed reading the New York Times that
|>> Comcast was hacked into, after reading the article I couldn't help but
|>> ask the question
|>> of "If comcast was using Linux with SELinux would this have happened".
|>> So the question to SELinux is: If Comcast was using Linux, with
|>> SELinux on there servers
|>> would this attack have been prevented? What should Comcast have had
|>> with there set up to better protect them from this type of
|>> attack?(even though they probably use windows)
|>> How would regular users and small businesses protect themselves from
|>> this type of terrorism?
|>> regards;
|> My understanding of the comcast hack was that the hackers altered
|> Comcast's registration information with the vendor that registers their
|> domain. So no, the problem wasn't anything internal with comcast's own
|> system.
|>
|> --
|> Matthew Hammer
|>
|
| AAhh I see, the vendor that registers their domain.
|
Of course the next question is whether the vendor who registers their
doimains had been running SELinux, could it be stopped, and there is a
good possibility.

Depending on the Version, SELinux prevents most buffer overflow attacks
on confined domains.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhAVPQACgkQrlYvE4MpobPWSwCfQnk59XT5A7vZ/hL8JtHJGBj5
9fkAoJ+RKyeW/Vcd86U7syYUK9T17zwR
=tzTL
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
