Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5KKGUhL023665
 for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2014 16:16:30 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so1366963wiv.8
 for <selinux@tycho.nsa.gov>; Fri, 20 Jun 2014 13:16:32 -0700 (PDT)
Received: from [192.168.1.138] (89-74-185-32.dynamic.chello.pl. [89.74.185.32])
 by mx.google.com with ESMTPSA id o3sm7562839wiz.24.2014.06.20.13.16.30
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 20 Jun 2014 13:16:30 -0700 (PDT)
From: Krzysztof Katowicz-Kowalewski <vnd@vndh.net>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_527C599C-C080-40C3-8EF8-82ED345894AE";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: Different authentication with different user roles
Message-Id: <26977C05-E366-4E64-974E-3D3605373FDA@vndh.net>
Date: Fri, 20 Jun 2014 22:16:28 +0200
To: selinux@tycho.nsa.gov
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Apple-Mail=_527C599C-C080-40C3-8EF8-82ED345894AE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello,

I=92m watching SELinux mailing list since a few months and it=92s my =
first time here to ask a question. I haven=92t found the answer for this =
one anywhere, so maybe you guys would help me, or maybe there=92s no =
such thing I=92ve imagined. But let=92s move to the main part, I have =
two questions are related examples=85

1) It is possible to authenticate user in different way for each of the =
roles he=92s in?

When the user is logged in and had the role of staff_r, he would type =
newrole command and depending on the new role given as an argument he =
would be asked about different passwords in each case. The default =
password for the account would not allow him to be authenticated and =
gain higher privileges in the system.

This scenario may looks like a bit of abuse of using single account by =
different people who has different passwords to authenticate but in fact =
there might be real world examples of this situation. In example, you =
could switch to some kind of sandbox role without using predefined shell =
binary only the newrole itself. Another example when you=92re logging in =
from untrusted source and you could consider that all of your moves are =
being logged - having separate passwords for different roles would give =
the attacker access to only part of the system, not the whole one. These =
examples may look a bit of naive but I=92m interested mainly in the idea =
pointed in the question and there=92re only here to illustrate the =
situation.=20

2) Could the method of authentication and source of authentication =
request be used to determine the role a user should be in by default?

And in this case I've imagined it in the following way. We can also =
assume that the primary role for the user is staff_r.
a) If the user is logged in locally (using tty, not pty as in case of =
sshd remote access) he could be authorized as sysadm_r without further =
authentication.
b) If the user is logged in using ssh from trusted source (trusted IP =
address, trusted subnetwork) then he could be authorized as sysadm_r =
without further authentication.
c) If the user is logged in using ssh but he had used his private key =
rather than a passphrase for authentication then he could be authorized =
as sysadm_r without further authentication.

Once more, these are just examples.

As far as I=92ve researched, the second scenario could be a good example =
of SELinux aware software and as I guest at least in b) and c) case it =
should be implemented directly in sshd, and then sshd could be able to =
decide how to handle user roles. Do you know if there=92s any thing like =
that currently implemented? And about the first case, could PAM be used =
somehow to deal with the mentioned problem, or maybe some other existing =
authentication system? I know that SELinux is used to being Type-Based =
Access Control rather that Role-Based Access Control and these stories =
I=92ve presented are just examples of RBAC but in fact there=92s such =
thing as role in SELinux, so why not use it in this way? :)

Thanks, Krzysztof Katowicz-Kowalewski

--Apple-Mail=_527C599C-C080-40C3-8EF8-82ED345894AE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJTpJacAAoJEEJGP6nEM7Rc/q0QAJHQxI0IsWf8aL6ApF8C1sPY
e4QpDNrX2V2VGhIkbDmArkdAnOkluZoBwiU+lFq+lI+vmIr+iTXUlOPyuEf2p2XC
miYjeNMPuehM2q8NWvMRrZRof4nU8Y0SZOjkJVQVFD9nuukq0beSIP7/GMkgGQmA
7Fc7gYA6ieZMkjuw0n+fbyx0PUuFhuZ07Sc0qnXxtAo3SVgoqr1p7k00Y6RMz/Qw
eTXegM2Ph+M/7SP8Fns+GXVaaGOLe1WvfX71ZlYTV2Dfksq/xV7Rvlcs28AA96Uv
dEZdy/dEwbHQu5ozEtRpysSTVyO1wpakongcOCe231gObd5CZ5zw1nM6/0GRzKd/
djHViRx9bxedK6udqK95G8iRjlMWUn6e/6SpyojQ1wvJWykGTjaZYvNv+iAejRzJ
RdAehyG+WBsux7Mdnx7zhNVDWRx6b8AIP4aAWCXzP70vY9sFzUkiCgfy5ZyamPSH
5EaCshMWNBYfbE+pK379xHd7i/Yqg5YHZKon6xaFQaCrGq249hmZH+64IcecyWyP
MgQlsz22aYWZ4xeKXk6TTRyrh9a/zGhfWYLfHPdnRraJbsQh9ZdMSdS8TSDhJtcR
+5bZgE4OkrvG/u3itkyhy0DK/zfVrlWJ5Ls7MSAEFRYtEyKynvTsqSegcdVQYLmA
RHqsUSCN5AE3pZpFLTF0
=2eX6
-----END PGP SIGNATURE-----

--Apple-Mail=_527C599C-C080-40C3-8EF8-82ED345894AE--
