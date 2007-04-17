Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HA7YNg020329
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 06:07:34 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HA7VRT009941
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 10:07:32 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 9B2E61886B
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 20:07:27 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (nospam.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YnUOV8bjFkBI for <selinux@tycho.nsa.gov>;
	Tue, 17 Apr 2007 20:07:27 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id CAB1818863
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 20:07:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 50C0D21507
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 20:07:57 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: FCGlob
Date: Tue, 17 Apr 2007 21:07:51 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704172007.54844.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://selinux-symposium.org/2007/papers/06-fcglob.pdf

I've just read the above paper.  It seems apparent that this is generally the 
right approach.

Page 3 states that a down-side is "the tree would be a binary file and not 
human readable any more".  Why would this be so?  Currently we compile a set 
of plain text .fc files into a plain text file that is not directly 
accessible to the sys-admin (everyone on this list knows how to get it - but 
it's not a documented interface) and there is also a semanage option to 
display the same data.

It seems to me that having .fc files with FCGlob data which are human readable 
and then compiling them into a binary form will not be any different.  
The .fc files shipped as part of policy modules will still need to be 
plain-text (the tree structure depends on nodes from other .fc files), and 
the semanage command can still do much the same tasks.

Why would it be desirable to compile FCGlob to regular expressions?  Once the 
performance benefits are proven we might as well go full-speed ahead.

As for regex's that have no clear meaning, the only thing to do is to remove 
them and wait for the original policy author to complain.  There are many 
regular expressions that never matched anything and probably many more that 
match old versions of software.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
