Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5UEfU73001081
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 10:41:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5UEeVss014069
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 14:40:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h5UEeVhY014066
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 14:40:31 GMT
Subject: Re: improvements to chcon.c
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov
In-Reply-To: <200307010011.22778.russell@coker.com.au>
References: <1056781690.14920.81.camel@columbia>
	 <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
	 <200307010011.22778.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1056984070.1110.782.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 30 Jun 2003 10:41:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-06-30 at 10:11, Russell Coker wrote:
> Steve, if you are totally convinced that the chcon program should not have 
> such functionality then I think that perhaps we should have a Debian-specific 
> program similar to chcon which offers it.  We can advise the users in the 
> documentation that you don't recommend it and that future developments may 
> break it, but I'm sure that most people will be happy to use it in the 
> mean-time.

I'm not fundamentally opposed to having such functionality in chcon (or
mkdir), but I would like to have it implemented in a manner that
provides as much policy flexibility as possible.  It may be that there
isn't much more that can be done than just making sure that we use the
context_* functions from libsecure/libselinux when manipulating the
fields and reconstituting the full context so that there aren't any
hardcoded assumptions about the layout, although this still leaves
hardcoded assumptions about specific fields existing.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
