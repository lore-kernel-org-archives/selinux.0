Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FHMYHa018655
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 13:22:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FHLWnJ004102
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:21:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6FHLWhr004098
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:21:32 GMT
Subject: Re: crash with 2.5.74 while loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058249829.24843.13.camel@columbia>
References: <1058249829.24843.13.camel@columbia>
Content-Type: text/plain
Message-Id: <1058289749.13738.711.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 13:22:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-15 at 02:17, Colin Walters wrote:
> Linux oopsed while loading a policy today on my SELinux 2.5.74 machine. 
> It doesn't offhand look directly related to SELinux, but I was curious
> if anyone here had seen it before.

I haven't seen it, but that doesn't mean it isn't our fault ;)  You
might want to try with 2.6.0-test1-selinux1, get it from
http://www.nsa.gov/selinux/lk/2.6.0-test1-selinux1.patch.gz.  The other
patch files in the lk directory are simply the individual logical change
sets, i.e. one to address a problem with setxattr and one to add the
selinux module.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
