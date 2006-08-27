Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7RBfZjn013334
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 07:41:35 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7RBewLN005417
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 11:40:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, casey@schaufler-ca.com
Subject: poly-instantiated directories and call-gate
Date: Sun, 27 Aug 2006 21:41:25 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608272141.29051.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When giving a talk on PI directories I was asked why every program that calls 
setuid() has to be changed instead of just changing what happens when 
setuid() is called.

I mentioned in my talk that the MTA local delivery agents and suexec need to 
be modified to use PAM to prevent users from using those facilities to escape 
from their poly-instantiated directories.  The idea is that if you change N 
programs and there are really N+1 programs that call setuid() before 
performing operations on behalf of users then you lose.

I believe that with a /tmp/.inst/whatever scheme (as previously discussed) 
most attacks require that both users that want to inappropriately exchange 
data need to be involved.  I find it difficult to imagine a scenario where it 
is expected that two users who are allowed to receive email or host cgi-bin 
scripts would be unable to exchange data in some more convenient manner.  
Thus the consequences of a single user breaking out of their instance of /tmp 
is mitigated.

In terms of having a call-gate, apparently this has been done before (Casey - 
would you care to comment?).  But even so I have great doubts about anything 
that involves changing a simple system call to an execution of a program 
(thus giving some potential for dead-locks among other things).  I believe 
that this was one of the issues with devfs that caused it to be deprecated.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
