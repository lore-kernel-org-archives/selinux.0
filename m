Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1QWDo018369
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:26:32 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1Q7ixlw003175
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 07:46:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1C1C661B03
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 18:47:18 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12328-10 for <selinux@tycho.nsa.gov>;
	Sat, 26 Feb 2005 18:47:17 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B2C1661AFE
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 18:47:17 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 0DFB9C8
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 18:46:57 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: missing features in user-land tools
Date: Sat, 26 Feb 2005 18:46:53 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502261846.55490.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While working on my tutorial for the SE Linux symposium I noticed that there 
is some functionality that is missing from the utilities.

One thing is the display of the parent context.  ps could be modified to have 
the option of displaying the parent context of every process, it's not 
absolutely required (things have been working well without that 
functionality), but it could be handy to have it.

Another is the possibility of creating a file with a specified context from a 
shell script.  Of course it would be possible to do:

echo $CONTEXT > /proc/self/attr/fscreate
echo -n > $FILE

But that is a hack, even without the issue that it's impossible to unset it 
(see my previous message) this is not a desirable way of doing it.


I believe that for ideal functionality we want a program that will create a 
file with a specified context.  It seems to me that modifying chcon would be 
a good way of doing this as chcon already supports specifying the context and 
the desired sym-link functionality.  Something like "chcon -n $CONTEXT $FILE" 
with "-n" meaning that the file should be created if it doesn't exist (not 
sure whether we would want chcon to abort if the file doesn't already exist - 
maybe another option for that).

The precedent for that is touch(1) which will change the time-stamp or create 
the file if it doesn't exist.


I think it would also be good if mktemp(1) was modified to allow specifying 
the context of the file being created.  Often a script creates a temp file 
which will be written to by a program running in a different context.  Sure 
it could call chcon(1) after creating the temp file, but I think that having 
mktemp do it all would be better.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
