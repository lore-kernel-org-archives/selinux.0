Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6ECCrHa011752
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 08:12:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6ECCqH5006835
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:12:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h6ECCqRX006832 for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:12:52 GMT
Subject: Re: [patch] uninitialized values in setfiles/psid.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058077234.10673.68.camel@columbia>
References: <1058077234.10673.68.camel@columbia>
Content-Type: text/plain
Message-Id: <1058184770.13738.575.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Jul 2003 08:12:51 -0400
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

The psid code in setfiles is actually obsolete now, and can be dropped.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
