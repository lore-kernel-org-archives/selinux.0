Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07569
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 11:15:24 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA29838
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 15:14:15 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id PAA29830
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 15:14:14 GMT
Date: Tue, 27 Aug 2002 17:15:22 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: FYI: woody startup messages
Message-ID: <20020827171522.A26026@lemuria.org>
References: <20020827161633.A23590@lemuria.org> <Pine.GSO.4.33.0208271028010.14544-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0208271028010.14544-100000@raven>; from sds@tislabs.com on Tue, Aug 27, 2002 at 10:32:45AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 27, 2002 at 10:32:45AM -0400, Stephen Smalley wrote:
> This isn't a bug, and was asked previously on the list, most recently on
> 8/20 (http://marc.theaimsgroup.com/?l=selinux&m=102985179503728&w=2).  You
> can only reconstruct an "absolute" (no such thing) pathname if you have a
> vfsmount and a dentry, and many of the file-related permission checks only
> have an inode or a dentry available at the point where they are checked.
> As with the port number issue, this merely affects the audit output, not
> the permission check.  SELinux is inode-based, not path-based.  The path
> information is merely a hint to help understand the audit message and is
> not reliable.

I see, thanks for the explanation. is there a better way to find a
specific inode than "find /home -inum xxx" ?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
