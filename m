Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA07272
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 22:03:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0I33iI08844
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 03:03:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0I33ff08840 for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 03:03:42 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0DD0992739
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 14:03:29 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1914C2368
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 04:03:25 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Cambridge Security Group talk
Date: Sat, 18 Jan 2003 01:49:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301180149.27476.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The talk seemed to go quite well.

The lecture theater could hold 150+ people and was more than half full at the 
start, very few people left early, and I think that the main reason for 
people leaving early was the fact that I exceeded the alotted time.

The audience asked some really technical questions about issues such as the 
way crond determines the correct security context for a process it runs (I'm 
not certain that I managed to convey the details of that one well to the 
audience, it's difficult to explain without diagrams or code).  I think that 
perhaps I should start a frequently asked really technical questions to 
address such issues.

One issue that drew a number of comments from the audence was the length of 
security contexts and the amount of typing that it can involve.  One audience 
member said "space in an Xterm is precious", another audience member 
mentioned having three servers without X that were not administered remotely 
(IE everything is done at the console without even an X based cut/paste 
facility).

One suggestion from the audience was to remove "_t" and "_r" suffixes as the 
context has all the information necessary to differentiate domains from 
roles.  Another suggestion was to remove some parts of the context when they 
aren't needed (such as object_r).  I tried this once but Steve convinced me 
to revert it.  I am now thinking that perhaps we should review this matter.

In regard to the permissions on files, it was pointed out in a quite clear 
fashion that standard Unix has 10 characters in the "ls -l" output to specify 
the permissions.  Of course this is ignoring the user and group fields which 
combined make it into a text representation almost as long as a security 
context.  On my laptop the average length of security contexts I have in use 
at the moment is 30.5 characters including the two ':' characters.  For unix 
permissions it's 10, plus 5 for the group, plus <=8 for the user-name which 
is 25 characters if we include two separators.

The audience had no comments on the issues related to default contexts, 
however they have my email address and hope that at some future time someone 
will have some ideas and email them to me.

There was a suggestion that I should write a magazine article about what I did 
with my SE Linux play machine.  When I was doing it, it didn't seem THAT 
exciting to me.  But if people want to learn more then I'm happy to oblige.  
I'll hunt around and see if someone is interested in publishing such an 
article.

Also an audience member asked me if it would be possible to run a machine with 
all files and processes UID=0, which was a strange co-incidence as I have 
been planning to do that for play machine ][ (but I may have mentioned it on 
a mailing list or something and the word may have got around).  This idea 
seemed to get a lot of interest from the audience, who seemed to actually 
want to do it as a serious way of running a system (rather than as a fun 
demonstration of the power of SE Linux).  But I can oblige.  It wouldn't be 
THAT difficult to modify "ls -l" to display link-count, security-context, 
size, date, and name, and to make similar changes to ps etc to not bother 
displaying UID/GID.  Then cron etc could be modified to run all jobs under 
the same UID etc.  The passwd wrapper would also work if the UID checks were 
made a configuration option (could be made a PAM module).


Anyway, I highly recommend that any of you who are in the Cambridge area 
attend a meeting if possible, and give a presentation if you are working on 
something that intersts them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
