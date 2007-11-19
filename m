Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAJMmosK027464
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 17:48:50 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAJMmngT025098
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 22:48:49 GMT
Date: Tue, 20 Nov 2007 09:48:27 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: casey@schaufler-ca.com, labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov
Subject: Re: [Labeled-nfs] [PATCH 13/13] NFSD: Label change notification for
 NFSv4 Server
In-Reply-To: <1195509634.5327.16.camel@heimdal.trondhjem.org>
Message-ID: <Xine.LNX.4.64.0711200923540.5484@us.intercode.com.au>
References: <236192.48539.qm@web36605.mail.mud.yahoo.com>
 <1195509634.5327.16.camel@heimdal.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Nov 2007, Trond Myklebust wrote:

> This proposal, OTOH, will force the server to track all clients that
> access a labelled file, and to notify them all synchronously if ever a
> change is made. That can never scale if, say, you want to relabel the
> entire filesystem as SELinux appears wont to do.

There are further requirements for conveying volatile security state 
between the peers, such as: the current security context of the client, 
and the client's current explicit label for new files (if present).

A possible approach for dealing with all of these is to use a 
per-procedure OP which is prefixed in a similar manner to SEQUENCE, when 
security labeling is active.  It may be possible to optimize this at the 
server so that an updated file security label (or ineed the entire 
security OP) is only sent if required.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
