Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAU1PHBD014671
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2008 20:25:17 -0500
Received: from wa-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAU1NENf003740
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2008 01:23:14 GMT
Received: by wa-out-1112.google.com with SMTP id j5so932969wah.18
        for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2008 17:25:11 -0800 (PST)
Subject: PAM _pam_load_conf_file: unable to open /etc/pam.d/system-auth
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Sat, 29 Nov 2008 17:25:07 -0800
Message-Id: <1228008307.4582.10.camel@unix>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello;
after loading the latest policycoreutils
I'm experiencing a bit of difficulties trying
to understand how to set:
/etc/selinux/newrole_pam.conf
(what do I put in there?)
I have: /usr/bin/aterm /etc/pam.d/test
in there, and in 
/etc/pam.d/test I have:
auth required /lib/security/pam_unix.so

but, unfortunantly receive a no password error 
when wanting to change roles.

after looking at auth.log I see a:
newrole: PAM _pam_load_conf_file: unable to open /etc/pam.d/system-auth

If I make: /etc/pam.d/system-auth
newrole will work perfectly until
I go and write the allow rules,
and put the policy into enforcing mode.

What or were do I find the info on what
to put in /etc/selinux/newrole_pam.conf
and so forth to have this new way 
for newrole work?

regards;

-- 
Justin P. Mattock <justinmattock@gmail.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
