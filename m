Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FL6SHa020248
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:06:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FL5RnJ019372
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:05:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6FL5Rhr019369
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:05:27 GMT
Subject: Re: [patch] uninitialized values in setfiles/psid.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058077234.10673.68.camel@columbia>
References: <1058077234.10673.68.camel@columbia>
Content-Type: text/plain
Message-Id: <1058303185.13738.811.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 17:06:26 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-07-13 at 02:20, Colin Walters wrote:
> While updating to the newer policycoreutils release, I noticed the
> following gcc warnings:
> 
> psid.c: In function `chpsid':
> psid.c:609: warning: `off' might be used uninitialized in this function
> psid.c:610: warning: `len' might be used uninitialized in this function
> 
> I believe the patch below should fix the problem.

A patch removing the obsolete psid code from setfiles has been committed
to the sourceforge CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
