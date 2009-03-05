Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n256neSl012315
	for <selinux@tycho.nsa.gov>; Thu, 5 Mar 2009 01:49:40 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n256k2lE013042
	for <selinux@tycho.nsa.gov>; Thu, 5 Mar 2009 06:46:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: PAM, GNOME, etc
Date: Thu, 5 Mar 2009 17:49:25 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903051749.31665.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the gdm package in Debian has some degree of SE Linux support (I 
haven't yet read the source to see what it does).  However it seems that the 
pam_selinux.so module is required and that it can't be the last module 
(previously I just appended a line to the pam configuration).

session required pam_selinux.so
session optional        pam_gnome_keyring.so auto_start

The above is part of my /etc/pam.d/gdm file.  The SE Linux module needs to be 
run before the pam_gnome_keyring.so module so that the daemon it spawns for 
the user will get the correct context.

It seems that we have three broad classes of session modules.  Those which 
launch no child processes, those which launch system processes (EG automatic 
home directory creation), and those which launch user processes (such as a 
GNOME keyring).

Dan, what are you guys doing in Fedora in this regard?  Are you integrating SE 
Linux support manually in every pam.d file to make sure you get it right?  It 
seems that any automatic method (such as just appending a line to every one 
of a set of files) is not going to work.

Or have you patched a bunch of PAM modules to call setexeccon(NULL) before 
they call exec()?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
