Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17605
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 14:49:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA24770
	for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:47:34 GMT
Received: from tlaloc.sfsu.edu (tlaloc.sfsu.edu [130.212.30.1])
        by jazzband.ncsc.mil  with ESMTP id SAA24766 for <selinux@tycho.nsa.gov>; Mon, 22 Jul 2002 18:47:33 GMT
Date: Mon, 22 Jul 2002 11:48:18 -0700 (PDT)
From: Stan Osborne <stan@tlaloc.sfsu.edu>
Message-Id: <200207221848.LAA16193@tlaloc.sfsu.edu>
To: selinux@tycho.nsa.gov
Subject: can't log in
Cc: stan@tlaloc.sfsu.edu
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

How do I debug problems with logging in?

After following the README instructions I am stuck at step 15 of
"BUILDING AND INSTALLING".   On the console I am not able to login as 
user "root" or "admin".   I am running a minmal (no MLS) 2.4.18-selinux 
kernel created by patching our vendor's (Sun/Cobalt) 2.4.16 source 
using patches from www.linux.org and www.nsa.gov/selinux.

Besides dealing with minor problems when applying the selinux kernel 
patches I had to install openssl and kerberos5.   Building the utils
required installing openssl library and .h and .a files for kerb5.

I have made few changes to the default configuration files.
Here are the user definitions in my policy/users file.

  user system_u roles system_r;
  user user_u roles user_r;
  user root roles { user_r sysadm_r };
  user admin roles { user_r sysadm_r };
  user named roles { user_r };

Here are sample log entries in /var/log/auth.

  Jul 19 01:58:28 raq104 PAM_pwdb[559]: (login) session opened for user admin by (uid=0)
  Jul 19 01:58:49 raq104 login[559]: UNABLE TO GET VALID SID FOR admin

Kerberos5 services are not active.   Is having these active a prerequisit?

Stan

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
