Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA21792
	for <selinux@tycho.nsa.gov>; Sun, 9 Dec 2001 00:18:18 -0500 (EST)
From: lonnie@outstep.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA05265
	for <selinux@tycho.nsa.gov>; Sun, 9 Dec 2001 05:17:37 GMT
Received: from mail.outstep.com (a904j637.tower.wayne.edu [141.217.140.65])
	by jazzband.ncsc.mil  with ESMTP id FAA05261
	for <selinux@tycho.nsa.gov>; Sun, 9 Dec 2001 05:17:36 GMT
To: selinux@tycho.nsa.gov
Subject: User Level Security Policies
Message-ID: <1007874114.3c12f042364c3@mail.outstep.com>
Date: Sun, 09 Dec 2001 00:01:54 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All,

Hope that you are all doing well today.

I am new to this list and have looked briefly over the archives regarding 
suppoer for Redhat 7.2 and see that SELinux does not yet support it.

I have two question that I hope someone could please answer for me, ok.

First the easy one.
1.) Is there some estimation as to when RH 7.2 might be supported?

Now the harder one.
2.) We have been looking at various security methods such as "restricted 
shells", "chroot", etc... to find a method of locking a user into their HOME 
directory. While this may sound a little restrictive, the current special 
project that we are working on required that we allow the user to login via kdm 
after which a simple window manager (fvwm95) would be started and then the user 
could select an application to run.

The catch is that the user would really never have a shell available to them 
and only be able to run one of the applications that we have pre-configured for 
them. 

Also, we would like to prevent the user from navigating out of their HOME 
directory at all times.

My question is "Can SELinux implement these types of security policies for our 
needs?"

Best Regards,
Lonnie Cumberland

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
