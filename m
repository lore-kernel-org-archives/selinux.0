Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1FHx9Rb006755
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 12:59:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1FHx8c3026953
	for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 17:59:08 GMT
Received: from smtp106.mail.sc5.yahoo.com (smtp106.mail.sc5.yahoo.com [66.163.169.226])
        by jazzband.ncsc.mil  with SMTP id i1FHx7R0026950 for <selinux@tycho.nsa.gov>; Sun, 15 Feb 2004 17:59:07 GMT
Date: Sun, 15 Feb 2004 11:58:32 -0600
Mime-Version: 1.0 (Apple Message framework v553)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Policy configuration question
From: Ignacio Tripodi <ignaciot@unt.edu>
To: selinux@tycho.nsa.gov
Message-Id: <916FF28D-5FE0-11D8-8943-000393013D1A@unt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm trying to tune up the policy because I'm getting many "avc: denied" 
log entries for almost every single command I try to run. The source 
context seems to be the same (system_u:system_r:local_login_t), 
regardless of what I'm trying to access. For example, if I want to do:

[ignaciot@UMLselinux]# cat VERSION

I get:

avc:  denied  { read } for  pid=494 exe=/bin/cat name=VERSION dev=62:00 
ino=97738 scontext=system_u:system_r:local_login_t 
tcontext=system_u:object_r:policy_src_t tclass=file

Shouldn't the source context be the one from the user who's running the 
program? If I check the current users in the policy using the setools, 
my entry shows like:

[ignaciot@UMLselinux]# seuser show users
system_u: system_r
user_u: user_r
root: staff_r sysadm_r system_r
ignaciot: staff_r sysadm_r

However, if I run getcon I get:

[ignaciot@UMLselinux]# getcon
system_u:system_r:local_login_t
(or system_u:system_r:sshd_t if I'm accessing via ssh)

Any clues of what I'm doing wrong?
Thanks!

Ignacio
CoPS Lab
University of North Texas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFAL7NPwGqh0xtlFYsRAowoAKCUxFMuy9I+jTZURJQOO+tAI086UwCeKa9y
+O+Nwh2UlaySNeh9xdCpz/0=
=nb/u
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
