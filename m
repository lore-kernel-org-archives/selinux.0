Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h51MVsI4006612
	for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2003 18:31:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h51MVrtV009475
	for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2003 22:31:53 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h51MVpal009472 for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2003 22:31:52 GMT
Date: Mon, 2 Jun 2003 08:31:30 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: John Wolff <jrwolff@comcast.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: Compaq DL-360
Message-ID: <20030601223130.GA29681@snoopy.apana.org.au>
References: <3ED7C88A.7060209@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ED7C88A.7060209@comcast.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 30, 2003 at 05:09:30PM -0400, John Wolff wrote:
> the boot sequence gets to the point where the OS attempts to mount the 
> SCSI drives.  I have downloaded and installed the latest drivers from 

Was the kernel able to mount the root filesystem?

Did the kernel panic include any text messages like "Cannot mount root"?

Reading your E-Mail, it is not very clear precisely when it crashes.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
