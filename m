Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAB97lXl028370
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 04:07:47 -0500
Received: from asav3.lyse.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oAB97kQU012361
	for <selinux@tycho.nsa.gov>; Thu, 11 Nov 2010 09:07:46 GMT
Date: Thu, 11 Nov 2010 10:07:44 +0100
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: rhelv6-list@redhat.com, selinux@tycho.nsa.gov
Subject: default to user_u for new logins (on RHEL6) ?
Message-ID: <20101111090744.GA9286@oc1046828364.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Our userdatabase is in an LDAP directory, and home directories for these
are created on demand by pam_oddjob_mkhomedir on first login. Is there
any way of defaulting to create all users as selinux user "user_u" --
instead of the default "unconfined_u" ?

It would be preferable to do this trough PAM, so that it only applies to
users affected by password authenticated users
(/etc/pam.d/password-auth-ac), and not to any system accounts that are
created trough f.ex. RPM.


  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
