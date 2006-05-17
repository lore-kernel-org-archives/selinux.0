Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4H9uoJx008154
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 05:56:50 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4H9ul5q002351
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 09:56:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
Subject: Re: Is SELinux appropriate for my use?
Date: Wed, 17 May 2006 15:58:39 +1000
Cc: selinux@tycho.nsa.gov
References: <446A0CE9.6020708@gmail.com>
In-Reply-To: <446A0CE9.6020708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605171558.43653.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 17 May 2006 03:33, Tetsuji Maverick Rai 
<tetsuji.maverick.rai@gmail.com> wrote:
> I am dubious SELinux is necessary if I use only apache2 with phpBB and
> other php based web applications.   Am I correct?   I am the only shell
> user of the machine.

If an attacker cracks phpBB (which has been done before as you note) then 
without SE Linux there is no restriction on their ability to try and crack 
SETUID programs on the system.  When running SE Linux Apache is not permitted 
to run /bin/passwd and other privileged programs so that someone who cracks 
phpBB can not go on to attack such programs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
