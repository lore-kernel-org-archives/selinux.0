Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4G5FEI4022063
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 01:15:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4G5Erl5016925
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 05:14:53 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4G5EoNc016921
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 05:14:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Subject: Re: slow application of contexts in devfs?
Date: Fri, 16 May 2003 15:13:26 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
References: <3EC2792D.1020209@yahoo.it> <200305160945.45658.russell@coker.com.au> <1053054721.21382.32.camel@chris.pebenito.net>
In-Reply-To: <1053054721.21382.32.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305161513.26298.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 May 2003 13:12, Christopher J. PeBenito wrote:
> I am using metalog, however I've already fixed up the file contexts, so

Please tell us the file name so it can be included into the standard policy to 
avoid other people having the same problem.

> its running in the correct domain.  The fact (which didnt occur to me
> earlier) is that devfsd starts up before the syslogger in Gentoo.  So

This is the way it should be.  devfsd starts before sysklogd in Debian too and 
everything works fine.

Are you running that cut-down syslogd that Red Hat uses for the early stages 
of their boot process (the one that causes all the problems)?  If so make 
sure that it is also labelled with the correct context, and also please tell 
us the file name.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
