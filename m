Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA03360
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 23:53:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA14049
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 03:53:46 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id DAA14045
	for <selinux@tycho.nsa.gov>; Mon, 27 May 2002 03:53:43 GMT
Message-ID: <3CF1ADC5.1070600@evoworks.evoserve.com>
Date: Mon, 27 May 2002 11:53:41 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new Debian package
References: <20020525195638.734D015EB@lyta.coker.com.au> <3CF03C25.1050803@evoworks.evoserve.com> <20020526071153.488F71C0F@lyta.coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Sun, 26 May 2002 08:45, Russell Coker wrote:
>
>>On Sun, 26 May 2002 03:36, Debian User wrote:
>>
>>>>I've just uploaded a new Debian package, this one has the latest patches
>>>>and new policy that works a lot better.  I now have a Debian machine
>>>>running in enforcing mode with a policy that is not much different from
>>>>the default in my package.  It's running as an ADSL gateway machine
>>>>(pppoatm with SpeedTouch USB driver), a web server, and has the courier
>>>>POP server running.
>>>>
>>>>As the basic stuff is working it won't be too difficult for you to add
>>>>support for other daemons etc.
>>>>
>>>I tried it just now policy compilation fails with:
>>>
>>>/usr/sbin/checkpolicy -o policy.9 policy.conerror in the statement
>>>ending on line 13924 (token ';'): unknown type ipsec_file_t
>>>
>>>/usr/sbin/checkpolicy: error(s) encountered while parsing configuration
>>>
>>This means that some file you are using has a rule involving the
>>ipsec_file_t while you have not included the ipsec.te file.  Including
>>ipsec.te is one way of solving the problem, but a better solution (if you
>>don't want ipsec) is to find the file in question and fix it.
>>
>
>As a follow up to this, that turned out to be a bug in my sample policy.  
>Just remove the lines in question from initrc.te.
>
Well i got my old and new policy files mixed up and there was a bug. I 
do need ipsec.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
