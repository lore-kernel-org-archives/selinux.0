Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA29874
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 10:09:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA03563
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 15:08:01 GMT
Received: from mx01.uni-tuebingen.de (mx01.uni-tuebingen.de [134.2.3.11])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA03551
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 15:07:50 GMT
Received: from linux16 (linux16.zdv.uni-tuebingen.de [134.2.18.16])
	by mx01.uni-tuebingen.de (8.9.3/8.9.3) with SMTP id QAA04017
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:09:18 +0100
From: Jan Petranek <jan@petranek.de>
To: selinux@tycho.nsa.gov
Subject: Goal / Danger: Attack by malicious root 
Date: Mon, 15 Jan 2001 16:08:34 +0100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01011516091701.13938@linux16>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

dear guys,

did You consider the possibility of an malicious root attacks? In most
Linuxdistributions, the priviliged user can read & manipulate all of the user's
data. 

This is indeed a situation I find myself in today: I am working on a
Linux-Machine in the university's computer pool. And I find my own
(non-encrypted) home directory far too insecure to put a private key or
something like that in here.  This is also from the point of view, that the
root-login may be hacked on a campus site like this.

So to me, there is a need of encrypting the user's data. The question of the
key yet remains: A key like a password / passphrase is quite limited in it's
length (by the memory of the user). A key on a medium (like a CD-ROM,
chipcard etc.) could be longer, but still there is the demand, that it can't be read by 
somebody else (not even the superuser), when mounted /
used by the user.
Also, the key medium could compromise the encryption, but that is another
problem.

I'd be quite glad, if you could take this point in consideration,

JanP



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
