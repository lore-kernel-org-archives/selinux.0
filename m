Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NJWZRb018993
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 14:32:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1NJV0lK010331
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 19:31:00 GMT
Received: from lakemtao08.cox.net (lakemtao08.cox.net [68.1.17.113])
	by jazzswing.ncsc.mil  with ESMTP id i1NJUxOX010328
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 19:31:00 GMT
Message-ID: <403A554C.2040000@snu.edu>
Date: Mon, 23 Feb 2004 13:32:28 -0600
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: identity
References: <200402231535.26738.russell@coker.com.au> <1077546531.18234.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1077546531.18234.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

> On Sun, 2004-02-22 at 23:35, Russell Coker wrote:
> 
>>One of the benefits of the SE Linux identity is that it tracks the originating 
>>user through all operations that they perform.
> 
> 
> Caveat:  This is no longer entirely true, as 'su' is now using
> pam_selinux and transitions to other user identities.
> 

Why was this decided, one of the main selling points of selinux was that 
the identity is always preserved, why back away from this concept?

 From talking to pebenito we aren't going to implement this at all in 
Gentoo, I'm wondering why others want to implement it.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
