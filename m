Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97ER1Wt011749
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 10:27:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97ER17d000102
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 14:27:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h97ER0Rn000099 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 14:27:00 GMT
Subject: Re: /selinux/enforce permissions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200310080000.51892.russell@coker.com.au>
References: <200310080000.51892.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065536810.3919.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 10:26:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 10:00, Russell Coker wrote:
> Wouldn't it make sense to have the permissions 0644 for /selinux/enforce?
> 
> Or maybe even 0666 would do?  After all either SE Linux is controlling it, or 
> it doesn't matter too much...

What rationale do you have for opening up access to it further?  Least
privilege and defense in depth suggest that 0600 is the right mode for
/selinux/enforce and /selinux/load, even though you also have to pass
the SELinux permission checks as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
