Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FL8OHa020307
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:08:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6FL8NH5006309
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:08:23 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6FL8MRX006306 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:08:22 GMT
Subject: Re: [patch] updated chcon.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058150876.4130.21.camel@columbia>
References: <1058150876.4130.21.camel@columbia>
Content-Type: text/plain
Message-Id: <1058303300.13738.815.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 17:08:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-07-13 at 22:47, Colin Walters wrote:
> Per our previous discussion, I've updated my previous patch for chcon to
> the new 2.5 API.  I tried to minimize the number of places which had
> knowledge of the components of the security context.
> 
> Tested on my Debian SELinux 2.5 system.

The coreutils-selinux.patch in the sourceforge CVS tree has been updated
to include the modified chcon.c.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
