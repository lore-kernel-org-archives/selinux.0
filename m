Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA21979
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 09:28:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA22140
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 14:27:37 GMT
Received: from sendmail (savages.net [208.170.193.18])
        by jazzband.ncsc.mil  with ESMTP id OAA22136 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 14:27:35 GMT
Message-ID: <3C989C1D.30500@pcez.com>
Date: Wed, 20 Mar 2002 06:26:37 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
References: <Pine.GSO.4.33.0203150854350.15480-100000@raven> <20020320102215.78752232D@lyta.coker.com.au> <3C988239.2080200@pcez.com> <20020320133514.46E8075B8@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



|
|
| Single user mode is effectively a reboot for users of the system.
|
Yes

|
| Check in what sense?  Checking for syntax errors should be easy enough,
| checking for dependencies with other .te's without actually compiling it will
| be difficult, checking for stupid mistakes should be possible, but checking
| for subtle mistakes or malicious omissions will be impossible.
|

I look at the policy as a giant state machine.  The checking could/should be
done off line.  By using the same concepts used in VLSI design, a software
program could look for nasties. Sounds like a great thesis :) Any one want to
send me to school again? I have work on it some and have a few things worked out
but  it would be a two year effort to have something that would get the  test
coverage needed.

|
| I was thinking of having the usual sysadm_t domain write it.  But you may be
| right, it might make sense to have a special domain to do it.
|
|
|>In situations that REQUIRE super verified security, then the packages them
|>self will be "certified" for that platform and configuration. What
|>"certified" means, I don't know.
|
|
| You still can't do pre-packaged .te's that are complete and fully
| restrictive.  Consider the issue of which source of password data to use
| through nss.  Consider the issue of which Apache modules are loaded.  These
| things can require substantial and subtle changes to many settings.
|

I agree, but what I am saying is There can be a standard install and standard
packages. The The standard is not fully restrictive. you try for 99.99% not
99.999% It will be a subset of a full system. If a/the company wants the 99.999%
security and flexability the need to hire us to do it.
|
|
| The average admin can't properly deal with standard unix permissions.  The
| average admin can't compile their own kernel.  Is SE Linux ever going to be
| for the average admin?
|

Yes, I would like a distro that works out the the box. all the admin does is add
users, create virtual web sites. .... They don't mess with the system.  The
packages are tested and verifed before it get to the sysadmin.

I would like to see SELinux in the schools, hospitals, police/fire stations, in
~ dept. of fish and wildlife offices.  But that the 99.99%, where Mr Msadmin can
just click a button the system drops to admin mode, drag the new package to the
~ install box and its done. World peace, and a chicken in every pot. :)


|
| Another thing is that I need to patch setfiles to take a list of file names
| on standard input.  Checking the entire file system after replacing a single
| package does not make sense.
|

Yes


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE8mJwbn6I06Opz+XURAq9bAJ9gRQaxvsBqZHN7/cItFWTguPH+wwCgtyZW
bzX/kps3A34n99HpRIgbONo=
=dEHp
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
