Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05448
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 11:47:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA26226
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:45:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA26222
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 15:45:55 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfsd module
Date: Thu, 18 Apr 2002 17:47:23 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204181059590.5560-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204181059590.5560-100000@raven>
MIME-Version: 1.0
Message-Id: <20020418154723.DAF6644D90@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 17:02, Stephen Smalley wrote:
> On Tue, 16 Apr 2002, Russell Coker wrote:
> > I've attached the source to my latest devfsd code.  I don't anticipate
> > any significant changes in future, could it be included in the next
> > selinux-small archive release?
>
> I'm not sure whether this should go into the upstream NSA distribution or
> if it would be better to place it on the sourceforge site, as with Mark's
> modified gdm program.  Thoughts?

A gdm is a fairly high-level thing with less connection to the core code.  
Also it depends on a lot of other things and can be a pain to support (I 
presume that gdm is like kdm in this regard).

The devfsd module is small, simple, and closely related to the core code.

But I'm not really bothered either way.  I'll keep it in my base "selinux" 
package in Debian regardless.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
