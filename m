Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA23925
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 00:28:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA00411
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 05:27:41 GMT
Received: from sendmail (savages.net [208.170.193.18])
	by jazzswing.ncsc.mil  with ESMTP id FAA00405
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2002 05:27:40 GMT
Message-ID: <3C748541.6050708@pcez.com>
Date: Wed, 20 Feb 2002 21:27:29 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
