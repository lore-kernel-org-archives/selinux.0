Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01040
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 13:16:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA04212
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:15:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA04208
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:15:37 GMT
Date: Mon, 26 Aug 2002 13:15:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: postfix patch
In-Reply-To: <20020826003626.D4EB974CA@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208261315310.24426-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Aug 2002, Russell Coker wrote:

> I've attached a patch for the postfix policy that fixes two spurious
> warnings, one potential situation where the policy could fail to compile, and
> a typo in merging changes into cvs.

Thanks, merged and available in the sourceforge CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
