Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00176
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 11:45:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA07202
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:43:40 GMT
Received: from femail7.sdc1.sfba.home.com (femail7.sdc1.sfba.home.com [24.0.95.87])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA07198
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:43:39 GMT
From: "Preston L. Bannister" <preston@home.com>
To: "Jan Petranek" <jan@petranek.de>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: Goal / Danger: Attack by malicious root 
Date: Mon, 15 Jan 2001 08:45:08 -0800
Message-ID: <GKEALNNOAPLKJBCDLBIBEEINCIAA.preston@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <01011516091701.13938@linux16>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I'd be *very* surprised if the selinux people can offer 
any protection from a hostile superuser.

Simply encrypting the data in your home directory offers
little protection as the software you use to perform the 
encryption is running on the superuser controlled machine. 

A superuser can intercept your input, change the software
you are running, and intercept output from the programs 
you run.  Under those circumstances nothing you do on that
machine is secure from a hostile superuser.

By definition a superuser can do anything on that machine.

Another basic rule is that no machine is secure if a hostile
has physical access to the hardware.  Visit the recent FBI 
planting of monitoring devices in the keyboards people on 
which they wish to spy.

In any case none of this is really relevant to selinux.


From: Jan Petranek
> did You consider the possibility of an malicious root attacks? In most
> Linuxdistributions, the priviliged user can read & manipulate all 
> of the user's data. 
> 
> This is indeed a situation I find myself in today: I am working on a
> Linux-Machine in the university's computer pool. And I find my own
> (non-encrypted) home directory far too insecure to put a private key or
> something like that in here.  This is also from the point of 
> view, that the root-login may be hacked on a campus site like this.
> 
> So to me, there is a need of encrypting the user's data. 
> The question of the key yet remains: A key like a password / 
> passphrase is quite limited in it's length (by the memory of 
> the user). A key on a medium (like a CD-ROM, chipcard etc.) 
> could be longer, but still there is the demand, that it can't 
> be read by somebody else (not even the superuser), when mounted /
> used by the user. Also, the key medium could compromise the 
> encryption, but that is another problem.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
