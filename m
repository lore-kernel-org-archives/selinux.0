Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o8UIO9r4014199
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2010 14:24:25 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o8UIONt7028996
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2010 18:24:24 GMT
Message-ID: <4CA4D5D4.9090104@redhat.com>
Date: Thu, 30 Sep 2010 14:24:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: selinux@lists.fedoraproject.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: error: ssh_selinux_getctxbyname: Failed to get default SELinux
 	security context
References: <55178.193.5.216.100.1285658649.squirrel@mail.puzzle.ch>	<4CA1AC7C.5070500@city-fan.org>	<49161.193.5.216.100.1285674973.squirrel@mail.puzzle.ch>	<20100928124040.GB19363@localhost.localdomain>	<59450.193.5.216.100.1285681871.squirrel@mail.puzzle.ch>	<4CA1F6EF.6030409@redhat.com> <4CA1FAFE.90202@city-fan.org>	<46879.193.5.216.100.1285686628.squirrel@mail.puzzle.ch>	<4CA30AC2.9090002@city-fan.org>	<28450.193.5.216.100.1285764809.squirrel@mail.puzzle.ch>	<33534.193.5.216.100.1285846666.squirrel@mail.puzzle.ch> <49903.193.5.216.100.1285856295.squirrel@mail.puzzle.ch>
In-Reply-To: <49903.193.5.216.100.1285856295.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/30/2010 10:18 AM, imsand@puzzle.ch wrote:
> another interesting thing is the following:
> (seen with the debug option in pam_selinux)
> 
> assuming that the linux user is mat and the corresponding selinux user is
> mat_u. during ssh login this happens:
> 
> Sep 30 16:09:49 testsrv sshd[4328]: pam_selinux(sshd:session): Open Session
> Sep 30 16:09:49 testsrv sshd[4328]: pam_selinux(sshd:session): Open Session
> Sep 30 16:09:49 testsrv sshd[4328]: pam_selinux(sshd:session): Username=
> mat SELinux User = mat_u Level= (null)
> Sep 30 16:09:49 testsrv  sshd[4328]: pam_selinux(sshd:session): set mat
> security context to mat_u:staff_r:staff_t
> Sep 30 16:09:49 testsrv sshd[4328]: pam_selinux(sshd:session): set mat key
> creation context to mat_u:staff_r:staff_t
> 
> As we can see, the user mapping works as desired and the new choosen
> context should be all right => mat_u:staff_r:staff_t.
> 
> But then, when I do an id -Z after successful login, the shell's context
> is context=user_u:user_r:user_t.
> 
> Very strange....
> 
> --
> selinux mailing list
> selinux@lists.fedoraproject.org
> https://admin.fedoraproject.org/mailman/listinfo/selinux
> 
> 
You got me.  If you create the mat_u user and login does the pam_selinux
session look different?

Why don't you ask on the upstream selinux list.  More sles experience is
probably there that is not monitoring this list.
 <selinux@tycho.nsa.gov>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyk1dMACgkQrlYvE4MpobO7cQCeJt8x3QmnammA6NahRasyuK8l
jR8AnjmTIhLgBTOvBgJlhSqW9vm9fMt8
=Hx39
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
