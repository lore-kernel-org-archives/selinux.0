Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JJFiI4005961
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 15:15:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JJFMQj018436
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 19:15:22 GMT
Received: from datas-world.dyndns.org (dsl-213-023-225-006.arcor-ip.net [213.23.225.6])
	by jazzswing.ncsc.mil  with ESMTP id h4JJFKxS018426
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 19:15:21 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
To: selinux@tycho.nsa.gov
Subject: Re: matrix
Date: Mon, 19 May 2003 21:15:32 +0200
References: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com>
In-Reply-To: <C540EABA36FDD41189FD00508BAF8E850149266A@atsgroup.saic.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200305192115.33548.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> http://news.bbc.co.uk/2/hi/technology/3039329.stm
> Above is an article about hacking in the movie Matrix Reloaded.
> > In the film Trinity gets the highest level of access to the target
> > machine by using a real-world loophole called "SSH1 CRC32".
> Fortunately for Trinity the power company wasn't using SE Linux.  When
> using
> SE Linux the loophole would not grant the highest level of access and the
> movie would have a very different ending.  ;)
I wouldn't bet, that SE Linux would make this impossible, at least not with 
Russell's policy and some minor insecurities in the rest of the network. The 
ssh process doesn't need to have all rights. It was reported, that rootkits 
where installed. Yes, this is not possible. But when I understand the policy 
right, at least rw access to the key file is possible (why?). Also var_log is 
readable. This combined with dns- or arp-spoofing should allow to spoof the 
ssh server. Now it's possible to get the password of the user. Mostly 
security systems aren't there to secure themselves, but the data they secure. 
And there is surely a user with ssh access, and access to all data.
Something wrong in my thoughts?

Regards
	Torsten
- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yS1UvxZktkzSmiwRAnS+AJ99YDFF/GXTPhNmn1LgysoH8NUVJwCfZfc5
OiOAEx5vLw5pYVb6xZ8YT1o=
=Rxu4
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
