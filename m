Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA25215
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 21:49:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA17620
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 01:48:32 GMT
Received: from mail.servicemail123.com ([12.96.162.84])
	by jazzswing.ncsc.mil  with ESMTP id BAA17616
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 01:48:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: JW <jw@centraltexasit.com>
Reply-To: jw@centraltexasit.com
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Problems with some of the SuSE-specific settings: Re: contrib branch
Date: Mon, 8 Jul 2002 20:48:42 -0500
References: <Pine.GSO.4.33.0207050926330.29942-100000@raven> <200207080123.12647.jw@centraltexasit.com> <20020708092445.CBC3347734@mail.servicemail123.com>
In-Reply-To: <20020708092445.CBC3347734@mail.servicemail123.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200207082048.42832.jw@centraltexasit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm getting a few errors from make load after appending your additions to the default files in domain/program and file_types/program

inetd:

jw@ccs001:/usr/src/selinux/policy> make load
<snip>
ERROR 'name conflict for type inetd_var_log_t' at token ';' on line 70930:
type inetd_var_log_t, file_type, sysadmfile;
# log file type
/usr/local/selinux/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.11] Error 1
jw@ccs001:/usr/src/selinux/policy>

Initrc:

/usr/local/selinux/bin/checkpolicy:  loading policy configuration from policy.conf
ERROR 'name conflict for type initrc_runlevel_t' at token ';' on line 73582:
type initrc_runlevel_t, file_type, sysadmfile;
#line 6494
/usr/local/selinux/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [policy.11] Error 1


Commenting out the appropriate lines in the .te files gets rid of the errors, no telling what that actually causes though.

I do not currently understand what they are confilting with. A little explination would be greatly apprecaited.


Also, once again I do not understand why make load must be run as root. Proof of my ignorance :-/
- -- 

- ----------------------------------------------------
Jonathan Wilson
System Administrator
Cedar Creek Software     http://www.cedarcreeksoftware.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9KkD6Q5u80xXOLBcRAhc8AJ9iNYm9YGJSH+6DZmjA7WtFJSp6qQCfR5g5
zDQMunDH48aPIBKU2I7d9fo=
=mlBX
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
