Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7RBG5Y2012828
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 07:16:06 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7RBFie7008816
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 11:15:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, drepper@redhat.com
Subject: PIE
Date: Sun, 27 Aug 2006 20:56:00 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608272056.03253.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://people.redhat.com/drepper/nonselsec.pdf

Ulrich, in the above PDF file you say that "eu-readelf -d BINARY|grep TEXTREL" 
will indicate whether there is a text relocation that needs to be fixed.

In a stock install of FC6T2 and in the latest rawhide when using "gcc -pie 
hello.c" to compile a hello-world program (#include <stdio.h> and 
printf("hello\n")) will have such a TEXTREL.  I'm posting here because this 
of course gives an execmod AVC message and having PIE and SE Linux not work 
together is something that will concern many people here.

What package would be responsible for this?

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
