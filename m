Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01071
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 13:17:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA27336
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:16:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA27332 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:16:08 GMT
Date: Mon, 26 Aug 2002 13:16:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: mrtg patch
In-Reply-To: <20020826003626.9D09C7463@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208261316300.24426-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Aug 2002, Russell Coker wrote:

> I've attached a patch against the latest release to add a new domain for
> mrtg.  I did this because mrtg in a full setup needs some access that you may
> not want to give to all system cron jobs, and because there is the option of
> running mrtg as a daemon...

Merged and available in the sourceforge CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
