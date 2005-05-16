Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4GD7kgA019005
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 09:07:46 -0400 (EDT)
Received: from web51507.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4GD4Ege006705
	for <selinux@tycho.nsa.gov>; Mon, 16 May 2005 13:04:14 GMT
Message-ID: <20050516130235.6023.qmail@web51507.mail.yahoo.com>
Date: Mon, 16 May 2005 06:02:35 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: fixfiles and lost+found
To: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200505151640.44051.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> fullrelabel() {
>     logit "Cleaning out /tmp"
>+    test -d /tmp/lost+found && chattr +i /tmp/lost+found
>     rm -rf /tmp/.??* /tmp/*
>+    test -d /tmp/lost+found && chattr -i /tmp/lost+found
>     LogReadOnly
>     restore
> }

Shouldn't this have a trap statement in case its gets terminated after making it
immutable and before putting it back?

-Steve Grubb


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
