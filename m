Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA06123
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 17:56:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA26991
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 22:55:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA26985 for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 22:55:11 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 723B292452
	for <selinux@tycho.nsa.gov>; Fri, 29 Mar 2002 09:56:12 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 46B53C4C8
	for <selinux@tycho.nsa.gov>; Thu, 28 Mar 2002 23:56:04 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles - patch
Date: Thu, 28 Mar 2002 23:56:03 +0100
MIME-Version: 1.0
Message-Id: <20020328225604.46B53C4C8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Mar 2002 22:47, Russell Coker wrote:
> I've attached a little patch for setfiles which allows "-" to be specified
> instead of a file system name to make it read file names from stdin.

Just found a minor bug in my code.  I had to add a check such as the 
following after the strtok() because strtok doesn't do anything if the only 
character in the string is '\n'!
if(buf[0] != '\n')

This is because programs like dpkg like to append an empty line after the 
list of files, and adding a "grep ." in the pipeline is too annoying.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
