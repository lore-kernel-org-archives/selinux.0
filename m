Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA10621
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 04:54:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA16272
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 08:53:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id IAA16268 for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 08:53:03 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 31E7292461
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 18:54:23 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 433AF466
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 10:55:07 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: multiple user roles/domains
Date: Sun, 9 Jun 2002 10:55:07 +0200
MIME-Version: 1.0
Message-Id: <20020609085508.433AF466@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Earlier this week I set up a machine with multiple user domains and matching 
roles.

This was a lot harder than it should be.

I had to change ldconfig.te, login.te, newrole.te, postfix.te, sshd.te, and 
xdm.te to list the new domains, and I had to change the rbac file to allow 
role transitions.  Also I had to define new types for files under /home.

Next I plan to do the following:
Have a "user_type" attribute on user_t and every similar domain, and have the 
.te files listed above refer to "user_type" instead of "user_t" wherever 
possible.

For the rbac file I'm not sure how I can solve it without having to edit that 
file separately in addition to modifying user.te for the new domains and 
roles.

Now for /home, I was thinking of having home_root_t, $1_home_dir_t 
(user_home_dir_t) for the main ~user directory, and $1_home_t (user_home_t) 
for the files and directories under ~user.  This means that when I want to 
give a web server access to ~user/www I can grant it access to search 
user_home_dir_t and r_dir_file() access to user_home_www_t.


What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
