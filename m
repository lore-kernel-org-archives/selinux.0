Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA02188
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 03:32:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA04160
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 08:31:27 GMT
Received: from ultraviolet.org (freeside.ultraviolet.org [192.215.175.10])
	by jazzband.ncsc.mil  with SMTP id IAA04156
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 08:31:26 GMT
Date: Wed, 21 Nov 2001 01:32:04 -0800
From: Tracy R Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux policy configuration tutorial?
Message-ID: <20011121013204.C6432@ultraviolet.org>
References: <20011116190059.L24702@ultraviolet.org> <Pine.GSO.4.33.0111190826490.24517-100000@raven>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
In-Reply-To: <Pine.GSO.4.33.0111190826490.24517-100000@raven>; from sds@tislabs.com on Mon, Nov 19, 2001 at 08:37:53AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2001 at 08:37:53AM -0500, Stephen Smalley wrote:
> I don't think anyone has written a general tutorial.  However, you'll find
> quite a bit of useful information in the security server section of the
> first technical report, the entire second technical report, and the OLS
> 2001 paper, all of which are on the web site.  Several people outside of

Thanks. I am slowly making progress. Over the last few nights I've been
going though "A Security Policy Configuration for the Security-Enhanced
Linux" in the documentation section and I have noticed that I get a 404
if I stop reading and pick it up again later. Looks like the url changes
periodically. Odd.

A policy question: I didn't have apache installed at the time I installed
SELinux but now I want to install, make it run some useful web app, and
try to secure it. SELinux seems to come with a policy for the stock apache
install so I installed the rpm that normally comes with RH6.1.=20

Then I did:

make relabel && make load

Just to make sure the newly installed files get assigned the right type
and the policy gets compiled and loaded. But when I try to start apache I
get permission denied:

[root@tracy policy]# /etc/rc.d/init.d/httpd start
Starting httpd: execvp: Permission denied
[root@tracy init.d]# /usr/sbin/httpd=20
bash: /usr/sbin/httpd: Permission denied
[root@tracy init.d]#=20
[root@tracy init.d]# ls -la /usr/sbin/httpd=20
-rwxr-xr-x   1 root     root       337500 Mar 29  2001 /usr/sbin/httpd
[root@tracy init.d]# ls -la --context /usr/sbin/httpd=20
-rwxr-xr-x root     root     system_u:object_r:httpd_exec_t
/usr/sbin/httpd

What am I missing here?

Also, I notice that when I log in as the user "jdoe" and do an ls -la on /
the jdoe user sees this:

ls: lost+found: Permission denied
ls: ...security: Permission denied

Not much good for hiding files is it?

As a result of the ls I get this in the messages file:

Nov 21 01:03:53 bench3 kernel: avc:  denied  { getattr } for  pid=3D9640 ex=
e=3D/usr/local/selinux/bin/ls path=3D/...security dev=3D08:01 ino=3D38857
Nov 21 01:03:53 bench3 kernel:    scontext=3Djdoe:user_r:user_t
Nov 21 01:03:53 bench3 kernel:    tcontext=3Dsystem_u:object_r:file_labels_t
Nov 21 01:03:53 bench3 kernel:    tclass=3Ddir

I'm not sure if I would really want the ls of every user in / to set that o=
ff
but even more of a problem is that the message takes up four lines in the
messages file. I normally run logcheck once an hour which sends me
anything interesting from the logfiles after filtering out the bits I have
deemed non-interesting so it would be quite convenient to have it all on
one line.

--=20
Tracy Reed      http://www.ultraviolet.org

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjv7dJQACgkQ9PIYKZYVAq3+fgCeKHkMqsnBixI4JPqkQyQCYSlK
ss4An3xfEHVVKfh44iAw0BBDLcZiH0Ej
=Uzvn
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
