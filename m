Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA22374
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 09:22:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA08126
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 14:21:30 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id OAA08122
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2002 14:21:29 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524289@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: selinux@tycho.nsa.gov
Cc: "'sds@tislabs.com'" <sds@tislabs.com>
Subject: General Users
Date: Tue, 15 Jan 2002 08:21:55 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current implementation of SELinux requires each user to be listed in the
user policy file
and the default_context. This is great for single purpose server and
workstation machines.
I am currently look at a project that will require hundreds of machines and 
thousands of users. The user name and password are propagated thru NIS. With

the current implement of SELinux this makes the management of the machines
non-workable. Requires to much system administration. User are added and 
removed on a regular basis. We cannot rebuild a policy file for each machine
for the 
addition or removal of a user.


What would be the best way to modify the current implement to create a
standard
user. I was thinking of setting up a standard user for the user policy file
and 
for the default context in the /etc/security (cron and default). I am
looking at modifying
the libsecure to look at the user, if the user is not found in the
default_context file
then assign him the standard user context.


Any suggestions would be great.


Mark Westerman

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
