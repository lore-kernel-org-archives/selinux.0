Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h716YpHa007558
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 02:34:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h716XcFB020832
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 06:33:39 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h716XaGD020829
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 06:33:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 99F9BBF1D
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 16:34:46 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09176-09
 for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 16:34:44 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id C11D3BF1A
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 16:34:44 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 47CA792719
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 16:34:44 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 65A197F264
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 16:34:37 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: thanks.txt
Date: Fri, 1 Aug 2003 16:34:36 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8ngK/wJEuk7yDBO"
Message-Id: <200308011634.36377.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_8ngK/wJEuk7yDBO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

For some time I've had people sending me messages on my SE play machine by 
creating files in the root home directory (I never worked out why they didn't 
email me).

The problem with this was that every "rm -rf /" operation would remove such 
files.  So I created a file named thanks.txt_append_only which people can put 
such messages in and gave it a type that user_t could only append to and read 
(no unlink or write).

I've attached a copy of the file for your interest.

Also I've made the .bash_history file read/append only so I have 19,500 lines 
of history of the commands that people have typed (including someone scp'ing 
to the root account on their machine from my play machine).  I'm not going to 
send it to the list as people probably don't expect such things to be 
published (although as it's online and world-readable for all I know it may 
be on the web by now).

If anyone who is on this list wants a copy but is unable to login to my play 
machine then let me know and I'll attach it to a private message.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_8ngK/wJEuk7yDBO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="thanks.txt_append_only"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="thanks.txt_append_only"

Thank You
Test
hugo was here
this
I'm very impressed -- thanks for this demo ! -- davux (davux@insia.org)
sorry about the killall -KILL bash, just wanted to see if annoyance was still possible :O
Wow, very very cool
s
Thx for the possibility to test this out! What about ulimit -c xxx? Could coredu
mps be a security-risk?
Hm, thats very cool, seems to be quite secure...
thx for the demo

-- 
Thanks for the opportunity to look at an SE Linux system.

test

tonguc was here (before kilroy)
elrond was here

 cow 
wow thats goofy
Oh no, not Elrond again! - rmt
Thanks a lot for the demo. Salva
Huh
kodi was here - impressive work - cool
looks all good, but what I really would like is root2 access :) root is just a limited acct here 
---
This is very impressive.  Nice work.  Thanks for letting us experiment it live like that. W.O.W.
  - se@soli.ca
---
///
root@cose -> 0
(/etc)# netstat -nlepta
(No info could be read for "-p": geteuid()=0 but you should be root.)
Active Internet connections (servers and established)
[..more crap..]

is dis realy a r00t machine?
///
there's a bnc in the root directory. funny.
///
This is a beautiful Linux! The security is obviously hard coded into the kernel... you've done nothing with PAM or any other pitiful additions to the operating system. This is just beautiful... Good idea for making a seperate partition for the sshd, just in case someone hacks the system (highly unlikely, it seems). I'm going to download and install SE Linux on my test box now :-) Cheers, -meep
///
nice stuff. -Z
Hi from Russia!
i will definately have to check this out futher... thanks for giving us a place to play around with SELinuxcat thanks.tx*!  ~James <selinux@jah37.gurepublicans.org>

--Boundary-00=_8ngK/wJEuk7yDBO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
