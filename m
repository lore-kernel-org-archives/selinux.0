Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07675
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 08:35:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08057
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:35:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA08051
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:35:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: new policy changes
Date: Wed, 19 Jun 2002 14:35:02 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206190829240.17899-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206190829240.17899-100000@raven>
MIME-Version: 1.0
Message-Id: <20020619123502.BCE2A1C9F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Jun 2002 14:32, Stephen Smalley wrote:
> On Wed, 19 Jun 2002, Russell Coker wrote:
> > Actually on my system it defaults to devfs_t which is the same as all the
> > /dev/pts/* files (due to the problems with devpts labelling on devfs). 
> > So I enabled writing to devfs_t character devices...
>
> I see.  In our devfs_contexts configuration (now a subset of the
> genfs_contexts configuration), we assign system_u:object_r:devpts_t to
> /pts.  Although this doesn't address the goal of maintaining separate
> types on ptys for different domains (when using devfs), it at least avoids
> the need to grant such generic access to devfs_t.

Yes.  In an ideal configuration of the current release version the problem I 
just encountered wouldn't have happened either.

I look forward to the new release with genfs_contexts...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
