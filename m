Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h89AFQLa028391
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 06:15:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h89ADoLY022486
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 10:13:51 GMT
Received: from mx1.avenit.de (nexus6.avenit.de [80.237.241.2])
	by jazzswing.ncsc.mil  with SMTP id h89ADosG022483
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 10:13:50 GMT
From: "Romix" <romix@php.cd>
To: <selinux@tycho.nsa.gov>
Subject: how to add a user with rights to login via ssh on selinux?
Date: Tue, 9 Sep 2003 12:15:12 +0200
Message-ID: <005801c376bb$439ed330$4200000a@roadwarrior>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

i have seen that a similar problem has been discussed on this list some
months ago, but that didn´t help me... :-/

im running selinux und want to create a user that has the right to login 
via ssh.
i created a user called setest:
# suseradd -m setest

i gave him a password:  
# sadminpasswd setest
...

i added the line "user setest roles { user_r sysadm_r };" to 
/etc/security/selinux/src/policy/users 

i applied the changes: 
# make -C /etc/security/selinux/src/policy load

and my /etc/security/default_contexts looks like this:

system_r:local_login_t  staff_r:staff_t user_r:user_t
system_r:sshd_t         staff_r:staff_t user_r:user_t 
system_r:crond_t        staff_r:staff_crond_t user_r:user_crond_t 
system_r:system_crond_t

if i right understand this should be enough, but my user setest can´t 
login, after typing in the password i get the message:
Connection to 10.0.0.11 closed by remote host.
Connection to 10.0.0.11 closed.

in the sshd-log i have the following lines:
Sep  8 20:45:17 [sshd] Accepted password for setest from 10.0.0.23 port 
33571 ssh2
Sep  8 20:45:17 [sshd] fatal: Could not obtain SID for user setest
Sep  8 20:45:17 [sshd] syslogin_perform_logout: logout() returned an 
error


what did i forgot or what do i wrong? can someone help me? thx.

cu, Romain



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
