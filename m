Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NESvRb016983
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 09:28:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1NESuQQ006873
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 14:28:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1NESuP0006870 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 14:28:56 GMT
Subject: Re: identity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200402231535.26738.russell@coker.com.au>
References: <200402231535.26738.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1077546531.18234.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 09:28:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-02-22 at 23:35, Russell Coker wrote:
> One of the benefits of the SE Linux identity is that it tracks the originating 
> user through all operations that they perform.

Caveat:  This is no longer entirely true, as 'su' is now using
pam_selinux and transitions to other user identities.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
