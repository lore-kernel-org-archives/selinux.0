Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0DD3wRb018615
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 08:03:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0DD3liV006801
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 13:03:47 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions.epoch.ncsc.mil [144.51.25.4])
        by jazzband.ncsc.mil  with ESMTP id i0DD3l06006798 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 13:03:47 GMT
Subject: Re: Samba and NFSv4 user-space server
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: russell@coker.com.au
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200401131419.23834.russell@coker.com.au>
References: <200401131419.23834.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1073999020.15711.30.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 13 Jan 2004 08:03:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-01-12 at 22:19, Russell Coker wrote:

> I spent some time discussing the matter with Tridge, he seems quite convinced 
> that SE Linux needs some method to allow an smbd to change security context 
> for file system operations (similar in concept to setfsuid() perhaps).
> 

I have implemented a fssid in my nfs work (which, hopefully, I will be
releasing real soon now).  The fssid is set based on the security
context of the user passed in the nfs request.  My modified SELinux will
use the fssid to make the security decision for file operations if it is
set.  After the request is processed, the fssid is cleared.  Of course,
all of this is in the kernel, I haven't made that functionality
available to the user space. 


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
