Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3DrHWt029705
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 08:53:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3DquC7008626
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 13:52:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hA3Dquuw008623
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 13:52:56 GMT
Subject: Re: specifying groups of types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: david caplan <dac@tresys.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1067794997.5374.42.camel@chris.pebenito.net>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com> <1067794997.5374.42.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1067867585.21113.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Nov 2003 08:53:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-02 at 12:43, Chris PeBenito wrote:
> Was there any resolution to this?  I think this would be useful for
> checkpolicy to have, but it hasn't been merged (at least on the
> sourceforge cvs).  I don't remember seeing any official response from
> the NSA team about it nor any criticism/improvements of it.

Dave correctly noted that the implementation was just an experimental
hack, not something for upstream inclusion, and explained what would
need to be done to implement it correctly.  No one has done that yet,
AFAIK.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
