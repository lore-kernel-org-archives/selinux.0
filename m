Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA02538
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 19:10:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA09080
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 23:08:59 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA09076 for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 23:08:57 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 516EF9246C
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 09:10:32 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id C437E873F
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 01:10:24 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: changing open mode of file handle
Date: Tue, 13 Aug 2002 01:10:24 +0200
MIME-Version: 1.0
Message-Id: <20020812231024.C437E873F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently I have cron jobs that create a temporary file in read-only mode, 
delete the file, then use the file descriptor as standard input for a process 
that runs "mail root".

The problem is that I don't want to give the mail program write access to the 
temporary file type, so I currently have to dontaudit the writes.

But I don't really like this, I'd rather just change the mode of the file 
handle to be read-only.

How can I change the open mode of a file handle for a deleted file to be 
read-only instead of read-write?  I'm sure it's possible but can't work out 
how.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
