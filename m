Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA10574
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 04:19:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA15252
	for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 08:18:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id IAA15248 for <selinux@tycho.nsa.gov>; Sun, 9 Jun 2002 08:18:18 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DAB8392461
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 18:19:36 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2DBBA75DE
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 10:20:14 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE Linux tutorial offer for Linux Kongress
Date: Sat, 8 Jun 2002 22:08:49 +0200
MIME-Version: 1.0
Message-Id: <20020609082014.2DBBA75DE@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am about to propose a tutorial on SE Linux for Linux Kongress.  The 
tutorial will be the equivalent of 6 classes in German school, which is about 
5 hours of teaching.

The format I am planning consists of a room filled with terminals and an SE 
server machine they can ssh to.  The start of the tutorial will involve the 
end-user side of things, each user will have two accounts on the server with 
different privs, both of which don't enable them to do any damage to the 
system or to other users.  I will also give them all a root account, being 
able to type "rm -rf /" as root without harm impresses people...

Then the second part of the tutorial will be teaching the people how to 
administer the system, the ssh terminal machines will all be running SE Linux 
and they will all have access to administer them, they will be running sshd 
bound to localhost for experimenting with ssh logins, but they can 
reconfigure that to allow other people to login (as user_r only).  Of course 
the problem with this is that someone is likely to trash their machine, 
hopefully the proportion of the audience who do that will be small enough not 
to matter too much (if everyone trashes their terminal then the tutorial may 
come to an abrupt halt).  Also I'll make part of the tutorial giving access 
to other people, if they stuff this up then it could allow hostile users in 
the room to damage their machines.  Maybe I'll need some sort of network-boot 
recovery proceedure.

The idea is also to have two or three people per terminal.  Having more than 
one person means that if one person gets confused then maybe the other can 
work it out (and this also facilitates communication between groups).  Three 
people is the most that you can really have sharing a PC, which is useful as 
the number of people will probably be limited by the number of terminals - so 
with 30 machines we can get 90 people.

Also they will be able to talk among themselves in non-English languages if 
they wish.

The Kongress requires that people register for talks, I will request a 
special registration form to allow people to register a group (with a 
recommendation that people who aren't Unix experts form a group with an 
expert, and that groups be formed of people with the same native language).

Also I am considering the use of an irc channel or rwall to send out sample 
commands etc.



What do you think of this?  Any suggestions?

BTW  This hasn't been accepted, so please don't register for the Kongress on 
the basis of this message.



Also I am going to offer a paper for Linux Kongress.  I probably won't be 
able to meet the stated requirements for the amount of new material for a 
paper.  But the members of the committee that I've spoken to think that the 
fact that SE Linux is new and exciting, and the shortage of people who are 
willing and able to speak on the topic in Europe (I'm the only one AFAIK) 
means that they will be likely to accept a paper from me regardless.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
