Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26073
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 14:12:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA29068
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 18:10:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA29063 for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 18:10:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Bennett Todd <bet@rahul.net>, selinux@tycho.nsa.gov
Subject: Re: limiting types on a file system
Date: Mon, 30 Sep 2002 20:11:53 +0200
References: <200209251622.02323.russell@coker.com.au> <20020925215924.GI26806@snoopy.apana.org.au> <20020926125103.GA1592@rahul.net>
In-Reply-To: <20020926125103.GA1592@rahul.net>
MIME-Version: 1.0
Message-Id: <200209302011.53443.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 26 Sep 2002 14:51, Bennett Todd wrote:
> Re the original problem of allowing end-users to use removable
> media, notably a floppy, many years ago I was faced with that one,
> and addressed it by making the raw floppy device read/write
> accessible to the user, then providing a build of mtools, cmdline
> utilities for copying files to and from MS-DOS formatted
> filesystems. This worked well enough for them.

That will work as long as the disks are in DOS or TAR formats.

Also to do that you would want to have a PAM module to relabel the floppy 
device node to a type that the user can access (maybe the home directory type 
for the user).  Don't want to have someone insert a floppy disk only to have 
someone login over the network and copy all the data off...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
