Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA22714
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:05:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA27695
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:04:24 GMT
Received: from sendmail (savages.net [208.170.193.18])
        by jazzband.ncsc.mil  with ESMTP id QAA27691 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:04:20 GMT
Message-ID: <3C98B2BF.9090706@pcez.com>
Date: Wed, 20 Mar 2002 08:03:11 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020320133514.46E8075B8@lyta.coker.com.au> <3C989C1D.30500@pcez.com> <20020320153129.C4B3EC61D@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



|>
|>I would like to see SELinux in the schools, hospitals, police/fire
|>stations, in ~ dept. of fish and wildlife offices.
|
|
| What is needed for that is a set of "teacher machine" policy files for SE
| Linux, a set of "student workstation" policy files, a set of "student
| time-share machine" policy files and a set of Police policy files.  All these
| would have to be quite different (although teacher machines and Police
| machines would have similar requirements).
|
|

Yes, each one would have a setup but there are common policies.

|
|
| That requires huge amounts of work writing policy files.  Some of my policy
| files have taken me more than a day's work.  I am getting better at it now,
| but I've still got to do Postfix which will be really painful.
|

I am trying to secure courier mail system, What a pain.

Shaun
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE8mLK9n6I06Opz+XURAmq8AJ9qe7Q+bbxl7y1O5CuzrVgTg8zr2gCglQzc
Jh7pib672OpJV5RlUjpCjug=
=WD2a
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
