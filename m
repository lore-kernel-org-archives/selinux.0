Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08252
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 12:24:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA03807
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 16:23:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA03803
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 16:23:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: FYI: woody startup messages
Date: Tue, 27 Aug 2002 18:24:15 +0200
References: <20020827161633.A23590@lemuria.org> <Pine.GSO.4.33.0208271028010.14544-100000@raven> <20020827171522.A26026@lemuria.org>
In-Reply-To: <20020827171522.A26026@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020827162415.E32F87954@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Aug 2002 17:15, Tom wrote:
> On Tue, Aug 27, 2002 at 10:32:45AM -0400, Stephen Smalley wrote:
> > This isn't a bug, and was asked previously on the list, most recently on
> > 8/20 (http://marc.theaimsgroup.com/?l=selinux&m=102985179503728&w=2). 
> > You can only reconstruct an "absolute" (no such thing) pathname if you
> > have a vfsmount and a dentry, and many of the file-related permission
> > checks only have an inode or a dentry available at the point where they
> > are checked. As with the port number issue, this merely affects the audit
> > output, not the permission check.  SELinux is inode-based, not
> > path-based.  The path information is merely a hint to help understand the
> > audit message and is not reliable.
>
> I see, thanks for the explanation. is there a better way to find a
> specific inode than "find /home -inum xxx" ?

Not from user-space.  This is why the path is logged...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
