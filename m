Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01046
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 13:16:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04220
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:15:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA04216
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:15:39 GMT
Date: Mon, 26 Aug 2002 13:16:27 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: cardmgr.te patch
In-Reply-To: <20020826003626.AB4DB7494@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208261315520.24426-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Aug 2002, Russell Coker wrote:

> The attached patch against the latest release allows the administrator to run
> "cardctl eject", allows cardmgr to create device nodes when it wants to
> (should look into the possibility of changing the way cardmgr works), and
> allows dpkg to stop and start the card manager for upgrades.
>
> It works for me and it's based on what works for Brian.

Merged and available in the sourceforge CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
