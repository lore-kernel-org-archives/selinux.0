Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA15293
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 04:35:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA24354
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 08:35:06 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id IAA24350
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 08:35:06 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: new packages
Date: Sun, 7 Jul 2002 04:35:38 -0400
Message-ID: <005201c22591$453d5c10$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020706215515.B77322208@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Some quick notes on the new updates I found.

1) kernel patch file had a blurb on one file, stated already applied.
(will get the section and past it)

2) fingerd.te gave me fits. Had to remote the file
/usr/share/Selinux/policy/current/domains/program/fingerd.te (not
running fingerd on this box)

3) using apt-get while in enforcement mode gives some interesting
errors.

This is directly logged in as root, NO su involved.  Tested on the
console and by ssh with the same results.

debian:~# id
uid=0(root) gid=0(root) groups=0(root) context=root:sysadm_r:sysadm_t
sid=181

debian:~# apt-get remove tiger
Reading Package Lists... Done
Building Dependency Tree... Done
The following packages will be REMOVED:
  tiger
0 packages upgraded, 0 newly installed, 1 to remove and 0  not upgraded.
1 packages not fully installed or removed.
Need to get 0B of archives. After unpacking 1184kB will be freed.
Do you want to continue? [Y/n] y
(Reading database ... 7904 files and directories currently installed.)
Removing tiger ...
dpkg (subprocess): unable to execute pre-removal script: Permission
denied
dpkg: error processing tiger (--remove):
 subprocess pre-removal script returned error exit status 2
dpkg (subprocess): unable to execute post-installation script:
Permission denied
dpkg: error while cleaning up:
 subprocess post-installation script returned error exit status 2
Errors were encountered while processing:
 tiger
E: Sub-process /usr/bin/dpkg returned an error code (1)
debian:~#


Ed



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
