Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00646
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 14:11:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA15076
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 19:10:44 GMT
Received: from stingray.missi.ncsc.mil (stingray.missi.ncsc.mil [144.51.50.20])
	by jazzband.ncsc.mil  with ESMTP id TAA15072
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 19:10:44 GMT
Received: from stingray.missi.ncsc.mil (root@localhost)
	by stingray.missi.ncsc.mil with ESMTP id g0GJ99N13712
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2002 14:09:09 -0500 (EST)
Message-ID: <200201161909.g0GJ99513708@stingray.missi.ncsc.mil>
From: "Miara, Richard J." <rjmiara@missi.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: RH 7.1 Selinux Install fails in step 7 - /usr/sbin/sshd not found
Date: Wed, 16 Jan 2002 14:09:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,
I'm doing a first time install of LSM SELinux on a  freshly installed Redhat
7.1 system.  All the steps worked fine until step 7 "Build and install the
modified applications" in the utils directory.  When I did a 'make install',
it ended with the following:

   if [ ! -f /usr/sbin/sshd.old ]; then mv /usr/sbin/sshd
/usr/sbin/sshd.old fi
   mv: cannot stat '/usr/sbin/sshd' no such file or directory
   make: *** [install] Error1

I'm not sure how to proceed from here?

tks,

    Rich




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
