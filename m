Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA26733
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 12:30:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA09519
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 17:29:51 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id RAA09515 for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 17:29:50 GMT
Reply-To: <dac@tresys.com>
From: "David Caplan" <dac@tresys.com>
To: "Shaun Savage" <savages@pcez.com>, <selinux@tycho.nsa.gov>
Subject: RE: SELinux
Date: Thu, 21 Feb 2002 12:33:46 -0500
Message-ID: <NJEELFKFDFJAACDDMCHCOENNDNAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3C748541.6050708@pcez.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would also add that one of the most valuable things to look at is the log
messages.  They make it real easy to find things that you've missed.  Of
course, just because you see a deny in the log doesn't mean you necessarily
want to allow it.

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Shaun Savage
Sent: Thursday, February 21, 2002 12:27 AM
To: selinux@tycho.nsa.gov
Subject: SELinux


I have been customizing the policy now for about three months.  If you
think of writing new policy as designing a state machine thing are easier.
the questions you need to ask is
1> How do you get to the execution of the program.  What domain should
you allow to start this program?
2> What protections are required? This is the biggest issue.  Is there a
  log file?  Does the program acceses any sockets? Is there user
communcation?  Detail knowledge of the application is needed.  I tend to
be paranoid so I create too many sub domains and make the policy difficult.
3> What programs are allowed to access this application data?

Read the policy/macros.te file
The linux/security/selinux/include/flask/*.h
av_permissions.h gives the bit pattern of all the permissions
av_perm_to_string.h & common_perm_to_string.h is some of the string
    permissions
class_to_string.h is most of the objects
flask.h gives the object classes

The main thing is to understand the application. Know what files,
sockets, are being accesed and how.

I do agree that there needs to be a more documentation, but if there
isn't the you can earn big dollars if you know it, I hope ;-).

Shaun Savage


--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
