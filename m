Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8U4CJrT021152
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 00:12:21 -0400 (EDT)
Received: from raq0.openthought.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8U4CJog008461
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 04:12:19 GMT
Date: Thu, 30 Sep 2004 04:09:32 +0000
From: Eric Andreychek <eric@openthought.net>
To: selinux@tycho.nsa.gov
Subject: Re: purpose of the staff_r role?
Message-ID: <20040930040932.GB17135@rwcwarranty.com>
References: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Howdy,

On Wed, 29 Sep 2004, Tom Anderson wrote:
> SE Linux appears to be quite powerful, but dear $deity it's confusing. 

- From one new SELinux user to another, keep tinkering around with it, it'll
start to make sense :-)  You're right, it is really powerful.  Don't be afraid
to get in there and work with the policies (just make a backup, RCS is your
friend ;-)

Nothing will help you figure it out quicker than building a policy for a daemon
without one :-)

> I'd sell my soul for a nice, readable O'Reilly Press title covering
> this stuff!

Well, lucky for you, you might not need to go quite that far ;-)

It looks like O'Reilly will be releasing one named "SELinux NSA's Open Source
Security Enhanced Linux" by Bill McCarty pretty soon:

  http://www.oreilly.com/catalog/selinux/index.html

The estimated release date is October.  I'm looking forward to that myself.

Good luck!
  -Eric

- -- 
 Eric Andreychek              | Lucy: "What happens if you practice the
 Eric Conspiracy Secret Labs  |  piano for 20 years and then end up not
 eric@openthought.net         |  being rich and famous?"
 http://openthought.net       | Schroeder: "The joy is in the playing."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBW4b8R5UKaDAjAG4RAhRhAKDgM8GT9BZxRFcHqcBMk7/QMRENyACcDFbu
cys8mXtVF8yKvu8VuH0MXJA=
=2hWg
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
