Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA00565
	for <selinux@tycho.nsa.gov>; Sat, 25 May 2002 21:36:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA08630
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 01:36:47 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id BAA08626
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 01:36:45 GMT
Message-ID: <3CF03C25.1050803@evoworks.evoserve.com>
Date: Sun, 26 May 2002 09:36:37 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new Debian package
References: <20020525195638.734D015EB@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>I've just uploaded a new Debian package, this one has the latest patches and 
>new policy that works a lot better.  I now have a Debian machine running in 
>enforcing mode with a policy that is not much different from the default in 
>my package.  It's running as an ADSL gateway machine (pppoatm with SpeedTouch 
>USB driver), a web server, and has the courier POP server running.
>
>As the basic stuff is working it won't be too difficult for you to add 
>support for other daemons etc.
>
I tried it just now policy compilation fails with:

/usr/sbin/checkpolicy -o policy.9 policy.conerror in the statement 
ending on line 13924 (token ';'): unknown type ipsec_file_t

/usr/sbin/checkpolicy: error(s) encountered while parsing configuration

make: *** [policy.9] Error 1





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
