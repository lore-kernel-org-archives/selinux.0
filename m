Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9GF1EWt003256
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 11:01:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9GF1DmR029693
	for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 15:01:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9GF1Cjp029688 for <selinux@tycho.nsa.gov>; Thu, 16 Oct 2003 15:01:12 GMT
Subject: Re: genfscon and /boot
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310170050.30444.russell@coker.com.au>
References: <200310162109.25021.russell@coker.com.au>
	 <1066308938.24561.38.camel@moss-spartans.epoch.ncsc.mil>
	 <200310170050.30444.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066316470.25279.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 16 Oct 2003 11:01:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-16 at 10:50, Russell Coker wrote:
> OK.  Then how about an option to label all of /boot as boot_t?  There can be 
> no confusion when all of a file system has the same label, and being overly 
> restrictive should not be a problem.

And we distinguish /boot from any other ext2 filesystem in what manner?
Particularly since any ext3 filesystem can also be mounted as an ext2
filesystem.

Exactly what is broken by having xattrs on /boot?  Why does this
interfere with the ability of old boot loaders to access /boot?

Of course, if we were still using the persistent label mapping, then
this wouldn't be an issue, but that wasn't an option...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
