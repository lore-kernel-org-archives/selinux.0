Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA07944
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 20:47:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA28156
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 00:45:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA28152
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 00:45:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Debian User <rogelio@evoworks.evoserve.com>
Subject: Re: devfs systems and no devfsd
Date: Tue, 7 May 2002 10:47:55 +1000
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205061453550.20696-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205061453550.20696-100000@raven>
MIME-Version: 1.0
Message-Id: <20020507004755.6415040BA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 7 May 2002 05:00, Stephen Smalley wrote:
> On Mon, 6 May 2002, Debian User wrote:
> > Can we use selinux with a devfs kernel but no devfsd?

Yes, the devfs_contexts will allow it to work, apart from the issue of 
/dev/pts not being labelled correctly.

> Good question.  We don't use devfs on our systems, but we added the
> devfs_contexts configuration as a simple mechanism for devfs users.  Then,
> Russell created the devfsd module, which I had assumed would largely
> supplant the use of devfs_contexts.  However, since devfs is intended to
> work even without devfsd, I suppose that we should retain devfs_contexts
> to support such operation.

The devfsd module will largely supplant the use of devfs_contexts, but 
devfs_contexts is still needed to label device nodes before devfsd is 
executed.  Also if you boot in recovery mode (init=/bin/bash) then there will 
be no devfsd...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
